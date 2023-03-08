//provided by Carla Cavalcante Koike, PhD, and Marcelo Grandi Mandelli, PhD

module controller (
	input   		clk,
	output reg [3:0] rowN,
	input 	  [3:0] columnN,
	output reg [3:0] key,
	output ready
	);
	
	wire [3:0] row,column;
	assign rowN=~row;
	assign column=~columnN;
	
	wire [7:0] value;
	integer counter;
	
	initial
		begin
			row<=4'b0001;
			key<=4'b0000;
			ready<=1'b0;
		end
			
			
		assign value={row,cold};
	
			
	always @(posedge clk)
		if (counter>=1000000 && ~ready)
		begin	
			counter<=0;
			if(row==4'b1000)
				row<=4'b0001;
			else
				row<=row<<1;
		end
		else
			counter<=counter+1;

	assign ready = (value[3:0]==4'b0000 ? 1'b0 : 1'b1);

	always @(posedge clk)
			case (value)
				8'b00010001: key<=4'b0001;
				8'b00010010: key<=4'b0010;
				8'b00010100: key<=4'b0011;		
				8'b00011000: key<=4'b1010;

				8'b00100001: key<=4'b0100;
				8'b00100010: key<=4'b0101;
				8'b00100100: key<=4'b0110;		
				8'b00101000: key<=4'b1011;
				
				8'b01000001: key<=4'b0111;
				8'b01000010: key<=4'b1000;
				8'b01000100: key<=4'b1001;		
				8'b01001000: key<=4'b1100;
				
				8'b10000001: key<=4'b1111;
				8'b10000010: key<=4'b0000;
				8'b10000100: key<=4'b1110;		
				8'b10001000: key<=4'b1101;
				
				default: key<=key;
			endcase
			
wire [3:0] cold;

	
Debouncer d0 (.iClock(clk),.iBouncy(column[0]), .oPulse(), .oState(cold[0]));
Debouncer d1 (.iClock(clk),.iBouncy(column[1]), .oPulse(), .oState(cold[1]));
Debouncer d2 (.iClock(clk),.iBouncy(column[2]), .oPulse(), .oState(cold[2]));
Debouncer d3 (.iClock(clk),.iBouncy(column[3]), .oPulse(), .oState(cold[3]));


endmodule