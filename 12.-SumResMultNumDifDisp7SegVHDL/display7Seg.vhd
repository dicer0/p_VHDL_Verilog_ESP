--5.-MUX DISPLAY 7 SEGMENTOS:
--Este codigo sirve para mostrar 4 numeros decimales diferentes en los 4 displays de 7 segmentos, esto por si solo
--no se puede lograr porque los displays de 7 segmentos solo pueden mostrar un solo numero a la vez en todos los 
--displays de la NEXYS 2, para lograrlo debemos usar un Multiplexor, un Divisor de Reloj y un Contador/Selector.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Librerias declaradas para poder hacer operaciones matematicas sin considerar el signo o para hacer conversiones de 
--binario a integer (osea de binario a decimal).

--Entidad: Voy a declarar como entrada 3 vectores que me permitiran introducir el codigo BCD proveniente del modulo
--DecodificadorBinBCD para saber las unidades, decenas y centenas del numero decimal creado por una suma, resta o 
--multiplicacion previa de 2 numeros binarios iniciales, ingresados al programa por medio de switches, las 
--operaciones son realizadas por el modulo sumadorRestadorMultiplicador que ademas manda a este modulo un vector 
--que indica el signo del numero decimal resultante de la operacion, ademas declaro como entrada un selector 
--proveniente del modulo contador que me servira para poder mostrar un numero a la vez en solo uno de los 4 displays 
--de 7 segmentos, esto se debe hacer asi porque en los displays de 7 segmentos solo se puede mostrar un numero a la 
--vez, no se pueden mostrar numeros diferentes en cada display. Las salidas declaradas son los nodos comunes que 
--activan cada display con un 0 logico y los leds A,B,C,D,E,F,G y DP de cada display que tambien se activan con un 0 
--logico para mostrar letras o numeros.
entity display7Seg is
    Port ( signo : in  STD_LOGIC_VECTOR (3 downto 0);--Signo proveniente del modulo sumadorRestadorMultiplicador.
           unidades : in  STD_LOGIC_VECTOR (3 downto 0);--Codigo BCD que representa las unidades.
           decenas : in  STD_LOGIC_VECTOR (3 downto 0);--Codigo BCD que representa las decenas.
           centenas : in  STD_LOGIC_VECTOR (3 downto 0);--Codigo BCD que representa las centenas.
           selectorMUX : in  STD_LOGIC_VECTOR (1 downto 0);--Selector proveniente del modulo contadorSelector.
           prenderDisplay : out  STD_LOGIC_VECTOR (3 downto 0);--Vector de nodos comunes para prender cada display.
           ledsAhastaDP : out  STD_LOGIC_VECTOR (7 downto 0));--Vector con los leds A,B,C,D,E,F,G y DP.
end display7Seg;

--Arquitectura: Aqui se va a hacer un multiplexor que al recibir el selector del modulo contadorSelector, me permita 
--mostrar un numero en solo uno de los displays de 7 segmentos.
architecture mostrar4Valores of display7Seg is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, no 
--esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal digito : STD_LOGIC_VECTOR (3 downto 0);
--El vector digito me permitira realizar la conversion Binario -> Hexadecimal.
begin
	--MULTIPLEXOR: Existen muchas entradas y una salida.
	--ENCENDIDO DE CADA DISPLAY PARA MOSTRAR UNIDADES, DECENAS Y CENTENAS:
	digitoDisplay : process(selectorMUX, unidades, decenas, centenas, digito, signo)
	begin
		case(selectorMUX) is
		--En el vector de entrada binario el bit mas significativo se encuentra en la posicion 15 y el menos 
		--significativo en la posicion 0.
			when "00" =>--UNIDADES
							prenderDisplay <= "1110";
							--Cuando el selector valga 00, la salida de 4 bits llamada prenderDisplay encendera solo el 4to 
							--display mandando un 0 logico a su nodo comun.
							digito <= unidades;
							--Y a la signal digito se le asignara el valor de la entrada unidades.
							
			when "01" =>--DECENAS
							prenderDisplay <= "1101";
							--Cuando el selector valga 01, la salida de 4 bits llamada prenderDisplay encendera solo el 3er 
							--display mandando un 0 logico a su nodo comun.
							digito <= decenas;
							--Y a la signal digito se le asignara el valor de la entrada decenas.
							
			when "10" => --CENTENAS
							prenderDisplay <= "1011";
							--Cuando el selector valga 10, la salida de 4 bits llamada prenderDisplay encendera solo el 2do 
							--display mandando un 0 logico a su nodo comun.
							digito <= centenas;
							--Y a la signal digito se le asignara el valor de la entrada centenas.
							
			when others =>--SIGNO
							prenderDisplay <= "0111";
							--Cuando el selector valga 11, la salida de 4 bits llamada prenderDisplay encendera solo el 1er 
							--display mandando un 0 logico a su nodo comun.
							digito <= signo;
							--Y a la signal digito se le asignara el valor de la entrada signo.
		end case;
	end process digitoDisplay;
	
	
	--DECODIFICADOR: Transforma un codigo de pocos bits a uno de muchos bits, este en particular convierte de codigo 
	--BCD a codigo display 7 segmentos, los bits que mandamos al display de 7 segmentos se consideran como codigo 
	--porque cada combinacion de unos y ceros representa una letra o numero.
	BCDtoDISP7SEG : process(digito) 
	begin
		--NUMEROS HEXADECIMALES EN VHDL: 1 digito hexadecimal equivale a 4 bits en binario, esto nos puede servir para 
		--poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits en VHDL, como cuando 
		--debo llenar un vector de puros ceros, declaro un numero hexadecimal poniendo X"numero hexadecimal".
		case(digito) is
			when X"0" => ledsAhastaDP <= "00000011"; --Pasa de X"0", osea 0000 a 0 en codigo display 7 segmentos.
			when X"1" => ledsAhastaDP <= "10011111"; --Pasa de X"1", osea 0001 a 1 en codigo display 7 segmentos.
			when X"2" => ledsAhastaDP <= "00100101"; --Pasa de X"2", osea 0010 a 2 en codigo display 7 segmentos.
			when X"3" => ledsAhastaDP <= "00001101"; --Pasa de X"3", osea 0011 a 3 en codigo display 7 segmentos.
			when X"4" => ledsAhastaDP <= "10011001"; --Pasa de X"4", osea 0100 a 4 en codigo display 7 segmentos.
			when X"5" => ledsAhastaDP <= "01001001"; --Pasa de X"5", osea 0101 a 5 en codigo display 7 segmentos.
			when X"6" => ledsAhastaDP <= "01000001"; --Pasa de X"6", osea 0110 a 6 en codigo display 7 segmentos.
			when X"7" => ledsAhastaDP <= "00011111"; --Pasa de X"7", osea 0111 a 7 en codigo display 7 segmentos.
			when X"8" => ledsAhastaDP <= "00000001"; --Pasa de X"8", osea 1000 a 8 en codigo display 7 segmentos.
			when X"9" => ledsAhastaDP <= "00001001"; --Pasa de X"9", osea 1001 a 9 en codigo display 7 segmentos.
			when X"F" => ledsAhastaDP <= "11111101"; --Pasa de X"F", osea 1111 a signo negativo.
			--Esto fue elegido de manera random, pudo ser cualquier otro valor el que fuera el signo negativo y
			--para el signo positivo solo haremos que no aparezca nada con la instruccion when others.
		 when others => ledsAhastaDP <= "11111111"; 
		 --Cualquier valor que no hayamos indicado no mostrara nada en el display.
		end case;
	end process BCDtoDISP7SEG;
end mostrar4Valores;
