--2.-CONTROL DE MOTOR A PASOS:
--Modulo que usa el divisor de reloj para prender y apagar las 4 bobinas A, B, C y D del motor a pasos unipolar 
--28BYJ-48, este motor cuenta con un sistema de engranes que tiene una reduccion de 1/64, esto significa que 
--para que el eje final de una vuelta, el eje original debe dar 64 vueltas, aunado a esto para que el rotor 
--principal de una vuelta, se deben cumplir 8 ciclos de la secuencia de pasos que se este utilizando. 
--Se cuenta con 3 secuencias de pasos principales: Paso simple, paso doble y paso medio.
--A continuacion, se describen las caracteristicas de cada una.

--PASO MEDIO O MEDIO PASO: En este paso primero se activa una fase y luego dos a la vez, por lo cual su 
--secuencia consta de 8 acciones y se necesitan 64 pasos (8 ciclos de 8 secuencias) para que el rotor original 
--de una vuelta completa, en total se necesitan 64 vueltas de 64 pasos cada una, osea 4096 pasos para que el 
--eje final de una vuelta, como resultado la rotacion es muy suave, obteniendo la maxima precision, pero se 
--tiene un torque mediocre, que soporta 63 gramos aproximadamente, no se puede saber a ciencia cierta, porque 
--este motor no esta hecho para soportar este paso.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria para poder realizar operaciones matematicas sin considerar el signo.

--Entidad: Aqui se declaran las entradas y salidas.
entity controlPasosMotor is
	Port ( frecuencia : in  STD_LOGIC;--Frecuencia de conmutacion de las bobinas obtenida del divisor de reloj.
          direccionGiro : in  STD_LOGIC;--Switch que indica la direccion del giro del motor a pasos.
			 salidaMotor : out  STD_LOGIC_VECTOR (3 downto 0);--Senales dirigidas a las 4 bobinas A, B, C y D.
			 ledDireccion : out  STD_LOGIC);--Led indicativo de la direccion del giro del motor a pasos.
end controlPasosMotor;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end 
--nombreArquitectura;
architecture Behavioral of controlPasosMotor is

--SIGNAL: Existe solo en VHDL y sirve para almacenar datos que solo sobreviviran durante la ejecucion del 
--programa. 
signal paso : STD_LOGIC_VECTOR (2 downto 0) := "000"; --Se le da un valor inicial de 0 al vector.
--3'b000 esta indicando que el valor es de tres (3) numeros (') binarios (b) con valor (000), se usa este 
--numero porque el paso simple tiene 8 acciones, por eso se cuenta del 0 al 7 en binario: 
--000, 001, 010, 011, 100, 101, 110, 111.

begin

--process(dentro de su parentesis debo poner las entradas que vaya a usar en el condicional)
--Las diferentes entradas se separan entre si por comas.
process(frecuencia, paso) --Se usa para usar condicionales o bucles y tiene su propio begin y end process;
	begin
		--La instruccion rising_edge() hace que este condicional se ejecute solamente cuando ocurra un flanco de 
		--subida en la entrada frecuencia, osea cuando pase de valer 0 logico a valer 1 logico, ademas la 
		--instruccion rising_edge() hara que el codigo se ejecute por si solo, sin que yo directamente tenga que 
		--indicarlo con una operacion logica.
		if(rising_edge(frecuencia)) then
			if(direccionGiro = '1')then
				ledDireccion <= '1';	--Encender led.
				case (paso) is --CASE se usa para evaluar los diferentes valores que pueda adoptar una variable.
					when "000" => salidaMotor <= "1000"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "001" => salidaMotor <= "1100"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "010" => salidaMotor <= "0100"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "011" => salidaMotor <= "0110"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "100" => salidaMotor <= "0010"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "101" => salidaMotor <= "0011"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "110" => salidaMotor <= "0001"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "111" => salidaMotor <= "1001"; --Salida de 4 bits dirigida a las 4 bobinas.
					--Para la ultima condicion siempre debo usar la instruccion when others perteneciente al 
					--condicional case.
					when others => salidaMotor <= "0000";
				end case;--Al final del end case debo poner punto y coma ;
			else
				ledDireccion <= '0'; --Apagar led.
				case (paso) is --CASE se usa para evaluar los diferentes valores que pueda adoptar una variable
					when "000" => salidaMotor <= "0001"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "001" => salidaMotor <= "0011"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "010" => salidaMotor <= "0010"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "011" => salidaMotor <= "0110"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "100" => salidaMotor <= "0100"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "101" => salidaMotor <= "1100"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "110" => salidaMotor <= "1000"; --Salida de 4 bits dirigida a las 4 bobinas.
					when "111" => salidaMotor <= "1001"; --Salida de 4 bits dirigida a las 4 bobinas.
					--Para la ultima condicion siempre debo usar la instruccion when others perteneciente al 
					--condicional case.
					when others => salidaMotor <= "0000";
				end case;--Al final del end case debo poner punto y coma ;
			end if;
			--Se usa una signal en vez de hacer el contador directo con la salida contador porque a las salidas 
			--solo se les puede asignar un valor, no se les puede leer.
			paso <= paso + "001";
		end if;
	end process;
end Behavioral;