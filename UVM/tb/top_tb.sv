`include "uvm_macros.svh"
import uvm_pkg::*;

module top_tb();

  logic pclk;
  logic PRESETn;

  apb_if vif(pclk, PRESETn);  // Instantiate virtual interface

  // DUT instantiation
  apb_mem dut (
    .pclk   (pclk       ),
    .PRESETn(PRESETn    ),
    .paddr  (vif.paddr  ),
    .pwrite (vif.pwrite ),
    .psel   (vif.psel   ),
    .penable(vif.penable),
    .pwdata (vif.pwdata ),

    .prdata (vif.prdata ),
    .pready (vif.pready )
  );

  // Clock generator
  initial pclk = 0;
  always #5 pclk = ~pclk;

  // Reset generation
  initial 
  begin
    PRESETn = 1;
    #10 PRESETn = 0;
  end

  // UVM run
  initial 
  begin
  
    uvm_config_db #(virtual apb_if)::set(null, "*", "vif", vif);
    run_test("apb_test");
  
  end

endmodule
