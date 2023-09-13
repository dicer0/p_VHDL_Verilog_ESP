--Antirrebotes: Una de las aplicaciones del registro de corrimiento, que es resultado de una 
--conexion en serie de varios flip flops (usualmente de Tipo D), donde simplemente se conecta
--la entrada de un FF tipo D a la salida de otro siguiendo el paso marcado de una misma senal 
--de reloj, es la del codigo antirrebotes, que sirve para crear un pequeno retraso de tiempo en
--el programa, que deje pasar las falsas pulsaciones que se producen al presionar un boton.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Libreras para poder usar el lenguaje VHDL.

entity shiftRegisterAntirrebotes is
    Port ( clk : in  STD_LOGIC;				--Senal de reloj.
			  clr : in  STD_LOGIC;				--Boton de clr para reiniciar el conteo del debounce.
			  --El codigo de un shift register se codifica como un flip flop tipo D, asignando de 
			  --forma temporal valores de forma directa a signals.
			  entradaBoton : in  STD_LOGIC;	--Boton que genera los rebotes.
			  salidaBoton : out  STD_LOGIC	--Salida sin rebotes.
			  );
end shiftRegisterAntirrebotes;

architecture debounce of shiftRegisterAntirrebotes is
--Dentro del process pero antes de su begin es donde se declaran las variables de tipo signal 
--que no son ni entradas ni salidas, solo existen durante la ejecucion del programa e interactuan 
--con el condicional o bucle de la instruccion process.
signal delay_1 : STD_LOGIC;
signal delay_2 : STD_LOGIC;
signal delay_3 : STD_LOGIC;

begin
	--La instruccion process se utiliza para poder ejecutar condicionales y bucles, en su 
	--parentesis se indican las entradas que vayan a estar involucradas.
	process(clk, clr, entradaBoton) begin
		if(clr = '1') then --Si el boton clr es presionado el conteo del debounce se reinicia.
			delay_1 <= '0';
			delay_2 <= '0';
			delay_3 <= '0';
		--La instruccion rising_edge indica que cada que ocurra un flanco de subida en el reloj, se 
		--ejecute una accion en especifico, en este caso esa accion es que se trasladen los datos 
		--de la entrada a la salida del registro, pero como pasa a traves de varias signal, esto es 
		--lo que ocasionara el retraso en tiempo, que genera el delay, este tiempo estara sujeto a 
		--la frecuencia de la senal de reloj, ya que cada que se perciba un flanco de subida, con el
		--diferente numero de signals, se estara esperando el tiempo del periodo de la senal entre 2.
		--t_delay = periodoReloj * (#signals_delay - (1/2))
		--t_delay = 1/frecuenciaReloj * (#signals_delay - (1/2))
		--frecuenciaReloj = 1/t_delay * (#signals_delay - (1/2))
		--Si se quisiera ejecutar esta accion con el flanco de bajada de la senal de reloj se debe 
		--usar la instruccion fallin_edge.
		elsif(rising_edge(clk)) then	--El tiempo de retardo se ejecuta en funcion de la senal clk.
			delay_1 <= entradaBoton;
			delay_2 <= delay_1;
			delay_3 <= delay_2;
		end if;
	end process;
	--Con la instruccion and se concatenan los valores de cada delay y de esta forma se estara 
	--dejando que pasen #signals_delay-1 = 2 ciclos de reloj para no captar los pulsos falsos al 
	--presionar el boton.
	salidaBoton <= delay_1 and delay_2 and delay_3;
end debounce;