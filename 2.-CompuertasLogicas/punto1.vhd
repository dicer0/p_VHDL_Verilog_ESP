--Declaracion de librerias
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad: Parte del codigo VHDL donde se declaran las entradas/salidas
entity punto1 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           salidaAND : out  STD_LOGIC;
			  salidaOR : out  STD_LOGIC;
			  salidaNAND : out  STD_LOGIC;
			  salidaNOR : out  STD_LOGIC;
			  salidaXOR : out  STD_LOGIC;
			  salidaXNOR : out  STD_LOGIC;
			  salidaNOTa : out  STD_LOGIC
			  );
end punto1;

--Aqruitectura: Parte del codigo VHDL donde se indican las operaciones logicas que hara el programa con las 
--entradas/salidas.
architecture Compuertas of punto1 is
begin
	salidaAND <= a and b and c;
	salidaOR <= a or b or c;
	salidaNAND <= not(a and b and c);
	--El operador NAND con mas de 2 variables se debe hacer negando la operacion and entre las 3 o mas variables.
	salidaNOR <= not(a or b or c);
	--El operador NOR con mas de 2 variables se debe hacer negando la operacion or entre las 3 o mas variables.
	salidaXOR <= a xor b xor c;
	salidaXNOR <= not(a xor b xor c);
	--El operador XNOR con mas de 2 variables se debe hacer negando la operacion nor entre las 3 o mas variables.
	salidaNOTa <= not a;
end Compuertas;

