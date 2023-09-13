--3.-DECODIFICADOR BINARIO A HEXADECIMAL CON MUX PARA MOSTRARLO EN LOS 4 DISPLAYS DE 7 SEGMENTOS A LA VEZ:
--Este codigo sirve para mostrar 4 numeros hexadecimales diferentes en los 4 displays de 7 segmentos, esto por si solo
--no se puede lograr porque los displays de 7 segmentos solo pueden mostrar un solo numero a la vez en todos los 
--displays de la NEXYS 2, para lograrlo debemos usar un Multiplexor, un Divisor de Reloj y un Contador/Selector.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Librerias declaradas para poder hacer operaciones matematicas sin considerar el signo o para hacer conversiones de 
--binario a integer (osea de binario a decimal).

--Entidad: Voy a declarar como entrada un vector que me permitira introducir el numero binario por medio de switches
--y un selector proveniente del modulo contador que me servira para poder mostrar un numero a la vez en solo uno de 
--los 4 displays de 7 segmentos, esto se debe hacer asi porque en los displays de 7 segmentos solo se puede mostrar 
--un numero a la vez, no se pueden mostrar numeros diferentes en cada display. Las salidas declaradas son los nodos 
--comunes que activan cada display con un 0 logico y los leds A,B,C,D,E,F y G de cada display que tambien se activan 
--con un 0 logico para mostrar letras o numeros, se declara aparte el DP, osea el led que prende el puntito en todos 
--los displays de 7 segmentos.
entity decodificadorBinHex is
    Port ( binario : in  STD_LOGIC_VECTOR (15 downto 0);--Entrada para meter un numero binario por medio de switches.
           selectorMUX : in  STD_LOGIC_VECTOR (1 downto 0);--Selector proveniente del modulo contador.
           prenderDisplay : out  STD_LOGIC_VECTOR (3 downto 0);--Vector de nodos comunes para prender cada display.
           ledsAhastaG : out  STD_LOGIC_VECTOR (6 downto 0);--Vector con los leds A,B,C,D,E,F y G.
           DP : out  STD_LOGIC);--Puntito en los displays.
end decodificadorBinHex;

