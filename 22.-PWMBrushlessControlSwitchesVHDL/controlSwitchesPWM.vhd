--Control de velocidad de un motor brushless (BLDC) por medio de codigo, pero calibrando el porcentaje del duty cycle 
--de la senal PWM para adaptarla al motor sin escobillas: Para la conexion de este motor se usa un controlador 
--externo llamado ESC (Electronic Speed Controller), el cual es alimentado por una batera LiPo, misma que puede 
--alimentar dispositivos externos a traves del cable rojo del ESC llamado BEC (Battery ELiminator Controller) por medio 
--de su pin de 5V y GND, a la tierra del ESC igual se conectara el pin GND de la Nexys 2 y a traves del puerto JA1 se 
--controlara su velocidad de rotacion, por medio de una senal PWM con frecuencia de 50 Hz, que varie su duty cycle de 
--1 a 2ms. El control del BLDC es identico al del servomotor, pero la unica diferencia es que esa senal PWM controla la 
--posicion de 0 a 180 y la de este tipo de motor controla la velocidad de giro, pero su funcionamiento es el mismo, solo 
--que se debe calibrar.
--------------------------------------------------------------------------------------------------
--Motor brushless MT2204 que se alimenta con bateras LiPo de 2 a 3S, cuenta con una KV = 2300, por lo que el rango de 
--velocidades que abarca como maximo, alimentandolo con una batera de 3S es de:
--0 a KV * V_ESC [rpm] = 2300 * 3.7 * 3S = 25,530 [rpm].
--La cual es controlada por una senal PWM (Pulse Width Module) con una frecuencia de 50 Hz (20 [ms]).
--------------------------------------------------------------------------------------------------
--Motor brushless A2212 que se alimenta con bateras LiPo de 2 a 3S, cuenta con una KV = 1400, por lo que el rango de 
--velocidades que abarca como maximo, alimentandolo con una batera de 3S es de:
--0 a KV * V_ESC [rpm] = 1400 * 3.7 * 3S = 15,540 [rpm].
--La cual es controlada por una senal PWM (Pulse Width Module) con una frecuencia de 50 Hz (20 [ms]).

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria declarada para poder hacer operaciones matematicas sin considerar el signo.

entity controlSwitchesPWM is
    Port ( relojNexys2 : in  STD_LOGIC;	--Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
           rst : in  STD_LOGIC;           						--Boton de reset.
			  selectPos : in  STD_LOGIC_VECTOR (2 downto 0);	--Selector de posicion.
			  ledAngulo : out  STD_LOGIC_VECTOR (2 downto 0);	--Leds del selector de posicion.
           PWM : out  STD_LOGIC); 									--Senal PWM.
end controlSwitchesPWM;

--Arquitectura: Aqui se hara el divisor de reloj y la senal PWM haciendo uso de una signal y condicionales if.
architecture frecuenciaNueva of controlSwitchesPWM is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin, se le asignan valores con el simbolo :=
signal divisorDeReloj : STD_LOGIC_VECTOR (25 downto 0);	--Vector con el que se obtiene el divisor de reloj.
--Esta signal sirve para que podamos obtener una gran gama de frecuencias indicadas en la tabla del divisor de reloj
--dependiendo de la coordenada que elijamos tomar del vector, se asignara al contador que dicta la velocidad del 
--motor brushless para que se cree una secuencia entre dos o mas velocidades distintas.
signal conteoFrecuenciaPWM: integer range 1 to 1e6 := 1; --Signal para el contador de uno a 1,000,000.
--Variable que obtiene un conteo para obtener la senal de 50 Hz que manda pulsos al motor brushless con el fin de que 
--llegue a velocidades de 0 a KV * V_ESC [rpm], esta tiene un periodo de T = 1/50 = 0.02s = 2ms.
--El valor del conteo se obtiene al dividir el periodo de 20ms sobre el periodo de la senal de 50MHz proveniente del 
--reloj de la Nexys 2: T50Mz = 1/50,000,000 = 20e-9s = 20ns. Por lo tanto, al realizar la operacion se obtiene que:
--T50Hz = 0.02s = 2ms; T50Mz = 20e-9s = 20ns; ConteoFrecuenciaPWM = T50Hz/T50Mz = 2ms/20ns = 2e-3/2e-9 = 1,000,000.
--AL realizar la calibracion, el valor real de los pasos para alcanzar la posicion 0 grados es de = 57000.
--Variable asignada al integer conteoFrecuenciaPWM para situar el estado alto de la senal PWM en 1ms, posicionando al 
--motor en una posicion de 0 grados inicialmente.
signal posicion0Grados: integer := 57e3;	--Integer que dicta los pasos para situar el eje del motor en 0 grados.
--Variable asignada al integer conteoFrecuenciaPWM para situar el estado alto de la senal PWM en 1ms, posicionando al 
--motor en una posicion de 0 grados inicialmente.
signal movServo: integer range 0 to 50000 := 0; --Dicta los pasos que debe dar el motor para llegar a una posicion.
--El valor del integer movServo sera modificado dependiendo del valor ingresado por los switches del vector 
--conteoFrecuenciaPWM, para asi hacer girar el eje del motor a una velocidad especifica, para ello la variable 
--selectorDutyCycle solo puede abarcar 1 valor.

