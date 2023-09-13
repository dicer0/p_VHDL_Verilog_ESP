--SUMA, RESTA, MULTIPLICACION Y DIVISION DE NUMEROS BINARIOS DE 4 BITS
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Estas libreras solo se declaran para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Esta librera nos permite hacer operaciones matematicas con vectores o bits sin considerar su signo.
use IEEE.STD_LOGIC_ARITH.ALL;
--Esta librera nos permite hacer operaciones matematicas usando process.

--Entidad: Aqui se declaran las entradas/salidas.
entity aritmetica is
    Port ( num1 : in  STD_LOGIC_VECTOR (3 downto 0);
           num2 : in  STD_LOGIC_VECTOR (3 downto 0);
			  --Numeros binarios que se van a sumar, restar, multiplicar y dividir.
           suma : out  STD_LOGIC_VECTOR (4 downto 0);
			  --El resultado de la suma debe ser un bit mayor a los numeros sumados entre si.
           resta : out  STD_LOGIC_VECTOR (3 downto 0);
			  --El resultado de la resta va a ser del mismo numero de bits que los numeros restados entre si.
           multiplicacion : out  STD_LOGIC_VECTOR (7 downto 0)
			  --El resultado de la multiplicacion va a tener el doble de bits que los numeros multiplicados entre si.
           --division : out  STD_LOGIC_VECTOR (3 downto 0)
			  --VHDL tiene problemas con la libreria IEEE.STD_LOGIC_ARITH.ALL; para hacer la division, por lo cual 
			  --no se hizo.
			  );
end aritmetica;

--Arquitectura: Aqui se declaran lo que haran las entradas/salidas, osea las operaciones matematicas.
architecture operacionMatematica of aritmetica is
begin
	--PROCESS no solo se usa para crear condicionales o bucles, tambien junto con el uso de la biblioteca 
	--IEEE.STD_LOGIC_ARITH.ALL; puede servir para hacer operaciones matematicas con las entradas que le indique.
	process (num1, num2)
		begin
			--suma <= num1+num2; Si pongo asi la suma me dara un error porque el vector suma es de 4 bits y los 
			--vectores num1 y num2 son de 2 bits, por lo que concateno ambos numeros con un bit 0.
			suma <= ('0'&num1) + ('0'&num2);
			--Encierro la concatenacion en un parentesis para que no se confunda el programa en la jerarquia de 
			--operaciones.
			resta <= num1-num2;
			multiplicacion <= num1*num2;--Con la multiplicacion la libreria no tiene problemas, es solo con la suma.
			--division <= num1/num2; Asi se haria la division si el programa me dejara hacerla directamente.
			--Todas las operaciones matematimas binarias se pueden realizar de manera muy sencilla, exceptuando a la 
			--division, esta necesita un proceso mas complejo.
		end process;
end operacionMatematica;

