/*****************************************************
FileName    : Table.sv
Auhtor	    : Jy
Data	      : 2011-6-17
Version	    : 0.10
Function    : It is a table, which record the address
	            and write data in two queue.
------------------------------------------------------
Data	      : 2011-6-30
Version	    : 0.11
Modification: Add a perl to deal with files,
	            merge read addess file and read data file
	            into one file.
*****************************************************/

class Table;
  Packet pkt2recv;	  // Packet to shallow copy from function record()
  logic[31:0] waddr_q[$]; // write address queue
  logic[31:0] wdata_q[$]; // write data queue
  logic[31:0] raddr_q[$]; // read address queue
  logic[31:0] rdata_q[$]; // read data queue
  int fpw;
  int fpr_a;
  int fpr_b;
	
  extern function new();
  // it is used to record address and data (W/R)
  // "rec_ctrl" used to control record read address and read data,
  // 1:record read address; 0:record read data (default:record read address)
  extern virtual task record(Packet pkt, bit rec_ctrl=1'b1);
  // it is used to close file points and transact temporary files
  extern virtual task close();
endclass

function Table::new();
  // the file to store write address and write data
  fpw   = $fopen("waddr_wdata.tab");
  // the follwing 2 files used to store read address and read data temporary,
  // it will be deal with at last, and then be delete
  fpr_a = $fopen("raddr.tmp");
  fpr_b = $fopen("rdata.tmp");
endfunction

// it is used to record address and data (W/R)
// "rec_ctrl" used to control record read address and read data,
// 1:record read address; 0:record read data (default:record read address)
task Table::record(Packet pkt, bit rec_ctrl);
  pkt2recv = new pkt;
  // record the HADDR & HWDATA
  if (pkt2recv.hwrite) begin	// if it is a WRITE operation
    foreach(pkt2recv.haddr_q[i]) begin
      // record in queue
      waddr_q.push_back(pkt2recv.haddr_q[i]);
      wdata_q.push_back(pkt2recv.hwdata_q[i]);
      // record in file
      $fwrite(fpw, "%8h : %8h\n", pkt2recv.haddr_q[i], pkt2recv.hwdata_q[i]);
    end
  end
  // record the HADDR & HRDATA
  else begin	 // if it is a READ operation
    if (rec_ctrl) begin// record the address
      foreach(pkt2recv.haddr_q[i]) begin
        // record in queue
        raddr_q.push_back(pkt2recv.haddr_q[i]);
        // record in file
        $fwrite(fpr_a, "%8h\n", pkt2recv.haddr_q[i]);
      end
    end
    else begin	 // record the read data
      foreach(pkt2recv.hrdata_q[i]) begin
        // record in queue
        rdata_q.push_back(pkt2recv.hrdata_q[i]);
        // record in file
        $fwrite(fpr_b, "%8h\n", pkt2recv.hrdata_q[i]);
      end
    end
  end
endtask

task Table::close();
  // close the file points
  $fclose(fpw);
  $fclose(fpr_a);
  $fclose(fpr_b);
  // recall perl to deal with files
  $system("read_transact");
  // delete temp files
  $system("rm -rf raddr.tmp");
  $system("rm -rf rdata.tmp");
endtask
