`timescale 1ns/1ps

import uvm_pkg::*;

module top_tb();

  // Clock & Reset
  bit pclk;
  bit presetn;

  initial 
  begin
    pclk = 0;
    forever #5 pclk = ~pclk; // 100 MHz clock
  end

  initial 
  begin
    presetn = 1;
    #2  presetn = 0;
    #20 presetn = 1;
  end

  // APB Interface instance
  apb_if apb_vif (pclk, presetn);

  // DUT instance (if parameterized)
  apb_mem dut (
    .pclk     (pclk           ),
    .PRESETn  (presetn        ),
    .paddr    (apb_vif.paddr  ),
    .pwdata   (apb_vif.pwdata ),
    .prdata   (apb_vif.prdata ),
    .pwrite   (apb_vif.pwrite ),
    .psel     (apb_vif.psel   ),
    .penable  (apb_vif.penable),
    .pready   (apb_vif.pready )
  );

  // Set interface handle in UVM config DB
  initial 
  begin
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.env.agent", "vif", apb_vif);

    // Run parameterized test
    run_test("apb_test");
  end

endmodule
