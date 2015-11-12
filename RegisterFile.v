module RegisterFile(clk, wrtEn, dIn, dr, sr1, sr2, sr1Out, sr2Out);
	parameter BIT_WIDTH = 32;
	parameter REG_WIDTH = 4;
	parameter REG_SIZE = (1 << REG_WIDTH);

	input clk, wrtEn;
	input [BIT_WIDTH - 1 : 0] dIn;
	input [REG_WIDTH - 1 : 0] dr, sr1, sr2;
	output [BIT_WIDTH - 1 : 0] sr1Out, sr2Out;
	
	reg [BIT_WIDTH - 1 : 0] registers [0 : REG_SIZE - 1];

	always @(posedge clk)
		if (wrtEn) registers[dr] <= dIn;	

	assign sr1Out = registers[sr1];
	assign sr2Out = registers[sr2];
	
endmodule
