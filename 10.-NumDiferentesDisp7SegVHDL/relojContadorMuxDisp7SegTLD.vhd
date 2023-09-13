--4.-TLD (Top Level Design) relojContadorMuxDisp7SegVHDL:
--Este codigo sirve para unir los 3 modulos anteriores y poder realizar el decodificador binario a hexadecimal y 
--mostrar en los 4 displays de 7 segmentos diferentes valores por medio del divisorDeReloj, el contadorSelector, el 
--Multiplexor y el Decodificador Binario a Hexadecimal.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.

--Entidad: Las entradas y salidas en este modulo son las que van a entrar y salir del diagrama de bloques global.
entity relojContadorMuxDisp7SegTLD is
    Port ( numBinario : in  STD_LOGIC_VECTOR (15 downto 0);
           Reset : in  STD_LOGIC;
           clkNexys2 : in  STD_LOGIC;
           numHexadecimal : out  STD_LOGIC_VECTOR (6 downto 0);
           puntoDisplay : out  STD_LOGIC;
           anodoComun : out  STD_LOGIC_VECTOR (3 downto 0));
end relojContadorMuxDisp7SegTLD;

--Arquitectura: Aqui se declaran las instancias de los demas modulos para poder unir entradas, salidas y signals.
architecture encenderDisplaysTLD of relojContadorMuxDisp7SegTLD is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin.
signal reloj : STD_LOGIC;--Reloj con frecuencia menor a 50MHz.
signal selector : STD_LOGIC_VECTOR (1 downto 0);--Contador/selector para encender cada display de 7 segmentos.
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
	
	--INSTANCIA DEL MODULO divisorDeReloj para obtener la frecuencia en la que quiero que se cree el contador/selector.
	frecuenciaReloj : entity work.divisorDeReloj port map(
			relojNexys2 => clkNexys2,  
			--La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clkNexys2 de este modulo.
			rst => Reset,
			--La entrada rst del divisorDeReloj se asigna a la entrada Reset de este modulo.
			salidaReloj => reloj
			--La salida salidaReloj del divisorDeReloj se asigna a la signal reloj de este modulo.
		);
	--INSTANCIA DEL MODULO contadorSelector para obtener el contador/selector que prendera cada display individualmente.
	selectorDisplay : entity work.contadorSelector port map(
			frecuenciaReloj => reloj,
			--A la entrada frecuenciaReloj del contadorSelector se le asigna el valor de la signal reloj de este modulo.
			contador => selector
			--La salida contador del contadorSelector se asigna a la signal selector de este modulo.
		);
	--INSTANCIA DEL MODULO decodBinHex para cambiar de sistema numerico binario a hexadecimal, recibir el selector del 
	--contador y prender cada uno de los 4 displays dependiendo del numero binario que este recibiendo y con la 
	--frecuencia del selector, prender y apagar los 4 displays tan rapido que para el ojo humano parezca que todos estan 
	--encendidos al mismo tiempo con valores diferentes.
	binarioAhexadecimal : entity work.decodificadorBinHex port map(
			binario => numBinario,  
			--La entrada binario de decodificadorBinHex se asigna a la entrada numBinario de este modulo.
			selectorMUX => selector,  
			--A la entrada selectorMUX de decodificadorBinHex se le asigna el valor de la signal selector de este modulo.
			prenderDisplay => anodoComun,  
			--La salida prenderDisplay de decodificadorBinHex se asigna a la salida anodoComun de este modulo.
			ledsAhastaG => numHexadecimal,  
			--La salida ledsAhastaG de decodificadorBinHex se asigna a la salida numHexadecimal de este modulo.
			DP => puntoDisplay
			--La salida DP de decodBinHex se asigna a la salida puntoDislpay de este modulo.
		);
end encenderDisplaysTLD;

