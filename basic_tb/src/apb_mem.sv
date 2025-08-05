module apb_mem
# (
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 32
) (
    input  logic                  pclk,
    input  logic                  PRESETn,
    input  logic [ADDR_WIDTH-1:0] paddr,
    input  logic                  pwrite,
    input  logic                  psel,
    input  logic                  penable,
    input  logic [DATA_WIDTH-1:0] pwdata,

    output logic [DATA_WIDTH-1:0] prdata,
    output logic                  pready
);

    typedef enum logic [1:0] { 
        SETUP    = 0,
        W_ENABLE = 1,
        R_ENABLE = 2
    } state_t;
    
    /////////////////////////////////////
    // Signals
    /////////////////////////////////////
        
    state_t                current_state;
    state_t                next_state;

    logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH - 1 : 0];

    /////////////////////////////////////
    // Assignments
    /////////////////////////////////////

    // read data
    assign prdata = (current_state == R_ENABLE) & (psel & penable & !pwrite) ? mem[paddr] : 'd0; 
    assign pready = (current_state == R_ENABLE || current_state == W_ENABLE) ? 'd1 : 'd0;

    /////////////////////////////////////
    // Always Blocks
    /////////////////////////////////////

    // next state logic 
    always_comb 
    begin
        case (current_state)
            SETUP: begin
                // Move to ENABLE when the psel is asserted
                if (psel && !penable) 
                begin
                    if (pwrite) 
                    begin
                        next_state = W_ENABLE;
                    end
                    else 
                    begin
                        next_state = R_ENABLE;
                    end
                end
                else
                begin
                    next_state = SETUP;
                end
            end
            default: begin
                next_state = SETUP;
            end 
        endcase    
    end 

    // state update logic
    always_ff @( posedge pclk or negedge PRESETn ) 
    begin
        if (~PRESETn)
        begin
            current_state <= SETUP;
        end
        else
        begin
            current_state <= next_state;
        end
    end

    // write data to mem
    always_ff @( posedge pclk or negedge PRESETn ) 
    begin
        if (current_state == W_ENABLE && psel && penable && pwrite)
        begin
            mem[paddr] <= pwdata;
        end
    end

endmodule