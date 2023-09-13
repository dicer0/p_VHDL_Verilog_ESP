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
--En este caso se usara la FSM para detectar el sentido de giro de un encoder rotativo, identificando
--las secuencias dadas por sus pines A y B para saber si el giro es CW (hacia la derecha) o CCW (hacia 
--la izquierda).
--Secuencia giro CW (Clock Wise), osea hacia la derecha: (PinA,PinB) = (1,1)(0,1)(0,0)(1,0).
--Secuencia giro CCW (Counter Clock Wise), osea hacia la izquierda: (PinA,PinB) = (1,1)(1,0)(0,0)(0,1).
library IEEE;
use IEEE.std_logic_1164.all;
--Librerias declaradas para poder usar el lenguaje de programacion VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria declarada para poder hacer operaciones matematicas sin considerar el signo.

entity giroEncoderRotativo is 
	port ( clk : in STD_LOGIC;		--Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
			 pinesAB: in STD_LOGIC_VECTOR (1 downto 0);	--Pines para detectar el sentido de giro del encoder.
			 giroCW : out STD_LOGIC;	--Led que indica el sentido de giro hacia la derecha del encoder.
			 giroCCW : out STD_LOGIC); --Led que indica el sentido de giro hacia la izquierda del encoder.
end giroEncoderRotativo;

