module barrel_shifter_gate(in, shift, out);
    input  [7:0] in;
    input  [2:0] shift;
    output [7:0] out;

    /*Write your code here*/
    wire L1[0:7], L2[0:7];

    genvar i;

    // level 1
    mux level1_1(L1[0], in[0], 1'b0, shift[0]);
    generate
        for (i = 1; i <= 7; i = i + 1) begin
            mux level1_2(L1[i], in[i], in[i-1], shift[0]);
        end
    endgenerate
    
    // level 2
    mux level2_1(L2[0], L1[0], 1'b0, shift[1]);
    mux level2_2(L2[1], L1[1], 1'b0, shift[1]);
    generate
        for (i = 2; i <= 7; i = i + 1) begin
            mux level2_3(L2[i], L1[i], L1[i-2], shift[1]);
        end
    endgenerate

    // level 3
    generate
        for (i = 0; i <= 3; i = i + 1) begin
            mux level2_3(out[i], L2[i], 1'b0, shift[2]);
        end
        for (i = 4; i <= 7; i = i + 1) begin
            mux level2_3(out[i], L2[i], L2[i-4], shift[2]);
        end
    endgenerate

    /*End of code*/
endmodule

// if sel == 1: x = b; else: x = a
module mux(x, a, b, sel);
    input 	a, b, sel;
    output 	x;
    wire sel_i, w1, w2;

    not #1 n0(sel_i, sel);
    and #1 a1(w1, a, sel_i);
    and #1 a2(w2, b, sel);
    or  #1 o1(x, w1, w2);
endmodule