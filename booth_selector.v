module booth_selector (double, shifted, single, y, neg, p);

input double;

input shifted;

input single;

input y;

input neg;

output p;

assign  p = (neg ^ ((y & single) | (shifted & double)));

endmodule
