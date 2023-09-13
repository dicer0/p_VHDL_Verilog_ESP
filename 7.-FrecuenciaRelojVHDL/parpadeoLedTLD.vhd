--TLD: Parpadeo Led
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Declaramos como entradas y salidas solo los pines que salgan del diagrama de bloques global en mi TLD, esto se ve 
--en el documento 8.2.-Senal de reloj CLK Solamente en VHDL.
entity parpadeoLedTLD is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           led_out : out  STD_LOGIC);
end parpadeoLedTLD;

--Arquitectura: Aqui voy a declarar todas las instancias de mis demas modulos para poderlos usar y sus signal.
architecture Behavioral of parpadeoLedTLD is
--Signal: Es un tipo de dato que sirve para almacenar un valor que no salga del bloque global TLD.
signal alambre_int : STD_LOGIC;
--Las signal se declaran antes del begin de la arquitectura.
begin
--INSTANCIAS:
	--Debo darle un nombre a cada instancia que cree, indicar el nombre de la entidad del modulo que quiero instanciar,
	--usar la palabra reservada port map(); y dentro de su parentesis asignarle a todas las entradas y salidas del 
	--modulo instanciado una entrada, salida o signal de este modulo, separadas por comas una de la otra, esto hara que 
	--lo que entre o salga del otro modulo entre, salga o se guarde en este. 
	--La sintaxis que debemos usar es la siguiente:
	
	--NombreInstancia	 	: 		entity work.Entidad_Del_Modulo_Que_Queremos_Instanciar 	port map(
	--		Entrada_Del_Modulo_Instanciado => Entrada_En_Este_Modulo,
	--		Salida_Del_Modulo_Instanciado  => Salida_En_Este_Modulo,
	
	--		Entrada_Del_Modulo_Instanciado => Salida_En_Este_Modulo,
	--		Salida_Del_Modulo_Instanciado  => Entrada_En_Este_Modulo,
	
	--		Entrada_Del_Modulo_Instanciado => Signal_En_Este_Modulo,
	--		Salida_Del_Modulo_Instanciado  => Signal_En_Este_Modulo
	--);
	
	--INSTANCIA DEL MODULO divisorDeReloj
	Divisor_frec: entity work.divisorDeReloj port map(
			relojEntrada50MHz => clk,
			reset => rst,
			relojSalida => alambre_int
		);
	--INSTANCIA DEL MODULO encenderApagarLed
	LED: entity work.encenderApagarLed port map(
			entrada => alambre_int,
			salida => led_out
		);
end Behavioral;