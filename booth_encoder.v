module booth_encoder (x, single, double, neg, pzero,nzero);

input [2:0]x;

output single;

output  double;

output neg;
output pzero;
output nzero;

wire w0;

wire w1;

assign single = x[0] ^ x[1];

assign neg = x[2];

assign  w0 = ~(x[1] ^ x[2]);

assign  w1 = (x[0] ^ x[1]);

assign pzero = ~x[0] & ~x[1] & ~x[2];
assign nzero = x[0] & x[1] & x[2];
assign double =~(w0|w1);

endmodule
