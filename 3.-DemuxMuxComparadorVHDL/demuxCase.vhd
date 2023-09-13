--DEMULTIPLEXOR DE 2 SALIDAS USANDO EL CONDICIONAL CASE
--Los Demultiplexores reciben una senal de entrada (el selector) y pueden dar varias senales digitales de salida 
--diferentes en forma de vector, el vector es un numero binario con un numero de bits constante, cada bit funciona 
--como variable y puede adoptar cualquiera de los valores digitales, ya sea 1 logico, 0 logico o Z alta impedancia. 
--Del vector puedo extraer cada bit individualmente y mandarlos por medio de un BUS al elemento electronico que yo 
--quiera.
--BUS es un conjunto de cables, en cada cable se transmitiran individualmente los valores que vaya adoptando cada bit 
--de la senal digital de salida (osea el numero binario) y se podra elegir cualquiera de las senales de salida 
--disponibles por medio del selector.
--El numero de salidas disponibles que tengo van en funcion del tamano del selector, si selector es de pocos bits 
--puedo elegir pocas posibles salidas y viceversa.

--El Demultiplexor puede recibir dos senales de entrada en vez de solo el selector, la segunda entrada se llama 
--enable y sirve para encender o apagar el demux, ya que, si el enable esta en cero, todos los bits de la salida 
--estaran en cero.

--El tamano del numero binario del selector se calcula de la siguiente manera: 
--#salidas = 2 ^(#bits del selector)
--2 = 2 ^(1)
--Por lo tanto, si quiero tener 2 salidas, el selector debe ser de 1 bit.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Las libreras IEEE y STD_LOGIC_1164 se declaran para poder usar el lenguaje de programacion VHDL

--La ENTIDAD es donde declaro mis entradas y salidas
entity demuxCase is
    Port ( selector : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           salida : out  STD_LOGIC_VECTOR (3 downto 0));
			  --El tamano del selector y el tamano de la salida no dependen uno del otro
end demuxCase;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end nombreArquitectura;
architecture nombreArquitectura of demuxCase is
begin
	--CONDICIONAL CASE, es parecido al condicional switch case
	--process se usa para poder usar condicionales o bucles y tiene su propio begin y end process;
	process(selector, enable)
	--process(dentro de su parentesis debo poner las entradas que vaya a usar en el condicional)
	--las diferentes entradas se separan entre si por comas.
	begin
		case (selector) is --CASE se usa para evaluar los diferentes valores que pueda adoptar una variable
			--El selector deber adoptar diferentes numeros binarios que abarquen todas las posibles salidas del 
			--demux, dependiendo del numero de bits que tenga es el numero de posibilidades que puede aportar
			--El simbolo & se usa para concatenar variables con bits y se usa para darle uso al enable
			--En VHDL cuando se asigna el valor a una variable de un bit se usan comillas simples '' y cuando se 
			--quiere asignar valor a un vector se usan comillas dobles ""
			when '0' => salida <= "000" & enable;        --selector con valor decimal 0 = salida 0001 de 4 bits
			--Para la ultima condicion siempre debo usar la instruccion when others del condicional case
			when others => salida <= enable & "000";     --selector con valor decimal 0 = salida ZZZZ de 4 bits
			--El tamano del selector y el tamano de la salida no dependen uno del otro
		end case;--Al final del end case debo poner punto y coma ;
	end process;--Al final del end process debo poner punto y coma ;
end nombreArquitectura;--Al final del end de la arquitectura debo poner punto y coma ;

--El deMux funciona porque en el ucf voy a tomar cada bit del vector de salida como si fuera una salida individual
--y la voy a asignar a diferentes leds, al display de 7 segmentos, a un BUS que se dirige a un motor a pasos o  
--cualquier otro dispositivo electronico.
