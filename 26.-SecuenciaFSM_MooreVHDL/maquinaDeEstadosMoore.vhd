--2.-MAQUINA DE ESTADO FINITO TIPO MOORE: Las FSM (Finite State Machines) estan conformadas de 
--entradas, transiciones y estados, donde cada estado tiene asignada una o varias salidas. Este tipo 
--de programacion es excelente para detectar o ejecutar secuencias, todo siguiendo el paso de la 
--senal de reloj CLK. En la maquina de Moore sus salidas se generan solo cuando se alcanza un estado 
--especfico, por lo que su velocidad es mas lenta, eso es bueno cuando la secuencia es ingresada 
--manualmente, pero no cuando se ingresa por medios digitales, ya que la velocidad de la entrada 
--supera la de la deteccion.
--El estado se refiere a un concepto abstracto que indica como una FSM reacciona automaticamente 
--a una secuencia de entradas segun un flujo prestablecido. Donde un mismo sistema, si se 
--encuentra en diferente estado, podra reaccionar de forma distinta a una misma entrada.
library IEEE;
use IEEE.std_logic_1164.all;
--Librerias declaradas para poder usar el lenguaje de programacion VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria declarada para poder hacer operaciones matematicas sin considerar el signo.

entity fsmMoore is 
	port ( clk : in STD_LOGIC;		--Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
			 boton : in STD_LOGIC;				--Boton presionado para detectar la secuencia de 1011.
			 ledSecuencia : out STD_LOGIC; 	--Led que indica cuando la secuencia se ha completado.
			 ledPasos : out STD_LOGIC_VECTOR(3 downto 0)); --Leds que indican los pasos de la secuencia.
end fsmMoore;

architecture deteccionSecuencia1011Boton of fsmMoore is
--TYPE: Con esta instruccion se define un tipo de dato que tiene un nombre en especifico y clasifica
--elementos parecidos, mas o menos como una clase en POO, a traves de la siguiente nomenclatura:
--type	nombreTipoDeDato	is (declaracionDeElementos);
--En VHDL con esta instruccion se declaran los estados de la FSM.
type Estados is (Inicio, uno, unoCero, unoCeroUno, unoCeroUnoUno);

