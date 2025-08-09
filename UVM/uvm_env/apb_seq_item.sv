`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_seq_item extends uvm_sequence_item;

    rand logic [10 - 1:0] paddr;
    rand logic [32 - 1:0] pwdata;
    rand logic [32 - 1:0] prdata;
    rand bit              pwrite;
    // rand bit           psel;    --> these should be controlled in driver
    // rand bit           penable; --> these should be controlled in driver

    `uvm_object_utils(apb_seq_item)

    function new(string name = "apb_seq_item");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        // printer.print_field_int("paddr"  , paddr  , ADDR_WIDTH);
        // printer.print_field_int("pwdata" , pwdata , DATA_WIDTH);
        // printer.print_field_int("pwrite" , pwrite ,          1);

        printer.print_field("paddr"  , paddr  , 10, UVM_HEX);
        printer.print_field("pwdata" , pwdata , 32, UVM_HEX);
        printer.print_field("pwrite" , pwrite ,  1, UVM_BIN);
    endfunction
    
endclass //apb_seq_item extends uvm_sequence_item