--3.-Máquina de estados que crea un contador al recibir 2 bits de un encoder rotativo y un bit de un boton para 
--seleccionar la operación en el siguiente, tomando en cuenta la dirección de giro del encoder.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity selectorEncoder is
PORT(
	CLK2	: in STD_LOGIC;	--Señal de reloj a 381.47 Hz
	contador : out  STD_LOGIC_VECTOR (1 downto 0);
	A1 : in STD_LOGIC;	--Pin A del encoder
	B1	: in STD_LOGIC;	--Pin B del encoder
	Boton	: in STD_LOGIC;	--Botón para el selector
	SELECTOR	: out STD_LOGIC_VECTOR(2 downto 0); --Selector para el módulo de operaciones
	DIRECTION: out STD_LOGIC	--Indicador de giro 1 = cw / 0 = ccw
);
end selectorEncoder;

architecture Behavioral of selectorEncoder is

type EDOS is (EA, EB, EC, ED);
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobrevivirán durante la ejecución del programa, no 
--está conectada a ningún puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal conteoAscendente : STD_LOGIC_VECTOR (1 downto 0) := "00";--Se le da un valor inicial de 0 al vector
signal EP : EDOS := EA;
signal AB : STD_LOGIC_VECTOR (1 downto 0);
signal cw : STD_LOGIC_VECTOR (1 downto 0);
signal ccw: STD_LOGIC_VECTOR (1 downto 0);
signal dir : STD_LOGIC;
begin
	process(CLK2)
	begin
		--La instrucción rising_edge indica que cada que ocurra un flanco de subida en el reloj, se le sumará un 1 
		--binario al valor que tenía previamente el vector conteoAscendente, esto hará que se cree la secuencia 
		--00, 01, 10 y 11 en el selector, especificamente en ese órden
		if(rising_edge(CLK2)) then
			conteoAscendente <= conteoAscendente + "01";
			--El conteo solito volverá a ser 00 cuando se supere el valor 11 en el vector conteoAscendente de 2 bits
		end if;
	end process;
	
	--Se usa una signal en vez de hacer el contador directo con la salida contador porque a las salidas solo se
	--les puede asignar un valor, no se les puede leer
	contador <= conteoAscendente;
	
	AB <= A1&B1;
	
	process(CLK2)
	begin
		if rising_edge(CLK2) then 
			case EP is
				when EA =>
					if AB = "11" then --HOLD
						EP <= EA;
						cw <= cw;
					elsif AB = "01" then --CW
						EP <= EB;
						dir <= '1';
						cw <= cw + "01";
					elsif AB = "10" then --CCW
						EP <= ED;
						dir <= '0';
						cw <= cw - "01";
					end if;
				when EB=>	--HOLD
					cw <= cw;
					if AB = "01" then EP <= EB;
					elsif AB = "00" then EP <= EC;
					elsif AB = "11" then EP <= EA;
					end if;
				when EC =>
					if AB = "00" then --HOLD
						EP <= EC;
						cw <= cw;
					elsif AB = "10" then --CW
						EP <= ED;
						dir <= '1';
						cw <= cw + "01";
					elsif AB = "01" then --CCW
						EP <= EB;
						dir <= '0';
						cw <= cw - "01";
					end if;
				when ED =>	--HOLD
					cw <= cw;
					if AB = "10" then EP <= ED;
					elsif AB = "11" then EP <= EA;
					elsif AB = "00" then EP <= EC;
					end if;
				when others => null;
			end case;
		end if;
	end process;
	
	DIRECTION <= DIR;
	SELECTOR	<= Boton & cw;
	
end Behavioral;