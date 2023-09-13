--MODULO QUE USA EL DIVISOR DE RELOJ PARA PRENDER Y APAGAR UN LED
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--En la entidad se declaran las entradas y salidas
entity encenderApagarLed is
    Port ( entrada : in  STD_LOGIC;
           salida : out  STD_LOGIC);
end encenderApagarLed;

--En la arquitectura se indican las acciones a ejecutar con las entradas y salidas
architecture Behavioral of encenderApagarLed is
begin
process(entrada)
	begin 
		if(entrada='1')then
			salida <= '1';	--Encender led.
		else
			salida <= '0'; --Apagar led.
		end if;
	end process;
end Behavioral;