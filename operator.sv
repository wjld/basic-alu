module operator(
    input logic enable,
    input logic [3:0] val0,
    input logic [3:0] operation,
    input logic [3:0] val1,
    output logic negative,
    output logic [7:0] result
    );

wire [7:0] toConvert;
wire [7:0] converted;

always_ff
    if (enable)
        begin
            if (operation == 4'b 1010)
                begin
                    toConvert = val0 * val1;
                    result = converted;
                    negative = 1;
                end
            else if (operation == 4'b 1011)
                begin
                    toConvert = val0 - val1;
                    if (toConvert[7])
                        begin
                            toConvert = ~({val0 - val1} - 1); //two-complement to binary
                            result = {4'b 1111, converted[3:0]};
                            negative = 0;
                        end
                    else
                        begin
                            result = converted;
                            negative = 1;
                        end                    
                end
            else
                begin
                    toConvert = val0 + val1;
                    result = converted;
                end
        end
    else
        begin
            result = 8'b 11111111;
            negative = 1;
        end

binToBCDConverter converter (.bin(toConvert),.bcd(converted));

endmodule