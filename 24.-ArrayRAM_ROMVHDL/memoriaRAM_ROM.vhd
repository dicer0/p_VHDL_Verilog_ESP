--1.-Memorias RAM y ROM: A la información guardada en una memoria se le llama datos (data). Cuando escribimos 
--en una memoria, la acción es de escritura (write) y cuando obtenemos información de una memoria lo que 
--hacemos es leerla (read). Para acceder a la información requerimos de una dirección (address).
--A las memorias ROM (Read Only Memory) solo se les puede leer sus datos, mientras que a las memorias RAM
--(Random Access Memory) se les puede leer o escribir datos cuando sea.
--En este caso se creara una memoria de 8 registros (filas) con 8 celdas cada uno, por lo que tendra una 
--capacidad de 8x8 = 64 bits = 8 bytes, por lo que necesitara un memory adress de 3 bits para contar de 0 a 8.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Libreras para poder usar el lenguaje VHDL
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Librera declarada para poder hacer operaciones matematicas sin considerar el signo.

entity memoriaRAM_ROM is
    Port ( clk : in  STD_LOGIC;	--Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
			  --Las acciones de la memoria pueden ser sincronas: Siguen el paso de la senal de reloj.
			  --O pueden ser asincronas: Se ejecutan en cualquier momento no importando la senal de reloj.
			  adressBus : in  STD_LOGIC_VECTOR(2 downto 0);	--Direccion de memoria.
			  RW : in  STD_LOGIC;	--Switch RW (Read/Write) para escribir o leer la memoria RAM.
			  --Con RW = 1 se puede leer el contenido de ambas memorias, con RW = 0 se escribe en la RAM.
			  dataInRAM : in  STD_LOGIC_VECTOR(7 downto 0);	--Bus de datos ingresados a la memoria RAM.
			  CS : in  STD_LOGIC;	--CS (Chip Selector) para saber si la salida es de la RAM o ROM.
			  --Con CS = 1 se elige leer el contenido de la ROM, con CS = 0 se lee el contenido de la RAM.
			  dataBus : out  STD_LOGIC_VECTOR(7 downto 0));	--Bus de datos extraidos de la memoria RAM.
end memoriaRAM_ROM;

architecture Behavioral of memoriaRAM_ROM is
--LOS ARRAYS EN VHDL SE DECLARAN DENTRO DE LA ARQUITECTURA, PERO ANTES DE SU BEGIN Y SE CONFORMAN DE:
--TYPE: Con esta instruccion se define un tipo de dato que tiene un nombre en especifico y define un 
--numero de elementos que tienen un tamano en especifico a traves de la siguiente nomenclatura:
--type	nombreTipoDeDato	is array (numeroDeElementos) of tamanoDeSusElementos;
type arreglo is array (1 to 8) of STD_LOGIC_VECTOR(7 downto 0); --Array tipo matriz de 8x8.
--CONSTANT: Instruccion usada para crear constantes, tiene un nombre propio y ademas si es un array, debe 
--tener el tipo de dato previamente declarado con la instruccion type, se le asignan valores con el simbolo :=
--En las memorias ROM, como no se les debe cambiar el contenido de sus datos, se declara como constant.
constant ROM : arreglo :=("00000000",	--memoryAdress = 000 = 1
								  "00000001",	--memoryAdress = 001 = 2
								  "00000010",	--memoryAdress = 010 = 3
								  "00000011",	--memoryAdress = 011 = 4
								  "00000100",	--memoryAdress = 100 = 5
								  "00000101",	--memoryAdress = 101 = 6
								  "00000110",	--memoryAdress = 110 = 7
								  "00000111");	--memoryAdress = 111 = 8
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, 
--solo existe durante la ejecucion del codigo y sirve para poder almacenar algun valor de forma temporal, 
--se debe declarar dentro de la arquitectura y antes de su begin, cuando se usa para crear un array en VHDL 
--no se les asigna un tipo de forma directa, sino que, se declara un nombre y se le asigna el tipo de dato
--previamente declarado con la instruccion type. En Verilog la declaracion de arrays si se puede hacer directa 
--pero en VHDL se debe hacer en partes, primero declarando el tipo de dato y luego asignandolo.
--En las memorias RAM, como se les puede escribir o leer datos, se declara como signal.
signal RAM: arreglo:=("00000000",	--memoryAdress = 000 = 1
							 "10000001",	--memoryAdress = 001 = 2
							 "01000010",	--memoryAdress = 010 = 3
							 "11000011",	--memoryAdress = 011 = 4
							 "00100100",	--memoryAdress = 100 = 5
							 "10100101",	--memoryAdress = 101 = 6
							 "01100110",	--memoryAdress = 110 = 7
							 "11100111");	--memoryAdress = 111 = 8
--signal que representa un array que podra adoptar varias matrices de valores distintos.
signal dataOutROM : STD_LOGIC_VECTOR(7 downto 0);	--Bus de datos extraidos de la memoria ROM.
signal dataOutRAM : STD_LOGIC_VECTOR(7 downto 0);	--Bus de datos extraidos de la memoria RAM.

begin
	--La obtencion de datos de la memoria ROM es sincrona porque depende de la senal de reloj, no es asi en
	--todas las memorias RAM o ROM, puede ser como sea pero aqui se hace asi para mostrar sus diferencias.
	process(clk) begin
		--La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco de 
		--subida en la senal de reloj clk proveniente de la NEXYS 2.
		if(rising_edge(clk)) then
			--conv_integer(): Metodo que convierte un numero binario en uno entero. Ademas cabe mencionar que
			--a esta conversion se le suma un 1 porque para acceder a las posiciones de un array se cuenta 
			--desde 1, no desde 0.
			dataOutROM <= ROM(conv_integer(adressBus)+1);	--Lectura de la memoria ROM.
		end if;
	end process;
	
	--La lectura y escritura de datos en la memoria RAM es asincrona porque NO depende de la senal de reloj.
	process(RW, dataInRAM, adressBus) begin
		--Si el switch RW esta en 1 logico, la memoria es de lectura, sino es de escritura.
		if (RW = '1') then
			dataOutRAM <= RAM(conv_integer(adressBus)+1);	--Lectura de la memoria RAM.
		else 
			RAM(conv_integer(adressBus)+1) <= dataInRAM;		--Escritura de la memoria RAM.
			dataOutRAM <= RAM(conv_integer(adressBus)+1);	--Lectura de la memoria RAM.
		end if;
	end process;
	
	process(CS, dataOutROM, dataOutRAM) begin
		--Si el switch RW esta en 1 logico, el data bus muestra la salida de la memoria ROM, sino muestra la 
		--salida de la memoria RAM.
		if (CS = '1') then
			dataBus <= dataOutROM;
		else 
			dataBus <= dataOutRAM;
		end if;
	end process;
end Behavioral;
