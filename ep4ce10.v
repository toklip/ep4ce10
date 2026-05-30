module ep4ce10(
  input clk_40m,
  output [3:0] led
);

wire clk_128k;
reg [7:0] r500hz;
wire clk_500hz= r500hz[7];
always @( posedge clk_128k)
  r500hz <= r500hz+8'b1;
reg [6:0] r4hz;
wire ce_4hz= (r4hz == 8'd124);
always @( posedge clk_500hz)
  if( r4hz < 7'd124)
    r4hz <= r4hz+7'b1;
  else
    r4hz <= 7'b0;
reg [3:0] led_ring;
initial
  led_ring <= 4'b1110;
always @( posedge clk_500hz)
  if( ce_4hz)
    led_ring <= {led_ring[2:0],led_ring[3]};
assign led= led_ring;
pll pll_inst(
  .inclk0( clk_40m),
  .c0( clk_128k)
);
endmodule
