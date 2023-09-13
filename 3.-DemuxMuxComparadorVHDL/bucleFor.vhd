--DEMUX DE 1 ENTRADA Y 2 SALIDAS
--BUCLE FOR CON EL LENGUAJE VHDL: En VHDL para interactuar con un bucle for se necesita crear un 
--tipo de dato llamado variable, este puede ser de 1 bit, un vector (numero binario) o hasta puede 
--ser un valor numerico entero.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las librerias IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL.

--La ENTIDAD es donde declaro mis entradas y salidas
entity demuxBucleFor is
    Port ( entrada : in  STD_LOGIC; --Entrada de 1 bit.
			  salidaBit : out  STD_LOGIC; --Salida de 1 bit.
			  --Salida tipo vector de 5 bits.
           salidaNumBinario : out  STD_LOGIC_VECTOR (4 downto 0));
end demuxBucleFor;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end 
--nombreArquitectura;
architecture Behavioral of demuxBucleFor is
begin--Dentro de la arquitectura es donde se declaran los condicionales y bucles.
	--BUCLE FOR: Bucle definido que se ejecuta varias veces.
	--process se usa para poder usar condicionales o bucles y tiene su propio begin y end process;
	process(entrada) --La entrada no se utilizara para centrarnos mas en el funcionamiento del for.
	--Dentro del process pero antes de su begin es donde se declaran las variables de tipo 
	--variable que interactuan con el bucle for.
	variable varBucleFor: STD_LOGIC_VECTOR (5 downto 0); --Variable tipo vector de 6 bits.
	
		begin
		--El bucle for se ejecutara varias veces para rellenar los bits de un vector de tipo 
		--variable con un 1 logico, parte de un numero inicial indicado antes de la palabra reservada 
		--"in" y llega hasta el numero indicado despues de "to", tocando ese limite.
			for i in 0 to 5 loop --Bucle que se ejecuta 6 veces.
				--Ahora accederemos a las 6 posiciones de la variable varBucleFor, ademas a las 
				--variables se les asigna valores con el simbolo := en VHDL.
				varBucleFor(i) := '1';
			end loop;
			
			--Reemplazo el numero 111111 del vector varBucleFor por el numero 010111, cambie solo sus 
			--coordenadas 5, 4 y 3.
			varBucleFor(5 downto 3):= "010";
			
			--A las salidas les asigno valores usando el simbolo <=
			--A las variables les asigno valores usando el simbolo :=
			--varBucleFor = 010111
			salidaNumBinario <= varBucleFor(4 downto 0); --salidaNumBinario = 10111
			salidaBit <= varBucleFor(5); 						--salidaBit = 0
		end process;
end Behavioral;