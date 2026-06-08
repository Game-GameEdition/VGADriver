module AddressConverter(
	input logic [9:0] hsync_count,
	input logic [9:0] vsync_count,
	output logic [18:0] pixeladdress
);

always_comb begin
	pixeladdress = (vsync_count*640)+hsync_count;
	end
	
endmodule	