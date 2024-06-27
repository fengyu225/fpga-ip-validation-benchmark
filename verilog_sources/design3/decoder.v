`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2024 05:24:58 PM
// Design Name: 
// Module Name: decoder
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


module decoder(
    // ports list
    a,
    b,
    c,
    out
    
    );
    // define categoties of the ports
    input a;
    input b;
    input c;
    
    output [7:0]out; //represent multipul bits data
    reg [7:0]out; //or: output reg [7:0]out;
    /// Remember, the signals which are Assignmented in the Always blocks, they have to be Assignmented as a reg categoty. In this case, the out singal have to be Assignmented as a reg
    
    always@(*)begin   // discurbe a logic block
   // always@(a,b,c) this is snother way. 
        case({a,b,c})    
        // {a,b,c} becomes a 3bits signal, initially, a,b,and c are 1 bit independent singals, by using {}, they are converted into one 3bits singal. iti is called concatation
        // For exmample: wire [3:0]d;
                       //assign d = {a,1'b0, b ,c};
                       //this means, the third bit of the d singal will always be 0
            3'b000: out = 8'b00000001;  //3'd0: out = 8'b00000001;
            3'b001:out = 8'b00000010;  //3'd1:out = 8'b00000010
            3'b010:out = 8'b00000100;  //3'd2:out = 8'b00000100;
            3'b011:out = 8'b00001000;  //3'd3:out = 8'd4
            3'b100:out = 8'b00010000;
            3'b101:out = 8'b00100000;
            3'b110:out = 8'b01000000;
            3'b111:out = 8'b10000000;
            
            // b, is Binary        8'b00001010
            // d, is Decimal       8'd10
            // h, is hexadecimal   8'ha
        endcase
    end
    
    
    
    
    
endmodule
