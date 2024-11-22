`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2024 14:04:53
// Design Name: 
// Module Name: verify1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module verify1();
reg [3:0]din;
reg start,clk;
wire [3:0]bout1,bout2,gout,xsout;

wire gcon,bcon1,bcon2,xscon,stop;

main ma(din,gcon,bcon1,xscon,bout1,bout2,gout,xsout,bcon2,start,stop);
controller con(gcon,bcon1,bcon2,xscon,start,stop,clk);


initial
begin
clk=1'b0;
forever
#5 clk = ~clk;
end



initial
begin

//$monitor("din=%b,gcon=%b,bcon1=%b,bcdcon=%b,bcon2=%b,bcon3=%b,xs3con=%b,bout1=%b,bout2=%b,bout3=%b,gout=%b,bcdout=%b,xs3out=%b",
//din,gcon,bcon1,bcdcon,bcon2,bcon3,xs3con,bout1,bout2,bout3,gout,bcdout,xs3out);

#5 din = 4'b0010; start = 1'b1;
//#5 din = 4'b1010; 
//#5 bcon1 = 1'b1;

//$display("din:%d->bcdout:%b",din,bcdout);
//#5 din = 4'd9; bcdcon = 1'b1;bcon2=1'b1;
//#5 din = 4'd10; bcdcon = 1'b1;
//#5 bcdcon = 1'b0;

//#5 din = 4'b1000;
//xscon = 1'b1;bcon2=1'b1;



#500 $finish;

end
endmodule
