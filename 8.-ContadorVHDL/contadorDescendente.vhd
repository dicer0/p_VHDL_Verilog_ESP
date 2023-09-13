--CONTADOR DESCENDENTE
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Librera para poder realizar operaciones matematicas sin considerar el signo.

--Entidad: Declaro como entradas al reloj y al boton de reset y como salida al contador de 4 bits.
entity contadorDescendente is
    Port ( CLK : in  STD_LOGIC;--Reloj de 50MHz de la NEXYS 2.
           Rst : in  STD_LOGIC;--Boton de Reset.
           Contador : out  STD_LOGIC_VECTOR (3 downto 0));--Contador de 4 bits, desde el 15 hasta el 0 en binario.
end contadorDescendente;

--Arquitectura: Aqui realizar el conteo usando una signal porque en ella leer los valores anteriores para 
--restarle uno y sobrescribirla para realizar el conteo descendente.
architecture Behavioral of contadorDescendente is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, no 
--esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal conteoDescendente : STD_LOGIC_VECTOR (3 downto 0) := "1111";--Se le da un valor inicial de 15 al vector.
--Se usa una signal porque las salidas no se pueden leer, solo escribir.
begin
	process(CLK, Rst)--Process sirve para hacer operaciones matematicas, condicionales o bucles.
	begin--Dentro del parentesis de process() se deben poner las entradas que usar, tiene su propio begin y end.
		--La instruccion rising_egde() hace que el condicional se ejecute solo cuando haya un flanco de subida en la 
		--entrada clkNexys2 que recibe el reloj de 50MHz de la NEXYS 2.
		if(rising_edge(CLK)) then
			--Cuando el push button reset esta presionado valdra un 1 logico porque hace corto circuito y reinicia el 
			--conteo de la signal conteoAscendente.
			if(Rst='1') then--Aqui se usan las comillas porque nos estamos refiriendo a un bit con valor 1 logico.
				--NUMEROS HEXADECIMALES EN VHDL: 1 digito hexadecimal equivale a 4 bits en binario, esto nos puede servir
				--para poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits, como cuando 
				--debo llenar un vector de puros ceros, declaro un numero hexadecimal poniendo X"numero hexadecimal".
				conteoDescendente <= "1111";--Es un contador descendente porque empieza a contar desde el 15.
				--Aqui pude haber puesto X"F" que vale 15 en decimal en vez de poner "1111".
			else
				--Por esta instruccion es que debo hacer uso de una signal en vez de usar directamente la salida Contador,
				--ya que las salidas no pueden ser leidas, solo se les puede asignar un valor.
				conteoDescendente <= conteoDescendente - "0001";
				--Aqui pude haber puesto X"1" en vez de poner "0001".
				--Es un contador ascendente porque cuenta uno a uno desde 15.
			end if;
		end if;
	end process;
	
	--Fuera del process debo asignar el valor que haya en la signal a la salida de mi modulo.
	Contador <= conteoDescendente;
end Behavioral;

