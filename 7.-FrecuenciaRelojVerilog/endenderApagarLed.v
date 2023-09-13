//MODULO QUE USA EL DIVISOR DE RELOJ PARA PRENDER Y APAGAR UN LED
module endenderApagarLed(
    input entrada,
    output reg salida//Las salidas usadas dentro de un condicional o bucle las debo declarar como reg.
    );
	
	//Condicional para encendido y apagado del led.
	always@(entrada)
	begin
		if(entrada == 1'b1)
		begin
			salida = 1'b1; //Encender led.
		end else begin
			salida = 1'b0; //Apagar led.
		end
	end
endmodule
