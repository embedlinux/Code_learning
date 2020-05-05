
module sramc_fsm (
   // AHB Bus Signal
   hclk,    
   hreset_n,
   hsel,    
   hready, 
   hwrite, 
   hsize, 
   htrans, 
   haddr,  
   hwdata, 
   //hrdata, 
   hready_resp,  
   hresp,   
   
   hsel_reg, 
   hwrite_reg,
   hsize_reg,
   haddr_reg
   );

// -- define AHB Bus Width and SRAM address width --
parameter  AHB_ADDR_WIDTH   = 32  ;
parameter  AHB_DATA_WIDTH   = 32  ;
parameter  SRAM_ADDR_WIDTH  = 12  ;
parameter  SRAM_DATA_WIDTH  = 32  ;

//-- define the port direction --
input                        hclk         ;
input	                       hreset_n     ;
input	                       hsel         ;
input			                   hready	    ;
input	                       hwrite       ;
input	  [2:0]	               hsize        ;
input	  [1:0]	               htrans       ;
input	  [AHB_ADDR_WIDTH-1:0] haddr        ;
input	  [AHB_DATA_WIDTH-1:0] hwdata       ;

//output  [AHB_DATA_WIDTH-1:0] hrdata       ;
output			                 hready_resp  ;
output  [1:0]	               hresp        ;	
output                       hwrite_reg   ;
output                       hsel_reg     ;
output  [2:0]		             hsize_reg    ;
output  [AHB_ADDR_WIDTH-1:0] haddr_reg    ;

// -- define the port type --
reg                            hwrite_reg   ;
reg                            hready_reg   ; 
reg    [1:0]                   htrans_reg   ;
reg                            hsel_reg     ;
reg    [2:0]	                 hsize_reg    ; 
reg    [AHB_ADDR_WIDTH-1:0]    haddr_reg    ;    
reg			                       hready_resp  ;
reg    [1:0]	                 hresp        ; 

reg     [3:0]                  current_state; 
reg     [3:0]                  next_state   ;	 //state register: CS=Current_State; NS=Next_State
		   
//--define the BUS transfer type which control the slave`s transaction--
parameter    HTRANS_IDLE   = 2'b00 ;	
parameter    HTRANS_BUSY   = 2'b01 ;
parameter    HTRANS_NONSEQ = 2'b10 ;	
parameter    HTRANS_SEQ	   = 2'b11 ;
	   
//--define the FSM name--
parameter    IDLE          = 4'b0000 ;
parameter    WRITE         = 4'b0001 ;
parameter    WRITE_BUSY	   = 4'b0010 ;
parameter    READ	         = 4'b0100 ;
parameter    READ_BUSY	   = 4'b1000 ;	   

//-- define switch constants --
parameter    ON   = 1'b1 ;
parameter    OFF  = 1'b0 ;	

//-- the FSM which detectS the bus state, includes 3 segments --

//-- 1st always block, sequential state transition --

always @ ( posedge hclk or negedge hreset_n )
  if ( !hreset_n )
	    current_state	<= IDLE;
  else
	    current_state	<= next_state;

//-- 2nd always block, combinational state transition condition judgement --

always @ ( * )
begin
    //next_state =4'bx;  //for simulation,verify the design integrality 
  if (hreset_n && hsel && hready)
  begin
     case ( current_state ) 
       IDLE:
		begin
	   	if ( hwrite )
        	    if ( htrans == HTRANS_NONSEQ ) 
	                  next_state = WRITE;
	            else
	                  next_state = IDLE;
		else 
         	    if ( htrans == HTRANS_NONSEQ ) 
		              next_state = READ;
     		    else
		              next_state = IDLE;
		end

	    WRITE:
	    begin	        	
        if ( hwrite )
	            if ( htrans == HTRANS_NONSEQ )
	                  next_state = WRITE;
	            else
	     	    if ( htrans == HTRANS_SEQ )
		              next_state = WRITE;
                else
		        if ( htrans == HTRANS_BUSY )
		              next_state = WRITE_BUSY;
		        else
		              next_state = IDLE; 
		else
		        if ( htrans == HTRANS_NONSEQ )
		             next_state = READ;
		        else
		             next_state = IDLE;
		end

	    WRITE_BUSY:
		begin
		if( hwrite )
		       if ( htrans == HTRANS_NONSEQ )
		            next_state = WRITE;
		       else
		       if ( htrans == HTRANS_SEQ )
		            next_state = WRITE;
               else
		       if ( htrans == HTRANS_BUSY )
		            next_state = WRITE_BUSY;
		       else
		            next_state = IDLE;	
	    else
	          if ( htrans == HTRANS_NONSEQ )
		            next_state = READ;
		      else
		       	    next_state = IDLE;
		end

 	    READ:
		begin
		if ( !hwrite )
		      if ( htrans == HTRANS_NONSEQ )
		           next_state = READ;
		      else
		      if ( htrans == HTRANS_SEQ )
		           next_state = READ;
              else
		      if ( htrans == HTRANS_BUSY )
		           next_state = READ_BUSY;
		      else
		           next_state = IDLE; 
		else
		      if ( htrans == HTRANS_NONSEQ )
		           next_state = WRITE;
		      else
		           next_state = IDLE;			
		end

	    READ_BUSY:
		begin
		if ( !hwrite )
		     if ( htrans == HTRANS_NONSEQ )
		           next_state = READ;
		     else
		     if ( htrans == HTRANS_SEQ )
		           next_state = READ;
             else
		     if ( htrans == HTRANS_BUSY )
		           next_state = READ_BUSY;
		     else
		           next_state = IDLE;	
	    end
	    endcase
	  end
	  else
	  	next_state = IDLE;  
  end