begin
	--A los process se les puede dar un nombre diferente para diferenciarlos entre si, se hace esto porque hay 
	--programas de VHDL donde se usan varios process y de esta forma es mas facil no confundir uno con otro, la sintaxis 
	--es la siguiente: 
	--nombreProcess : process(Entradas o signals que se usan en el bucle, condicional u operacion matematica) begin 
	--		Contenido del process.
	--end process;
	clkdiv: process(relojNexys2, rst) begin
		if(rst = '1') then --Cuando el boton Reset sea presionado valdra 1 logico y el divisor de reloj se reiniciara.
			divisorDeReloj <= "00000000000000000000000000";
		elsif(conteoFrecuenciaPWM > 1e6) then
			--Se reinicia el conteo para obtener la frecuencia de 50 Hz de la senal PWM cuando se llegue al tope 
			--calculado anteriormente, donde: ConteoFrecuenciaPWM = T50Hz/T50Mz = 2ms/20ns = 2e-3/2e-9 = 1,000,000 = 1e6.
			conteoFrecuenciaPWM <= 1;
		elsif(rising_edge(relojNexys2)) then
			--La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco de subida 
			--en la senal de reloj clkNexys2 proveniente de la NEXYS 2.
			divisorDeReloj <= divisorDeReloj + 1; 				--Esto crea al divisor de reloj.
			conteoFrecuenciaPWM <= conteoFrecuenciaPWM + 1; --Esto crea la frecuencia de 50 Hz para la senal PWM.
		end if;
	end process clkdiv;

	--Debo asignar el contenido de una coordenada de la signal divisorDeReloj a salidaReloj para obtener una 
	--frecuencia en especifico, cada coordenada del vector corresponde a una frecuencia en la tabla del divisor de 
	--reloj y asignara cierta velocidad de respuesta al control de velocidad por medio de switches.
	highDutyCyclePWM: process(divisorDeReloj(12)) begin
		if(rising_edge(divisorDeReloj(12))) then
			--Cuando el valor del selector sea distinto de cero, vera cual es la posicion que le corresponde y la asignara 
			--a la variable movServo, que hara girar al motor en su velocidad 0, media y maxima.
			if(selectPos /= "000") then 
				case(selectPos) is--CASE se usa para evaluar los diferentes valores de la variable que tenga en su parentesis
					--Los switches del selector se levantan para que el integer movimientoServo adopte diferentes numeros 
					--que muevan el motor sin escobillas a diferentes velocidades, que son las siguientes:
					when "001" => 
						movServo <= 0; 	 --Bit menos significativo del selector = 0 = velocidad cero.
						ledAngulo <= "001";
					when "010" =>
						movServo <= 25000; --Bit 2 del selector = movServo = 25,000 = velocidad media.
						ledAngulo <= "010";
					when "100" =>
						movServo <= 50000; --Bit mas significativo del selector = 50,000 = velocidad maxima = 25,530 [rpm].
						ledAngulo <= "100";
					--Si no se ha seleccionado nada o se mete con los switches cualquier otra cosa, el BLDC se detiene.
					when others => 
						movServo <= 0;
						ledAngulo <= "000";
				end case;
			end if;
		end if;
	end process highDutyCyclePWM;
	
	--Para mantener el estado alto de la senal PWM de 1 a 2 ms con el fin de mover el servomotor de 0 a 180 grados, se 
	--debe realizar un conteo como el que se realizo para crear la frecuencia de 50 Hz en la senal PWM, para ello se 
	--realiza el siguiente calculo:
	--T1ms = 1ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1ms/20ns   = 1e-3/20e-9   = 50,000;  velocidad 0.
	--T1ms = 1.5ms; T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1.5ms/20ns = 1.5e-3/20e-9 = 75,000;  velocidad media.
	--T1ms = 2ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 2ms/20ns   = 2e-3/20e-9   = 100,000; velocidad maxima.
	--Con este calculo podemos saber que, para que el pulso en alto abarque un rango inicial de 1ms se debe usar 50e3 
	--pasos, a este ancho inicial de pulso se le debe sumar el valor de la signal DutyCycle_1a2ms para que el pulso 
	--paulatinamente vaya aumentando de 1 a 2ms, creando asi la secuencia de 3 velocidades.
	--Pero recordemos que esta es la teoria, para alcanzar dichas posiciones se debe realizar una calibracion, donde 
	--veremos el numero de pasos reales para alcanzar cada velocidad.
	--AL REALIZAR LA CALIBRACION DEL SERVOMOTOR SE OBTIENE LO SIGUIENTE:
	--El motor sin escobillas MT2204 alcanza un rango de 1ms con un paso inicial de 57e3.
	pwmSignal: process(conteoFrecuenciaPWM, posicion0Grados, movServo)begin
		--Este if crea el estado en alto y bajo de la senal PWM que crea la secuencia, yendo de 0 a 25,530 [rpm].
		if(conteoFrecuenciaPWM <= (posicion0Grados + movServo)) then
			PWM <= '1';
		else
			PWM <= '0';
		end if;
	end process pwmSignal;
end frecuenciaNueva;