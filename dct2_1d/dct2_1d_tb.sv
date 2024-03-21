`timescale 1 ns/10 ps
module dct2_1d_tb();

reg clk;
reg signed [511:0] X_test; // valores de teste
reg signed [511:0] yexpected;
reg [1:0]N;
wire signed [511:0] Y; // saída do circuito (duv)
reg [31:0] vectornum, errors; // variáveis para controle
reg [1025:0] testvectors[0:999]; // memória com vetores de teste
toplevel DUV(.X_test(X_test), .N(N), .Y(Y) );

always begin
	clk = 1; #5; clk = 0; #5; // clock com período de 10ns
end

initial begin // carrega os vetores de teste no início da simulação
	$readmemb("goldenmodel.dat", testvectors); // lê vetores na memória
	vectornum = 0; errors = 0; // inicializa controle
	#27;
end 

// aplica cada vetor de teste em uma borda de subida do relógio
always @(posedge clk) begin
	#1; {N, X_test, yexpected} = testvectors[vectornum];
end

// verifica o resultado na borda de descida
always @(negedge clk) begin

	if (Y != yexpected) begin
		$display("Error: inputs = %b", {X_test});
		$display(" outputs = %b (%b exp)",Y,yexpected);
		errors = errors + 1;
	end

	vectornum = vectornum + 1;

	if (vectornum == 1000) begin
		$display("%d tests completed with %d errors", vectornum, errors);
		$finish; // termina a simulação após passar por todos os testes
	end

end
endmodule