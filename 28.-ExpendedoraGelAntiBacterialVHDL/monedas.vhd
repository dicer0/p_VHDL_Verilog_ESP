--Este mdulo calcula el precio total de compra, recibe el valor de las monedas ingresadas, realiza el 
--calculo del cambio, dependiendo de la cantidad ingresada, activa las salidas a los actuadores lineales 
--y envia una seal de activacin para el mdulo PWM.
library IEEE;
use IEEE.std_logic_1164.all;
--Libreras para poder usar el lenguaje VHDL.
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
--Libreras declaradas para poder hacer operaciones matemticas sin considerar el signo o para hacer conversiones de 
--binario a integer (osea de binario a decimal).
entity depositoMonedas is
	 Port( RELOJ50		: in STD_LOGIC;							 --Reloj a 50MHz
			 DATAINM 	: in STD_LOGIC_VECTOR (3 downto 0);  --Moneda ingresada [1 2 5 10]
			 ARTICULOSM	: in STD_LOGIC_VECTOR (2 downto 0);  --Cantidad de articulos a comprar
			 MENSAJEM	: out STD_LOGIC_VECTOR (4 downto 0); --Mensaje a LCD
			 DATAOUTLED : out STD_LOGIC_VECTOR (3 downto 0); --A actuadores lineales [1 2 5 10]
			 CAMM			: out STD_LOGIC_VECTOR (3 downto 0);
			 RESM			: out STD_LOGIC_VECTOR (3 downto 0);
			 DATAPWM		: out std_logic
	 );
end depositoMonedas;

architecture Behavioral of depositoMonedas is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin, se le asignan valores con el simbolo :=
signal M1 	: integer range 0 to 63 :=10; --Contador de Monedas de 1 peso.
signal M2 	: integer range 0 to 63 :=10; --Contador de Monedas de 2 pesos.
signal M5 	: integer range 0 to 63 :=10; --Contador de Monedas de 5 pesos.
signal M10 	: integer range 0 to 63 :=10; --Contador de Monedas de 10 pesos.
--Calculos resultantes de dinero.
signal DIN	: integer range 0 to 63 :=0; --Dinero ingresado.
signal PRET	: integer range 0 to 63 :=0; --Precio total de la compra.
signal CAM	: integer range 0 to 63 :=0; --Cambio.
signal CAM2	: integer range 0 to 63 :=0; --Iteraciones para el calculo del cambio.
signal RES	: integer range 0 to 63 :=0; --Dinero restante.
signal contador : STD_LOGIC_VECTOR (24 DOWNTO 0):=(others => '0');
signal retardo : STD_LOGIC;
signal DATAOUTM 	: STD_LOGIC_VECTOR (3 downto 0); --[1 2 5 10]

