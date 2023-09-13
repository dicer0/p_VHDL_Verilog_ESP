--6.-TLD (Top Level Design) maquina expendedora de gel antibacterial:
--Este codigo sirve para unir los mdulos anteriores y poder realizar la operacion de la maquina expendedora.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity expendedoraGelAntibacterial is
    Port ( on_off : in  STD_LOGIC;
           selectorArticulo : in  STD_LOGIC_VECTOR (2 downto 0);
           productoDisponible : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  ledsDisplay7Seg : out  STD_LOGIC_VECTOR (6 downto 0);
			  DP : out  STD_LOGIC;
           anodoComun : out  STD_LOGIC_VECTOR (3 downto 0);
           disponible : out  STD_LOGIC;
			  PWM_Servo : out  STD_LOGIC);
end expendedoraGelAntibacterial;

architecture Behavioral of expendedoraGelAntibacterial is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin.
signal reloj : STD_LOGIC;--Reloj con frecuencia menor a 50MHz.
signal CLK50MHz : STD_LOGIC;--Reloj con frecuencia de 50MHz.
signal selector : STD_LOGIC_VECTOR (1 downto 0);--contador/selector para encender cada display de 7 segmentos
signal articulo : STD_LOGIC_VECTOR (2 downto 0);--seleccion de producto del usuario
signal mensaje : STD_LOGIC_VECTOR (1 downto 0);--mensaje mostrado en el display de 7 segmentos
signal onOffServo : STD_LOGIC;--Variable que enciende con 0 el servomotor y lo apaga con 1.

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
			relojNexys2 => CLK,
			--La entrada relojNexys2 del divisorDeReloj se asigna a la entrada CLK de este modulo.
			salidaReloj => reloj,
			--La salida salidaReloj del divisorDeReloj se asigna a la signal reloj de este modulo.
			salida50MHz => CLK50MHz
			--La salida salidaReloj del divisorDeReloj se asigna a la signal CLK50MHz de este modulo.
		);
	--INSTANCIA DEL MODULO contadorSelector para obtener el contador/selector que prendera cada display individualmente.
	selectorDisplay : entity work.contadorSelector port map(
			frecuenciaReloj => reloj,
			--A la entrada frecuenciaReloj del contadorSelector se le asigna el valor de la signal reloj de este modulo.
			contador => selector
			--La salida contador del contadorSelector se asigna a la signal selector de este modulo.
		);
	--INSTANCIA DEL MODULO control para que el usuario pueda prender la maquina o introducir el numero de articulos.
	--que quiere obtener
	controladorMaquina : entity work.controlDisplay port map(
			ON_OFF => on_off,
			--La entrada ON_OFF del control se asigna a la entrada on_off de este modulo.
			selectorArticulo => selectorArticulo,
			--La entrada selectorArticulo del control se asigna a la entrada selectorArticulo de este modulo.
			productoDisponible => productoDisponible,
			--La entrada productoDisponible del modulo control se asigna a la entrada productoDisponible de este modulo.
			articuloDisplay => articulo,
			--La salida articuloDisplay del modulo control se asigna a la signal articulo de este modulo.
			mensajeBienvenida => mensaje,
			--La salida mensajeBienvenida del modulo control se asigna a la signal mensaje de este modulo.
			disponibilidad => disponible
			--La salida disponibilidad del modulo control se asigna a la salida disponible de este modulo
		);
	--INSTANCIA DEL MODULO displayDe7Segmentos para recibir el selector del contador y prender cada uno de los 4 
	--displays dependiendo de las entradas provenientes del modulo control y con la frecuencia del selector, prendera 
	--y apagara los 4 displays tan rapido que para el ojo humano parezca que todos esten encendidos al mismo tiempo 
	--con valores diferentes.
	mostrarMensaje : entity work.displayDe7Segmentos port map(
			articuloDisplay => articulo,
			--A la entrada articuloDisplay de displayDe7Segmentos se le asigna el valor de la signal articulo de este 
			--modulo.
			mensajeBienvenida => mensaje,
			--A la entrada mensajeBienvenida de displayDe7Segmentos se le asigna el valor de la signal mensaje de este 
			--modulo.
			selectorMUX => selector,  
			--A la entrada selectorMUX de displayDe7Segmentos se le asigna el valor de la signal selector de este modulo.
			prenderDisplay => anodoComun,
			--La salida prenderDisplay de displayDe7Segmentos se asigna a la salida anodoComun de este modulo.
			ledsAhastaG => ledsDisplay7Seg,  
			--La salida ledsAhastaG de displayDe7Segmentos se asigna a la salida ledsDisplay7Seg de este modulo.
			DP => DP,
			--La salida DP de displayDe7Segmentos se asigna a la salida DP de este modulo.
			servo_ON => onOffServo
			--La salida servo_ON de displayDe7Segmentos se asigna a la signal onOffServo de este modulo.
		);
	controlServoMotor : entity work.servomotorPWM port map(
			CLKNexys2 => CLK,
			--A la entrada CLKNexys2 de servomotorPWM se le asigna el valor de la signal CLK50MHz de este modulo.
			rst => onOffServo,
			--A la entrada rst de servomotorPWM se le asigna el valor de la signal onOffServo de este modulo.
			PWM => PWM_Servo
			--La salida PWM del servomotorPWM se asigna a la salida PWM_Servo de este modulo.
		);
end Behavioral;