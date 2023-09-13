--Top Level Desing: Sumador Completo usando dos medios sumadores y una compuerta OR.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Libreras que me permiten usar el lenguaje VHDL.

--Entidad: Aqui se declaran las entradas y salidas.
entity TopLevelDesign is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Cout : out  STD_LOGIC
			  --Las entradas y salidas en este modulo son solamente las que van a entrar y salir del sumador completo.
			  );
end TopLevelDesign;
--Estas entradas y salidas deben ser asignadas a las entradas o salidas de los demas modulos para que se pueda crear el
--diagrama de bloques TLD completo.

--Arquitectura: Aqui se declaran las instancias de los demas modulos para poder unir entradas, salidas y signals.
architecture Behavioral of TopLevelDesign is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin, su sintaxis es la siguiente:
--signal nombreSignal: tipo_de_dato_vector_o_bit;
signal s1:STD_LOGIC;--Esta suma sale de un medio sumador hacia el otro sumador.
signal c1:STD_LOGIC;--Este acarreo sale de un medio sumador hacia la compuerta OR.
signal c2:STD_LOGIC;--Este es el otro acarreo que sale de un medio sumador hacia la compuerta OR.
--Las signal declaradas son las salidas de los medios sumadores que solo hacen conexiones internas y no salen 
--del bloque global.

--Dentro del begin de la arquitectura es donde debo hacer las instancias de los demas modulos para mandarlos a 
--llamar y poder usarlos para crear el TLD (Top Level Desgin). 
begin
	--INSTANCIAS:
	--Debo darle un nombre a cada instancia que cree, indicar el nombre de la entidad del modulo que quiero instanciar,
	--usar la palabra reservada port map(); y dentro de su parentesis asignarle a todas las entradas y salidas del 
	--modulo instanciado una entrada, salida o signal de este modulo separadas por comas una de la otra, esto hara que 
	--lo que entre o salga del otro modulo, entre, salga o se guarde en este. 
	--La sintaxis que debemos usar es la siguiente:
	
	--NombreInstancia	 	: 		entity work.Entidad_Del_Modulo_Que_Queremos_Instanciar 	port map(
	--		Entrada_Del_Modulo_Instanciado => Entrada_En_Este_Modulo,
	--		Salida_Del_Modulo_Instanciado  => Salida_En_Este_Modulo,
	
	--		Entrada_Del_Modulo_Instanciado => Salida_En_Este_Modulo,
	--		Salida_Del_Modulo_Instanciado  => Entrada_En_Este_Modulo,
	
	--		Entrada_Del_Modulo_Instanciado => Signal_En_Este_Modulo,
	--		Salida_Del_Modulo_Instanciado  => Signal_En_Este_Modulo
	--);

--INSTANCIAS DEL MDULO medioSumador:
--1er Medio Sumador o Half Adder 1 (HA1).
HA1: entity work.nombreEntidadMedioSumador port map(
		AMedSum => A,    --La entrada A del 1er medio sumador se asigna a la entrada A del sumador completo.
		BMedSum => B,    --La entrada B del 1er medio sumador se asigna a la entrada B del sumador completo.
		--Se asigna una signal cuando la salida o entrada de la instancia se usa solo internamente y no sale del 
		--diagrama de bloques que describe el TLD (Top Level Desing).
		sumMedSum => s1, --La salida Suma del 1er medio sumador se guarda en la signal s1 de este modulo.
		coutMedSum => c1 --El acarreo de salida del 1er medio sumador se guarda en la signal c1 de este modulo.
	);
--2do Medio Sumador o Half Adder 1 (HA2):
HA2: entity work.nombreEntidadMedioSumador port map(
		AMedSum => s1,    --La entrada A del 2do medio sumador se asigna a la salida s1 de HA1 guardada en una signal.
		BMedSum => Cin,   --La entrada B del 2do medio sumador se asigna a la entrada Cin del sumador completo.
		sumMedSum => Sum, --La salida Suma del 2do medio sumador se asigna a la salida Sum del sumador completo.
		coutMedSum => C2  --El acarreo de salida del 2do medio sumador se guarda en la signal c2 de este modulo.
	);
--INSTANCIA DEL MODULO compuertaOR:
--Compuerta OR que une los dos medios sumadores HA1 y HA2.
COMPUERTA_OR: entity work.nombreEntidadCompuertaOR port map(
		C1 => c1,        --La entrada C1 de la compuerta OR se asigna a la salida c1 de HA1 guardada en una signal.
		C2 => c2,        --La entrada C2 de la compuerta OR se asigna a la salida c2 de HA2 guardada en una signal.
		SalidaOr => Cout --La salida de la compuerta OR se asigna a la salida Cout del sumador completo.
	);
	
end Behavioral;

