--COMPARADOR DE 2 NUMEROS BINARIOS CON RESULTADO MOSTRADO EN DISPLAY DE 7 SEGMENTOS
--Para hacer este comparador se usar un condicional IF
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las librerias IEEE y IEEE.STD_LOGIC_1164 sirven para que pueda solo usar el lenguaje VHDL

--ENTDIDAD: Aqu se declaran las entradas/salidas del programa
entity comparador is
    Port ( AN : out  STD_LOGIC_VECTOR (3 downto 0);
			  --El vector AN sirve para elegir cuales de los 4 displays de 7 segmentos que tiene 
			  --la FPGA se van a activar. Los displays se prenden mandando un 0 logico.
           CA : out  STD_LOGIC;
           CB : out  STD_LOGIC;
           CC : out  STD_LOGIC;
           CD : out  STD_LOGIC;
           CE : out  STD_LOGIC;
           CF : out  STD_LOGIC;
           CG : out  STD_LOGIC;
           DP : out  STD_LOGIC;
			  --Leds individuales de todos los displays de 7 segmentos, se prende cada uno con 0 logico
			  a : in  STD_LOGIC_VECTOR (3 downto 0);	--Numeros binarios A y B de 4 bits a comparar.
           b : in  STD_LOGIC_VECTOR (3 downto 0));
end comparador;

--ARQUITECTURA: Aqu se les dice a las entradas/salidas lo que van a hacer
architecture nombreArquitectura of comparador is--La arquitectura tiene su propio begin y end nombreArquitectura;
begin
	--process se declara siempre que vaya a usar condicionales if o case y dentro de sus parentesis van las entradas
	--que voy a usar dentro del condicional.
	process(A, B)
	begin--process tiene sus propios begin y end process;
		if (A>B) then 
			AN <= "1110";--Solo el 4to display esta encendido
			--Para que este orden se respete en el UCF debo asignar cada display partiendo desde el bit 
			--menos significativo hasta el mas significativo.
			CA <= '1';--Led A del display apagado
			CB <= '1';--Led B del display apagado
			CC <= '0';--Led C del display ENCENDIDO
			CD <= '0';--Led D del display ENCENDIDO
			CE <= '1';--Led E del display apagado
			CF <= '1';--Led F del display apagado
			CG <= '0';--Led G del display ENCENDIDO
			--Todos estos leds prendidos estan representando un signo de mayor que >.
			DP <= '1';--El punto del display esta apagado.
		elsif (A<B) then
			AN <= "0111";--Solo el 1er display esta encendido
			--Para que este orden se respete en el UCF debo asignar cada display partiendo desde el bit 
			--menos significativo hasta el mas significativo
			CA <= '1';--Led A del display apagado
			CB <= '1';--Led B del display apagado
			CC <= '1';--Led C del display apagado
			CD <= '0';--Led D del display ENCENDIDO
			CE <= '0';--Led E del display ENCENDIDO
			CF <= '1';--Led F del display apagado
			CG <= '0';--Led G del display ENCENDIDO
			--Todos estos leds prendidos estan representando un signo de menor que <.
			DP <= '1';--El punto del display esta apagado.
		elsif (A=B) then
			AN <= "1001";--Los dos displays de en medio estan encendidos
			--Para que este orden se respete en el UCF debo asignar cada display partiendo desde el bit 
			--menos significativo hasta el mas significativo.
			CA <= '1';--Led A del display apagado
			CB <= '1';--Led B del display apagado
			CC <= '1';--Led C del display apagado
			CD <= '0';--Led D del display ENCENDIDO
			CE <= '1';--Led E del display apagado
			CF <= '1';--Led F del display apagado
			CG <= '0';--Led G del display ENCENDIDO
			--Todos estos leds prendidos estan representando un signo de igual que =.
			DP <= '1';--El punto del display esta apagado.
		elsif (A>=B) then
			AN <= "1011";--Solo el 2do display esta encendido
			--Para que este orden se respete en el UCF debo asignar cada display partiendo desde el bit 
			--menos significativo hasta el mas significativo
			CA <= '0';--Led A del display ENCENDIDO
			CB <= '0';--Led B del display ENCENDIDO
			CC <= '1';--Led C del display apagado
			CD <= '0';--Led D del display ENCENDIDO
			CE <= '1';--Led E del display apagado
			CF <= '1';--Led F del display apagado
			CG <= '0';--Led G del display ENCENDIDO
			--Todos estos leds prendidos estan representando un signo de mayor o igual que >=.
			DP <= '1';--El punto del display esta apagado.
		elsif (A<=B) then
			AN <= "1101";--Solo el 3er display esta encendido
			--Para que este orden se respete en el UCF debo asignar cada display partiendo desde el bit 
			--menos significativo hasta el mas significativo.
			CA <= '0';--Led A del display ENCENDIDO
			CB <= '1';--Led B del display apagado
			CC <= '1';--Led C del display apagado
			CD <= '0';--Led D del display ENCENDIDO
			CE <= '1';--Led E del display apagado
			CF <= '0';--Led F del display ENCENDIDO
			CG <= '0';--Led G del display ENCENDIDO
			--Todos estos leds prendidos estan representando un signo de mayor o igual que >=.
			DP <= '1';--El punto del display esta apagado.
		else
			AN <= "1001";--Los dos displays de en medio estan encendidos
			--Para que este orden se respete en el UCF debo asignar cada display partiendo desde el bit 
			--menos significativo hasta el mas significativo.
			CA <= '1';--Led A del display apagado
			CB <= '1';--Led B del display apagado
			CC <= '0';--Led C del display ENCENDIDO
			CD <= '1';--Led D del display apagado
			CE <= '1';--Led E del display apagado
			CF <= '0';--Led F del display ENCENDIDO
			CG <= '0';--Led G del display ENCENDIDO
			--Todos estos leds prendidos estan representando un signo de menor o igual que <=.
			DP <= '0';--El punto del display esta ENCENDIDO.
		end if;
	end process;
end nombreArquitectura;
--Este cadigo no se puede hacer asi porque como los displays muestran una sola imagen todos a la vez
--Aunque se cumplan varias condiciones del if a la vez, no se veran todos, necesitara 2 displays externos
--Para que se pudieran ver todas las condiciones a la vez.