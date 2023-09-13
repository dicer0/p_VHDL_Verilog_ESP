--4.-CONVERTIDOR BINARIO a BCD: METODO SHIFT ADD-3
--Este metodo sirve para convertir numeros binarios a codigo BCD, el codigo BCD sirve para que las maquinas nos puedan
--ensenar numeros en un display de 7 segmentos, donde cada 4 bits representan un digito decimal.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Estas librerias solo se declaran para poder usar el lenguaje VHDL.
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--Esta libreria nos permite hacer operaciones matematicas con vectores o bits sin considerar su signo.
use IEEE.STD_LOGIC_ARITH.ALL;
--Esta libreria nos permite hacer operaciones matematicas usando process.

entity DecodificadorBinBCD is
    Port ( numBinario : in  STD_LOGIC_VECTOR (7 downto 0);
           centenasBCD : out  STD_LOGIC_VECTOR (3 downto 0);
           decenasBCD : out  STD_LOGIC_VECTOR (3 downto 0);
           unidadesBCD : out  STD_LOGIC_VECTOR (3 downto 0));
end DecodificadorBinBCD;

architecture SHIFTADD3 of DecodificadorBinBCD is
--SIGNAL: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
--existe durante la ejecucion del codigo y sirve para poder almacenar algun valor, se debe declarar dentro de la 
--arquitectura y antes de su begin, se le asignan valores con el simbolo :=
signal codigoBCDcompleto : STD_LOGIC_VECTOR (11 downto 0);
--Esta signal sirve para almacenar el codigo BCD completo que incluye sus 4 bits de unidades, decenas y centenas.
begin
	--Dentro del process se va a poner el algoritmo para ejecutar el metodo Shift Add-3, para entender el procedimiento
	--debo meterme al documento 11.-Sum, Res, Mult, Decod BCD y 4 Valores Disp 7 Seg.
	process(numBinario)
	--Las variables se deben declarar dentro de process y deben estar antes de su begin, estas solo van a poder existir 
	--y ser usadas dentro del process donde esten declaradas, su sintaxis es: variable nombreVariable: tipo_de_dato;
	variable posiciones : STD_LOGIC_VECTOR (19 downto 0);
	begin
		--LLENAR DE CEROS TODAS LAS POSICIONES POSIBLES (OSEA LAS COLUMNAS) DE LA TABLA SHIFT ADD-3
		for ejecucionBucle in 0 to 19 loop
			--Este bucle se va a repetir 20 veces y lo que hara es limpiar todos los bits de la variable posiciones.
			posiciones(ejecucionBucle) := '0'; --Con limpiar nos referimos a llenar de ceros el vector.
		end loop;
		
		--METER EL NUMERO BINARIO EN LA VARIABLE POSICIONES PARA QUE ENTRE A LA TABLA DEL METODO SHIFT ADD-3
		posiciones(7 downto 0) := numBinario(7 downto 0);
		--Con esta instruccion metemos el valor de la entrada llamada numBinario a las posiciones 0,1,2,3,4,
		--5,6 y 7 del vector posiciones, esto se hace para que este en la posicion inicial de la tabla.
		
		--METODO SHIFT ADD-3 A LAS COLUMNAS: UNIDADES, DECENAS Y CENTENAS
		for i in 0 to 7 loop --En la tabla se repite la operacion hasta SHIFT8, por eso se ejecuta 8 veces.
			--Este bucle se va a repetir 8 veces y lo que hara es ejecutar las operaciones SHIFT1, SHIFT2, SHIFT3, 
			--SHIFT4, SHIFT5, SHIFT6, SHIFT7 y SHIFT8 ya que estas son todas las veces que se puede recorrer el numero 
			--binario a la izquierda en la tabla del metodo SHIFT ADD-3 aplicado a un numero binario de maximo 8 bits, 
			--durante estos recorrimientos se debe analizar cada columna de Unidades, Decenas y Centenas.
			
			--COLUMNA DE UNIDADES: ADD-3
			if posiciones(11 downto 8) > "100" then 
				--Cada columna la puedo analizar individualmente si analizo las coordenadas del vector posiciones que 
				--las abarcan, las posiciones 11, 10, 9 y 8 abarcan la columna de Unidades.
				posiciones(11 downto 8) := posiciones(11 downto 8)+"11"; --Add3
				--Si el numero binario contenido en estas coordenadas del vector posiciones es mayor a 4, osea 100 se 
				--le suma el numero decimal 3, osea 011.
			end if;
				
			--COLUMNA DE DECENAS: ADD-3
			if posiciones(15 downto 12) > "100" then 
				--Las posiciones 15, 14, 13 y 12 abarcan la columna de Decenas.
				posiciones(15 downto 12) := posiciones(15 downto 12)+"11";--Add3
				--Si el numero binario contenido en estas coordenadas del vector posiciones es mayor a 4, osea 100 se 
				--le suma el numero decimal 3, osea 011.
			end if;
				
			--COLUMNA DE CENTENAS: ADD-3
			if posiciones(19 downto 16) > "100" then 
				--Las posiciones 19, 18, 17 y 16 abarcan la columna de Centenas.
				posiciones(19 downto 16) := posiciones(19 downto 16)+"11";--Add3
				--Si el numero binario contenido en estas coordenadas del vector posiciones es mayor a 4, osea 100 se 
				--le suma el numero decimal 3, osea 011.
			end if;
				
			--SHIFT: Este pedazo de codigo aplicara los SHIFT1,2,3,4,5,6,7 y SHIFT8
			posiciones(19 downto 1) := posiciones(18 downto 0);
			--Esta operacion del bucle es la operacion SHIFT y es usada para mover un lugar a la izquierda todo el 
			--vector cuando ningun numero en ninguna columna sea mayor a 4, osea 100.
		end loop;
	
	--GUARDO EL RESULTADO DEL METODO SHIFT ADD-3 EN LA SIGNAL.
	codigoBCDcompleto <= posiciones(19 downto 8);
	--Las posiciones 19 downto 8 son todas las que abarca el codigo BCD al terminar de ejecutarse el metodo 
	--SHIFT ADD-3 porque ya no debe quedar ningun bit en la columna BINARIO.
	end process;
	
	--SEPARAR EL RESULTADO DEL MTODO SHIFT ADD-3, OSEA AL CODIGO BCD EN UNIDADES, DECENAS Y CENTENAS:
	--A las salidas les asigno valores usando el simbolo <= y lo puedo hacer en cualquier lugar del codigo.
	centenasBCD <= codigoBCDcompleto(11 downto 8);--4 bits del codigo BCD representan un digito decimal, osea 1 centena.
	decenasBCD  <= codigoBCDcompleto(7 downto 4);--4 bits del codigo BCD representan un digito decimal, osea 1 decena.
	unidadesBCD <= codigoBCDcompleto(3 downto 0);--4 bits del codigo BCD representan un digito decimal, osea 1 unidad.
end SHIFTADD3;