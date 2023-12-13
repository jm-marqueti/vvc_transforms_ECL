module control(input start, clk, reset,
output enable_write,enable_read, direction, mux, ready,
output reg [2:0] counter);

//registrador de estado
reg [1:0] current_state, next_state;

//codificação de estado
localparam idle = 2'b00, H = 2'b01, V = 2'b10, NA = 2'b11;

//lógica sequencial para transição de estado:
always @ (posedge clk) begin
	if (reset) begin
		current_state <= idle;
		counter <= 0;
	end
	else
		current_state <= next_state;
		
	if ((current_state == H) | (current_state == V))
		counter <= counter + 3'b001;
		
end


//lógica de próximo estado:
always @ (current_state or counter or start) begin
	case(current_state)
	
		idle: begin
			if (start) 
				next_state = H;
			else
				next_state = idle;
		end
		
		H: begin
			if (counter == 7)
				next_state = V; 
			else
				next_state = H;
		end		
		
		V: begin
		if (counter == 7)
				next_state = idle; 
		else
				next_state = V;
		end
		
		NA: begin
		end
		
	endcase
end

//lógica de saída:
assign enable_write = current_state[0];
assign enable_read = 1; // can save power by reading only when necessary?
assign mux = !enable_write; // select X when in first direction state and X intermediate when in the second direction
assign direction = !current_state[1]; // investigate direction!!
assign ready = !(current_state[1]|current_state[0]); // ready when idle (state 00)


endmodule