--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la 
--NEXYS 2, solo existe durante la ejecucion del codigo y sirve para poder almacenar algun valor de 
--forma temporal, se debe declarar dentro de la arquitectura y antes de su begin a traves de la 
--siguiente nomenclatura:
--signal		nombreVariable	: tipoDeDato := 	valor;
--En VHDL con esta instruccion se guarda el estadoPresente y estadoFuturo de la maquina de estados,
--cabe mencionar que dentro del codigo proporcionado por el diagrama de estados de Aldec, el estado 
--presente es nombrado como Sreg0 y el futuro como NextState_Sreg0.
signal estadoPresente, estadoFuturo: Estados;
--Divisor de Reloj: Esta signal sirve para que podamos obtener una gran gama de frecuencias indicadas 
--en la tabla del divisor de reloj, dependiendo de la coordenada que elijamos tomar del vector.
signal clkdiv: std_logic_vector (25 downto 0);	--Declaracion del divisor de reloj.
--Antirrebotes: Una de las aplicaciones del registro de corrimiento, que es resultado de una 
--conexion en serie de varios flip flops (usualmente de Tipo D), donde simplemente se conecta
--la entrada de un FF tipo D a la salida de otro siguiendo el paso marcado de una misma senal 
--de reloj, es la del codigo antirrebotes, que sirve para crear un pequeno retraso de tiempo en
--el programa, que deje pasar las falsas pulsaciones que se producen al presionar un boton.
--El retraso en tiempo del antirrebotes estara sujeto a la frecuencia de la senal de reloj, ya que 
--cada que se perciba un flanco de subida, con el diferente numero de delays, se estara esperando el 
--tiempo calculado con la siguiente ecuacion:
--t_delay = periodoReloj * (#signals_delay - (1/2))
--t_delay = 1/frecuenciaReloj * (#signals_delay - (1/2))
--frecuenciaReloj = 1/t_delay * (#signals_delay - (1/2))
signal delay_1 : STD_LOGIC;
signal delay_2 : STD_LOGIC;
signal botonDebounce : STD_LOGIC; --Entrada del boton ya con el delay antirrebotes anadido.
--Los type y signal se declaran dentro de la arquitectura, pero antes de su begin.
begin
	--Primero que nada, se anade el proceso del divisor de reloj, este no viene incluido en el codigo 
	--de Aldec. Se puede nombrar los process de la siguiente manera:
	--nombreProcess : process(entradas y signals separadas por comas) begin
	divisorDeReloj: process(clk, clkdiv) begin
	--La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco 
	--de subida en la senal de reloj clk proveniente de la NEXYS 2, se elige distintas frecuencias 
	--para ver cual es la que mejor funciona para detectar las entradas de la maquina de estados.
		if(rising_edge(clk)) then
			clkdiv <= clkdiv + '1';	--Esto crea al divisor de reloj.
		end if;
	end process;
	
	--Luego se anade el proceso del antirrebotes, este tampoco viene incluido en el codigo de Aldec.
	antirrebotesBoton: process(clkdiv(17), boton, delay_1, delay_2) begin
	--La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco 
	--de subida en la senal del divisor de reloj clkdiv, en este caso esa accion es que se trasladen 
	--los datos de la entrada a la salida del registro, pero como pasa a traves de varias signal, esto 
	--es lo que ocasionara el retraso en tiempo, que genera el delay del antirrebotes, para obtener un
	--delay de antirrebotes de 8 milisegundos, que es lo suficientemente rapido para identificar una 
	--secuencia introducida manualmente usando una FSM tipo Moore; la frecuencia de la senal de reloj 
	--debe ser de 187.5 Hz.
	--frecuenciaReloj = 1/t_delay * (#signals_delay - (1/2)) = 1/0.008 * (2 - (1/2)) = 187.5 Hz.
	--La que mas se le acerca es la posicion 17 del divisor de reloj cuya frecuencia es f = 190.73 Hz.
		if(rising_edge(clkdiv(17))) then
			delay_1 <= boton;
			delay_2 <= delay_1;
		end if;
		botonDebounce <= delay_1 and delay_2;
	end process;
	
	--Las partes necesarias para implementar el codigo de una FSM son las siguientes:
	--Actualizacion del estado presente y futuro: En esta parte del codigo que se ejecuta cada que se 
	--perciba un flanco de subida en la senal de reloj, continuamente se asigna el valor del estado 
	--futuro al estado presente, para de esa forma actualizarlo.
	--La frecuencia ideal para identificar la secuencia en una FSM tipo Moore esta en la coordenada 
	--23 = 2.98Hz = 0.335 seg.
	--Esta parte a veces viene incluida hasta abajo del codigo proporcionado por Aldec, pero debe ser 
	--modificado para funcionar a traves de la senal del divisor de reloj.
	actualizacionDeEstado: process(clkdiv(23)) begin
		if rising_edge(clkdiv(23)) then 
			estadoPresente <= estadoFuturo;
		end if;
	end process;
	
	--Logica de la maquina de estados: A traves de esta parte se lleva a cabo la funcion de la 
	--FSM, donde dependiendo de su tipo, ya sea Mealy o Moore, sus salidas se asignan a las transiciones 
	--de un estado a otro o al estado en si. Cabe mencionar que siempre que se cree una nueva FSM, esta 
	--es la parte que debera ser reemplazada en el codigo, lo demas se puede quedar igual y funcionaria de 
	--maravilla, pero hay que tener en cuenta cambiar el nombre de la entrada por la signal del antirrebotes 
	--y cambiar el nombre de Sreg0 por estadoPresente y NextState_Sreg0 por la signal estadoFuturo. 
	--Ademas, deberemos cambiar el nombre de los nuevos estados en la parte de arriba, en los type.
	--Aqui a traves de condicionales if y case se declaran los estados, entradas y transiciones.
	maquinaDeEstados: process(botonDebounce, estadoPresente) begin
		--Condiciones iniciales de la maquina de estados:
		estadoFuturo <= estadoPresente;	--Asignacion del estado presente al estado futuro.
		ledSecuencia <= '0';	--El led que indica cuando la secuencia se ha completado esta apagado.				
		ledPasos <= "0000";	--Los leds que indica los pasos de la secuencia estan apagados.
		--Condicional case: Lee el valor de la variable estado presente y dentro del case describe lo 
		--que hace cada estado.
		--FSM tipo Moore: LAS SALIDAS se declaran en LOS ESTADOS que describen los case.
		case(estadoPresente) is
			when Inicio =>							--Estado: primerUno.
				--SALIDAS DEL ESTADO Inicio:
				ledSecuencia <= '0';
				ledPasos <= "0000";
				--TRANSICIONES DEL ESTADO Inicio:
				case(botonDebounce) is
					when '1' =>						--Transicion al estado uno: Cuando la entrada boton = 1.
						estadoFuturo <= uno;		
					when '0' =>						--Transicion al estado Inicio: Cuando la entrada boton = 0.
						estadoFuturo <= Inicio;	
					when others =>
						null;
				end case;
			when uno =>								--Estado: uno.
				--SALIDAS DEL ESTADO uno:
				ledSecuencia <= '0';
				ledPasos <= "1000";
				--TRANSICIONES DEL ESTADO uno:
				case(botonDebounce) is
					when '0' =>						--Transicion al estado unoCero: Cuando la entrada boton = 0.
						estadoFuturo <= unoCero;
					when '1' =>						--Transicion al estado Inicio: Cuando la entrada boton = 1.
						estadoFuturo <= Inicio;
					when others =>
						null;
				end case;
			when unoCero =>						--Estado: unoCero.
				--SALIDAS DEL ESTADO unoCero:
				ledSecuencia <= '0';
				ledPasos <= "0100";
				--TRANSICIONES DEL ESTADO unoCero:
				case(botonDebounce) is
					when '1' =>						--Transicion al estado unoCeroUno: Cuando la entrada boton = 1.
						estadoFuturo <= unoCeroUno;
					when '0' =>						--Transicion al estado unoCero: Cuando la entrada boton = 0.
						estadoFuturo <= unoCero;
					when others =>
						null;
				end case;
			when unoCeroUno =>					--Estado: unoCeroUno.
				--SALIDAS DEL ESTADO unoCeroUno:
				ledSecuencia <= '0';
				ledPasos <= "0010";
				--TRANSICIONES DEL ESTADO unoCeroUno:
				case(botonDebounce) is
					when '1' =>						--Transicion al estado unoCeroUnoUno: Cuando la entrada boton = 1.
						estadoFuturo <= unoCeroUnoUno;
					when '0' =>						--Transicion al estado Inicio: Cuando la entrada boton = 0.
						estadoFuturo <= Inicio;
					when others =>
						null;
				end case;
			when unoCeroUnoUno =>				--Estado: unoCeroUnoUno.
				--SALIDAS DEL ESTADO unoCeroUnoUno:
				ledSecuencia <= '1';
				ledPasos <= "0001";
				--TRANSICIONES DEL ESTADO unoCeroUnoUno:
				--Transicion al estado Inicio: Cuando la entrada boton = 0 o boton = 1.
				if(botonDebounce = '0' or botonDebounce = '1') then
					estadoFuturo <= Inicio;
				end if;
			when others =>
				null;
		end case;
	end process;
	--Fin de la logica de la maquina de estados.
end deteccionSecuencia1011Boton;