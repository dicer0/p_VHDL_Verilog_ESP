--Declaracion de librerias
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad:Declaracion de entradas/salidas
entity punto2 is
    Port ( v1 : in  STD_LOGIC;
           v2 : in  STD_LOGIC;
           v3 : in  STD_LOGIC;
           v4 : in  STD_LOGIC;
           p1 : in  STD_LOGIC;
           p2 : in  STD_LOGIC;
           p3 : in  STD_LOGIC;
           sal : out  STD_LOGIC);
end punto2;

--Arquitectura:Uso de las entradas/salidas previamente declaradas
architecture AlarmaCasaHabitacion of punto2 is
begin
	sal<=(v1 or v2 or v3 or v4 or p1 or p2 or p3);
end AlarmaCasaHabitacion;
