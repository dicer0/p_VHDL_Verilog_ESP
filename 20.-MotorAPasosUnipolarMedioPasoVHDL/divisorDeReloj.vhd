--1.-DIVISOR DE RELOJ:
--Este proceso sirve para dictarle al reloj en que frecuencia quiero que opere.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Librerias para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Libreria declarada para poder hacer operaciones matematicas sin considerar el signo.

entity divisorDeReloj is
    Port ( relojNexys2 : in  STD_LOGIC;   --Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
           reset : in  STD_LOGIC;         --Boton de reset.
           salidaReloj : out  STD_LOGIC); --Reloj que quiero con una frecuencia menor a 50MHz.
end divisorDeReloj;

--Arquitectura: Aqui se hara el divisor de reloj haciendo uso de una signal y condicionales if.
architecture frecuenciaNueva of divisorDeReloj is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin, se le asignan valores con el simbolo :=
signal divisorDeReloj : STD_LOGIC_VECTOR (24 downto 0);
--Esta signal sirve para que podamos obtener una gran gama de frecuencias indicadas en la tabla del divisor de reloj
--dependiendo de la coordenada que elijamos tomar del vector para asignarsela a la salida.
begin
	process(relojNexys2, reset)
	begin
		if(reset = '1') then--Cuando el boton Reset sea presionado valdra 1 logico y el divisor de reloj se reiniciara.
			--NUMEROS HEXADECIMALES EN VHDL: 1 digito hexadecimal equivale a 4 bits en binario, esto nos puede servir 
			--para poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits, como cuando 
			--debo llenar un vector de puros ceros, declaro un numero hexadecimal poniendo X"numero hexadecimal".
			divisorDeReloj <= "0000000000000000000000000";
			--Poner X"000000" equivale a poner "000000000000000000000000".
		elsif(rising_edge(relojNexys2)) then
			--La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco de subida en
			--la senal de reloj clkNexys2 proveniente de la NEXYS 2.
			divisorDeReloj <= divisorDeReloj + 1;--Esto crea al divisor de reloj.
		end if;
	end process;

	--Debo asignar el contenido de una coordenada de la signal divisorDeReloj a salidaReloj para obtener una frecuencia 
	--en especifico, cada coordenada del vector corresponde a una frecuencia en la tabla del divisor de reloj.
	salidaReloj <= divisorDeReloj(15);--En la tabla se ve que la coordenada 16 proporciona una frecuencia de 381.47Hz.
	--El motor a pasos unipolar 28BYJ-48 con el medio paso puede recibir una frecuencia minima de 1 Hz y maxima de 800Hz, 
	--esto nos da la posibilidad de elegir de la coordenada 15 (762.94 Hz) a la coordenada 24 (1.49 Hz) del divisor de reloj.
end frecuenciaNueva;
