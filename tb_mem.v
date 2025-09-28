`include "memory.v"
//here tb is nothing but processor
//we can do this by using task as well
module tb;
parameter WIDTH = 8;
parameter DEPTH = 32;
parameter ADDR_WIDTH = $clog2(DEPTH);

reg clk,rst,wr_rd,valid;
reg [ADDR_WIDTH-1:0] addr;
reg [WIDTH-1:0] wdata;
wire [WIDTH-1:0] rdata;
wire ready;
integer i,j;
reg [20*8-1:0]test_name;
//integer dataA[10:0];

memory dut(.clk(clk),.rst(rst),.wr_rd(wr_rd),.addr(addr),.wdata(wdata),.rdata(rdata),.valid(valid),.ready(ready));

always #5 clk = ~clk;

initial begin
  $value$plusargs("test_name=%0s",test_name);
end

initial begin
  clk = 0;
  wr_rd = 0;
  valid = 0;
  wdata = 0;
  addr = 0;
  rst = 1;
  @(posedge clk);
  rst = 0;
  
  case(test_name)
        "1wr_1rd": begin
                   writes(15,1);
            	   reads(15,1);
            	   end
        "5wr_5rd" : begin
                    writes(16,5);
            	    reads(16,5);
            	    end
        "fd_wr_fd_rd": begin
                       writes(0,DEPTH);
        			   reads(0,DEPTH);
        			  end
        "bd_wr_bd_rd": begin
                       bd_writes();
        			   bd_reads(); 
        			   end
        "fd_wr_bd_rd": begin
                       writes(0,DEPTH);
        			   bd_reads();				                  
					   end
        "bd_wr_fd_rd": begin
                       bd_writes();
        			   reads(0,DEPTH);			
        			   end
	"1st_quator_wr_rd": begin
	                    writes(0,DEPTH/4);
						reads(0,DEPTH/4);
						end
     "2nd_quator_wr_rd": begin
	                     writes(DEPTH/4,DEPTH/4);
						 reads(DEPTH/4,DEPTH/4);
						end
     "3rd_quator_wr_rd": begin
	                     writes(DEPTH/2,DEPTH/4);
						 reads(DEPTH/2,DEPTH/4);
						end
     "4th_quator_wr_rd": begin
	                     writes((3*DEPTH)/4,DEPTH/4);
						 reads((3*DEPTH)/4,DEPTH/4);
						end
     "consecutive_wr_rd": begin
	                      for(i=0;i<DEPTH;i=i+1) begin
				        	consecutive(i);
			         	  end						  
				          end
	          "t1"   : begin
						  fork
						  writes(12,10);
						  reads(12,10);
						  #30 rst=1;
						  join
						 
				       end
			   "t2"   : begin
			            writes(15,1);
			            reads(27,1);
						end
			  "t3"   : begin
                        writes(15,11);
			            end
			  "t4"   : begin
                        writes(15,11);
			            end

  endcase
end
 //write data
 task writes(input reg[DEPTH-1:0] start_loc,input reg[DEPTH:0]num_writes); begin
 // j=0;
  for(i=start_loc;i<start_loc+num_writes;i=i+1) begin
  @(posedge clk);
  wr_rd = 1;
  addr = i;
  wdata = $random;
  //wdata = 'd55+j;
   // dataA[j] = $random;
    //wdata = dataA[j];
  valid = 1;
  wait (ready==1);
 // j = j + 1;
  end
  @(posedge clk);
  wr_rd = 0;
  addr = 0;
  wdata = 0;
  valid = 0;
 end
endtask

 //read data
   task reads(input reg[DEPTH-1:0] start_loc,input reg[DEPTH:0]num_reads); begin
   for(i=start_loc;i<start_loc+num_reads;i=i+1) begin
   @(posedge clk);
   wr_rd = 0;
   addr = i;
   valid = 1;
   wait (ready==1);
  end
  @(posedge clk);
   wr_rd = 0;
   addr = 0;
   valid = 0;
end
endtask

task bd_writes();
$readmemh("input.hex",dut.mem);
endtask

task bd_reads();
$writememh("output.hex",dut.mem);
endtask

task consecutive(input reg[ADDR_WIDTH-1:0]loc); begin
			@(posedge clk);
			wr_rd=1;
			addr=loc;
			wdata=$random;
			valid=1;
			wait(ready==1);
			@(posedge clk);
			wr_rd=0;
			addr=loc;
			valid=1;
			wait(ready==1);
	end
endtask

initial begin
 #800;
 $finish;
end

endmodule


