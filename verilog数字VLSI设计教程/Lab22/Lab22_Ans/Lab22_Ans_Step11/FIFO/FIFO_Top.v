// ===========================================================
// FIFO_Top:  A complete FIFO assembled from FIFOStateM of
// Lab10 and Mem1kx32 of Lab07.
//
// ------------------------------------------------------------
// 2006-05-19 jmw: v. 1.0  Copied from Lab11_Ans.   Added AWid
//      and DWid params; deleted timescales; added Full & Empty
//      output ports.  Used new port implied wires to drop
//      several internal wire names.  Replaced ResetFIFO with
//      Reseter input implied wire; removed inversion from
//      Clocker map to Mem1kx32 instance clock pin.  Moved tb
//      to separate file.
// ============================================================
//
module FIFO_Top #( parameter AWid = 5, DWid = 32 )
        ( output[DWid-1:0] Dout, input[DWid-1:0]  Din
        , output Full, Empty
        , input ReadIn, WriteIn, Clocker, Reseter
        );
//
wire SM_MemReadCmd, SM_MemWriteCmd;
wire[AWid-1:0] SM_MemAddr, SM_ReadAddr, SM_WriteAddr;
wire Mem_Enable, MemReadOK, MemERROR;
//
assign SM_MemAddr = ({SM_MemReadCmd,SM_MemWriteCmd}==2'b10)?
                           SM_ReadAddr: SM_WriteAddr;
assign Mem_Enable = ~(SM_MemReadCmd && SM_MemWriteCmd)
                             && ~Empty && ~Full;
//
FIFOStateM #( .AWid(AWid) )
FIFO_SM1( .ReadAddr(SM_ReadAddr), .WriteAddr(SM_WriteAddr)
        , .EmptyFIFO(Empty), .FullFIFO(Full)
        , .ReadCmd(SM_MemReadCmd)
        , .WriteCmd(SM_MemWriteCmd)
        , .ReadReq(ReadIn), .WriteReq(WriteIn)
        , .Clk(Clocker), .Reset(Reseter)
        );
//
Mem1kx32 #( .AWid(AWid), .DWid(DWid) )
RegFile1(  .Dready(MemReadOK), .ParityErr(MemERROR)
        , .DataO(Dout), .DataI(Din)
        , .Addr(SM_MemAddr),  .ClockIn(Clocker)
        , .ChipEna(Mem_Enable), .Read(SM_MemReadCmd)
        , .Write(SM_MemWriteCmd)
        , .Reset(Reseter)
        );
//
endmodule // FIFO_Top.
//
