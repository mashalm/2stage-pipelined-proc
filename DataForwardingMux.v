
module DataForwardingMux(sel, dInSrc1, dInSrc2, dInSrc3, dOut);
	parameter BIT_WIDTH = 32;
	
	input [1 : 0] sel;
	input [BIT_WIDTH - 1 : 0] dInSrc1, dInSrc2, dInSrc3;
	output [BIT_WIDTH - 1 : 0] dOut;
   //if sel[1] is zero we don't need to dataforward at all
	assign dOut = (sel[1] == 0) ? dInSrc1 :
					  (sel[0] == 0) ? dInSrc2 :
											dInSrc3;
endmodule
