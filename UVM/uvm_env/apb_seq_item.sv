class apb_seq_item extends uvm_sequence_item;

    rand logic [31:0] addr;
    rand logic [31:0] data;
    rand bit          write;

    `uvm_object_utils(apb_seq_item)

    function new(string name = "apb_seq_item");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("addr" ,  addr, 32);
        printer.print_field_int("data" ,  data, 32);
        printer.print_field_int("write", write,  1);
    endfunction
    
endclass //apb_seq_item extends uvm_sequence_item