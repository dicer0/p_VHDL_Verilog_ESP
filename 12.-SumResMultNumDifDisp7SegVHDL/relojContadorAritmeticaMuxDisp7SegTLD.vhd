--6.-TLD (Top Level Design) relojContadorAritmeticaMuxDisp7SegVHDL:
--Este codigo sirve para unir los 3 modulos anteriores y poder realizar la suma, resta o multiplicacion de 2 numeros 
--binarios, para ello primero se realiza la operacion matematica, luego se aplica el decodificador binario a codigo 
--BCD y finalmente su resultado se muestra en los 4 displays de 7 segmentos, mostrando asi diferentes valores por 
--medio del divisorDeReloj, el contadorSelector, el Multiplexor y el Decodificador Binario a BCD.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.

--Entidad: Las entradas y salidas en este modulo son las que van a entrar y salir del diagrama de bloques global.
entity relojContadorAritmeticaMuxDisp7SegTLD is
    Port ( numero1 : in  STD_LOGIC_VECTOR (3 downto 0);
           numero2 : in  STD_LOGIC_VECTOR (3 downto 0);
           seleccionarOperacion : in  STD_LOGIC_VECTOR (2 downto 0);
           clkNexys2 : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           ledsNEXYS : out  STD_LOGIC_VECTOR (7 downto 0);
           ledsDisplay : out  STD_LOGIC_VECTOR (7 downto 0);
           anodoComun : out  STD_LOGIC_VECTOR (3 downto 0));
end relojContadorAritmeticaMuxDisp7SegTLD;

--Arquitectura: Aqui se declaran las instancias de los demas modulos para poder unir entradas, salidas y signals.
architecture Behavioral of relojContadorAritmeticaMuxDisp7SegTLD is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin.
signal reloj : STD_LOGIC;--Reloj con frecuencia menor a 50MHz.
signal selector : STD_LOGIC_VECTOR (1 downto 0);--Contador/selector para encender cada display de 7 segmentos.
signal resultado : STD_LOGIC_VECTOR (7 downto 0);--Almacena el resultado de la operacion matematica y enciende leds.
signal SIGNO : STD_LOGIC_VECTOR (3 downto 0);--Almacena el vector que denota el signo de la operacion matematica.
signal CENTENAS : STD_LOGIC_VECTOR (3 downto 0);--Almacena los 4 bits del codigo BCD que denotan las centenas.
signal DECENAS : STD_LOGIC_VECTOR (3 downto 0);--Almacena los 4 bits del codigo BCD que denotan las decenas.
signal UNIDADES : STD_LOGIC_VECTOR (3 downto 0);--Almacena los 4 bits del codigo BCD que denotan las unidades.
begin
	--INICIALIZACION DE VALORES
	ledsNEXYS <= numero1 & numero2;--El punto siempre estara apagado.
	
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
	--INSTANCIA DEL MODULO sumadorRestadorMultiplicador para la suma, resta o multiplicacion de numeros binarios.
	suma_Resta_o_Multiplicacin : entity work.sumadorRestadorMultiplicador port map(
			num1 => numero1,
			--A la entrada num1 del sumadorRestadorMultiplicador se le asigna el valor de la entrada numero1 de este 
			--modulo.
			num2 => numero2,
			--A la entrada num2 del sumadorRestadorMultiplicador se le asigna el valor de la entrada numero2 de este 
			--modulo.
			selectorOperacion => seleccionarOperacion,
			--A la entrada selectorOperacion del sumadorRestadorMultiplicador se le asigna el valor de la entrada 
			--seleccionarOperacion de este modulo.
			Result => resultado,
			--La salida Result del selectorOperacion se asigna a la signal resultado de este modulo.
			signo => SIGNO
			--La salida signo del selectorOperacion se asigna a la signal SIGNO de este modulo.
		);
	--INSTANCIA DEL MODULO DecodificadorBinBCD para cambiar de sistema numerico binario a codigo BCD por medio del 
	--metodo Shift Add-3.
	ShiftAdd_3 : entity work.DecodificadorBinBCD port map(
			numBinario => resultado,
			--A la entrada numBinario de DecodificadorBinBCD se le asigna el valor de la signal resultado de este modulo.
			centenasBCD => CENTENAS,
			--La salida centenasBCD de DecodificadorBinBCD se asigna a la signal centena de este modulo.
			decenasBCD => DECENAS,
			--La salida decenasBCD de DecodificadorBinBCD se asigna a la signal decena de este modulo.
			unidadesBCD => UNIDADES
			--La salida unidadesBCD de DecodificadorBinBCD se asigna a la signal unidad de este modulo.
		);
	--INSTANCIA DEL MODULO display7Seg para recibir el selector del contador y prender cada uno de los 4 displays 
	--dependiendo del codigo BCD que este recibiendo, y con la frecuencia del selector, prender y apagar los 4 displays 
	--tan rapido que al ojo humano parezca que todos estan encendidos al mismo tiempo con valores diferentes.
	mostrarDigito : entity work.display7Seg port map(
			signo => SIGNO,
			--A la entrada signo de display7Seg se le asigna el valor de la signal SIGNO de este modulo
			unidades => UNIDADES,
			--A la entrada unidades de display7Seg se le asigna el valor de la signal UNIDADES de este modulo
			decenas => DECENAS,
			--A la entrada decenas de display7Seg se le asigna el valor de la signal DECENAS de este modulo
			centenas => CENTENAS,
			--A la entrada centenas de display7Seg se le asigna el valor de la signal CENTENAS de este modulo.
			selectorMUX => selector,  
			--A la entrada selectorMUX de display7Seg se le asigna el valor de la signal selector de este modulo.
			prenderDisplay => anodoComun,  
			--La salida prenderDisplay de display7Seg se asigna a la salida anodoComun de este modulo.
			ledsAhastaDP => ledsDisplay
			--La salida ledsAhastaG de display7Seg se asigna a la salida numHexadecimal de este modulo.
		);
end Behavioral;