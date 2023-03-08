module lights(
    input logic [3:0] values [2:0],
    output logic [7:0] LEDR,
    output logic [1:0] LEDG
    );

always_comb
    begin
        if (&values[1])
            LEDG = 0;
        else
            LEDG = {~&values[1][3:2],~&values[1][1:0]};
        if (~&values[0] && &values[1])
            LEDR = {values[0],4'b 0000};
        else if (&values[0] && ~&values[2])
            LEDR = {4'b 0000,values[0]};
        else if (~&values[0] && ~&values[2])
            LEDR = {values[0],values[2]};
        else
            LEDR = 8'b 00000000;
    end

endmodule