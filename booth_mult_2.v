module booth_mult_2(clk, reset, a, b, result);

input clk, reset;
input signed [7:0] a,b;
output reg result;

reg signed [8:0] OY;
reg signed [15:0]action;
reg signed [15:0]acc;
reg signed [15:0]pp;
reg unsigned [2:0]sel;
reg signed [15:0]scale;

always @(posedge clk or posedge reset) begin
		if(reset)	begin
			acc <= 15'b0;
			result <= 15'b0;
			pp <= 15'b0; 
			scale <= 8'b00000001;
			count <= 0;
			action <= 8'b0;
			sel <= 3'b0;
			OY = {Y, 1'b0};
			//pp_array_flat <= 64'b0;
			
		end
        else if (count < 8)  begin
        OY <= {a, 1'b0};

        if(count == 0)
			sel = OY[1:0];
		else if (count == 1)
			sel = OY[2:1];
		else if(count == 2)
			sel = OY[3:2];
		else if(count == 3)
			sel = OY[4:3];
        else if(count == 4)
			sel = OY[5:4];
        else if(count == 5)
			sel = OY[6:5];
        else if(count == 6)
			sel = OY[7:6];
        else if(count == 7)
			sel = OY[8:7];
        

        end

        case (sel)
        2'b00 : action <= 0;
        2'b01 : action <= b;
        2'b10 : action <= -1*b;
        2'b11 : action <= 0;
        default : action <= 0;
        endcase

        pp <= scale*action;
        acc <= acc + pp;
        count=count+1;
		scale = scale << 2;
    end
assign result = acc;


endmodule