//-- 3rd always block, sequential FSM output --
always @ ( posedge hclk or negedge hreset_n )
begin
  if ( !hreset_n  )
    begin
	    hwrite_reg                          <= hwrite;
	    hsel_reg                            <= 1'b0;
      htrans_reg                          <= 1'b0;
      hready_reg	                       	<= 1'b0;
	    hsize_reg     [2:0]                 <= 3'b000;
	    haddr_reg     [AHB_ADDR_WIDTH-1:0]	<= 32'h0000;
      hready_resp                         <= 1'b1;
	    hresp         [1:0]	                <= 2'b00;
	    current_state [3:0]                 <= 4'b0000;
	    next_state	  [3:0]                 <= 4'b0000;	    
    end 
  else  
    if ( hsel && hready)
     begin
     case ( next_state )
     IDLE:
        begin	
		      hwrite_reg       <= 1'b0;
		      hsel_reg         <= 1'b0;
	        hsize_reg   		 <= 3'b000;
	        haddr_reg [31:0] <= 32'h0000;
          htrans_reg		   <= HTRANS_IDLE;
          hready_reg       <= 1'b0;
	        hready_resp      <= 1'b1;
	        hresp [1:0]	     <= 2'b00;
        end

	    WRITE:
	       begin
		        hwrite_reg     <= hwrite;
		        hsel_reg       <= hsel;
	          haddr_reg		   <= haddr;
	          hsize_reg		   <= hsize;	
            htrans_reg		 <= htrans;
            hready_reg     <= hready;	
            hready_resp    <= 1'b1;
	          hresp [1:0]    <= 2'b00;		           	
           end

       WRITE_BUSY:
          begin
	          hwrite_reg     <= hwrite;
	          hsel_reg       <= hsel_reg;
	          haddr_reg		   <= haddr;
	          hsize_reg		   <= hsize;	
            htrans_reg     <= htrans;
            hready_reg     <= hready;	
            hready_resp    <= 1'b1;
	          hresp [1:0]    <= 2'b00;
	       end
     
        READ:
	       begin
	         hsel_reg        <= hsel;
           htrans_reg		   <= htrans;
	         hwrite_reg      <= hwrite;
	         haddr_reg		   <= haddr;
	         hsize_reg		   <= hsize;	
           htrans_reg		   <= htrans;
           hready_reg      <= hready;	
           hready_resp     <= 1'b1;
	         hresp [1:0]     <= 2'b00;		
	       end

    	READ_BUSY:
         begin	  
	         hsel_reg        <= hsel;
		       haddr_reg		   <= haddr;
	         hsize_reg		   <= hsize;	
           htrans_reg		   <= htrans;
	         hwrite_reg      <= hwrite;
           hready_reg      <= hready;	
           hready_resp     <= 1'b1;
		       hresp [1:0]     <= 2'b00;	
	       end
        endcase
	  end
    else
	       begin
		       hsel_reg        <= hsel;
           haddr_reg		   <= 32'h0;
	         hwrite_reg      <= hwrite;
		       hsize_reg		   <= 3'h0;	
           htrans_reg		   <= HTRANS_IDLE;
           hready_reg      <= 1'b0;	
           hready_resp     <= 1'b1;
	         hresp [1:0]     <= 2'b00;
         end
   end

endmodule 
