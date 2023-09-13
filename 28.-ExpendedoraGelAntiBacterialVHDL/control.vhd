--3.-CONTROL PARA EL MENSAJE MOSTRADO EN LOS 4 DISPLAYS DE 7 SEGMENTOS:
--Por medio de este modulo se enciende toda la maquina expendedora, se elige el tipo de producto que dara y 
--se recibe la senal del sensor ldr (Light Dependant Resistor) para ver si hay productos disponibles o no.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.
entity controlDisplay is
    Port ( ON_OFF : in  STD_LOGIC;	--Switch que enciende o apaga toda la maquina expendedora.
           selectorArticulo : in  STD_LOGIC_VECTOR (2 downto 0);	--Elegir tipo de producto.
           productoDisponible : in  STD_LOGIC;	--Sensor LDR que indica si hay productos disponibles.
           articuloDisplay : out  STD_LOGIC_VECTOR (2 downto 0);	--Letrero que indica el articulo elegido.
           mensajeBienvenida : out  STD_LOGIC_VECTOR (1 downto 0);--Letrero que dice HOLA.
           disponibilidad : out  STD_LOGIC);	--Led que se enciende si hay productos disponibles.
end controlDisplay;

architecture Behavioral of controlDisplay is begin
--Los process se declaran en VHDL para poder utilizar condicionales y bucles, dentro de su parentesis se 
--declaran las entradas que se utilizaran.
process(ON_OFF, selectorArticulo, productoDisponible) begin
	if(productoDisponible = '1') then	--Si hay producto disponible, no se prendera el led disponibilidad.
		--El bit ON_OFF funciona como enable del led disponibilidad y el selector articuloDisplay.
		disponibilidad <= ON_OFF;	--Si hay productos disponibles se prendera un led.
		if (selectorArticulo = "001") then	 	
			articuloDisplay <= "00" & ON_OFF;		--selectorArticulo = articuloDisplay = 001 = Art.1
			mensajeBienvenida <= "00";					--mensajeBienvenida 00 = Se muestra el letrero del articulo.
		elsif(selectorArticulo = "010") then 	
			articuloDisplay <= "0" & ON_OFF & "0"; --selectorArticulo = articuloDisplay = 010 = Art.2
			mensajeBienvenida <= "00";					--mensajeBienvenida 00 = Se muestra el letrero del articulo.
		elsif(selectorArticulo = "100") then 	
			articuloDisplay <= ON_OFF & "00";		--selectorArticulo = articuloDisplay = 100 = Art.3
			mensajeBienvenida <= "00";					--mensajeBienvenida 00 = Se muestra el letrero del articulo.
		else
			articuloDisplay <= "000";					--articuloDisplay = 000 = Se muestra el letrero de saludo.
			mensajeBienvenida <= "0" & ON_OFF;		--mensajeBienvenida 01 = HOLA
		end if;
	else 
		disponibilidad <= '0'; 					--Si NO hay productos disponibles no se prendera el led.
		articuloDisplay <= "000";				--No se mostrara ningun articulo seleccionado.
		mensajeBienvenida <= ON_OFF & "0";	--El mensajeBienvenida 10 = 00 = ---- (que significa vacio).
	end if;
end process;
end Behavioral;