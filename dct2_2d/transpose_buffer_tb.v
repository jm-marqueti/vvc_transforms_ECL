`timescale 1 ns/10 ps
module transpose_buffer_tb();

reg clock, reset, enable, direction; //input
reg signed [15:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15, in_16, in_17, in_18, in_19, in_20, in_21, in_22, in_23, in_24, in_25, in_26, in_27, in_28, in_29, in_30, in_31;

//output
wire signed [15:0] out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9, out_10, out_11, out_12, out_13, out_14, out_15, out_16, out_17, out_18, out_19, out_20, out_21, out_22, out_23, out_24, out_25, out_26, out_27, out_28, out_29, out_30, out_31;

reg [31:0] vectornum; // variáveis para controle

transpose_buffer_32x32 DUV(clock, reset, enable, direction, in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15, in_16, in_17, in_18, in_19, in_20, in_21, in_22, in_23, in_24, in_25, in_26, in_27, in_28, in_29, in_30, in_31, out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9, out_10, out_11, out_12, out_13, out_14, out_15, out_16, out_17, out_18, out_19, out_20, out_21, out_22, out_23, out_24, out_25, out_26, out_27, out_28, out_29, out_30, out_31);

always begin
	clock = 1; #5; clock = 0; #5; // clock com período de 10ns
end

initial begin // carrega os vetores de teste no início da simulação
	 // inicializa controle
	reset = 1;
	vectornum = 0;
	#11;
	reset = 0;
end

// aplica cada vetor de teste em uma borda de subida do relógio
always @(posedge clock) begin
	vectornum = vectornum + 1;
end

// verifica o resultado na borda de descida
always @(negedge clock) begin
	if (vectornum == 12)
		$finish; // termina a simulação após passar por todos os testes
end
endmodule