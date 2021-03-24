module asu (x, y, mode, carry, out);
    input [7:0] x, y;
    input mode;
    output carry;
    output [7:0] out;

    /*Write your code here*/
    wire cout;
    wire [7:0] sum, bsout;

    adder add0(x, y, cout, sum);
    barrel_shifter bs0(x, y[2:0], bsout);

    assign {carry, out} = mode ? {cout, sum} : {1'b0, bsout};

    /*End of code*/
    
endmodule