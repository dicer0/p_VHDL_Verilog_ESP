--Los comentarios se ponen con dos guiones seguidos
--El lenguaje VHDL no distingue entre mayusculas y minusculas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las libreras IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL

--La ENTIDAD es donde declaro mis entradas y salidas, empieza con la palabra reservada is y termina con end, las 
--entradas y salidas se ponen dentro de Port(); y usan las palabras reservadas in y out aparte de la librera STD_LOGIC;
entity nombreModulo is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           salidaAND : out  STD_LOGIC;
           salidaOR : out  STD_LOGIC;
           salidaNAND1 : out  STD_LOGIC;
           salidaNAND2 : out  STD_LOGIC;
           salidaNOR1 : out  STD_LOGIC;
           salidaNOR2 : out  STD_LOGIC;
           salidaXOR : out  STD_LOGIC;
           salidaXNOR1 : out  STD_LOGIC;
           salidaXNOR2 : out  STD_LOGIC;
           salidaNOTa : out  STD_LOGIC);
end nombreModulo;
--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene el nombre del modulo, empieza con begin y 
--termina con end mas el nombre de la arquitectura.
architecture nombreArquitectura of nombreModulo is
begin
	salidaAND   <= a and b and c;			--Compuerta AND de 3 entradas.
	salidaOR    <= a or b or c;			--Compuerta OR de 3 entradas.
	salidaNAND1 <= a nand b;				--Compuerta NAND de 2 entradas, NAND = NOT AND.
	salidaNAND2 <= not(a and b and c);	--Compuerta NAND de 3 entradas, NAND = NOT AND.
	salidaNOR1  <= a nor b;					--Compuerta NOR de 2 entradas, NOR = NOT OR.
	salidaNOR2  <= not(a or b or c);		--Compuerta NOR de 3 entradas, NOR = NOT OR.
	salidaXOR   <= a xor b xor c;			--Compuerta XOR de 3 entradas.
	salidaXNOR1 <= a xnor b;				--Compuerta XNOR de 2 entradas, XNOR = NOT XOR.
	salidaXNOR2 <= not(a xor b xor c);	--Compuerta XNOR de 2 entradas, XNOR = NOT XOR.
	salidaNOTa  <= not a;					--Compuerta NOT de 1 entrada.	
--Las compuertas logicas NAND, NOR y XNOR no se puede hacer de forma directa cuando se tratan 3 variables, para poder
--hacerlo se debe negar toda la operacion, pero con 2 variables si se puede aplicar el operador directamente.
end nombreArquitectura;

