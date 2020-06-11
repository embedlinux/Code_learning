package components;
    `include "defines.sv"
    
    apb_bus_t apb_bus;
    logic event_tx_i2c_vld,event_tx_vld;
    data_t data_tx_i2c;
    logic data_tx_i2c_vld;
    
    //Driver
    class Initiator;
        
        function void init_en();
            apb_bus.sel = 0;
            apb_bus.wdata = 0;
            apb_bus.addr = 0;
            apb_bus.write = 0;
            apb_bus.enable = 0;
        endfunction
        
        task write_oper(address_t address,data_t data_w);
            @(posedge apb_bus.clk);
            #1;
            apb_bus.sel = 1;
            apb_bus.write = 1;
            apb_bus.wdata = data_w;
            apb_bus.addr = address;
            #T;
            apb_bus.enable = 1;
            #T;
            init_en();
        endtask
        
        task read_oper(address_t address,output data_t data_r);
            @(posedge apb_bus.clk);
            #1;
            apb_bus.sel = 1;
            apb_bus.write = 0;
            apb_bus.addr = address;
            #T;
            apb_bus.enable = 1;
            #T;
            data_r = apb_bus.rdata;
            init_en();
        endtask
    endclass

    typedef class Config;
    //Generator
    class Request; 
        data_t data_w;
        data_t data_r;
        Initiator initiator;
        
        function new();
            data_w = 32'h1234_5678;//32'b0001_0010_0011_0100_0101_0110_0111_1000
            initiator = new();
            clear_req();
        endfunction
        
        function void clear_req();
            initiator.init_en();
        endfunction
        
        task configure_reg(data_t data_reg_config,data_t data_reg_timeout);
            initiator.write_oper(ADDR_REG_CONFIG,data_reg_config);
            #(T*10);
            initiator.write_oper(ADD_REG_TIMEOUT,data_reg_timeout);
        endtask
        
        task write_data(data_t data_w);
            initiator.write_oper(ADDR_TX_FIFO,data_w);
        endtask
        
        task read_data(output data_t data_r);
            initiator.read_oper(ADDR_RX_FIFO,data_r);
        endtask
        
        task req_run(Config req_config);
            if(req_config.config_type == CONFIG_WR_DATA)begin
                configure_reg(data_t'({30'd10,WRI_EN}),data_t'(32'd10000));
                write_data(data_w);
            end
            else if(req_config.config_type == CONFIG_RD_DATA)begin
                configure_reg(data_t'({30'd10,RD_EN}),data_t'(32'd10000));
                read_data(data_r);
            end
        endtask
    
    endclass:Request
    
    class Config;
        config_type_t config_type;
        
        function new(config_type_t config_type=CONFIG_RD_DATA);
            this.config_type = config_type;
        endfunction
        
    endclass:Config
    
    class Monitor;

        mailbox #(data_t) mb_data_i2c_tx;
        mailbox #(data_t) mb_data_tx;
        
        function new(mailbox mb1,mailbox mb2);
            this.mb_data_i2c_tx = mb1;
            this.mb_data_tx = mb2;
        endfunction
        
        task store_res_tx();
            wait(event_tx_i2c_vld);
            #(T/2.0);
            mb_data_i2c_tx.put(data_tx_i2c);
            $display("store_res_tx:MAILBOX PUT:'h%h",data_tx_i2c);
        endtask
        
        task store_source_tx();
            wait(event_tx_vld);
            #(T/2.0);
            mb_data_tx.put(apb_bus.wdata);
            $display("store_source_tx:MAILBOX PUT:'h%h",apb_bus.wdata);
        endtask
        
        task mon_run();
            fork 
                store_res_tx();
                store_source_tx();
            join
        endtask
    
    endclass:Monitor
    
    class Checker;
        uint cmp_cnt;
        uint err_cnt;
        data_t data_A,data_B;
        mailbox #(data_t) mb_data_A,mb_data_B;
        sim_res_t check_res;
        
        function new(mailbox mb_A,mailbox mb_B);
            cmp_cnt = 0;
            err_cnt = 0;
            this.mb_data_A = mb_A;
            this.mb_data_B = mb_B;
        endfunction
        
        task collect_res();
            mb_data_A.get(this.data_A);
            mb_data_B.get(this.data_B);
            $display("MAILBOX GET:'h%h, 'h%h",this.data_A,this.data_B);
        endtask
        
        function sim_res_t compare(data_t dataA,data_t dataB);
            if(dataA == dataB)begin
                check_res = TRUE;
            end
            else begin
                err_cnt ++;
                check_res = FALSE;
            end
            return check_res;
        endfunction
        
        task check_run();
            sim_res_t check_res;
            collect_res();
            check_res = compare(data_A,data_B);
            if(check_res == TRUE)
                $display("RUN PASS");
            else
                $display("RUN FAIL");
        endtask
    
    endclass:Checker
    
    class Environment;
        mailbox #(data_t) mb[2];
        Checker chk;
        Request req;
        Monitor monitor;
        Config req_config;
        
        function new();
            uint i;
            req_config = new();
            req = new();
            foreach(mb[i])
                mb[i] = new();
            monitor = new(mb[0],mb[1]);
            chk = new(mb[0],mb[1]);
        endfunction
        
        task env_run();
            fork
                req.req_run(req_config);
                monitor.mon_run();
            join
            chk.check_run();
        endtask
        
    endclass:Environment
    
endpackage