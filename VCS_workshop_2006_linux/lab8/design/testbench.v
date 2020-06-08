module testbench;

`define CM_SOURCE 1
`define CM_MODULE 10
`define CM_HIER 11
`define MEM_SIZE 32'h4000

reg execute1, execute2, execute3;
integer start, imm_inst, branch_inst, jump_inst, resets;
integer decoded, fsm_error, memread, memwrite, bus_error, reg_cpt; 
real coverage, coverage_limit, percentage;
real percentage_covered;

initial
begin
    `ifdef COVER
         percentage = `COVER;
    `else
         percentage = 100;
    `endif
     coverage_limit = $cm_get_limit(`CM_SOURCE, `CM_HIER, "TOP");
end

initial fsm_error = 0;
initial memread = 0;
initial memwrite = 0;
initial bus_error = 0;
initial reg_cpt = 0;
initial execute1 = 0;
initial execute2 = 0;
initial execute3 = 0;
initial decoded = 0;
initial start = 0;

always @(TOP.CPU.ALU.ALUout)
begin
   imm_inst <= $get_uvar("count0");
   branch_inst <= $get_uvar("count1");
   jump_inst <= $get_uvar("count2");
   resets <= $get_uvar("count3");
end

always @(TOP.CPU.CLK)
begin
    decoded <= $get_uvar("decode");
    memread <= $get_uvar("read");
    memwrite <= $get_uvar("write");
    bus_error <= $get_uvar("bus_error");
    reg_cpt <= $get_uvar("reg_corrupt");
    fsm_error <= $get_uvar("fsm_error");
    coverage <= $cm_get_coverage(`CM_SOURCE, `CM_HIER, "TOP");
    if (coverage >= (percentage/100)*coverage_limit)
    begin
        $display("\nSIMULATION EXIT: Desired coverage of %f percent reached", percentage);
        force TOP.Iaddr = ((`MEM_SIZE-1)*4);
        #1 $finish;
    end
end

always @(decoded)
if (decoded)
begin
    $set_uvar("decode",0);
    $display("\nASSERT: New Instruction is being executed");
    if (start == 0)
    $display("        TO LOAD PC with Instruction ADDRESS for Data");
    else
    $display("        Instruction is of type %s", TOP.CPU.Decoder.instr_type);
    start = start + 1;
    if (TOP.CPU.Decoder.instr_type == "BRANCH")
        execute2 = 1;
    else if (TOP.CPU.Decoder.instr_type == "JUMP")
        execute3 = 1;
    else
        execute1 = 1;
end

always @(memread) 
if (memread && (execute1||execute2||execute3))
begin
    $set_uvar("read",0);
    execute1 <= 0;
    execute2 <= 0;
    execute3 <= 0;
    $display("\nASSERT: System Memory is being READ");
end

always @(memwrite) 
if (memwrite && (execute1||execute2||execute3))
begin
    $set_uvar("write",0);
    execute1 <= 0;
    execute2 <= 0;
    execute3 <= 0;
    $display("\nASSERT: System Memory is being WRITTEN");
end

always @(bus_error) 
if (bus_error)
begin
    $display("\nASSERT: CONTENTION on System Memory Bus");
    force TOP.Iaddr = ((`MEM_SIZE-1)*4);
    #1 $finish;
end

always @(reg_cpt) 
if (reg_cpt == 1)
begin
    $display("\nASSERT: CPU Registers have been CORRUPTED");
    force TOP.Iaddr = ((`MEM_SIZE-1)*4);
    #1 $finish;
end

always @(fsm_error) 
if (fsm_error ==1)
begin
    $display("\nASSERT: current and next states of CPU changed on negedge of CLK");
    force TOP.Iaddr = ((`MEM_SIZE-1)*4);
    #1 $finish;
end

endmodule
