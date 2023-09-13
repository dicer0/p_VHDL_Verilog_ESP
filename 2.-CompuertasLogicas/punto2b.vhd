--Declaración bibliotecas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad: Parte del código VHDL donde se declaran las entradas/salidas
entity punto2b is
    Port ( e1 : in  STD_LOGIC;
           e2 : in  STD_LOGIC;
           led : out  STD_LOGIC);
end punto2b;

--Arquitectura:Uso de las entradas/salidas previamente declaradas
architecture prendeLed of punto2b is
begin
led<=e1 xor e2;
end prendeLed;