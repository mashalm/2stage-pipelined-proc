
module PipeRegister(clk, dmemDataIn, dmemWrtEn,
							memtoReg, jal, //mux selectors
							PCinc, aluOut, regFileWrtEn, regWrtIndex,
							//outputs:
							dmemAddr_out, dmemDataIn_out, dmemWrtEn_out, memtoReg_out, jal_out,
							PCinc_out, regFileAluOut_out, regFileWrtEn_out, regWrtIndex_out);
							
	parameter DBITS = 32;
	parameter REG_INDEX_BIT_WIDTH = 4;

	input clk;
	input[DBITS-1:0] dmemDataIn, PCinc, aluOut;
	input dmemWrtEn, memtoReg, jal, regFileWrtEn;
	input[REG_INDEX_BIT_WIDTH - 1: 0] regWrtIndex;

	reg[DBITS-1:0] dmemDataIn_m, PCinc_m, aluOut_m;
	reg dmemWrtEn_m, memtoReg_m, jal_m, regFileWrtEn_m;
	reg[REG_INDEX_BIT_WIDTH-1: 0] regWrtIndex_m;

	output[DBITS-1:0] dmemAddr_out, regFileAluOut_out, dmemDataIn_out, PCinc_out;
	output dmemWrtEn_out, memtoReg_out, jal_out, regFileWrtEn_out;
	output[REG_INDEX_BIT_WIDTH-1:0] regWrtIndex_out;

	always @ (negedge clk) begin
		aluOut_m <= aluOut;
		PCinc_m <= PCinc;
		dmemDataIn_m <= dmemDataIn;
		//signals:
		dmemWrtEn_m <= dmemWrtEn;
		memtoReg_m <= memtoReg;
		jal_m <= jal;
		regFileWrtEn_m <= regFileWrtEn;
		regWrtIndex_m <= regWrtIndex;
	end

	assign dmemAddr_out = aluOut_m;
	assign regFileAluOut_out = aluOut_m;
	assign dmemDataIn_out = dmemDataIn_m;
	assign PCinc_out = PCinc_m;
	assign dmemWrtEn_out = dmemWrtEn_m;
	assign memtoReg_out = memtoReg_m;
	assign jal_out = jal_m;
	assign regFileWrtEn_out = regFileWrtEn_m;
	assign regWrtIndex_out = regWrtIndex_m;

endmodule