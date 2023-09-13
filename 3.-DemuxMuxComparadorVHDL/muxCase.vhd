--MULTIPLEXOR DE 9 ENTRADAS USANDO EL CONDICIONAL CASE
--Los multiplexores reciben varias senales de entrada (en este caso de 2 bits) y por medio de otra entrada 
--llamada selector se elige una de ellas para que sea la salida, cambiando el selector se puede elegir otra 
--senal para que sea la nueva salida

--El tamano del numero binario del selector se calcula de la siguiente manera: 
--#entradas = 2 ^(#bits del selector)
--16 = 2 ^(4)
--Por lo tanto, si tengo 9, 10, 11, 12, 13, 14, 15 o 16 entradas, el # de bits del selector debe ser de 4, osea [3:0]

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las libreras IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL

--La ENTIDAD es donde declaro mis entradas y salidas
entity muxCase is
    Port ( a : in  STD_LOGIC_VECTOR (1 downto 0);
           b : in  STD_LOGIC_VECTOR (1 downto 0);
           c : in  STD_LOGIC_VECTOR (1 downto 0);
           d : in  STD_LOGIC_VECTOR (1 downto 0);
           e : in  STD_LOGIC_VECTOR (1 downto 0);
           f : in  STD_LOGIC_VECTOR (1 downto 0);
           g : in  STD_LOGIC_VECTOR (1 downto 0);
           h : in  STD_LOGIC_VECTOR (1 downto 0);
           i : in  STD_LOGIC_VECTOR (1 downto 0);
			  --Senales de entrada
           selector : in  STD_LOGIC_VECTOR (3 downto 0);
			  --El selector tambien es una senal de entrada
           salida : out  STD_LOGIC_VECTOR (1 downto 0));
			  --La salida sera determinada por el selector
end muxCase;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end nombreArquitectura;
architecture nombreArquitectura of muxCase is
begin
	--CONDICIONAL CASE, es parecido al condicional switch case
	--process se usa para poder usar condicionales o bucles y tiene su propio begin y end process;
	process(selector, a, b, c, d, e, f, g, h, i)
	--process(dentro de su parentesis debo poner las entradas que vaya a usar en el condicional)
	--las diferentes entradas se separan entre si por comas.
	begin
		--En VHDL no se puede inicializar las entradas, por lo que estas deben ser asignadas a switches de la NEXYS 2
		--o a switches externos.
		case (selector) is --CASE se usa para evaluar los diferentes valores que pueda adoptar una variable
			--El selector deber adoptar diferentes numeros binarios que abarquen todas las posibles salidas del 
			--demux, dependiendo del numero de bits que tenga es el numero de posibilidades que puede aportar
			--El simbolo & se usa para concatenar variables con bits y se usa para darle uso al enable.
			when "0001" => salida <= a;  --selector con valor decimal 1 = salida 0001 de 4 bits
			when "0010" => salida <= b;  --selector con valor decimal 2 = salida 0001 de 4 bits
			when "0011" => salida <= c;  --selector con valor decimal 3 = salida 0001 de 4 bits
			when "0100" => salida <= d;  --selector con valor decimal 4 = salida 0001 de 4 bits
			when "0101" => salida <= e;  --selector con valor decimal 5 = salida 0001 de 4 bits
			when "0110" => salida <= f;  --selector con valor decimal 6 = salida 0001 de 4 bits
			when "0111" => salida <= g;  --selector con valor decimal 7 = salida 0001 de 4 bits
			when "1000" => salida <= h;  --selector con valor decimal 8 = salida 0001 de 4 bits
			when "1001" => salida <= i;  --selector con valor decimal 9 = salida 0001 de 4 bits
			--Para la ultima condicion siempre debo usar la instruccion when others perteneciente al 
			--condicional case
			when others => salida <= "ZZ";--selector con valor decimal 10, 11, 12, 13, 14, 15 o 16 = salida ZZ de 2 bits
			--El tamano del selector y el tamano de la salida no dependen uno del otro
		end case;--Al final del end case debo poner punto y coma ;
	end process;--Al final del end process debo poner punto y coma ;
end nombreArquitectura;--Al final del end de la arquitectura debo poner punto y coma ;

