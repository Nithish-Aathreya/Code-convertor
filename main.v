`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2024 13:40:56
// Design Name: 
// Module Name: main
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


module main(din,gcon,bcon1,xscon,bout1,bout2,gout,xsout,bcon2,start,stop);
input [3:0]din;
input gcon,bcon1,bcon2,xscon,start;
output [3:0]bout1,bout2,gout,xsout;
output stop;

wire [3:0]bus;
assign bus = din;

BtoG m0(bus,gout,gcon);

GtoB m1(gout,bout1,bcon1);

BtoXS m2(bus,xsout,xscon);

XstoB m3(xsout,bout2,bcon2);

endmodule






//Binary to gray with Gcon
module BtoG(din,dout,gcon );
input [3:0]din;
input gcon;
output reg [3:0]dout;
always @(*)
begin

if(gcon==1'b1)
begin
dout[3] <= din[3];
dout[2] <= din[3]^din[2];
dout[1] <= din[2]^din[1];
dout[0] <= din[1]^din[0];
end

else
dout = 4'bx;

end 
endmodule

//Gray to binary with Bcon1
module GtoB(din,dout,bcon1);
input [3:0]din;
input bcon1;
output reg [3:0]dout;
always @(*)
begin

if(bcon1 == 1'b1)
begin
dout[3] <= din[3];
dout[2] <= dout[3] ^ din[2];
dout[1] <= dout[2] ^ din[1];
dout[0] <= dout[1] ^ din[0];
end

else
dout = 4'bx;

end
endmodule

// binary to excess3
module BtoXS(din,dout,xscon);
input [3:0]din;
input xscon;
output reg [3:0]dout;
always @(*)
begin
if(xscon ==1'b1)
dout <= din + 4'b0011;
else
dout = 4'bx;

end
endmodule


// Excess3 to binary
module XstoB(din,dout,bcon2);
input [3:0]din;
input bcon2;
output reg [3:0]dout;
always @(*)
begin
if(bcon2 ==1'b1)
dout = din - 4'b0011;
else
dout = 4'bx;

end
endmodule


module controller(gcon,bcon1,bcon2,xscon,start,stop,clk);
input start,clk;
output reg gcon,bcon1,bcon2,xscon,stop;


reg [2:0]state;
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
always @(posedge clk or negedge clk)
begin
case(state)
s0: begin
     if(start==1'b1)
     state<=s1;
     else
     state<=s0;
     end 
       
s1: #10 state<=s2;
s2: #10 state<=s3;
s3: #10 state<=s4;
default: state<=s0;
endcase
end

always @(state)
begin
case(state)
s0: begin
#1 gcon=1'b0;bcon1=1'b0;xscon=1'b0;bcon2=1'b0;stop=1'b0;
end

s1:begin
#5 gcon=1'b0;bcon1=1'b0;xscon=1'b0;bcon2=1'b0;stop=1'b0;
end

s2: begin
#5 gcon=1'b1;bcon1=1'b0;xscon=1'b1;bcon2=1'b0;stop=1'b0;
end

s3: begin
#5 gcon=1'b1;bcon1=1'b1;xscon=1'b1;bcon2=1'b1;stop=1'b0;
end

s4:begin
#5 gcon=1'b0;bcon1=1'b0;xscon=1'b0;bcon2=1'b0;stop=1'b1;
end

default: begin
gcon=1'b0;bcon1=1'b0;xscon=1'b0;bcon2=1'b0;
end


endcase
end
endmodule