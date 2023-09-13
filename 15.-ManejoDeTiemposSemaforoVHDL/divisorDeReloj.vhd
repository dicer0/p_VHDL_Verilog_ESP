--1.-DIVISOR DE RELOJ:
--Este proceso sirve para dictarle al reloj en que frecuencia quiero que opere.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria declarada para poder hacer operaciones matematicas sin considerar el signo.

entity divisorDeReloj is
    Port ( relojNexys2 : in  STD_LOGIC;   --Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
           rst : in  STD_LOGIC;           --Boton de reset.
           salidaReloj : out  STD_LOGIC); --Reloj que quiero con una frecuencia menor a 50MHz.
end divisorDeReloj;

architecture frecuenciaNueva of divisorDeReloj is

signal divisorDeReloj : STD_LOGIC_VECTOR (25 downto 0);

begin
	process(relojNexys2, rst)
	begin
		if(rst='1') then
			divisorDeReloj <= "00000000000000000000000000";
		elsif(rising_edge(relojNexys2)) then
			divisorDeReloj <= divisorDeReloj + 1;
		end if;
	end process;

	salidaReloj <= divisorDeReloj(25);
	--La coordenada 25 corresponde a una frecuencia de 0.745Hz, obtenida con la formula.
end frecuenciaNueva;