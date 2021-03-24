module barrel_shifter(in, shift, out);
    input  [7:0] in;
    input  [2:0] shift;
    output [7:0] out;

    /*Write your code here*/
    wire [7:0] L1, L2;

    // level 1
    assign L1 = shift[0] ? {in[6:0], 1'b0} : in;

    // level 2
    assign L2 = shift[1] ? {L1[5:0], 2'b0} : L1;

    // level 3
    assign out = shift[2] ? {L2[3:0], 4'b0} : L2;

    /*End of code*/
endmodule