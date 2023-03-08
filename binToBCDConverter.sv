module binToBCDConverter(
    input [7:0] bin,
    output reg [7:0] bcd
    );

reg [3:0] i;

//Double Dabble algorithm;
//Even though 8 bits can represent 
//up to 127, only two BCD digits
//are considered, since the result can
//only be 81 at max
always @(bin)
    begin
        bcd = 0;
        for (i = 0; i < 8; i = i+1)
            begin
                 bcd = {bcd[6:0],bin[7-i]};
                 if(i < 7 && bcd[3:0] > 4) 
                      bcd[3:0] = bcd[3:0] + 3;
                 if(i < 7 && bcd[7:4] > 4)
                      bcd[7:4] = bcd[7:4] + 3;
            end
        if (bcd[7:4] == 0)
            bcd = {4'b 1111,bcd[3:0]};
    end

endmodule