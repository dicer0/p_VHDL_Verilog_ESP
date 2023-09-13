--4.-TLD (Top Level Design):
--Este codigo sirve para unir los 4 modulos anteriores y poder realizar el decodificador binario a hexadecimal y 
--mostrar en 4 displays de 7 segmentos valores hexadecimales diferentes por medio del divisorDeReloj, el contador 
--ascendente/descendente y el Decodificador Binario a Hexadecimal.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.

--Entidad: Las entradas y salidas en este modulo son las que van a entrar y salir del diagrama de bloques global.
entity contadorHexadecimalTLD is
    Port ( Habilitacion : in  STD_LOGIC;
           direcc : in  STD_LOGIC;
			  Reset : in  STD_LOGIC;
			  clkNexys2 : in  STD_LOGIC;
			  anodoDisplay : out STD_LOGIC_VECTOR (3 downto 0);
			  puntoDisplay : out  STD_LOGIC;
           numHexadecimal : out  STD_LOGIC_VECTOR (6 downto 0));
end contadorHexadecimalTLD;

--Arquitectura: Aqui se declaran las instancias de los demas modulos para poder unir entradas, salidas y signals.
architecture encenderDisplayTLD of contadorHexadecimalTLD is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin.
signal reloj : STD_LOGIC;--Reloj con frecuencia menor a 50MHz.
signal selector : STD_LOGIC_VECTOR (3 downto 0);--Selector de los 4 Displays.

begin
	--INSTANCIAS:
	--Debo darle un nombre a cada instancia que cree, indicar el nombre de la entidad del modulo que quiero instanciar,
	--usar la palabra reservada port map(); y dentro de su parentesis asignarle a todas las entradas y salidas del 
	--modulo instanciado una entrada, salida o signal de este modulo, separadas por comas una de la otra, esto hara que 
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
			salidaReloj => reloj
			--La salida salidaReloj del divisorDeReloj se asigna a la signal reloj de este modulo.
		);
	--INSTANCIA DEL MODULO contadorSelector para obtener el contador/selector que prendera cada display individualmente.
	selectorDisplay : entity work.contadorAsc_Desc port map(
			clkNexys2 => reloj,
			--A la entrada clkNexys2 del contadorAsc_Desc se le asigna el valor de la signal reloj de este modulo.
			Reset => Reset,
			--La entrada Reset del contadorAsc_Desc se asigna a la entrada Reset de este modulo.
			Direccion  => direcc,
			--La entrada Direccion del contadorAsc_Desc se asigna a la entrada Reset de este modulo.
			Contador => selector
			--La salida contador del contadorAsc_Desc se asigna a la signal selector de este modulo.
		);
	--INSTANCIA DEL MODULO decodBinHex para cambiar de sistema numerico binario a hexadecimal, recibira el selector del 
	--contador y prender el display dependiendo del numero binario que esta recibiendo y con la frecuencia del reloj, 
	--prender y apagar los leds que estan en el display.
	HexadecimalADisp7Seg : entity work.decodificadorBinHex port map(
			digito => selector,
			--A la entrada digito de decodificadorBinHex se le asigna el valor de la signal selector de este modulo.
			enable => Habilitacion,
			--La entrada enable de decodificadorBinHex se asigna a la entrada Habilitacion de este modulo.
			prenderDisplay => anodoDisplay,
			--La salida prenderDisplay de decodificadorBinHex se asigna a la salida anodoDisplay de este modulo.
			ledsAhastaG => numHexadecimal,  
			--La salida ledsAhastaG de decodificadorBinHex se asigna a la salida numHexadecimal de este modulo.
			DP => puntoDisplay
			--La salida DP de decodBinHex se asigna a la salida puntoDislpay de este modulo.
		);
end encenderDisplayTLD;