// Carry Ripple Adder (8-bit)
module adder_gate(x, y, carry, out);
    input [7:0] x, y;
    output carry;
    output [7:0] out;

    /*Write your code here*/

    wire Co[0:8];
    // set Cin to 0
    assign Co[0] = 1'b0;

	genvar i;
	generate
		for (i = 0; i <= 7; i = i + 1) begin
			FA1 adder(Co[i+1], out[i], x[i], y[i], Co[i]);
		end
	endgenerate

	assign carry = Co[8];
    /*End of code*/

endmodule

// Full Adder (1-bit)
module FA1(Cout, Sum, A, B, Cin);
    input A, B, Cin;
	output Cout, Sum;

    wire t[0:2];

    and #1 and0(t[0], A, B);
    and #1 and1(t[1], B, Cin);
    and #1 and2(t[2], Cin, A);
    or #1 or0(Cout, t[0], t[1], t[2]);
    xor #1 xor0(Sum, A, B, Cin);
endmodule