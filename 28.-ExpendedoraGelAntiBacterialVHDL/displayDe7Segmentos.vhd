--4.-DECODIFICADOR PARA MOSTRAR ALGO EN LOS 4 DISPLAYS DE 7 SEGMENTOS A LA VEZ:
--Este codigo sirve para mostrar 4 cosas diferentes en los 4 displays de 7 segmentos, esto por si solo
--no se puede lograr porque los displays de 7 segmentos solo pueden ensenar un solo numero a la vez en todos los 
--displays de la NEXYS 2, para lograrlo debemos usar un Multiplexor, un Divisor de Reloj y un Contador.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Librerias declaradas para poder hacer operaciones matematicas sin considerar el signo o para hacer conversiones de 
--binario a integer (osea de binario a decimal).

entity displayDe7Segmentos is
    Port ( articuloDisplay : in  STD_LOGIC_VECTOR (2 downto 0);--Entrada que me indica el articulo elegido.
           mensajeBienvenida : in  STD_LOGIC_VECTOR (1 downto 0);--vector que me indica el mensaje a desplegar.
			  selectorMUX : in  STD_LOGIC_VECTOR (1 downto 0);--Selector proveniente del modulo contadorDisplay.
           prenderDisplay : out  STD_LOGIC_VECTOR (3 downto 0);--Vector de nodos comunes para prender cada display.
           ledsAhastaG : out  STD_LOGIC_VECTOR (6 downto 0);--Vector con los leds A,B,C,D,E,F y G.
           DP : out  STD_LOGIC;--Puntito en los displays.
			  servo_ON : out  STD_LOGIC);--Salida que enciende al servomotor cuando se haya seleccionado un articulo.
end displayDe7Segmentos;

