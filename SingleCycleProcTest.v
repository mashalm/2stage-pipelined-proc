module SingleCycleProcTest;

reg clk, reset;
reg[9:0] switches;
reg[3:0] keys;
wire[9:0] ledr;
wire[7:0] ledg;
wire[6:0] hex0, hex1, hex2, hex3;

integer i, counter;

always #10 clk = ~clk;

singlecycleproc CPU(
    .clk    (clk),
    .reset  (reset),
    .SW     (switches),
    .KEY    (keys),
    .LEDR   (ledr),
    .LEDG   (ledg),
    .HEX0   (hex0),
    .HEX1   (hex1),
    .HEX2   (hex2),
    .HEX3   (hex3),
    .CLOCK_50(clk)
);

initial begin
    // Initialize instruction data
    for(i=0; i<256; i=i+1) begin
        CPU.inst_mem.data[i] = 32'b0;
    end

    // Initialize data data
    for(i=0; i<32; i=i+1) begin
        CPU.data_mem.data[i] = 32'b0;
    end

    // initialize Register File
    for(i=0; i<32; i=i+1) begin
        CPU.rf.registers[i] = 32'b0;
    end

    CPU.rf.registers[1] = 10;
    CPU.rf.registers[2] = 20;

    // Load instructions into instruction data
    $readmemh("../instructions.txt", CPU.inst_mem.data);

    counter = 0;
    clk = 0;
    reset = 1;

    $display("time\t clk  reset");
    $monitor("%g\t   %b    %b", $time, clk, reset);
    #10
    reset = 0;
end

always@(posedge clk) begin
    if(counter == 5)    // stop after 5 cycles
        $stop;

    $display("cycle = %d", counter);

    // print PC
    $display("PC = %d", CPU.pcOut[13:2]);
    $display("instr = %h", CPU.inst_mem.data[CPU.pcOut[13:2]]);

    // print Registers
    $display("Registers");
    $display("R0 =%d, R8 =%d", CPU.rf.registers[0], CPU.rf.registers[8]);
    $display("R1 =%d, R9 =%d", CPU.rf.registers[1], CPU.rf.registers[9]);
    $display("R2 =%d, R10 =%d", CPU.rf.registers[2], CPU.rf.registers[10]);
    $display("R3 =%d, R11 =%d", CPU.rf.registers[3], CPU.rf.registers[11]);
    $display("R4 =%d, R12 =%d", CPU.rf.registers[4], CPU.rf.registers[12]);
    $display("R5 =%d, R13 =%d", CPU.rf.registers[5], CPU.rf.registers[13]);
    $display("R6 =%d, R14 =%d", CPU.rf.registers[6], CPU.rf.registers[14]);
    $display("R7 =%d, R15 =%d", CPU.rf.registers[7], CPU.rf.registers[15]);

    // print Data data
    $display("Data data: 0x00 =%d", {CPU.data_mem.data[3] , CPU.data_mem.data[2] , CPU.data_mem.data[1] , CPU.data_mem.data[0] });
    $display("Data data: 0x04 =%d", {CPU.data_mem.data[7] , CPU.data_mem.data[6] , CPU.data_mem.data[5] , CPU.data_mem.data[4] });
    $display("Data data: 0x08 =%d", {CPU.data_mem.data[11], CPU.data_mem.data[10], CPU.data_mem.data[9] , CPU.data_mem.data[8] });
    $display("Data data: 0x0c =%d", {CPU.data_mem.data[15], CPU.data_mem.data[14], CPU.data_mem.data[13], CPU.data_mem.data[12]});
    $display("Data data: 0x10 =%d", {CPU.data_mem.data[19], CPU.data_mem.data[18], CPU.data_mem.data[17], CPU.data_mem.data[16]});
    $display("Data data: 0x14 =%d", {CPU.data_mem.data[23], CPU.data_mem.data[22], CPU.data_mem.data[21], CPU.data_mem.data[20]});
    $display("Data data: 0x18 =%d", {CPU.data_mem.data[27], CPU.data_mem.data[26], CPU.data_mem.data[25], CPU.data_mem.data[24]});
    $display("Data data: 0x1c =%d", {CPU.data_mem.data[31], CPU.data_mem.data[30], CPU.data_mem.data[29], CPU.data_mem.data[28]});

    $display("\n");

    counter = counter + 1;
end


endmodule
