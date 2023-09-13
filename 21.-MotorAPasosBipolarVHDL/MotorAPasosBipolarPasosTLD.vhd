--3.-TLD (Top Level Design) MotorAPasosBipolarPasosTLD:
--Este codigo sirve para unir los 2 modulos anteriores y poder aplicar las 5 configuraciones de pasos a un motor 
--bipolar de tipo NEMA 17, para ello primero se ejecuta un divisorDeReloj, del cual se obtiene la frecuencia con la que 
--se encienden y apagan las 2 bobinas A y B del motor, esto indicara su velocidad por medio del pin STEP, adoptando 
--valores de 1 a 1000 Hz, luego en el modulo controlMotor se indica el sentido de giro usando un switch y mandando ese 
--bit al pin DIR del controlador, despues por medio de switches se elige una secuencia, ya sea de paso completo, 1/2 paso
--1/4 de paso, 1/8 de paso o 1/16 de paso, los 3 bits que sirven para elegir el paso se asignan a los pines de micro 
--stepping MS1, MS2 y MS3, dirigidas al controlador A4988.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.

--Declaramos como entradas y salidas solo los pines que salgan del diagrama de bloques global en mi TLD, esto se ve 
--en el documento 8.2.-Senal de reloj CLK Solamente en VHDL.
entity MotorAPasosBipolarPasosTLD is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  direcc : in  STD_LOGIC;
			  secuenciaPasos : in  STD_LOGIC_VECTOR (2 downto 0);
			  microStepping : out  STD_LOGIC_VECTOR (2 downto 0);
			  ledsMicroStepping : out  STD_LOGIC_VECTOR (2 downto 0);
           ledDirecc : out  STD_LOGIC;
			  STEP : out  STD_LOGIC;
			  dirPin : out  STD_LOGIC);
end MotorAPasosBipolarPasosTLD;

--Arquitectura: Aqui voy a declarar todas las instancias de mis demas modulos para poderlos usar y sus signal.
architecture Behavioral of MotorAPasosBipolarPasosTLD is
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
			relojNexys2 => clk,
			--La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clk de este modulo.
			reset => rst,
			--La entrada reset del divisorDeReloj se asigna a la entrada rst de este modulo.
			salidaReloj => STEP
			--La salida salidaReloj del divisorDeReloj se asigna a la salida STEP de este modulo.
		);
	--INSTANCIA DEL MODULO controlPasosMotor
	motorNEMA17: entity work.controlPasosMotor port map(
			direccionGiro => direcc,
			--La entrada direccionGiro del controlPasosMotor se asigna a la entrada direcc de este modulo.
			selectPaso => secuenciaPasos,
			--La entrada selectPaso del controlPasosMotor se asigna a la entrada secuenciaPasos de este modulo.
			M_S => microStepping,
			--La salida M_S del controlPasosMotor se asigna a la salida microStepping de este modulo.
			ledMS => ledsMicroStepping,
			--La salida ledMS del controlPasosMotor se asigna a la salida ledsMicroStepping de este modulo.
			DIR => dirPin,
			--La salida DIR del controlPasosMotor se asigna a la salida dirPin de este modulo.
			ledDireccion => ledDirecc
			--La salida ledDireccion del controlPasosMotor se asigna a la salida ledDirecc de este modulo.
		);
end Behavioral;