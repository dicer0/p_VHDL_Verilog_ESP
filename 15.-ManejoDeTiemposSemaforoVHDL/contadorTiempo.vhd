--2.-CONTADOR:
--En proceso se realiza el conteo de 0 a 23 del selector que indicara el comportamiento 
--de las dos secuencias del semaforo: Modo normal y modo nocturno.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria para poder realizar operaciones matemticas sin considerar el signo


entity contadorTiempo is
    Port ( frecuenciaReloj : in  STD_LOGIC;	--Reloj de 50MHz de la NEXYS 2.
			  --Contador de 5 bits, desde 0 hasta el 31 en binario, aqui se abarcan 
			  --los 20 segundos de la secuencia.
           Contador : out  STD_LOGIC_VECTOR (4 downto 0);
			  reiniciar: in STD_LOGIC
			 );
end contadorTiempo;

architecture Behavioral of contadorTiempo is
signal conteoAscendente : STD_LOGIC_VECTOR (4 downto 0) := "00000";
begin
	process(frecuenciaReloj, reiniciar)
	begin
		if(rising_edge(frecuenciaReloj)) then
			--Cuando el conteo llegue hasta 20, se reinicia el conteo del selector.
			if(conteoAscendente >= "10100") then
				conteoAscendente <= "00000";
			--Tambien si se presiona el boton de reset, el conteo se reinicia.
			elsif(reiniciar = '1') then
				conteoAscendente <= "00000";
			--Si el conteo no ha llegado a los 20 segundos o no se ha reiniciado, cuenta 
			--de 0 a 20 con un tiempo de separacion de 1/0.745Hz = 1.3422 segundos.
			else
				conteoAscendente <= conteoAscendente + "00001";
			end if;
		end if;
	end process;
	
	Contador <= conteoAscendente;
end Behavioral;