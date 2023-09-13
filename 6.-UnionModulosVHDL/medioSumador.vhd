--MEDIO SUMADOR: Sumador de 2 bits
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--El medio sumador tiene dos entradas A y B de 1 bit y 2 salidas, el resultado de la suma y su acarreo (carry).
entity nombreEntidadMedioSumador is
    Port ( AMedSum : in  STD_LOGIC;
           BMedSum : in  STD_LOGIC;
           sumMedSum : out  STD_LOGIC;
           coutMedSum : out  STD_LOGIC);
end nombreEntidadMedioSumador;

architecture medioSumador of nombreEntidadMedioSumador is
begin
	sumMedSum <= AMedSum xor BMedSum;--Resultado de la suma.
	coutMedSum <= AMedSum and BMedSum;--Acarreo o Carry.
end medioSumador;