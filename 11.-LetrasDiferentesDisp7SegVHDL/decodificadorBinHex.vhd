--3.-DECODIFICADOR BINARIO A CODIGO LETRERO CON MUX PARA MOSTRARLO EN LOS 4 DISPLAYS DE 7 SEGMENTOS A LA VEZ:
--Este codigo sirve para mostrar 4 letras diferentes de un letrero en los 4 displays de 7 segmentos, esto por si 
--solo no se puede lograr porque los displays de 7 segmentos solo pueden mostrar un solo digito a la vez en todos 
--los displays de la NEXYS 2, para lograrlo debemos usar un Multiplexor, un Divisor de Reloj y un Contador/Selector.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Librerias declaradas para poder hacer operaciones matematicas sin considerar el signo o para hacer conversiones de 
--binario a integer (osea de binario a decimal).

entity decodificadorIPN is
	Port ( selectorMUX : in  STD_LOGIC_VECTOR (1 downto 0);--Selector proveniente del modulo contador.
          prenderDisplay : out  STD_LOGIC_VECTOR (3 downto 0);--Vector de nodos comunes para prender cada display.
          ledsAhastaDP : out  STD_LOGIC_VECTOR (7 downto 0));--Vector con los leds A,B,C,D,E,F y G.
end decodificadorIPN;

architecture Behavioral of decodificadorIPN is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, 
--no esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal anodoEncendido : STD_LOGIC_VECTOR (3 downto 0) := "1111";--En un inicio ningun display esta encendido.
--Este vector servira para prender cada uno de los displays, dependiendo de la letra que corresponda en el letrero.
begin
	--MULTIPLEXOR: Existen muchas entradas y una salida
	--LECTURA DE NUMEROS BINARIOS PARA INTRODUCURLOS EN SU DIGITO HEXADECIMAL CORRESPONDIENTE
	MUX : process(selectorMUX)
	begin
		case(selectorMUX) is
		--Como los displays de 7 segmentos en la FPGA son de nodo comun, debo mandar un 0 logico para que se enciendan 
		--sus leds y/o sus nodos comunes.
			when "00" => ledsAhastaDP <= "10011111";
			--Cuando el selector valga 00, en la salida ledsAhastaDP que se encarga de encender o apagar todos los leds
			--del display, se pondra la letra I.
			when "01" => ledsAhastaDP <= "00110001";
			--Cuando el selector valga 01, en la salida ledsAhastaDP que se encarga de encender o apagar todos los leds
			--del display, se pondra la letra P
			when "10" => ledsAhastaDP <= "00010011";
			--Cuando el selector valga 01, en la salida ledsAhastaDP que se encarga de encender o apagar todos los leds
			--del display, se pondra la letra N.
			when others => ledsAhastaDP <= "11111110";
			--Cuando el selector valga 11, en la salida ledsAhastaDP que se encarga de encender o apagar todos los leds
			--del display, se encendera el punto DP del display.
		end case;
	end process MUX;
	
	--ENCENDER CADA DISPLAY DE 7 SEGMENTOS PARA APARENTAR QUE CADA UNO TIENE UN VALOR DIFERENTE:
	--Como no podemos tener desplegados 4 valores diferentes en los display de 7 segmentos, lo que se hace es que por 
	--medio del selector proveniente del modulo contador con la frecuencia dictada por el divisorDeReloj, este codigo 
	--prenda cada display individualmente tan rapido (osea con una frecuencia tan alta) que nuestros ojos no lo 
	--puedan distinguir y veamos como si estuvieran prendidos al mismo tiempo con valores diferentes, cada display 
	--individual se encendera dependiendo del selector que haya entrado al programa, para asignar a la salida 
	--ledsAhastaDP un valor y prenda los leds A,B,C,D,E,F,G o DP correspondientes en todos los displays, este process 
	--lo que hara es acceder a la salida tipo vector llamada prenderDisplay y mandar un 0 logico al nodo comun del 
	--display, que debe prenderse en cada momento, para que despues el selector cambie de valor y se ejecute 
	--nuevamente el codigo, pero ahora prendiendo diferentes leds y otro display de 7 segmentos.
	elegirDisplay : process(selectorMUX, anodoEncendido) 
	begin
		--En un inicio todos los displays de 7 segmentos estaran apagados.
		prenderDisplay <= "1111";
		--Al usar el nombre de un vector y poner entre parentesis una de sus coordenadas, estoy accediendo solo a ese 
		--bit del vector, ademas con la instruccion conv_integer() estoy convirtiendo lo que haya en el interior de su 
		--parentesis a su equivalente decimal.
		if(anodoEncendido(conv_integer(selectorMUX)) = '1') then
		--Este condicional siempre sera cierto porque el vector anodoEncendido esta inicializado con valor 1111, por lo 
		--que cualquiera de sus coordenadas tiene un 1 logico, lo importante de este condicional es que convierte al 
		--selector en su numero decimal y la coordenada que corresponda la cambia a un 0 logico en el vector 
		--prenderDisplay, que prende cada display dependiendo de los bits que existan en la signal anodoEncendido en ese 
		--momento, determinados por el valor del selector.
			prenderDisplay(conv_integer(selectorMUX)) <= '0';
		end if;
	end process elegirDisplay;
end Behavioral;
