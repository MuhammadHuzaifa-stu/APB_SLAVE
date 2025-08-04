`timescale 1ns/1ps

module tb_apb_mem();

    // Parameters
    parameter ADDR_WIDTH = 10;
    parameter DATA_WIDTH = 32;

    // DUT signals
    logic                    pclk;
    logic                    PRESETn;
    logic [ADDR_WIDTH-1:0]   paddr;
    logic                    pwrite;
    logic                    psel;
    logic                    penable;
    logic [DATA_WIDTH-1:0]   pwdata;
    logic [DATA_WIDTH-1:0]   prdata;
    logic                    pready;

    // Read from address 5
    logic [31:0] read_data;
  
    // Clock generation
    always #5 pclk = ~pclk;

    // DUT instantiation
    apb_mem #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .pclk   (pclk   ),
        .PRESETn(PRESETn),
        .paddr  (paddr  ),
        .pwrite (pwrite ),
        .psel   (psel   ),
        .penable(penable),
        .pwdata (pwdata ),
        .prdata (prdata ),
        .pready (pready )
    );

    // Task to do APB write
    task apb_write(
        input [ADDR_WIDTH-1:0] addr, 
        input [DATA_WIDTH-1:0] data
    );
    begin
        @(posedge pclk);
        paddr   <= addr;
        pwdata  <= data;
        pwrite  <= 1'b1;
        psel    <= 1'b1;
        penable <= 1'b0;

        @(posedge pclk);
        penable <= 1'b1;

        @(posedge pclk);
        psel    <= 1'b0;
        penable <= 1'b0;
    end
    endtask

    // Task to do APB read
    task apb_read(
        input  [ADDR_WIDTH-1:0] addr, 
        output [DATA_WIDTH-1:0] data);
    begin
        @(posedge pclk);
        paddr   <= addr;
        pwrite  <= 1'b0;
        psel    <= 1'b1;
        penable <= 1'b0;

        @(posedge pclk);
        penable <= 1'b1;

        @(posedge pclk);
        data    <= prdata;
        psel    <= 1'b0;
        penable <= 1'b0;
    end
    endtask

    // Test sequence
    initial 
    begin
        // Init
        pclk    = 0;
        PRESETn = 0;
        paddr   = 0;
        pwrite  = 0;
        psel    = 0;
        penable = 0;
        pwdata  = 0;

        #20;
        PRESETn = 1;

        // Write 32'hABCD1234 to address 5
        apb_write(5, 32'hABCD1234);
        apb_read (5,    read_data);

        // Display result
        $display("Read data: 0x%08X", read_data);
        
        if (read_data === 32'hABCD1234) 
        begin
            $display("TEST PASSED");
        end 
        else 
        begin
            $display("TEST FAILED");
        end

        #10;
        $finish;
    end

endmodule