begin
	process(DATAINM, ARTICULOSM) begin
	--CALCULO DEL PRECIO A PAGAR	
		case ARTICULOSM is
			when "001" =>
					PRET <= 10; --1 BOTELLA ($10).
					MENSAJEM <= "00001"; --INGRESE $10.
			when "010" =>
					PRET <= 20; --2 BOTELLAS ($20).
					MENSAJEM <= "00010"; --INGRESE $20.
			when "100" =>
					PRET <= 30; --3 BOTELLAS ($30).
					MENSAJEM <= "00011"; --INGRESE $30.
			when others => 
					PRET <= 0;--0 BOTELLAS.
					MENSAJEM <= "00100"; --SALUDO.
		end case;
		
	--INGRESO DE LAS MONEDAS
		case DATAINM is
			when "1000" => 
				if (M1 = 84) then			--84 monedas de 1 peso
					MENSAJEM <= "01000";	--Deposito lleno FUERA DE SERVICIO
				elsif(M1 = 0) then
					MENSAJEM <= "01001";	--Deposito vacio FUERA DE SERVICIO
				else
					M1 <= M1 +1;
					DIN <= DIN + 1;
				end if;
			when "0100" => 
				if (M2 = 71) then			--71 monedas de 2 pesos
					MENSAJEM <= "01000";	--Deposito lleno FUERA DE SERVICIO
				elsif(M2 = 0) then
					MENSAJEM <= "01001";	--Deposito vacio FUERA DE SERVICIO
				else
					M2 <= M2 +1;
					DIN <= DIN + 2;
				end if;
			when "0010" =>
				if (M5 = 59) then			--59 monedas de 5 pesos
					MENSAJEM <= "01000";	--Deposito lleno FUERA DE SERVICIO
				elsif(M5 = 0) then
					MENSAJEM <= "01001";	--Deposito vacio FUERA DE SERVICIO
				else
					M5 <= M5 +1;
					DIN <= DIN + 5;
				end if;
			when "0001" =>
				if (M10 = 45) then		--45 monedas de 10 pesos
					MENSAJEM <= "01000";	--Deposito lleno FUERA DE SERVICIO
					elsif(M10 = 0) then
					MENSAJEM <= "01001";	--Deposito vacio FUERA DE SERVICIO
				else
					M10 <= M10 +1;
					DIN <= DIN + 10;
				end if;
			when others => DIN <= 0;
		end case;
		
	--DINERO INGRESADO
	if (DIN = PRET) then 	--EL DINERO INGRESADO ES IGUAL AL PRECIO DEL PRODUCTO
		MENSAJEM <= "00101"; --GRACIAS
	elsif (0<DIN and DIN < PRET) then --EL DINERO INGRESADO ES MENOR AL PRECIO DEL PRODUCTO
		MENSAJEM <= "00110"; --DEPOSITE (RES)
		RES <= PRET - DIN;		
	elsif (DIN > PRET) then --EL DINERO INGRESADO EXCEDE EL PRECIO DEL PRODUCTO
		MENSAJEM <= "00111"; --SU CAMBIO ES (CAM)
		CAM <= DIN - PRET;
		CAM2 <= DIN - PRET;
		
	--CALCULO DEL CAMBIO
		if (CAM2 /= 0) then
			for k in 0 to 8 loop
				if (M5 /= 0 AND M2 /=0 AND M1 /= 0) then
					if (CAM2 >= 5) then
						CAM2 <= CAM2 - 5;
						DATAOUTM <= "0010";
						M5 <= M5 - 1;
					elsif (CAM2 >= 2) then
						CAM2 <= CAM2 - 2;
						DATAOUTM <="0100";
						M2 <= M2 - 1;
					elsif (CAM2 >= 1) then
						CAM2 <= CAM2 - 1;
						DATAOUTM <="1000";
						M1 <= M1 - 1;
					end if;
				elsif (M2 /=0 AND M1 /= 0) then
					if (CAM2 >= 2) then
						CAM2 <= CAM2 - 2;
						DATAOUTM <="0100";
						M2 <= M2 - 1;
					elsif (CAM2 >= 1) then
						CAM2 <= CAM2 - 1;
						DATAOUTM <="1000";
						M1 <= M1 - 1;
					end if;
				elsif (M1 /= 0) then
					if (CAM2 >= 1) then
						CAM2 <= CAM2 - 1;
						DATAOUTM <="1000";
						M1 <= M1 - 1;
					end if;
				else
					MENSAJEM <= "01001";	--Deposito vacio FUERA DE SERVICIO
					DATAOUTM <= "0000";
				end if;
			end loop;
		end if;
	else							--HO HA INGRESADO DINERO
		MENSAJEM <= "00100"; --SALUDO
		DATAOUTM <= "0000";
	end if;
	end process;
	
	CAMM <= std_logic_vector(to_unsigned(CAM, CAMM'length));
	RESM <= std_logic_vector(to_unsigned(RES, RESM'length));

	--RETARDO A LEDS
	process(RELOJ50) begin --DIVISOR DE FRECUENCIA A 1HZ
		if RELOJ50'event and RELOJ50='1' then  
			contador <= contador + '1';
		end if;
	end process;
	retardo <= contador(24); --FRECUENCIA A 1 HZ
	
	process(retardo) begin
		if retardo'event and retardo = '1' then
			DATAOUTLED <= DATAOUTM; -- SEAL RETARDADA
			DATAPWM <= '1';
		end if;
	end process;
end Behavioral;