module state(
	input logic clk,
	input logic [1:0] state,
	input logic [3:0] value,
	output logic passThrough,
	output logic [1:0] selector
	);

always @(posedge clk)
	casex({state,value})
		6'b 000xxx: {passThrough,selector} = 3'b 100;
		6'b 00100x: {passThrough,selector} = 3'b 100;
		6'b 001010: {passThrough,selector} = 3'b 101;
		6'b 001011: {passThrough,selector} = 3'b 101;
		6'b 001100: {passThrough,selector} = 3'b 101;
		6'b 001101: {passThrough,selector} = 3'b 000;
		6'b 001110: {passThrough,selector} = 3'b 000;
		6'b 001111: {passThrough,selector} = 3'b 100;
		
		6'b 010xxx: {passThrough,selector} = 3'b 110;
		6'b 01100x: {passThrough,selector} = 3'b 110;
		6'b 011010: {passThrough,selector} = 3'b 101;
		6'b 011011: {passThrough,selector} = 3'b 101;
		6'b 011100: {passThrough,selector} = 3'b 101;
		6'b 011101: {passThrough,selector} = 3'b 001;
		6'b 011110: {passThrough,selector} = 3'b 001;
		6'b 011111: {passThrough,selector} = 3'b 100;
		
		6'b 100xxx: {passThrough,selector} = 3'b 110;
		6'b 10100x: {passThrough,selector} = 3'b 110;
		6'b 101010: {passThrough,selector} = 3'b 010;
		6'b 101011: {passThrough,selector} = 3'b 010;
		6'b 101100: {passThrough,selector} = 3'b 010;
		6'b 101101: {passThrough,selector} = 3'b 011;
		6'b 101110: {passThrough,selector} = 3'b 010;
		6'b 101111: {passThrough,selector} = 3'b 100;
		
		6'b 110xxx: {passThrough,selector} = 3'b 100;
		6'b 1110xx: {passThrough,selector} = 3'b 100;
		6'b 11110x: {passThrough,selector} = 3'b 011;
		6'b 111110: {passThrough,selector} = 3'b 011;
		6'b 111111: {passThrough,selector} = 3'b 100;
	endcase

endmodule