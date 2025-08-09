interface apb_if #(
    localparam ADDR_WIDTH = 10,
    localparam DATA_WIDTH = 32
)(
    input logic pclk,
    input logic PRESETn
);

    logic [ADDR_WIDTH-1:0] paddr;
    logic                  pwrite;
    logic                  psel;
    logic                  penable;
    logic [DATA_WIDTH-1:0] pwdata;

    logic [DATA_WIDTH-1:0] prdata;
    logic                  pready;

endinterface //apb_if