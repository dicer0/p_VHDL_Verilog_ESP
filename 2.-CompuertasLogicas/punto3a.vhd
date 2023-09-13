--Declaracion bibliotecas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad: Parte del codigo VHDL donde se declaran las entradas/salidas
entity punto3a is
    Port ( sw1 : in  STD_LOGIC;
           sw2 : in  STD_LOGIC;
           encFoco : out  STD_LOGIC);
end punto3a;

--Arquitectura:Uso de las entradas/salidas previamente declaradas
architecture PrendidoApagado of punto3a is
begin
	encFoco<=sw1 xor sw2;
end PrendidoApagado;