--Arquitectura: Aqui se va a hacer un multiplexor que al recibir el selector del modulo contadorSelector, me permita 
--mostrar un numero en solo uno de los displays de 7 segmentos.
architecture binarioAhexadecimal of decodificadorBinHex is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, no 
--esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal anodoEncendido : STD_LOGIC_VECTOR (3 downto 0) := "1111";--En un inicio ningun display esta encendido.
--Este vector me servir para prender cada uno de los displays, dependiendo de si el numero binario tiene solo 
--unidades, decenas o centenas y asi poder mostrar su equivalente correspondiente en hexadecimal.
signal digito : STD_LOGIC_VECTOR (3 downto 0);
--El vector digito me permitira realizar la conversion Binario -> Hexadecimal.
begin
	--INICIALIZACION DE VALORES
	DP <= '1';--El punto siempre estara apagado.
	
	--MULTIPLEXOR: Existen muchas entradas y una salida.
	--LECTURA DE NUMEROS BINARIOS PARA INTRODUCURLOS EN SU DIGITO HEXADECIMAL CORRESPONDIENTE.
	MUX : process(selectorMUX, binario)
	begin
		case(selectorMUX) is
		--En el vector de entrada binario el bit mas significativo se encuentra en la posicion 15 y el menos 
		--significativo en la posicion 0.
			when "00" => digito <= binario(3 downto 0);
			--Cuando el selector valga 00, la signal de 4 bits llamada digito se llenara de los ultimos 4 bits que haya 
			--en la entrada que recibe el numero binario, desde la posicion 3 hasta la 0.
			when "01" => digito <= binario(7 downto 4);
			--Cuando el selector valga 01, digito se llenara de los 4 penultimos bits que haya en la entrada que recibe 
			--el numero binario, desde la posicion 7 hasta la 4.
			when "10" => digito <= binario(11 downto 8);
			--Cuando el selector valga 10, digito se llenara de los 4 segundos bits que haya en la entrada que recibe 
			--el numero binario, desde la posicion 11 hasta la 8.
			when others => digito <= binario(15 downto 12);--La ultima posibilidad de un case se pone como when others.
			--Cuando el selector valga 11, digito se llenara de los 4 primeros bits que haya en la entrada que recibe 
			--el numero binario, desde la posicion 15 hasta la 12.
		end case;
	end process MUX;
	
	--DECODIFICADOR: Transforma un codigo de pocos bits a uno de muchos bits, este en particular convierte de codigo 
	--hexadecimal a codigo display 7 segmentos, los bits que mandamos al display de 7 segmentos se consideran como 
	--codigo porque cada combinacion de unos y ceros representa una letra o numero.
	HEXtoDISP7SEG : process(digito) 
	begin
		--NUMEROS HEXADECIMALES EN VHDL: 1 digito hexadecimal equivale a 4 bits en binario, esto nos puede servir para 
		--poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits en VHDL, como cuando 
		--debo llenar un vector de puros ceros, declaro un numero hexadecimal poniendo X"numero hexadecimal".
		case(digito) is
			when X"0" => ledsAhastaG <= "0000001"; --Pasa de X"0", osea 0000 a 0 en codigo display 7 segmentos.
			when X"1" => ledsAhastaG <= "1001111"; --Pasa de X"1", osea 0001 a 1 en codigo display 7 segmentos.
			when X"2" => ledsAhastaG <= "0010010"; --Pasa de X"2", osea 0010 a 2 en codigo display 7 segmentos.
			when X"3" => ledsAhastaG <= "0000110"; --Pasa de X"3", osea 0011 a 3 en codigo display 7 segmentos.
			when X"4" => ledsAhastaG <= "1001100"; --Pasa de X"4", osea 0100 a 4 en codigo display 7 segmentos.
			when X"5" => ledsAhastaG <= "0100100"; --Pasa de X"5", osea 0101 a 5 en codigo display 7 segmentos.
			when X"6" => ledsAhastaG <= "0100000"; --Pasa de X"6", osea 0110 a 6 en codigo display 7 segmentos.
			when X"7" => ledsAhastaG <= "0001101"; --Pasa de X"7", osea 0111 a 7 en codigo display 7 segmentos.
			when X"8" => ledsAhastaG <= "0000000"; --Pasa de X"8", osea 1000 a 8 en codigo display 7 segmentos.
			when X"9" => ledsAhastaG <= "0000100"; --Pasa de X"9", osea 1001 a 9 en codigo display 7 segmentos.
			when X"A" => ledsAhastaG <= "0001000"; --Pasa de X"A", osea 10, osea 1010 a A en codigo display 7 segmentos.
			when X"B" => ledsAhastaG <= "1100000"; --Pasa de X"B", osea 11, osea 1011 a b en codigo display 7 segmentos.
			when X"C" => ledsAhastaG <= "0110001"; --Pasa de X"C", osea 12, osea 1100 a C en codigo display 7 segmentos.
			when X"D" => ledsAhastaG <= "1000010"; --Pasa de X"D", osea 13, osea 1101 a d en codigo display 7 segmentos.
			when X"E" => ledsAhastaG <= "0110000"; --Pasa de X"E", osea 14, osea 1110 a E en codigo display 7 segmentos.
			when others => ledsAhastaG <= "0111000"; 
			--Pasa de X"F", osea 15, osea 1111 a F en codigo display 7 segmentos.
		end case;
	end process HEXtoDISP7SEG;
	
	--ENCENDER CADA DISPLAY DE 7 SEGMENTOS PARA APARENTAR QUE CADA UNO TIENE UN VALOR DIFERENTE:
	--Como no podemos tener desplegados 4 valores diferentes en los display de 7 segmentos, lo que se hace es que por 
	--medio del selector proveniente del modulo contador con la frecuencia dictada por el divisorDeReloj, este codigo 
	--prenda cada display individualmente tan rapido (osea con una frecuencia tan alta) que nuestros ojos no lo puedan 
	--distinguir y veamos como si estuvieran prendidos al mismo tiempo con valores diferentes, cada display individual 
	--se encendera dependiendo del selector que haya entrado al programa, para luego asignar a la signal digito un valor 
	--determinado dependiendo de los switches que esten activados en la entrada hexadecimal y por ultimo prenda los 
	--leds A,B,C,D,E,F o G correspondientes en todos los displays, este process lo que hara es que acceder a la salida 
	--tipo vector llamada prenderDisplay y mandar un 0 logico al nodo comun del display que se debe prender en ese 
	--momento, para que despues el selector cambie de valor y se ejecute nuevamente el codigo pero ahora prendiendo 
	--diferentes leds y otro display de 7 segmentos.
	elegirDisplay : process(selectorMUX, anodoEncendido) 
	begin
		--En un inicio todos los displays de 7 segmentos estaran apagados.
		prenderDisplay <= "1111";
		--Al usar el nombre de un vector y poner entre parentesis una de sus coordenadas, estoy accediendo solo a ese bit 
		--del vector, ademas con la instruccion conv_integer() estoy convirtiendo lo que haya en el interior de su 
		--parentesis a su equivalente decimal.
		if(anodoEncendido(conv_integer(selectorMUX))= '1') then
		--Este condicional siempre sera cierto porque el vector anodoEncendido esta inicializado con valor 1111, por lo 
		--que cualquiera de sus coordenadas tiene un 1 logico, lo importante de este condicional es que convierte al 
		--selector en su numero decimal y la coordenada que corresponda la cambia a un 0 logico en el vector 
		--prenderDisplay, que prende cada display dependiendo de los bits que existan en la signal digito en ese momento,
		--determinados por el valor del selector.
			prenderDisplay(conv_integer(selectorMUX)) <= '0';
		end if;
	end process elegirDisplay;
end binarioAhexadecimal;

