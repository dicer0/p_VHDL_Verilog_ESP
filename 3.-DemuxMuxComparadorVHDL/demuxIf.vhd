--DEMULTIPLEXOR DE 9 SALIDAS USANDO EL CONDICIONAL IF
--Los Demultiplexores reciben una senal de entrada (el selector) y pueden dar varias senales digitales de salida 
--diferentes en forma de vector, el vector es un numero binario con un numero de bits constante, cada bit funciona 
--como variable y puede adoptar cualquiera de los valores digitales, ya sea 1 logico, 0 logico o Z alta impedancia. 
--Del vector puedo extraer cada bit individualmente y mandarlos por medio de un BUS al elemento electronico que yo 
--quiera.
--BUS es un conjunto de cables, en cada cable se transmitiran individualmente los valores que vaya adoptando cada bit 
--de la senal digital de salida (osea el numero binario) y se podra elegir cualquiera de las senales de salida 
--disponibles por medio del selector.
--El numero de salidas disponibles que tengo van en funcion del tamano del selector, si selector es de pocos bits 
--puedo elegir pocas posibles salidas y viceversa.

--El Demultiplexor puede recibir dos senales de entrada en vez de solo el selector, la segunda entrada se llama 
--enable y sirve para encender o apagar el demux, ya que, si el enable esta en cero, todos los bits de la salida 
--estaran en cero.

--El tamano del numero binario del selector se calcula de la siguiente manera: 
--#salidas = 2 ^(#bits del selector)
--16 = 2 ^(4)
--Por lo tanto, si tengo 9 bits en mi vector de salida, el # de bits del selector debe ser de 4, osea [3:0]
--Este mismo numero de bits en el selector funciona tambien para cuando tengo 10, 11, 12, 13, 14, 15 o 16 bits en el 
--vector de salida. Este calculo es para que pueda abarcar todas las salidas posibles en funcin al numero de bits 
--en mi vector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las libreras IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL

--La ENTIDAD es donde declaro mis entradas y salidas
entity demuxIf is
    Port ( selector : in  STD_LOGIC_VECTOR (3 downto 0);
           enable : in  STD_LOGIC;
           salida : out  STD_LOGIC_VECTOR (8 downto 0));
			  --El tamano del selector y el tamano de la salida no dependen uno del otro
end demuxIf;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end nombreArquitectura;
architecture nombreArquitectura of demuxIf is
begin
	--CONDICIONAL IF
	--process se usa para poder usar condicionales o bucles y tiene su propio begin y end process;
	process (selector, enable)
		--process(dentro de su parentesis debo poner las entradas que vaya a usar en el condicional)
		--las diferentes entradas se separan entre si por comas
		begin
			if (selector = "0001") then salida <= "00000000" & enable;            
				--selector con valor decimal 1 = salida 000000001 de 9 bits
				elsif (selector = "0010") then salida <= "0000000" & enable & "0";
				--selector con valor decimal 2 = salida 000000010 de 9 bits
				elsif (selector = "0011") then salida <= "000000" & enable & "00";
				--selector con valor decimal 3 = salida 000000100 de 9 bits
				elsif (selector = "0100") then salida <= "00000" & enable & "000";
				--selector con valor decimal 4 = salida 000001000 de 9 bits
				elsif (selector = "0101") then salida <= "0000" & enable & "0000";
				--selector con valor decimal 5 = salida 000010000 de 9 bits
				elsif (selector = "0110") then salida <= "000" & enable & "00000";
				--selector con valor decimal 6 = salida 000100000 de 9 bits
				elsif (selector = "0111") then salida <= "00" & enable & "000000";
				--selector con valor decimal 7 = salida 001000000 de 9 bits
				elsif (selector = "1000") then salida <= "0" & enable & "0000000";
				--selector con valor decimal 8 = salida 010000000 de 9 bits
				elsif (selector = "1001") then salida <= enable & "00000000";
				--selector con valor decimal 9 = salida 100000000 de 9 bits
				--Para la ultima condicion (o ultimas condiciones) siempre debo usar la instruccion else 
				--perteneciente al condicional if
				else salida <= "ZZZZZZZZZ";
				--selector con valor decimal 0, 10, 11, 12, 13, 14, 15 o 16 = salida ZZZZZZZZZ de 9 bits
			end if;
			--Todos los elsif (que son los else if de VHDL) y el else deben ir dentro del if y end if;
		end process;--Al final de end process debo poner punto y coma ;
end nombreArquitectura;--Al final del end de la arquitectura debo poner punto y coma ;

