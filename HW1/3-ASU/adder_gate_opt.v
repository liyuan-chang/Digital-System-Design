// Carry-Lookahead Adder (8-bit)
module adder_gate(x, y, carry, out);
    input [7:0] x, y;
    output carry;
    output [7:0] out;

    /*Write your code here*/

    wire Cin;
	wire PG[0:3], GG[0:3];
	wire Co[0:3];
	wire [1:0] s[0:3];
    // set Cin to 0
    assign Cin = 1'b0;

	CLA_2bit adder0(Co[0], s[0], PG[0], GG[0], x[1:0], y[1:0], Cin);
	CLA_2bit adder1(Co[1], s[1], PG[1], GG[1], x[3:2], y[3:2], Co[0]);
	CLA_2bit adder2(Co[2], s[2], PG[2], GG[2], x[5:4], y[5:4], Co[1]);
	CLA_2bit adder3(Co[3], s[3], PG[3], GG[3], x[7:6], y[7:6], Co[2]);

	assign out = {s[3], s[2], s[1], s[0]};
	assign carry = Co[3];
    /*End of code*/

endmodule

// Carry-Lookahead Adder (2-bit)
module CLA_2bit(Cout, S, PG, GG, A, B, Cin);
	input [1:0] A, B;
	input Cin;
	output [1:0] S;
	output Cout, PG, GG;

	wire [1:0] G, P;
	wire C;
	wire t[0:2];

	// Generate G = A & B
	BWAND#(2) bwand0(G, A, B);
	// Propagate P = A ^ B
	BWXOR#(2) bwxor0(P, A, B);

	// C = G[0] | (P[0] & Cin);
	and #1 and0(t[0], P[0], Cin);
	or #1 or0(C, G[0], t[0]);
	// S = P ^ {C, Cin};
	BWXOR#(2) bwxor1(S, P, {C, Cin});
	// PG = P[1] & P[0]
	and #1 and1(PG, P[1], P[0]);
	// GG = G[1] | (P[1]&G[0])
	and #1 and2(t[1], P[1], G[0]);
	or #1 or1(GG, G[1], t[1]);
	// Cout = GG | (PG & Cin)
	and #1 and3(t[2], PG, Cin);
	or #1 or2(Cout, GG, t[2]);

endmodule

// bitwise AND
module BWAND#(parameter N = 4)(Z, A, B);
	input [N-1:0] A, B;
	output [N-1:0] Z;

	genvar i;
	generate
		for (i = 0; i <= N-1; i = i + 1) begin
			and #1 and0(Z[i], A[i], B[i]);
		end
	endgenerate

endmodule

// bitwise XOR
module BWXOR#(parameter N = 4)(Z, A, B);
	input [N-1:0] A, B;
	output [N-1:0] Z;

	genvar i;
	generate
		for (i = 0; i <= N-1; i = i + 1) begin
			xor #1 xor0(Z[i], A[i], B[i]);
		end
	endgenerate

endmodule

// Carry-Lookahead Adder (4-bit)
/* module CLA_4bit(Cout, S, PG, GG, A, B, Cin);
	input [3:0] A, B;
	input Cin;
	output [3:0] S;
	output Cout, PG, GG;

	wire [3:0] G, P;
	wire [2:0] C;
	wire t[0:6];

	// Generate G = A & B
	BWAND#(4) bwand0(G, A, B);
	// Propagate P = A ^ B
	BWXOR#(4) bwxor0(P, A, B);

	// C[0] = G[0] | (P[0] & Cin);
	and #1 and0(t[0], P[0], Cin);
	or #1 or0(C[0], G[0], t[0]);
	// C[1] = G[1] | (P[1] & C[0]);
	and #1 and1(t[1], P[1], C[0]);
	or #1 or1(C[1], G[1], t[1]);
	// C[2] = G[2] | (P[2] & C[1]);
	and #1 and2(t[2], P[2], C[1]);
	or #1 or2(C[2], G[2], t[2]);
	// S = P ^ {C[2:0], Cin};
	BWXOR#(4) bwxor1(S, P, {C[2:0], Cin});
	// PG = P[3] & P[2] & P[1] & P[0]
	and #1 and3(PG, P[3], P[2], P[1], P[0]);
	// GG = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0])
	and #1 and4(t[3], P[3], P[2], P[1], G[0]);
	and #1 and5(t[4], P[3], P[2], G[1]);
	and #1 and6(t[5], P[3], G[2]);
	or #1 or3(GG, G[3], t[5], t[4], t[3]);
	// Cout = GG | (PG & Cin)
	and #1 and7(t[6], PG, Cin);
	or #1 or4(Cout, GG, t[6]);

endmodule */