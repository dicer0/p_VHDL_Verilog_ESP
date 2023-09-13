--1.-DIVISOR DE RELOJ:
--Este proceso sirve para dictarle al reloj en que frecuencia quiero que opere.
--El calculo que debo de hacer para obtener una senal CLK que tenga la frecuencia que yo quiero es el siguiente:
--Conteo' = 50e6/frecuenciaDeseada
--Contador = (Conteo'/2)-1
--Este resultado solo sobrevivira dentro del programa y debe guardarse en una variable que vaya contando desde cero 
--hasta el resultado que hayamos obtenido de Contador para crear una senal interna que despues la puedo usar para 
--obtener la verdadera senal de reloj que quiero que vaya de 1 a 400 Hz.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Libreras para poder usar el lenguaje VHDL.

--Entidad: Aqui se declaran las entradas y salidas, lo que se declara es la entrada del boton de reset, la entrada del 
--reloj de 50MHz proporcionado por la NEXYS 2 y la salida de reloj con la frecuencia que quiero obtener.
entity divisorDeReloj is
    Port ( relojEntrada50MHz : in  STD_LOGIC;--Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
           reset : in  STD_LOGIC;--Boton de reset.
			  relojSalida : out  STD_LOGIC);--Reloj que quiero con una frecuencia menor a 500 Hz.
end divisorDeReloj;

--Arquitectura: Aqui voy a realizar el divisor de reloj con mis entradas y salidas, esto se hara creando 3 signals y 2 
--process, el 1ero me crear una senal interna y el segundo usara esa senal interna para darme la senal de reloj que 
--quiero obtener.
architecture Behavioral of divisorDeReloj is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, no 
--esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal contador : integer;--El contador sirve para crear la seal de reloj interno.
signal i_clk : STD_LOGIC;
--la senal de reloj interno solo mantiene su nivel alto por un nanosegundo, pero sirve para despues crear la senal de 
--reloj con la frecuencia que yo quiero.
signal clk_out : STD_LOGIC;
--Creara la senal de reloj con la frecuencia que quiero usando la senal de reloj interno, posteriormente se almacenara 
--en la signal clk_out para que al final del codigo le asigne su valor a la salida llamada relojSalida, se hace uso de 
--una signal y no se almacena directamente en la salida relojSalida porque posteriormente se deber leer y sobrescribir 
--al mismo tiempo el valor de esta misma signal y eso no se puede hacer con las salidas.

begin	
--process() sirve para poder usar condicionales o bucles, puede tener su propio nombre y tiene su propio begin y end
	--Este primer process sirve para crear la senal de reloj interno usando el contador y para reiniciar el conteo cuando
	--presiono el boton de reset.
	relojInterno : process(relojEntrada50MHz, reset)
		begin
		--La instruccion rising_edge hace que este condicional se ejecute solo cuando ocurra un flanco de subida en la 
		--senal de reloj CLK proveniente de la NEXYS 2 de 50MHz.
			if(rising_edge(relojEntrada50MHz)) then
			--Cuando el push button reset este presionado valdra uno logico porque hace corto circuito y reiniciara el 
			--conteo de la signal contador.
			--El signo = en VHDL sirve para ver si hay igualdad.
				--IF ANIDADO
				if(reset = '1') then--Como la entrada reset es de 1 bit, se le debe asignar el valor poniendo comillas.
					--El signo <= en VHDL sirve para asignar un valor.
					contador <= 0;--Como el contador es de tipo integer se le debe asignar el valor decimal sin poner comillas.
				
				--Conteo para obtener una senal CLK de 1Hz a 400 Hz.
				--Conteo' = 50e6/frecuenciaDeseada = 50e6/1.
				--Contador = (Conteo'/2)-1 = (25e6)-1 = 24999999.
				--Este valor lo introduzco en el elsif para que el contador se reinicie cuando llegue a su valor maximo.
				elsif(contador = 24999999) then
					contador <= 0;
					--Por esta linea de codigo es que la senal interna tiene nivel alto solo en un pequeno nanosegundo, ya 
					--que vale 1 logico solamente cuando el contador esta en el valor maximo que calculamos.
					i_clk <= '1';
				else
					contador <= contador +1;--Las signal se pueden leer y asignar en la misma linea sin problema.
					--Por esta linea de codigo es que la senal interna esta en nivel bajo en la mayora de su ciclo, ya que 
					--vale 0 logico durante todo el conteo del contador excepto cuando esta en su valor maximo.
					i_clk <= '0';
				end if;
			end if;
	end process relojInterno;

	--El segundo process sirve para crear la senal CLK que quiero usando el reloj interno que creamos anteriormente, ademas
	--tambien puede ser detenida por el mismo boton de reset.
	relojDeSalida : process(i_clk, reset)
		begin
			if (reset = '1') then--Cuando el boton de reset es presionado el reloj de salida vale 0 logico.
				clk_out <= '0';
			--Cuando hay un flanco de subida en el reloj interno, al reloj de salida se le asigna el valor negado del 
			--valor que tenia anteriormente para crear la senal de reloj que quiero.
			elsif(rising_edge(i_clk)) then
				--Por esta linea de codigo es que tuvimos que crear una signal en vez de usar directo la salida reloj1Hz, 
				--ya que se esta leyendo y sobrescribiendo el valor en una misma linea de codigo y las salidas no se 
				--pueden leer, solo se les puede asignar un valor.
				clk_out <= not clk_out;
			end if;
	end process relojDeSalida;

--Fuera del segundo process asignaremos el valor de la signal clk_salida a la salida reloj1Hz
relojSalida <= clk_out;

end Behavioral;
