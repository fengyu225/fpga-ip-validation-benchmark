`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2024 10:42:55 PM
// Design Name: 
// Module Name: 3_8_decoder
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
    clk,
    rst,
    led
    );
    
    input clk;
    input rst;
    output [5:0]led;
    reg [27:0]cnt;
    
    always@(posedge clk or posedge rst)
        if(rst)
            cnt <= 0;
        else if (cnt == 62500000 -1)
            cnt <= 0;
        else 
            cnt <= cnt + 1'd1;

    reg [3:0]cnt2;
    
    always@(posedge clk or posedge rst)
        if(rst)
            cnt2 <= 0;
       // else if (cnt2 == 7)  no need, because cnt2 is only 3 bits, when it is full, it will automaticly becomes 000
         //   cnt <= 0;

        else if (cnt == 62500000 -1)
            cnt2 <= cnt2 + 1'd1;
            
        // when I wan to Instantiate a moudle, I will first add the .v file in this project, and then Instantiation
        
        my3_8_decoder my3_8_decoder(
            .a(cnt2[2]),// link every bit of cnt2 in the ports
            .b(cnt2[1]),
            .c(cnt2[0]),
            .out(led[5:0])  // CAUTION: right now, this led is driven by the Low-level module(my3_8_decoder), in fact, out is a reg category and it is defined in the my3_8_decoder, so it is no need to define led as a reg in this file.
                            //          in fact, in this file, led is a wire value. you can define it as a wire, or just not, because it is default as a wire. Why Ican not define it as a reg? because led singal is driven by the low-level
                            //          module, if a signal is driven by low-level modlues, whatever it is a reg or a wire, it have to be defined as a wire.
        );
endmodule