architecture secuenciaDeGiro of giroEncoderRotativo is
--TYPE: Con esta instruccion se define un tipo de dato que tiene un nombre en especifico y clasifica
--elementos parecidos, mas o menos como una clase en POO, a traves de la siguiente nomenclatura:
--type	nombreTipoDeDato	is (declaracionDeElementos);
--En VHDL con esta instruccion se declaran los estados de la FSM.
type Estados is (AB_1_1, AB_0_1CW, giroIzq, AB_1_0CCW, AB_0_0, giroDer);

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
signal delay_1 : STD_LOGIC_VECTOR (1 downto 0);
signal delay_2 : STD_LOGIC_VECTOR (1 downto 0);
signal pinesDebounce : STD_LOGIC_VECTOR (1 downto 0); --Entrada ya con el delay antirrebotes anadido.
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
	antirrebotesBoton: process(clkdiv(7), pinesAB, delay_1, delay_2) begin
	--La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco 
	--de subida en la senal del divisor de reloj clkdiv, en este caso esa accion es que se trasladen 
	--los datos de la entrada a la salida del registro, pero como pasa a traves de varias signal, esto 
	--es lo que ocasionara el retraso en tiempo, que genera el delay del antirrebotes, para obtener un
	--delay de antirrebotes de 8 microsegundos, que es lo suficientemente rapido para identificar la 
	--secuencia introducida por el encoder rotativo; para ello la frecuencia de la senal de reloj 
	--debe ser de 187.5 kHz.
	--frecuenciaReloj = 1/t_delay * (#signals_delay - (1/2)) = 1/8e-6 * (2 - (1/2)) = 187,500 Hz.
	--La que mas se le acerca es la posicion 7 del divisor de reloj cuya frecuencia es f = 195,312.5 Hz.
		if(rising_edge(clkdiv(7))) then
			delay_1 <= pinesAB;
			delay_2 <= delay_1;
		end if;
		pinesDebounce <= delay_1 and delay_2;
	end process;
	
	--Las partes necesarias para implementar el codigo de una FSM son las siguientes:
	--Actualizacion del estado presente y futuro: En esta parte del codigo que se ejecuta cada que se 
	--perciba un flanco de subida en la senal de reloj, continuamente se asigna el valor del estado 
	--futuro al estado presente, para de esa forma actualizarlo.
	--La frecuencia ideal para identificar la secuencia en una FSM tipo Moore esta en la coordenada 
	--15 = 762.94Hz = 1.3ms.
	--Esta parte a veces viene incluida hasta abajo del codigo proporcionado por Aldec, pero debe ser 
	--modificado para funcionar a traves de la senal del divisor de reloj.
	actualizacionDeEstado: process(clkdiv(15)) begin
		if rising_edge(clkdiv(15)) then 
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
	maquinaDeEstados: process(pinesDebounce, estadoPresente) begin
		--Condiciones iniciales de la maquina de estados:
		estadoFuturo <= estadoPresente;
		--Secuencia de giro CW, hacia la derecha: 	(PinA,PinB) = (1,1),(0,1),(0,0),(1,0).
		--Secuencia de giro CCW, hacia la izquierda: (PinA,PinB) = (1,1),(1,0),(0,0),(0,1).
		giroCW <= '0';		--Giro derecha 	= 0.
		giroCCW <= '0';	--Giro izquierda 	= 0.
		--FSM tipo Moore: LAS SALIDAS se declaran en LOS ESTADOS que describen los case.
		case(estadoPresente) is
			when AB_1_1 =>							--Estado: AB_1_1 = (1,1).
				--SALIDAS DEL ESTADO AB_1_1:
				giroCW <= '0';
				giroCCW <= '0';
				--TRANSICIONES DEL ESTADO AB_1_1:
				case pinesDebounce is
					when "01" =>						--Transicion al siguiente paso del giro hacia la derecha.
						estadoFuturo <= AB_0_1CW;	
					when "10" =>						--Transicion al siguiente paso del giro hacia la izquierda.
						estadoFuturo <= AB_1_0CCW;	
					when others =>
						null;
				end case;
			when AB_0_1CW =>						--Estado: AB_0_1CW = (1,1),(0,1) = Giro CW.
				--SALIDAS DEL ESTADO AB_0_1CW:
				giroCW <= '0';
				giroCCW <= '0';
				case pinesDebounce is
					when "00" =>						--Transicion al siguiente paso del giro hacia la derecha.
						estadoFuturo <= AB_0_0;
					when others =>
						null;
				end case;
			when giroIzq =>						--Estado: giroIzq = (1,1),(1,0),(0,0),(0,1) = Giro CCW.
				--SALIDAS DEL ESTADO giroIzq:
				giroCW <= '0';
				giroCCW <= '1';
				case pinesDebounce is
					when "11" =>						--Transicion al reinicio de la secuencia de ambos giros.
						estadoFuturo <= AB_1_1;
					when others =>
						null;
				end case;
			when AB_1_0CCW =>						--Estado: AB_1_0CCW = (1,1),(1,0) = Giro CCW.
				--SALIDAS DEL ESTADO AB_1_0CCW:
				giroCW <= '0';
				giroCCW <= '0';
				case pinesDebounce is
					when "00" =>						--Transicion hacia al sig. paso del giro hacia la derecha o izq.
						estadoFuturo <= AB_0_0;
					when others =>
						null;
				end case;
			when AB_0_0 =>	--Estado: AB_0_0 con giro CCW = (1,1),(1,0),(0,0) o giro CW = (1,1),(0,1),(0,0).
				--SALIDAS DEL ESTADO AB_0_0:
				giroCW <= '0';
				giroCCW <= '0';
				case pinesDebounce is
					when "10" =>						--Transicion que termina la secuencia del giro CW (der).
						estadoFuturo <= giroDer;
					when "01" =>						--Transicion que termina la secuencia del giro CCW (izq).
						estadoFuturo <= giroIzq;
					when others =>
						null;
				end case;
			when giroDer =>						--Estado: giroDer = (1,1),(0,1),(0,0),(1,0) = Giro CW.
				--SALIDAS DEL ESTADO giroDer:
				giroCW <= '1';
				giroCCW <= '0';
				case pinesDebounce is
					when "11" =>						--Transicion al reinicio de la secuencia de ambos giros.
						estadoFuturo <= AB_1_1;
					when others =>
						null;
				end case;
			when others =>
				null;
		end case;
	end process;
	--Fin de la logica de la maquina de estados.
end secuenciaDeGiro;
