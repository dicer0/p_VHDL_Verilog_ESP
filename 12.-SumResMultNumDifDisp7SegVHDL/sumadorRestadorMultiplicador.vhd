--3.-MULTIPLEXOR PARA SELECCIONAR QUE LA OPERACION SEA SUMA, RESTA O MULTIPLICACION:
--Este proceso sirve para elegir que operacion se hace con los dos numeros binarios entrantes num1 y num2.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Estas librerias solo se declaran para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Esta libreria nos permite hacer operaciones matematicas con vectores o bits sin considerar su signo.
use IEEE.STD_LOGIC_ARITH.ALL;
--Esta libreria nos permite hacer operaciones matematicas usando la instruccion process.

entity sumadorRestadorMultiplicador is
    Port ( num1 : in  STD_LOGIC_VECTOR (3 downto 0);
           num2 : in  STD_LOGIC_VECTOR (3 downto 0);
			  --Numeros binarios siempre positivos que se van a sumar, restar o multiplicar.
           selectorOperacion : in  STD_LOGIC_VECTOR (2 downto 0);
			  --Con este selector por medio del MUX indicaremos que operacion se ejecutara.
           Result : out  STD_LOGIC_VECTOR (7 downto 0);
			  --El resultado de la multiplicacion va a tener el doble de bits que los numeros multiplicados entre si.
			  --El resultado de la suma debe ser un bit mayor a los numeros sumados entre si.
			  --El resultado de la resta va a ser del mismo numero de bits que los numeros restados entre si.
			  --La multiplicacion demanda mas bits, por lo cual el vector que almacena el resultado sera de ese tamano.
           signo : out  STD_LOGIC_VECTOR (3 downto 0));
			  --Este vector indicara el signo de la operacion despues en el display de 7 segmentos.
end sumadorRestadorMultiplicador;

--Arquitectura: Aqui se declara lo que haran las entradas/salidas, osea las operaciones matematicas.
architecture seleccionarOperacion of sumadorRestadorMultiplicador is
begin
	--PROCESS no solo se usa para crear condicionales o bucles, tambien junto con el uso de la biblioteca 
	--IEEE.STD_LOGIC_ARITH.ALL; puede servir para hacer operaciones matematicas con las entradas que le indique.
	process (num1, num2, selectorOperacion)
		begin
			case(selectorOperacion) is
				--SUMA:
				when "001" => 
				--Result <= num1+num2; Si pongo asi la suma me dara un error porque el vector Result es de 8 bits y los 
				--vectores num1 y num2 son de 4 bits cada uno, por eso es que concateno ambos numeros con 4 bits 0000,
				--la concatenacion se hace con el signo &.
									Result <= ("0000" & num1) + ("0000" & num2);
									--NUMEROS HEXADECIMALES EN VHDL: 1 digito hexadecimal equivale a 4 bits en binario, esto nos 
									--puede servir para poner un numero binario grande sin tener la necesidad de poner un valor 
									--de muchos bits en VHDL, como cuando debo llenar un vector de puros ceros, declaro un 
									--numero hexadecimal poniendo X"numero hexadecimal".
									signo <= X"E";
									--Poner X"E" equivale a poner "1110" y esto indica un signo positivo +.
				--RESTA:
				when "010" => 
				--Para la resta se debe hacer un condicional if ya que aqui es donde puede cambiar el signo de la operacion,
				--dependiendo de si num1 es mayor o igual a num2, si esto es asi, la magintud se saca solo haciendo la resta
				--y el signo se queda como positivo.
									if(num1 >= num2) then
										Result <= ("0000" & num1) - ("0000" & num2);
										signo <= X"E";
										--Poner X"E" equivale a poner "1110" y esto indica un signo positivo +.
				--Si num1 es menor a num2, el signo se convertira a negativo y la magnitud se debe obtener restando 
				--num2 menos num1.
									else
										Result <= ("0000" & num2) - ("0000" & num1);
										signo <= X"F";
										--Poner X"F" equivale a poner "1111" y esto indica un signo negativo -.
									end if;
				--MULTIPLICACION:
				when "100" => 
				--Cuando haga la multiplicacion no necesito concatenar ceros de mas porque la operacion por si sola llena
				--el vector Result de 8 bits y el signo se quedara como positivo siempre.
									Result <= num1 * num2;
									signo <= X"E";
									--Poner X"E" equivale a poner "1110" y esto indica un signo positivo +.
				when others => 
				--Cuando se seleccione otra opcion se mostraran puros ceros en los displays de 4 segmentos.
									Result <= "00000000";
									signo <= X"E";
									--Poner X"E" equivale a poner "1110" y esto indica un signo positivo +.
			end case;
		end process;
end seleccionarOperacion;