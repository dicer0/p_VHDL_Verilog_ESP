--Compuerta OR, esta se usa para unir el acarreo de los dos medios sumadores para obtener el carry de salida del 
--sumador completo llamado Cout.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Esta es una simple compuerta OR en el diagrama de bloques.
entity nombreEntidadCompuertaOR is
    Port ( C1 : in  STD_LOGIC;
           C2 : in  STD_LOGIC;
           SalidaOr : out  STD_LOGIC);
end nombreEntidadCompuertaOR;

architecture compuertaOR of nombreEntidadCompuertaOR is
begin
	SalidaOr <= C1 or C2;--Compuerta OR que recibe los dos acarreos de salida del medio sumador 1 y 2.
end compuertaOR;
