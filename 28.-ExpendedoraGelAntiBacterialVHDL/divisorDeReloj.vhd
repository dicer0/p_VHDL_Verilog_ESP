--1.-DIVISOR DE RELOJ:
--Este proceso sirve para dictarle al reloj en que frecuencia quiero que opere.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria declarada para poder hacer operaciones matematicas sin considerar el signo.
entity divisorDeReloj is
    Port ( relojNexys2 : in  STD_LOGIC;   --Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
			  salida50MHz : out  STD_LOGIC;  --Salida CLK de 50MHz proporcionado por la NEXYS 2.
           salidaReloj : out  STD_LOGIC); --Reloj que quiero con una frecuencia menor a 50MHz.
end divisorDeReloj;

--Arquitectura: Aqui se hara el divisor de reloj haciendo uso de una signal y condicionales if.
architecture frecuenciaNueva of divisorDeReloj is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin, se le asignan valores con el simbolo :=
signal divisorDeReloj : STD_LOGIC_VECTOR (24 downto 0);
--Esta signal sirve para que podamos obtener una gran gama de frecuencias indicadas en la tabla del divisor de reloj
--dependiendo de la coordenada que elijamos tomar del vector para asignarsela a la salida.
begin
	process(relojNexys2)
	begin
		if(rising_edge(relojNexys2)) then
			--La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco de subida en
			--la senal de reloj clkNexys2 proveniente de la NEXYS 2.
			divisorDeReloj <= divisorDeReloj + 1;	--Esto crea al divisor de reloj.
		end if;
	end process;
	--Debo asignar el contenido de una coordenada de la signal divisorDeReloj a salidaReloj para obtener una frecuencia 
	--en especifico, cada coordenada del vector corresponde a una frecuencia en la tabla del divisor de reloj.
	salidaReloj <= divisorDeReloj(16);	--En la tabla se ve que la coordenada 19 proporciona una frecuencia de 1.49Hz.
	salida50MHz <= relojNexys2;	--Salida del CLK sin el divisor de reloj para crear la senal PWM.
end frecuenciaNueva;