--3.-DECODIFICADOR BINARIO A HEXADECIMAL PARA MOSTRARLO EN EL DISPLAY DE 7 SEGMENTOS:
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
    Port ( digito : in  STD_LOGIC_VECTOR (3 downto 0);--Numero binario de 4 bits proveniente del modulo contador.
			  enable : in  STD_LOGIC;--Boton de habilitacion.
           prenderDisplay : out  STD_LOGIC_VECTOR (3 downto 0);--Nodo comun para prender un display.
           ledsAhastaG : out  STD_LOGIC_VECTOR (6 downto 0);--Vector con los leds A,B,C,D,E,F y G.
           DP : out  STD_LOGIC);--Puntito en los displays.
end decodificadorBinHex;

--Arquitectura: Aqui se va a hacer un multiplexor que al recibir el selector del modulo contadorSelector, me permita 
--mostrar un numero en solo uno de los displays de 7 segmentos.
architecture mostrarEnDisplay of decodificadorBinHex is
begin
	--INICIALIZACION DE VALORES
	DP <= '1';--El punto siempre estara apagado.
	
	--PRENDER O APAGAR EL DISPLAY DE 7 SEGMENTOS CON LA ENTRADA ENABLE
	OnOffDisplay : process(enable)
	begin
	--El enable prende o apaga directamente al display de 7 segmentos del conteo, se puso de esta manera porque el 
	--display se prende con un 0 y se apaga con un 1.
		if(enable = '1') then
			prenderDisplay <= "1110";
		else
			prenderDisplay <= "1111";
		end if;
	end process;
	
	--DECODIFICADOR: Transforma un codigo de pocos bits a uno de muchos bits, este en particular convierte de codigo 
	--hexadecimal a codigo display 7 segmentos, los bits que mandamos al display de 7 segmentos se consideran como 
	--codigo porque cada combinacion de unos y ceros representa una letra o numero.
	HEXtoDISP7SEG : process(digito)--A los procesos se les puede poner nombre
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
end mostrarEnDisplay;