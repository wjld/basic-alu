module alu(
	input logic	clk,
	input logic	reset,
	input logic released,
	input logic	[3:0] key,
	output logic [6:0] HEX0,
	output logic [6:0] HEX1,
	output logic [6:0] HEX2,
	output logic [6:0] HEX4,
	output logic [6:0] HEX5,
	output logic [6:0] HEX6,
	output logic [7:0] LEDG,
	output logic [7:0] LEDR
	);

wire negative;
wire passThrough;
wire [1:0] selector;
wire [5:0] filtered;
wire [3:0] values [2:0];
wire [7:0] result;

assign LEDG[7] = released & (~|filtered[5:4] | &filtered[5:4]);

state	s0(
	.clk(clk),
	.state(filtered[5:4]),
	.value(key),
	.selector(selector),
	.passThrough(passThrough)
	);
filter f0(
	.reset(reset),
	.released(released),
	.passThrough(passThrough),
	.selector(selector),
	.key(key),
	.filtered(filtered)
	);
memory m0(
	.clk(clk),
	.enable(passThrough),
	.reset(reset),
	.address(filtered[5:4]),
	.write(filtered[3:0]),
	.read(values)
	);
operator	op0(
	.enable(&filtered[5:4]),
	.val0(values[0]),
	.val1(values[2]),
	.operation(values[1]),
	.result(result),
	.negative(negative)
	);
calcDecoder7 cd0(
	.in(result[3:0]),
	.out(HEX0)
	);
calcDecoder7 cd1(
	.in(result[7:4]),
	.out(HEX1)
	);
calcDecoder7 cd2(
	.in({1'b 1,negative,2'b 11}),
	.out(HEX2)
	);
calcDecoder7 cd3(
	.in(values[2]),
	.out(HEX4)
	);
calcDecoder7 cd4(
	.in(values[1]),
	.out(HEX5)
	);
calcDecoder7 cd5(
	.in(values[0]),
	.out(HEX6)
	);
lights L0(
	.values(values),
	.LEDR(LEDR),
	.LEDG(LEDG[1:0])
	);

endmodule