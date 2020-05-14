parameter T = 200;
parameter DATA_W = 32;

parameter bit [2-1:0] WRI_EN = 2'B01,
                    RD_EN = 2'B10;

typedef int unsigned uint;
//ADDR_REG_CONFIG = 'd8,//configure register
//ADD_REG_TIMEOUT = 'd12;//time before starting
typedef enum uint {ADDR_TX_FIFO = 'd0,ADDR_RX_FIFO = 'd4,ADDR_REG_CONFIG = 'd8,ADD_REG_TIMEOUT = 'd12} address_t;
typedef enum uint {TRUE,FALSE} sim_res_t;
typedef logic [DATA_W-1:0] data_t;
typedef struct {
	logic clk;
	logic write;
	logic sel;
	logic enable;
	data_t wdata;
	data_t rdata;
	data_t addr;
	logic ready;
	logic slverr;
} apb_bus_t;

typedef enum {WR,RD} gen_t;
typedef enum {CONFIG_WR_DATA,CONFIG_RD_DATA} config_type_t;
