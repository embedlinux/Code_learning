// ===========================================================
// FIFOTop:  Updated for dual-port memory operation.
// ------------------------------------------------------------
// 2006-05-24 jmw: v. 1.4 Separated Clocker to ClkR and ClkW;
//      routed them to submodules.
// 2006-05-24 jmw: v. 1.3  Added separate read & write clock
//      pin inputs to SM.
// 2006-05-24 jmw: v. 1.2  Removed SM_MemAddr wire and logic;
//      changed Mem1kx23 instance to DPMem1kx32 and wired both
//      input clock pins to the same shared clock; wired the
//      new input address pins to different SM address outputs.
// 2006-05-24 jmw: v. 1.1  Renamed from FIFO_Top to FIFOTop.
//      Deleted Mem_Enable wire & logic.
// 2006-05-19 jmw: v. 1.0  Copied from Lab11_Ans.   Added AWid
//      and DWid params; deleted timescales; added Full & Empty
//      output ports.  Used new port implied wires to drop
//      several internal wire names.  Replaced ResetFIFO with
//      Reseter input implied wire; removed inversion from
//      Clocker map to Mem1kx32 instance clock pin.  Moved tb
//      to separate file.
// ============================================================
//
module FIFOTop #( parameter AWid = 5, DWid = 32 )
        ( output[DWid-1:0] Dout, input[DWid-1:0]  Din
        , output Full, Empty
        , input ReadIn, WriteIn, ClkR, ClkW, Reseter
        );
//
wire SM_MemReadCmd, SM_MemWriteCmd;
wire[AWid-1:0] SM_MemAddr, SM_ReadAddr, SM_WriteAddr;
wire MemReadOK, MemERROR;
//
FIFOStateM #( .AWid(AWid) )
FIFO_SM1( .ReadAddr(SM_ReadAddr), .WriteAddr(SM_WriteAddr)
        , .EmptyFIFO(Empty), .FullFIFO(Full)
        , .ReadCmd(SM_MemReadCmd)
        , .WriteCmd(SM_MemWriteCmd)
        , .ReadReq(ReadIn), .WriteReq(WriteIn)
        , .ClkR(ClkR), .ClkW(ClkW), .Reset(Reseter)
        );
//
DPMem1kx32 #( .AWid(AWid), .DWid(DWid) )
FIFO_Mem1
        ( .Dready(MemReadOK), .ParityErr(MemERROR)
        , .DataO(Dout), .DataI(Din)
        , .AddrR(SM_ReadAddr), .AddrW(SM_WriteAddr)
        , .ClkR(ClkR), .ClkW(ClkW), .ChipEna(1'b1)
        , .Read(SM_MemReadCmd), .Write(SM_MemWriteCmd)
        , .Reset(Reseter)
        );
//
endmodule // FIFOTop.
//
