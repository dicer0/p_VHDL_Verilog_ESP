--2.-CONTROL DE MOTOR A PASOS:
--Modulo que usa el divisor de reloj para prender y apagar las 2 bobinas A y B del motor a pasos bipolar
--de tipo NEMA 17, este motor cuenta con un controlador A4988 y a traves de sus pines STEP Y DIR se puede 
--controlar su movimiento y sentido de giro, cada vez que el pin STEP reciba un pulso, dara un paso, la 
--mayoria de motores bipolares dan pasos 200 pasos para dar una vuelta completa, osea que dan un giro de 
--1.8 grados, algunos dan giros de 400 pasos, osea 0.9 grados de rotacion por paso. 
--En el motor bipolar se cuenta con 5 secuencias de pasos principales: Paso completo, medio paso, 1/4 de 
--paso, 1/8 de paso y 1/16 de paso, mientras mas se disminuya el paso, mejor sera la precision de su 
--movimiento, pero su torque se reducira proporcionalmente, el torque maximo del motor se alcanza en el 
--paso completo, donde aguanta hasta 4kg de peso en una carga.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria para poder realizar operaciones matematicas sin considerar el signo.

--Entidad: Aqui se declaran las entradas y salidas.
entity controlPasosMotor is
	Port ( direccionGiro : in  STD_LOGIC;--Switch que indica la direccion del giro del motor a pasos.
			 selectPaso : in  STD_LOGIC_VECTOR (2 downto 0);--Switches para elegir una secuencia de paso.
			 --Se pueden elegir 5 opciones de pasos: Paso Completo, 1/2 paso, 1/4 de paso, 1/8 de paso y 
			 --1/16 de paso. Mientras sea menor el paso, mayor sera su precision, pero se reduce su torque 
			 --de forma proporcional.
			 M_S : out  STD_LOGIC_VECTOR (2 downto 0);--Pines MS1, MS2 y MS3 que eligen el tipo de paso.
			 ledMS : out  STD_LOGIC_VECTOR (2 downto 0);
			 DIR : out  STD_LOGIC;
			 ledDireccion : out  STD_LOGIC);--Led indicativo de la direccion del giro del motor a pasos.
end controlPasosMotor;

--La ARQUITECTURA es donde declaro que haran mis entradas y salidas, tiene su propio begin y end 
--nombreArquitectura;
architecture Behavioral of controlPasosMotor is
begin
--process(dentro de su parentesis debo poner las entradas que vaya a usar en el condicional)
--Las diferentes entradas se separan entre si por comas.
process(direccionGiro, selectPaso) --Tiene su propio begin y end process;
	begin
		case(selectPaso)is
		--Con los 3 pines MS1, MS2 y MS3 de Micro Stepping (MS), se establece el tipo de paso del motor para
		--lograr una mayor precision o torque, se elige una de las siguientes opciones:
		--							MS1	MS2	MS3	
		--Paso Completo = 	 0		 0		 0
		--Paso Medio = 	    1		 0		 0
		--1/4 de Paso = 	    0		 1		 0
		--1/8 de Paso = 	    1		 1		 0
		--1/16 de Paso = 	    1		 1		 1
		--Mientras mas se reduzca el paso, mayor es la resolucion de la precision en su movimiento, pero el 
		--torque se reduce proporcionalmente:
		--# Pasos 1 vuelta paso completo = 200 [pasos/revolucion]
		--# Pasos 1 vuelta cualquier otro paso = # Pasos 1 vuelta paso completo * 1/division de paso
		--# Pasos 1 vuelta de 1/4 de paso = 200 * 1/(1/4) = 200 * 4 = 800 [pasos/revolucion]
			when "000" => M_S <= "000"; ledMS <= "000";	--Paso completo.
			when "001" => M_S <= "100"; ledMS <= "100";	--1/2 Paso.
			when "010" => M_S <= "010"; ledMS <= "010";	--1/4 de Paso.
			when "011" => M_S <= "110"; ledMS <= "110";	--1/8 de Paso.
			when "100" => M_S <= "111"; ledMS <= "111";	--1/16 de Paso.
			when others => M_S <= "000"; ledMS <= "000"; --Motor a pasos bipolar con paso completo.
		end case;
		if(direccionGiro = '1') then
			DIR <= '1';	--DIR = 1; Giro del motor en sentido de las manecillas del reloj (derecha).
			ledDireccion <= '1';
		else 
			DIR <= '0';	--DIR = 0; Giro del motor en sentido contrario de las manecillas del reloj (izquierda).
			ledDireccion <= '0';
		end if;
	end process;
end Behavioral;