module memory(
    input logic clk,
    input logic enable,
    input logic reset,
    input logic [1:0] address,
    input logic [3:0] write,
    output logic [3:0] read [2:0]
    );

always_ff @(posedge clk or negedge reset)
    if(!reset)
        read = '{default:'1};
    //if back to initial state
    else if(read[2] != 4'b 1111 & address == 2'b 00)
        read = '{default:'1};
    else if (address != 2'b 11 && enable)
        read[address] = write;

endmodule