--Arquitectura: Aqui se va a hacer un multiplexor que al recibir el selector del modulo contadorSelector, me permita 
--mostrar un numero en solo uno de los displays de 7 segmentos.
architecture muxAdisplay of displayDe7Segmentos is
begin
	process(articuloDisplay, mensajeBienvenida, selectorMUX) begin
		if(mensajeBienvenida = "00") then --Selector mensajeBienvenida = 00 = Se muestra el letrero del articulo.
			--if anidado para ver el estado del otro selector llamado articuloDisplay.
			servo_ON <= '0'; --El servomotor esta encendido.
			if (articuloDisplay = "001") then
				case selectorMUX is
					when "00"   => 
								prenderDisplay <= "0111";--Prende solo el 1er display.
								ledsAhastaG <= "0001000";--Letra A
								DP <= '1';--El puntito esta apagado.
					when "01"   => 
								prenderDisplay <= "1011";--Prende solo el 2do display.
								ledsAhastaG <= "1111010";--Letra r
								DP <= '1';--El puntito esta apagado.
					when "10"   => 
								prenderDisplay <= "1101";--Prende solo el 3er display.
								ledsAhastaG <= "1110000";--Letra t.
								DP <= '0';--El puntito esta encendido.
					when others => 
								prenderDisplay <= "1110";--Prende solo el 4to display.
								ledsAhastaG <= "1001111";--Numero 1
								DP <= '1';--El puntito esta apagado.
				end case;
			elsif(articuloDisplay = "010") then
				case selectorMUX is
					when "00"   => 
								prenderDisplay <= "0111";--Prende solo el 1er display.
								ledsAhastaG <= "0001000";--Letra A
								DP <= '1';--El puntito esta apagado.
					when "01"   => 
								prenderDisplay <= "1011";--Prende solo el 2do display.
								ledsAhastaG <= "1111010";--Letra r
								DP <= '1';--El puntito esta apagado.
					when "10"   => 
								prenderDisplay <= "1101";--Prende solo el 3er display.
								ledsAhastaG <= "1110000";--Letra t.
								DP <= '0';--El puntito esta encendido.
					when others => 
								prenderDisplay <= "1110";--Prende solo el 4to display.
								ledsAhastaG <= "0010010";--Numero 2
								DP <= '1';--El puntito esta apagado.
				end case;
			elsif(articuloDisplay = "100") then
				case selectorMUX is
					when "00"   => 
								prenderDisplay <= "0111";--Prende solo el 1er display.
								ledsAhastaG <= "0001000";--Letra A
								DP <= '1';--El puntito esta apagado.
					when "01"   => 
								prenderDisplay <= "1011";--Prende solo el 2do display.
								ledsAhastaG <= "1111010";--Letra r
								DP <= '1';--El puntito esta apagado.
					when "10"   => 
								prenderDisplay <= "1101";--Prende solo el 3er display.
								ledsAhastaG <= "1110000";--Letra t.
								DP <= '0';--El puntito esta encendido.
					when others => 
								prenderDisplay <= "1110";--Prende solo el 4to display.
								ledsAhastaG <= "0000110";--Numero 3
								DP <= '1';--El puntito esta apagado.
				end case;
			else
				case selectorMUX is
				when "00"   => 
							prenderDisplay <= "1111";--Los 4 displays estan apagados.
							ledsAhastaG <= "1111110";--Todos los leds de los displays estan apagados.
							DP <= '1';--El puntito esta apagado.
				when "01"   => 
							prenderDisplay <= "1111";--Los 4 displays estan apagados.
							ledsAhastaG <= "1111110";--Todos los leds de los displays estan apagados.
							DP <= '1';--El puntito esta apagado.
				when "10"   => 
							prenderDisplay <= "1111";--Los 4 displays estan apagados.
							ledsAhastaG <= "1111110";--Todos los leds de los displays estan apagados.
							DP <= '1';--El puntito esta apagado.
				when others => 
							prenderDisplay <= "1111";--Los 4 displays estan apagados.
							ledsAhastaG <= "1111110";--Todos los leds de los displays estan apagados.
							DP <= '1';--El puntito esta apagado.
			end case;
			end if;
		elsif(mensajeBienvenida = "01") then --Selector mensajeBienvenida = 01 = HOLA
			servo_ON <= '1'; --El servomotor esta apagado.
			case selectorMUX is
				when "00"   => 
							prenderDisplay <= "0111";--Prende solo el 1er display.
							ledsAhastaG <= "1001000";--Letra H
							DP <= '1';--El puntito esta apagado.
				when "01"   => 
							prenderDisplay <= "1011";--Prende solo el 2do display
							ledsAhastaG <= "0000001";--Letra O
							DP <= '1';--El puntito esta apagado.
				when "10"   => 
							prenderDisplay <= "1101";--Prende solo el 3er display
							ledsAhastaG <= "1110001";--Letra L
							DP <= '1';--El puntito esta apagado.
				when others => 
							prenderDisplay <= "1110";--Prende solo el 4to display
							ledsAhastaG <= "0001000";--Letra A
							DP <= '1';--El puntito esta apagado.
			end case;
		elsif(mensajeBienvenida = "10") then --Selector mensajeBienvenida = 10 = ---- (que significa vacio).
			servo_ON <= '1'; --El servomotor esta apagado.
			case selectorMUX is
				when "00"   => 
							prenderDisplay <= "0111";--Prende solo el 1er display
							ledsAhastaG <= "1111110";--simbolo -
							DP <= '1';--El puntito esta apagado.
				when "01"   => 
							prenderDisplay <= "1011";--Prende solo el 2do display
							ledsAhastaG <= "1111110";--simbolo -
							DP <= '1';--El puntito esta apagado.
				when "10"   => 
							prenderDisplay <= "1101";--Prende solo el 3er display
							ledsAhastaG <= "1111110";--simbolo -
							DP <= '1';--El puntito esta apagado.
				when others => 
							prenderDisplay <= "1110";--Prende solo el 4to display
							ledsAhastaG <= "1111110";--simbolo -
							DP <= '1';--El puntito esta apagado.
			end case;
		else
			prenderDisplay <= "1111";--Los 4 displays estan apagados.
			ledsAhastaG <= "1111111";--Todos los leds de los displays estan apagados.
			DP <= '1';--El puntito esta apagado.
			servo_ON <= '1'; --El servomotor esta apagado.
		end if;
	end process;
end muxAdisplay;