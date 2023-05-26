//
// ntt_intt_pwm_top: keccak accelerator top-level. 
// Designed by Alessandra Dolmeta
// alessandra.dolmeta@polito.it
//


`include "/register_interface/typedef.svh"
`include "/register_interface/assign.svh"

module ntt_intt_pwm
    	#(
	 parameter int unsigned AXI_ADDR_WIDTH = 32,
	 localparam int unsigned AXI_DATA_WIDTH = 32, 
	 parameter int unsigned AXI_ID_WIDTH,
	 parameter int unsigned AXI_USER_WIDTH
     	)
       (
	input logic clk_i,
	input logic rst_ni,
	input logic test_mode_i,

	AXI_BUS.Slave axi_slave
       );
   
	import ntt_intt_pwm_reg_pkg::ntt_intt_pwm_reg2hw_t;
	import ntt_intt_pwm_reg_pkg::ntt_intt_pwm_hw2reg_t;
	 		
	// Wiring signals between reg file and ip
	REG_BUS #(.ADDR_WIDTH(32), .DATA_WIDTH(32)) axi_to_regfile();
	ntt_intt_pwm_reg2hw_t reg_file_to_ip;
	ntt_intt_pwm_hw2reg_t ip_to_reg_file;

	axi_to_reg_intf #(
	   		.ADDR_WIDTH(AXI_ADDR_WIDTH),
			.DATA_WIDTH(AXI_DATA_WIDTH),
			.ID_WIDTH(AXI_ID_WIDTH),
			.USER_WIDTH(AXI_USER_WIDTH),
	 		.DECOUPLE_W(0)
	) i_axi2reg (
		.clk_i,
		.rst_ni,
		.testmode_i (test_mode_i),
		.in(axi_slave),
		.reg_o (axi_to_regfile)
	);

	// Convert the REG_BUS interface to the struct signals used by autogenerated register file 
	typedef logic [AXI_ADDR_WIDTH-1:0] addr_t;
	typedef logic [AXI_ADDR_WIDTH-1:0] data_t;
	typedef logic [AXI_ADDR_WIDTH/8-1:0] strb_t;
	`REG_BUS_TYPEDEF_REQ(reg_req_t, addr_t, data_t, strb_t);
  	`REG_BUS_TYPEDEF_RSP(reg_rsp_t, data_t);
	reg_req_t to_reg_file_req;
	reg_rsp_t from_reg_file_rsp;
	`REG_BUS_ASSIGN_TO_REQ(to_reg_file_req, axi_to_regfile);
	`REG_BUS_ASSIGN_FROM_RSP(axi_to_regfile, from_reg_file_rsp);

	ntt_intt_pwm_reg_top #(
	.reg_req_t(reg_req_t),
	.reg_rsp_t(reg_rsp_t)
	) i_regfile (
		.clk_i,
		.rst_ni,
		.devmode_i(1'b1),
		// From the protocol converters to regfile
		.reg_req_i(to_reg_file_req),
		.reg_rsp_o(from_reg_file_rsp),
		
		// Signals to ntt_intt_pwm IP
		.reg2hw(reg_file_to_ip),
		.hw2reg(ip_to_reg_file) 
	);

        
   // wiring signals between control unit and ip
   wire logic [63:0] din_ntt_intt_pwm, dout_ntt_intt_pwm;
   assign din_ntt_intt_pwm = reg_file_to_ip.din;
			       			        	
	ntt_intt_pwm i_ntt_intt_top (
		.clk(clk_i),
		.rst(rst_ni),
		.load_a_f(reg_file_to_ip.ctrl.load_a_f.q),
		.load_a_i(reg_file_to_ip.ctrl.load_a_i.q),
		.read_a(reg_file_to_ip.ctrl.read_a.q),
		.read_b(reg_file_to_ip.ctrl.read_b.q),
        .start_ab(reg_file_to_ip.ctrl.start_ab.q),
        .start_fntt(reg_file_to_ip.ctrl.start_fntt.q & reg_file_to_ip.ctrl.start_ntt.qe),
		.start_pwm2(reg_file_to_ip.ctrl.start_pwm.q & reg_file_to_ip.ctrl.start_pwm.qe),
		.start_intt(reg_file_to_ip.ctrl.start_intt.q & reg_file_to_ip.ctrl.start_intt.qe),
		.din(din_ntt_intt_pwm),
		.dout(dout_ntt_intt_pwm),
		.done(ip_to_reg_file.status)
	);

  assign ip_to_reg_file.dout = dout_ntt_intt_pwm;
  
endmodule : ntt_intt_pwm
