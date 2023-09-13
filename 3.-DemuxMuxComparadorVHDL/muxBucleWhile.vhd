--BUCLE WHILE CON EL LENGUAJE VHDL: En VHDL para interactuar con un bucle while se necesita crear 
--un tipo de dato llamado variable, este puede ser de 1 bit, un vector (numero binario) o hasta 
--puede ser un valor numerico entero.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las libreras IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL

--La ENTIDAD es donde declaro mis entradas y salidas
entity muxBucleWhile is
    Port ( entrada : in  STD_LOGIC; --Entrada de 1 bit.
           salidaBit : out  STD_LOGIC; --Salida de 1 bit.
			  --Salida tipo vector de 5 bits.
           salidaNumBinario : out  STD_LOGIC_VECTOR (4 downto 0));
end muxBucleWhile;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end 
--nombreArquitectura;
architecture Behavioral of muxBucleWhile is
begin--Dentro de la arquitectura es donde se declaran los condicionales y bucles.
	--BUCLE WHILE: Bucle indefinido que se puede ejecutar sin nunca terminar.
	--process se usa para poder usar condicionales o bucles y tiene su propio begin y end process;
	process(entrada)
	--Dentro del process pero antes de su begin es donde se declaran las variables de tipo 
	--variable que interactuan con el bucle for.
	variable varBucleWhile: STD_LOGIC_VECTOR (5 downto 0); --Variable tipo vector de 6 bits.
	variable i: integer := 6;
	
	begin
		--El bucle while se ejecutara varias veces para rellenar los bits de un vector de tipo 
		--variable con un 1 logico, esto lo hara ejecutandose indefinidamente hasta que su 
		--condicion se cumpla (sea True), en este caso esa condicion es que la variable i sea menor 
		--a 6.
			while (i < 6) loop --Bucle que se ejecuta 6 veces.
				--Ahora accederemos a las 6 posiciones de la variable varBucleFor, ademas a las 
				--variables se les asigna valores con el simbolo := en VHDL.
				varBucleWhile(i) := '1';
			end loop;
			
			--Reemplazo el numero 111111 del vector varBucleWhile por el numero 010111, cambie solo sus 
			--coordenadas 5, 4 y 3.
			varBucleWhile(5 downto 3):= "010";
			
			--A las salidas les asigno valores usando el simbolo <=
			--A las variables les asigno valores usando el simbolo :=
			--varBucleWhile = 010111
			salidaNumBinario <= varBucleWhile(4 downto 0); --salidaNumBinario = 10111
			salidaBit <= varBucleWhile(5); 						--salidaBit = 0
		end process;
end Behavioral;
