--4.-TLD (Top Level Design) Semaforo: En el programa se describen dos secuencias simples de un semáforo para el control 
--de un crucero que tiene dos sentidos, de Sur a Norte SN (abajo hacia arriba) y de Oeste a Este OE (derecha a 
--izquierda), en cada secuencia se tienen los siguientes tiempos, donde ademas se tiene que tomar en cuenta que 
--cuando el semaforo SN se encuentre con la luz verde o amarilla encendida, el semaforo OE debe estar en rojo y 
--viceversa: 
--		- Secuencia 1 (modo normal): 10s se muestra la luz roja, 7s se muestra la verde con 3 parpadeos antes del 
--		  amarillo y 3s se muestra la luz amarilla, estas secuencias estan entrelazadas en los dos semaforos SN y OE, 
--		  dando en total una secuencia de 20s.
--		- Secuencia 2 (modo nocturno): En esta secuencia simplemente se pone a parpadear la luz roja en el semaforo SN 
--		  y la amarilla en el semaforo OE.
--El tiempo total que abarcan ambas secuencias no es de 10 + 7 + 3 + 3 = 23s aunque asi parezca, ya que los tiempos de
--encendido y apagado de los focos rojo, amarillo y verde estan entrelazados en los dos semaforos.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entidad: Las entradas y salidas en este modulo son las que van a entrar y salir del diagrama de bloques global.
entity manejoDeTiemposSemaforoTLD is
    Port ( Reset : in  STD_LOGIC;
			  clkNexys2 : in  STD_LOGIC;
			  modoNocturno : in  STD_LOGIC;
           semaforoSurNorte : out  STD_LOGIC_VECTOR (2 downto 0);
           semaforoOesteEste : out  STD_LOGIC_VECTOR (2 downto 0));
end manejoDeTiemposSemaforoTLD;

architecture Behavioral of manejoDeTiemposSemaforoTLD is

--Conexiones internas del diseno TLD.
signal reloj : STD_LOGIC;
signal controlSecuencia : STD_LOGIC_VECTOR (4 downto 0);

begin
	--INSTANCIAS:
	--Debo darle un nombre a cada instancia que cree, indicar el nombre de la entidad del modulo que quiero instanciar,
	--usar la palabra reservada port map(); y dentro de su parentesis asignarle a todas las entradas y salidas del 
	--modulo instanciado una entrada, salida o signal de este mdoulo separadas por comas una de la otra, esto hara que 
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
	--INSTANCIA DEL MODULO contadorTiempo para obtener el conteo que controla la secuencia del semaforo.
	contadorSecuencia : entity work.contadorTiempo port map(
			frecuenciaReloj => reloj,
			--A la entrada frecuenciaReloj del contadorSelector se le asigna el valor de la signal reloj de este modulo.
			Contador => controlSecuencia,
			--La salida contador del contadorTiempo se asigna a la signal controlSecuencia de este modulo.
			reiniciar => Reset
			--La entrada rst del divisorDeReloj se asigna a la entrada Reset de este modulo.
		);
	--INSTANCIA DEL MODULO secuenciaSemaforo para recibir el contador e iniciar la secuencia del semaforo.
	controlSemaforo : entity work.secuenciaSemaforo port map(
			conteo => controlSecuencia,
			--A la entrada conteo de secuenciaSemaforo se le asigna el valor de la signal controlSecuencia de este modulo.
			modoParpadeo => modoNocturno,
			--La entrada modoParpadeo de secuenciaSemaforo se asigna a la entrada modoNocturno de este modulo.
			semSN => semaforoSurNorte,  
			--La salida semNS de secuenciaSemaforo se asigna a la salida semaforoNorteSur de este modulo.
			semOE => semaforoOesteEste
			--La salida semEO de secuenciaSemaforo se asigna a la salida semaforoNorteSur de este modulo.
		);
end Behavioral;