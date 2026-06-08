module VGADriver(
					  input logic clock,
					  input logic reset_n,
					  output logic hsync,
					  output logic vsync,
					  output logic [3:0] red_display,
					  output logic [3:0] green_display,
					  output logic [3:0] blue_display
					  );

logic enable_n;

logic hdisplay;
logic vdisplay;
logic [15:0] rgb_input;
logic [15:0] rgb_output;
logic [9:0] row_count;
logic [9:0] column_count;
logic [18:0] pixeladdress;

assign red_display = rgb_output[15:12];
assign green_display = rgb_output[10:7];
assign blue_display = rgb_output[4:1];

logic mux_input;
assign mux_input = hdisplay & vdisplay;		
		
EnableCounter enable_counter(
									  .clock(clock),
									  .reset_n(reset_n),
									  .enable_n(enable_n)
									  );
									  
SyncCounter sync_counter(
								 .clock(clock),		
								 .enable_n(enable_n),
								 .reset_n(reset_n),
								 .hdisplay(hdisplay),
								 .vdisplay(vdisplay),
								 .hsync(hsync),
								 .vsync(vsync),
								 .h_display_count(column_count),
								 .v_display_count(row_count)
								 );
								 

bigMux big_mux(
		.d0(16'b0),
		.d1(rgb_input),
		.s(mux_input),
		.y(rgb_output)
);

AddressConverter addy_convert(
		.hsync_count(row_count),
		.vsync_count(column_count),
		.pixeladdress(pixeladdress)
);

ROMink minkhoa(
	.address(pixeladdress),
	.clock(clock),
	.data(16'b0),
	.wren(1'b0),
	.q(rgb_input)
);
					    
endmodule
