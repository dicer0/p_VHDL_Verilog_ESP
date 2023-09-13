--Declaracion bibliotecas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad: Parte del codigo VHDL donde se declaran las entradas/salidas
entity punto3d is
    Port ( p1 : in  STD_LOGIC;--Puerta 1
           p2 : in  STD_LOGIC;--Puerta 2
           c1 : out  STD_LOGIC;--Cerrojo 1
           c2 : out  STD_LOGIC);--Cerrojo 2
end punto3d;

--Arquitectura:Uso de las entradas/salidas previamente declaradas
architecture accesoPuerta of punto3d is
begin
	c1<=p1 xor p2;
	c2<=p1 xnor p2;
end accesoPuerta;
