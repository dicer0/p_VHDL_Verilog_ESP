--2.-CONTADOR ASCENDENTE Y DESCENDENTE
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria para poder realizar operaciones matematicas sin considerar el signo.

--Entidad: Declaro como entradas al reloj, al boton reset, direccion, enable y como salida al contador de 4 bits.
entity contadorAsc_Desc is
    Port ( clkNexys2 : in  STD_LOGIC;--Reloj de 50MHz de la NEXYS 2.
           Reset : in  STD_LOGIC;--Boton de Reset.
			  Direccion : in  STD_LOGIC;--Boton que indica si el contador es ascendente o descendente.
           Contador : out  STD_LOGIC_VECTOR (3 downto 0)--Contador de 4 bits, desde cero hasta 15 en binario.
			 );
end contadorAsc_Desc;

--Arquitectura: Aqui se realiza el conteo usando una signal, porque en ella se leeran los valores anteriores, para 
--sumarle uno y sobrescribirla y asi realizar el conteo ascendente.
architecture Behavioral of contadorAsc_Desc is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, no 
--esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal conteoAscendenteDescendente : STD_LOGIC_VECTOR (3 downto 0) := "0000";--Se le da un valor inicial de 0 al vector.
--Se usa una signal porque las salidas no se pueden leer, solo escribir, osea asignarles valores.
begin
	process(clkNexys2, Reset, Direccion)
	--Process sirve para hacer operaciones matematicas, condicionales o bucles.
	begin--Dentro del parentesis de process() se deben poner las entradas que usara, tiene su propio begin y end.
			--La instruccion rising_egde() hace que el condicional se ejecute solo cuando haya un flanco de subida en 
			--la entrada clkNexys2 que recibe el reloj de 50MHz de la NEXYS 2.
			if(rising_edge(clkNexys2)) then
				--Cuando el switch del reset no este presionado valdra 0 logico y reiniciara el conteo de la signal 
				--conteoAscendente.
				if(Reset='0') then--Aqui se usan las comillas porque nos estamos refiriendo a un bit con valor 1 logico.
					if(Direccion='0')then
						--NUMEROS HEXADECIMALES EN VHDL: 1 digito hexadecimal equivale a 4 bits en binario, esto nos puede 
						--servir para poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits, 
						--como cuando debo llenar un vector de puros ceros, declaro un numero hexadecimal poniendo:
						--X"numero hexadecimal".
						conteoAscendenteDescendente <= "0000";
						--Al dar clic al boton reset, empezara el conteo desde cero si la direccion es ascendente.
						--Aqui pude haber puesto X"0" en vez de poner "0000".
					else 
						conteoAscendenteDescendente <= "1111";
						--Al dar clic al boton reset se empezara desde 15 el conteo si la direccion es descendente.
						--Aqui pude haber puesto X"F" en vez de poner "1111", despues de haber tomado el valor inicial
						--declarado arriba de "0000".
					end if;
				elsif(Direccion='1') then
					conteoAscendenteDescendente <= conteoAscendenteDescendente - X"1";
					--Si damos clic al boton direccion, a la signal conteo se le restar lo que lleve almacenado.
					--Aqui puse X"1" en vez de poner "0001" por simple facilidad, ya que 4 bits binarios equivalen a 
					--un numero hexadecimal.
				else
					--Por esta instruccion es que debo hacer uso de una signal en vez de usar directamente la salida 
					--Contador, ya que las salidas no pueden ser leidas, solo se les puede asignar un valor.
					conteoAscendenteDescendente <= conteoAscendenteDescendente + "0001";
					--Aqui pude haber puesto X"1" en vez de poner "0001".
					--Es un contador ascendente porque cuenta uno a uno desde cero.
				end if;
			end if;
	end process;
	
	--Fuera del process debo asignar el valor que haya en la signal a la salida de mi modulo
	Contador <= conteoAscendenteDescendente;
	
end Behavioral;