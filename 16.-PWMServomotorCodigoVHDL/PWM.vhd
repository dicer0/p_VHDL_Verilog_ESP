--2.-CONTADOR DE 2 BITS:
--En este codigo el contador es de 2 bits, esto implica que contara desde cero hasta 3 en forma binaria:
--00, 01, 10 y 11.
--Estos numeros binarios en el modulo siguiente representaran al selector y el selector lo que hara es guardar en la 
--signal digito (del siguiente modulo tambien) 4 numeros binarios que representen 1 digito hexadecimal, este barrido
--se debe hacer en orden y con la frecuencia dictada por el divisorDeReloj para prender individualmente cada display 
--de 7 segmentos.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias que sirven solamente para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria para poder realizar operaciones matematicas sin considerar el signo.

--Entidad: En la entidad se declara que el contador sea de 2 bits porque como en la NEXYS 2 hay 4 displays de 7 
--segmentos, lo que yo quiero es que durante un ciclo de reloj todos los displays sean encendidos una vez, mostrando 
--cada digito del numero hexadecimal que corresponda al numero binario que se esta introduciendo por medio de switches, 
--puedo hacer esto con 2 bits porque cuando el selector adopte los valores 00, 01, 10 y 11 prendera una vez cada 
--digito en uno de los 4 displays de 7 segmentos durante cada ciclo de reloj.
entity PWM is
    Port ( frecuenciaReloj : in  STD_LOGIC;--Este es el reloj proveniente del modulo divisorDeReloj.
           PWM_Servo : out  STD_LOGIC_VECTOR (1 downto 0));
end PWM;

architecture contador2Bits of PWM is
--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del programa, no 
--esta conectada a ningun puerto de la tarjeta de desarrollo y se le asignan valores con el simbolo :=
signal conteoAscendente : STD_LOGIC_VECTOR (1 downto 0) := "00";--Se le da un valor inicial de 0 al vector.
begin
	process(frecuenciaReloj)
	begin
		--La instruccion rising_edge indica que cada que ocurra un flanco de subida en el reloj, se le sumara un 1 
		--binario al valor que tenia previamente el vector conteoAscendente, esto hara que se cree la secuencia 
		--00, 01, 10 y 11 en el selector, especificamente en ese orden.
		if(rising_edge(frecuenciaReloj)) then
			conteoAscendente <= conteoAscendente + "01";
			--El conteo solito volvera a ser 00 cuando se supere el valor 11 en el vector conteoAscendente de 2 bits.
		end if;
	end process;
	
	--Se usa una signal en vez de hacer el contador directo con la salida contador porque a las salidas solo se
	--les puede asignar un valor, no se les puede leer.
	PWM_Servo <= conteoAscendente;
end contador2Bits;
