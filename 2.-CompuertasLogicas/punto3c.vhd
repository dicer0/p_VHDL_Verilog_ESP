--Declaracion de libreras
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad: Parte del codigo VHDL donde se declaran las entradas/salidas
entity punto3c is
    Port ( persona : in  STD_LOGIC;
           temperatura : in  STD_LOGIC;
           ventilador : out  STD_LOGIC);
end punto3c;

--Arquitectura:Uso de las entradas/salidas previamente declaradas
architecture Ambientacion of punto3c is
begin
	ventilador<=persona or temperatura;
end Ambientacion;
