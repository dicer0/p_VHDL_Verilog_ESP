--COMPARADOR: PARA HACER UN COMPARADOR DEBO HACER USO DE CONDICIONALES IF.

--Los comentarios se ponen con dos guiones seguidos
--El lenguaje VHDL no distingue entre mayusculas y minsculas
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las libreras IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL

--La ENTIDAD es donde declaro mis entradas y salidas
entity comparador is
    Port ( a : in  STD_LOGIC_VECTOR (4 downto 0);
           b : in  STD_LOGIC_VECTOR (4 downto 0);
			  --Entradas en forma de vector, osea numero binario de 5 bits, su bit mas significativo 
			  --esta en la coordenada 4 y el menos significativo en la coordenada 0.
           igual : out  STD_LOGIC;
           menor : out  STD_LOGIC;
           mayor : out  STD_LOGIC);
			  --Las salidas son de un bit
end comparador;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y 
--end nombreArquitectura;
architecture nombreArquitectura of comparador is
begin
	--CONDICIONAL IF
	--process se usa para poder usar condicionales o bucles y tiene su propio begin y end process;
	process (A, B)
		--process(dentro de su parentesis debo poner las entradas que vaya a usar en el condicional).
		--las diferentes entradas se separan entre si por comas.
		begin
			--En VHDL cuando se asigna el valor a una variable de un bit se usan comillas simples '' 
			--y cuando se quiere asignar valor a un vector se usan comillas dobles "".
			igual <= '0';
			mayor <= '0';
			menor <= '0';
			--Es recomendable siempre inicializar mis salidas con algun valor, las entradas no pueden 
			--ser inicializadas.
			--En VHDL el contenido del condicional if se pone entre las instrucciones then y end if y 
			--su condicion se pone despues de la palabra reservada if sin la necesidad de estar entre 
			--parentesis.
			if (A = B) 
				then 
					igual <= '1'; 
				end if;--Al final de los end if debo poner punto y coma ;
			--Condicional igual que
			if (A > B) 
				then 
					mayor <= '1';
				end if;
			--Condicional mayor que
			if (A < B) 
				then 
					menor <= '1'; 
				end if;
			--Condicional menor que
		end process;--Al final de end process debo poner punto y coma ;
end nombreArquitectura;--Al final del end de la arquitectura debo poner punto y coma ;

