--3.-TLD (Top Level Design) MotorAPasosUnipolarMedioPasoTLD:
--Este codigo sirve para unir los 2 modulos anteriores y poder aplicar la configuracion de paso simple a un motor a pasos
--unipolar modelo 28BYJ-48, para ello primero se ejecuta un divisorDeReloj, del cual se obtiene la frecuencia con la que 
--se encienden y apagan las 4 bobinas A, B, C y D del motor, esto indicara su velocidad, que estara siempre limitada por 
--el sistema de engranajes reductor que tiene en su salida, finalmente en el modulo controlMotor se inicia un contador en 
--donde se ejecutan las 4 acciones de la secuencia de paso simple y se asigna las senales pertinentes a las 4 salidas 
--dirigidas al motor a pasos. 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.

--Declaramos como entradas y salidas solo los pines que salgan del diagrama de bloques global en mi TLD, esto se ve 
--en el documento 8.2.-Senal de reloj CLK Solamente en VHDL.
entity MotorAPasosUnipolarMedioPasoTLD is
    Port ( direcc : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  bobinasMotor : out  STD_LOGIC_VECTOR (3 downto 0); --Senales dirigidas a las 4 bobinas A, B, C y D.
           ledDirecc : out  STD_LOGIC);
end MotorAPasosUnipolarMedioPasoTLD;

--Arquitectura: Aqui voy a declarar todas las instancias de mis demas modulos para poderlos usar y sus signal.
architecture Behavioral of MotorAPasosUnipolarMedioPasoTLD is
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
			relojNexys2 => clk,
			--La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clk de este modulo.
			reset => rst,
			--La entrada reset del divisorDeReloj se asigna a la entrada rst de este modulo.
			salidaReloj => alambre_int
			--La salida salidaReloj del divisorDeReloj se asigna a la signal alambre_int de este modulo.
		);
	--INSTANCIA DEL MODULO controlPasosMotor
	motor28BYJ_48: entity work.controlPasosMotor port map(
			direccionGiro => direcc,
			--La entrada direccionGiro del controlPasosMotor se asigna a la entrada direcc de este modulo.
			frecuencia => alambre_int,
			--A la entrada frecuencia del controlPasosMotor se le asigna el valor de la signal alambre_int de este modulo.
			salidaMotor => bobinasMotor,
			--La salida salidaMotor del controlPasosMotor se asigna a la salida bobinasMotor de este modulo.
			ledDireccion => ledDirecc
			--La salida ledDireccion del controlPasosMotor se asigna a la salida ledDirecc de este modulo.
		);
end Behavioral;