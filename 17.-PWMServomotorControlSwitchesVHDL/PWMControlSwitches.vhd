--SENAL PWM CON FRECUENCIA DE 50HZ PARA CONTROL DE SERVOMOTOR:
--Este proceso sirve para primero crear un divisor de reloj, donde se puede dictar al reloj en que frecuencia 
--quiero que opere el servomotor, indicando asi su velocidad de rotacion, en este mismo proceso del divisor de reloj 
--se crea un contador que creara la frecuencia de 50 Hz para la senal PWM, despues lo que se hace es usar ese reloj 
--modificado para monitorear los switches del selector y asi seleccionar una posicion, a donde el servomotor se ira
--y mantendra su posicion hasta que cense que haya ocurrido un cambio, siempre y cuando el valor del selector sea 
--distinto de cero.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria declarada para poder hacer operaciones matematicas sin considerar el signo.

entity controlSwitchesPWM is
    Port ( relojNexys2 : in  STD_LOGIC;	--Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
           rst : in  STD_LOGIC;           						--Boton de reset.
			  selectPos : in  STD_LOGIC_VECTOR (5 downto 0);	--Selector de posicion.
			  ledAngulo : out  STD_LOGIC_VECTOR (5 downto 0);	--Leds del selector de posicion.
           PWM : out  STD_LOGIC); 									--Senal PWM.
end controlSwitchesPWM;

--Arquitectura: Aqui se hara el divisor de reloj y la senal PWM haciendo uso de una signal y condicionales if.
architecture frecuenciaNueva of controlSwitchesPWM is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin, se le asignan valores con el simbolo :=
signal divisorDeReloj : STD_LOGIC_VECTOR (25 downto 0);	--Vector con el que se obtiene el divisor de reloj.
--Esta signal sirve para que podamos obtener una gran gama de frecuencias indicadas en la tabla del divisor de reloj
--dependiendo de la coordenada que elijamos tomar del vector, para asignarsela al contador que dicta la velocidad del 
--servomotor cuando va de una posicion a otra.
signal conteoFrecuenciaPWM: integer range 1 to 1e6 := 1; --Signal para el contador de uno a 1,000,000.
--Variable que obtiene un conteo para obtener la senal de 50 Hz que manda pulsos al servomotor con el fin de que 
--llegue a posiciones de 0 a 180 grados, esta tiene un periodo de T = 1/50 = 0.02s = 2ms, aunque despues de mandar 
--estos pulsos, puede tener un tiempo de espera antes de mandar el otro y eso es lo que dicta la velocidad de rotacion 
--que lleva al llegar de una posicion a otra. 
--El valor del conteo se obtiene al dividir el periodo de 20ms sobre el periodo de la senal de 50MHz proveniente del 
--reloj de la Nexys 2: T50Mz = 1/50,000,000 = 20e-9s = 20ns. Por lo tanto, al realizar la operacion se obtiene que:
--T50Hz = 0.02s = 2ms; T50Mz = 20e-9s = 20ns; ConteoFrecuenciaPWM = T50Hz/T50Mz = 2ms/20ns = 2e-3/2e-9 = 1,000,000.
signal posicion0Grados: integer := 26e3;	--Integer que dicta los pasos para situar el eje del motor en 0 grados.
--Variable asignada al integer conteoFrecuenciaPWM para situar el estado alto de la senal PWM en 1ms, posicionando al 
--motor en una posicion de 0 grados inicialmente.
signal movServo: integer range 0 to 92109 := 0; --Dicta los pasos que debe dar el motor para llegar a una posicion.
--EL valor del integer movServo sera modificado dependiendo del valor ingresado por los switches del vector 
--conteoFrecuenciaPWM, para asi situar el eje del motor en una posicion especifica y dejarlo ahi, para ello la 
--variable selectorDutyCycle solo puede abarcar 1 valor.

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
	--reloj y asignara cierta velocidad de respuesta al control de movimiento por medio de switches.
	highDutyCyclePWM: process(divisorDeReloj(12)) begin
		if(rising_edge(divisorDeReloj(12))) then
			--Cuando el valor del selector sea distinto de cero, vera cual es la posicion que le corresponde y la asignara 
			--a la variable movServo, que movera el servomotor a la posicion de 30, 60, 90, 120, 150 o 180 grados.
			if(selectPos /= "000000") then 
				case(selectPos) is--CASE se usa para evaluar los diferentes valores de la variable que tenga en su parentesis
					--Los switches del selector se levantan para que el integer movimientoServo adopte diferentes numeros 
					--que muevan el servomotor a todas las posibles posiciones, que son las siguientes:
					when "000001" => 
						movServo <= 12329; --Bit menos significativo del selector = 12,329 = 30 grados.
						ledAngulo <= "000001";
					when "000010" =>
						movServo <= 26419; --Bit 2 del selector = movServo = 26,419 = 60 grados.
						ledAngulo <= "000010";
					when "000100" =>
						movServo <= 41868; --Bit 3 del selector = movServo = 41,868 = 90 grados.
						ledAngulo <= "000100";
					when "001000" =>
						movServo <= 57774; --Bit 4 del selector = movServo = 57,774 = 120 grados.
						ledAngulo <= "001000";
					when "010000" =>
						movServo <= 75633; --Bit 5 del selector = movServo = 75,633 = 150 grados.
						ledAngulo <= "010000";
					when "100000" =>
						movServo <= 92109; --Bit mas significativo del selector = 92,109 = 180 grados.
						ledAngulo <= "100000";
					--Si no se ha seleccionado nada o se mete con los switches cualquier otra cosa, el servomotor se 
					--mueve a su posicion inicial.
					when others => 
						movServo <= 0;
						ledAngulo <= "000000";
				end case;
			end if;
		end if;
	end process highDutyCyclePWM;
	
	--Para mantener el estado alto de la senal PWM de 1 a 2 ms con el fin de mover el servomotor de 0 a 180 grados, se 
	--debe realizar un conteo como el que se realizo para crear la frecuencia de 50 Hz en la senal PWM, para ello se 
	--realiza el siguiente calculo:
	--T1ms = 1ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1ms/20ns   = 1e-3/20e-9   = 50,000;  0 grados servo.
	--T1ms = 1.5ms; T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1.5ms/20ns = 1.5e-3/20e-9 = 75,000;  90 grados servo.
	--T1ms = 2ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 2ms/20ns   = 2e-3/20e-9   = 100,000; 180 grados servo.
	--Con este calculo podemos saber que para que el pulso en alto abarque un rango inicial de 1ms se debe usar 50e3 
	--pasos, a este ancho inicial de pulso se le debe sumar el valor de la signal DutyCycle_1a2ms para que el pulso 
	--paulatinamente vaya aumentando de 1 a 2ms, creando asi la secuencia que va a las posiciones 0, 90 y 180 grados.
	--Pero recordemos que esta es la teoria, para alcanzar dichas posiciones se debe realizar una calibracion, donde 
	--veremos el numero de pasos reales para alcanzar cada posicion.
	--AL REALIZAR LA CALIBRACION DEL SERVOMOTOR SE OBTIENE LO SIGUIENTE:
	--El servomotor SG90 alcanza un rango de 1ms con un paso inicial de 26e3.
	pwmSignal: process(conteoFrecuenciaPWM, posicion0Grados, movServo)begin
		--Este if crea el estado en alto y bajo de la senal PWM que crea la secuencia, yendo de 0 a 90 y 180 grados.
		if(conteoFrecuenciaPWM <= (posicion0Grados + movServo)) then
			PWM <= '1';
		else
			PWM <= '0';
		end if;
	end process pwmSignal;
end frecuenciaNueva;