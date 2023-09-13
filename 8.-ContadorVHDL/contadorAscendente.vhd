--CONTADOR ASCENDENTE
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Librera para poder realizar operaciones matematicas sin considerar el signo.

--Entidad: Declaro como entradas al reloj y al boton de reset y como salida al contador de 4 bits.
entity contadorAscendente is
    Port ( clkNexys2 : in  STD_LOGIC;--Reloj de 50MHz de la NEXYS 2.
           Reset : in  STD_LOGIC;--Boton de Reset.
           Contador : out  STD_LOGIC_VECTOR (3 downto 0)--Contador de 4 bits, desde 0 hasta 15 en binario.
			 );
end contadorAscendente;

--Arquitectura: Aqui se realiza el conteo usando una signal porque en ella leer los valores anteriores para 
--sumarle uno y sobrescribirla para realizar el conteo ascendente.
architecture Behavioral of contadorAscendente is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, 
--no esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal conteoAscendente : STD_LOGIC_VECTOR (3 downto 0) := "0000";--Se le da un valor inicial de 0 al vector.
--Se usa una signal porque las salidas no se pueden leer, solo escribir.
begin
	process(clkNexys2, Reset)--Process sirve para hacer operaciones matematicas, condicionales o bucles.
	begin--Dentro del parentesis de process() se deben poner las entradas que usar, tiene su propio begin y end.
		--La instruccion rising_egde() hace que el condicional se ejecute solo cuando haya un flanco de subida en la 
		--entrada clkNexys2 que recibe el reloj de 50MHz de la NEXYS 2.
		if(rising_edge(clkNexys2)) then
			--Cuando el push button reset este presionado valdra un 1 logico porque hace corto circuito y reinicia el 
			--conteo de la signal conteoAscendente.
			if(Reset='1') then--Aqui se usan las comillas porque nos estamos refiriendo a un bit con valor 1 logico.
				--NUMEROS HEXADECIMALES EN VHDL: 1 digito hexadecimal equivale a 4 bits en binario, esto nos puede servir
				--para poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits, como cuando 
				--debo llenar un vector de puros ceros, declaro un numero hexadecimal poniendo X"numero hexadecimal".
				conteoAscendente <= "0000";--Es un contador ascendente porque empieza a contar desde cero.
				--Aqui pude haber puesto X"0" en vez de poner "0000".
			elsif(conteoAscendente >= "1000") then
				conteoAscendente <= "0000";--El conteo se puede hacer solo hasta un numero, en este caso es hasta el 8.
			else
				--Por esta instruccion es que debo hacer uso de una signal en vez de usar directamente la salida Contador,
				--ya que las salidas no pueden ser leidas, solo se les puede asignar un valor.
				conteoAscendente <= conteoAscendente + "0001";
				--Aqui pude haber puesto X"1" en vez de poner "0001".
				--Es un contador ascendente porque cuenta uno a uno desde cero.
			end if;
		end if;
	end process;
	
	--Fuera del process debo asignar el valor que haya en la signal a la salida de mi modulo.
	Contador <= conteoAscendente;
end Behavioral;

