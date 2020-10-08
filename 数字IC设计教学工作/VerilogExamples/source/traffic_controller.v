//------------------------------------------------------------------
//------------------------------------------------------------------
module traffic_controller
(clk          ,
 rst          ,
 req_n        ,
 major_red    ,
 major_green  ,
 minor_red    ,
 minor_green  ,
 req_ind
);
//-------------------------------------------------------------------
//-------------------------------------------------------------------
input clk;
input rst;
input req_n;
output major_red;
output major_green;
output minor_red;
output minor_green;
output req_ind;
//-------------------------------------------------------------------
reg major_red;
reg major_green;
reg minor_red;
reg minor_green;
reg req_ind;
reg[8:0] cnt;
reg min1;
reg min5;
reg min10;
reg clr;
reg[1:0] state;
reg[1:0] next_state;
//-------------------------------------------------------------------
parameter[1:0] MAJOR_0 = 2'b00;
parameter[1:0] MAJOR_1 = 2'b01;
parameter[1:0] MINOR   = 2'b10;
//-------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        state <= MAJOR_0;
    else
        state <= next_state;
end
//-------------------------------------------------------------------
always @(state or min1 or min5 or min10 or req_ind)
begin
    case(state)
        MAJOR_0 : begin
                      if(min5 == 1'b1)
                          next_state = MAJOR_1;
                      else
                          next_state = state;
                      end 
        MAJOR_1 : begin
                      if((min10 == 1'b1) || (req_ind == 1'b1))
                          next_state = MINOR;
                      else
                          next_state = state;
                      end
        MINOR   : begin
                      if(min1 == 1'b1)
                          next_state = MAJOR_0;
                      else
                          next_state = state;
                      end
        default : next_state = MAJOR_0;
    endcase    
end
//-------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        cnt <= 10'h000;
    else if(clr == 1'b1)
        cnt <= 10'h000;
    else 
        cnt <= cnt + 1'b1;
end
//------------------------------------------------------------------- 
always @(cnt or state)
begin
    if((state == MAJOR_0) && (cnt == 9'd19))  // 299
        min5 = 1'b1;
    else
        min5 = 1'b0;
end
//-------------------------------------------------------------------
always @(cnt or state)
begin
    if((state == MAJOR_1) && (cnt == 9'd19))  // 299
        min10 = 1'b1;
    else
        min10 = 1'b0;
end
//-------------------------------------------------------------------
always @(cnt or state)
begin
    if((state == MINOR) && (cnt == 9'd5))    // 59
        min1 = 1'b1;
    else
        min1 = 1'b0;
end
//-------------------------------------------------------------------
always @(min1 or min5 or min10)
begin
    if((min1 == 1'b1) || (min5 == 1'b1) || (min10 == 1'b1))
        clr = 1'b1;
    else
        clr = 1'b0;     
end
//-------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        req_ind <= 1'b0;
    else if(state == MINOR)
        req_ind <= 1'b0; 
    else if(req_n == 1'b0)
        req_ind <= 1'b1;
end
//-------------------------------------------------------------------
always @(state)
begin
    if(state == MINOR) begin
        major_red = 1'b1;
        major_green = 1'b0;
        minor_red = 1'b0;
        minor_green = 1'b1;
        end
    else begin
        major_red = 1'b0;
        major_green = 1'b1;
        minor_red = 1'b1;
        minor_green = 1'b0;
        end
end
//-------------------------------------------------------------------
endmodule
