--Declaracion bibliotecas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad: Parte del codigo VHDL donde se declaran las entradas/salidas
entity punto3b is
    Port ( e1 : in  STD_LOGIC;
           e2 : in  STD_LOGIC;
           timbre : out  STD_LOGIC);
end punto3b;

--Arquitectura:Uso de las entradas/salidas previamente declaradas
architecture prendeLed of punto3b is
begin
	timbre<=e1 and e2;
end prendeLed;
