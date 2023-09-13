--3.-SECUENCIA MODO NORMAL Y NOCTURNO:
--En proceso se prenden y apagan los tres leds (rojo, amarillo y verde) en las dos secuencias 
--modo normal y nocturno en los dos semaforos SN (abajo hacia arriba) y OE (izquierda a derecha)
--	-Secuencia 1 (modo normal): 10s se muestra la luz roja, 7s se muestra la verde con 3 parpadeos 
--	 antes del amarillo y 3s se muestra la luz amarilla, estas secuencias estan entrelazadas en los
--	 dos semaforos SN y OE, dando en total una secuencia de 20s.
--	-Secuencia 2 (modo nocturno): En esta secuencia simplemente se pone a parpadear la luz roja en 
--	 el semaforo SN y la amarilla en el semaforo OE.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity secuenciaSemaforo is
    Port ( conteo : in  STD_LOGIC_VECTOR (4 downto 0);
           modoParpadeo : in  STD_LOGIC;
           semSN : out  STD_LOGIC_VECTOR (2 downto 0);
           semOE : out  STD_LOGIC_VECTOR (2 downto 0));
end secuenciaSemaforo;

architecture Behavioral of secuenciaSemaforo is
	constant verde: std_logic_vector (2 downto 0):="100";		--Semaforo en verde.
	constant amarillo: std_logic_vector (2 downto 0):="010";	--Semaforo en amarillo.
	constant rojo: std_logic_vector (2 downto 0):="001"; 		--Semaforo en rojo.
	constant parpadeo: std_logic_vector (2 downto 0):="000";	--Semaforos que esten parpadeando.
begin
	asignacion: process (conteo, modoParpadeo) begin
		--Si el switch modoParpadeo esta activado, se enciende el modo Nocturno, donde simplemente
		--parpadean los samaforos SN y OE, en SN parpadea la luz roja y en OE parpadea la luz amarilla.
		if (modoParpadeo = '1') then
			case(conteo) is -- Alternativa con case
				when "00000" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 0.
				when "00001" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 1.
				when "00010" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 2.
				when "00011" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 3.
				when "00100" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 4.
				when "00101" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 5.
				when "00110" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 6.
				when "00111" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 7.
				when "01000" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 8.
				when "01001" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 9.
				when "01010" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 10.
				when "01011" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 11.
				when "01100" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 12.
				when "01101" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 13.
				when "01110" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 14.
				when "01111" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 15.
				when "10000" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 16.
				when "10001" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 17.
				when "10010" => semSN<=parpadeo; semOE<=parpadeo; 	--segundo 18.
				when "10011" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 19.
				when others => semSN<=parpadeo; 	semOE<=parpadeo; 	--otros, osea el reinicio del conteo.
			end case;
		--Si el switch modoParpadeo esta activado, se enciende el modo Nocturno, donde 10s se muestra 
		--la luz roja, 7s se muestra la verde con 3 parpadeos antes del amarillo y 3s se muestra la luz 
		--amarilla, estas secuencias estan entrelazadas en los dos semaforos SN y OE, dando en total 
		--una secuencia de 20s.
		else
			case(conteo) is -- Alternativa con case
				when "00000" => semSN<=rojo; 		semOE<=verde; 		--segundo 0: Empieza el rojo en NS.
				when "00001" => semSN<=rojo; 		semOE<=parpadeo; 	--segundo 1.
				when "00010" => semSN<=rojo; 		semOE<=verde; 		--segundo 2.
				when "00011" => semSN<=rojo; 		semOE<=parpadeo; 	--segundo 3.
				when "00100" => semSN<=rojo; 		semOE<=verde; 		--segundo 4.
				when "00101" => semSN<=rojo; 		semOE<=parpadeo; 	--segundo 5.
				when "00110" => semSN<=rojo; 		semOE<=verde; 		--segundo 6.
				when "00111" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 7.
				when "01000" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 8.
				when "01001" => semSN<=rojo; 		semOE<=amarillo; 	--segundo 9.
				when "01010" => semSN<=verde; 	semOE<=rojo; 		--segundo 10: Empieza el verde en NS.
				when "01011" => semSN<=parpadeo; semOE<=rojo; 		--segundo 11: Empieza el parpadeo en NS.
				when "01100" => semSN<=verde; 	semOE<=rojo; 		--segundo 12.
				when "01101" => semSN<=parpadeo; semOE<=rojo; 		--segundo 13.
				when "01110" => semSN<=verde; 	semOE<=rojo; 		--segundo 14.
				when "01111" => semSN<=parpadeo; semOE<=rojo; 		--segundo 15.
				when "10000" => semSN<=verde; 	semOE<=rojo; 		--segundo 16.
				when "10001" => semSN<=amarillo; semOE<=rojo; 		--segundo 17: Empieza el amarillo en NS.
				when "10010" => semSN<=amarillo; semOE<=rojo; 		--segundo 18.
				when "10011" => semSN<=amarillo; semOE<=rojo; 		--segundo 19.
				when others => semSN<=parpadeo; 	semOE<=rojo;		--otros, osea el reinicio del conteo.
			end case;
		end if;
	end process asignacion;
end Behavioral;