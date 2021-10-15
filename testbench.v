`timescale 1 ns / 1 ps
module testbench#(
    parameter CLOCK_RATE = 100000000, // board internal clock
    parameter BAUD_RATE = 9600
);
    reg res_n;
    reg clk;
      
    // rx interface
        
       wire [7:0] out_RX;
    wire rxDone;

    // tx interface
    wire tx;
    reg txEn;
    reg txStart;
    reg [7:0] in;
    wire txDone;
    wire txBus;
    wire txClk,rxClk;
    baud_rate_gen #(
    .CLOCK_RATE(CLOCK_RATE),
    .BAUD_RATE(BAUD_RATE)
) gen (
    .clk(clk),
    .rxClk(rxClk),
    .txClk(txClk)
);

    uart uu (
        res_n,
     clk,
          // rx interface
          out_RX,
     rxDone,
    // tx interface
     tx,
     txEn,
     txStart,
    in,
     txDone,
     txBusy
    );
 
     // simulation init
    initial begin
        clk = 0;
       forever #5 clk = ~clk;
    end
initial begin
         
       txEn=1'b1;  
       txStart=1'b1;   
       in = 8'b01000001;
         repeat (8)  @(posedge txClk);
              in = 8'b01001100;
         repeat (8)  @(posedge txClk);
           
       in = 8'b01010001;
      repeat (8)  @(posedge txClk);
     
       in = 8'b01000001;
         repeat (8)  @(posedge txClk);
           
       in = 8'b01101100;
 
repeat (8)  @(posedge txClk);
       
       in = 8'b01001100;
 
repeat (8)  @(posedge txClk);
     
         
       in = 8'b01000001;
repeat (8)  @(posedge txClk);
     
          
       in = 8'b01000001;
    
   repeat (8)  @(posedge txClk);
     
       
       in = 8'b01000110;
    end
   

   

endmodule