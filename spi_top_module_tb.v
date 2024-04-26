`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2023 18:59:11
// Design Name: 
// Module Name: spi_top_tb
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

module spi_top_tb;
  
  parameter data=32,addr=32;
  
    reg PRESETn;
    reg PSEL;
	reg PCLK;
	reg PWRITE;
	
	reg [addr-1:0] PADDR;
	reg [data-1:0] PWDATA;
	reg miso;
	
	wire [data-1:0] PRDATA;
	wire ss;
	wire sclk;
    wire mosi;
    
    spi_top uut(
    .PRESETn(PRESETn),
    .PSEL(PSEL),
	.PCLK(PCLK),
	.PWRITE(PWRITE),
	
	.PADDR(PADDR),
	.PWDATA(PWDATA),
	.miso(miso),
	.PRDATA(PRDATA),
	.ss(ss),
	.sclk(sclk),
	.mosi(mosi)
    );

    initial
    begin
        PCLK=0;
        forever #1 PCLK=~PCLK;
    end
    
    initial 
    begin
        PRESETn=1;
        PADDR = 0;
        PWDATA = 0;
        PWRITE = 0; 
        @(posedge PCLK);
        
        PSEL=1;
	    PRESETn=0;
        PADDR=8'h00;                                     // REGISTERS CONFIG  write
        PWRITE=1; 
        PWDATA=32'b00000000000000000000000101110010;    //7-0 SPICR_1, 15-8 SPICR_2   23-16 SPIBDR
        @(posedge PCLK);

        PADDR=8'h04;
        PWRITE=1; 
        PWDATA=32'h501acf1a;                                   // data to write      
        repeat(32) @(posedge uut.SPI_MASTER.sclk);
        
        PADDR=8'h00;  
        PWRITE=0; 
        PWDATA=32'b00000000000000000000000001100010;           // read  register config
        
        repeat(2) @(posedge uut.SPI_MASTER.sclk);
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 10
        
        PADDR=8'h08;                  // address to read
        PWRITE=0; 
        repeat(3)@(posedge PCLK);       // 1st data is read successfully
 
        PADDR=8'h00;  
        PWRITE=1;     
                                       
        PRESETn=1;
        repeat(4) @(posedge PCLK);         //1+2+74+12+64+4=157
             
        PRESETn=0;
        @(posedge PCLK);
        
        PADDR=8'h00;                                     // REGISTERS CONFIG  write
        PWRITE=1; 
        PWDATA=32'b00000000000000000000000101110010;    //7-0 SPICR_1, 15-8 SPICR_2   23-16 SPIBDR
        @(posedge PCLK);       //159
        
        PADDR=8'h04;
        PWDATA=32'h5bcdef7a;
       // repeat(3) @(posedge PCLK);
        repeat(32) @(posedge uut.SPI_MASTER.sclk);
      
        PADDR=8'h00;  
        PWRITE=0; 
        PWDATA=32'b00000000000000000000000001100010;           // read  register config
        
        repeat(2) @(posedge uut.SPI_MASTER.sclk);
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=1; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 11
        miso=1; @(posedge uut.SPI_MASTER.sclk);        miso=0; @(posedge uut.SPI_MASTER.sclk);     // 11
        
        PADDR=8'h08;                  // address to read
        PWRITE=0; 
        repeat(3)@(posedge PCLK);       // 1st data is read successfully
        
        end
endmodule