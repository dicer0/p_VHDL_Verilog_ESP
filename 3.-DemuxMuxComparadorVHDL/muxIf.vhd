--MULTIPLEXOR DE 4 ENTRADAS USANDO EL CONDICIONAL IF
--Los multiplexores reciben varias senales de entrada (en este caso de un solo bit) y por medio de otra entrada 
--llamada selector se elige una de ellas para que sea la salida, cambiando el selector se puede elegir otra 
--senal para que sea la nueva salida

--El tamano del numero binario del selector se calcula de la siguiente manera: 
--#entradas = 2 ^(#bits del selector)
--4 = 2 ^(2)
--Por lo tanto, si tengo 4 o 3 entradas, el # de bits del selector debe ser de 2, osea [1:0]

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las libreras IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL

--La ENTIDAD es donde declaro mis entradas y salidas
entity muxIf is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           d : in  STD_LOGIC;
			  --Senales de entrada
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
			  --El selector tambien es una senal de entrada, pero es de tipo vector
           salida : out  STD_LOGIC);
			  --La salida sera determinada por el selector
end muxIf;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end nombreArquitectura;
architecture nombreArquitectura of muxIf is
begin
	--CONDICIONAL IF
	--process se usa para poder usar condicionales o bucles y tiene su propio begin y end process;
	process (a, b, c, d, selector)
		--process(dentro de su parentesis debo poner las entradas que vaya a usar en el condicional)
		--las diferentes entradas se separan entre si por comas
		begin
			if (selector = "00") then salida <= a;       --selector con valor decimal 0 = salida a
				elsif (selector = "01") then salida <= b; --selector con valor decimal 1 = salida b
				elsif (selector = "10") then salida <= c; --selector con valor decimal 2 = salida c
				--Para la ultima condicion (o ultimas condiciones) siempre debo usar la instruccion else
				else salida <= d;                       --selector con valor decimal 3 = salida d
			end if;
			--Todos los elsif (que son los else if de VHDL) y el else deben ir dentro del if y end if;
		end process;--Al final de end process debo poner punto y coma ;
end nombreArquitectura;--Al final del end de la arquitectura debo poner punto y coma ;

