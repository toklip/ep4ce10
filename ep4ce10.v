module ep4ce10(
  input clk_40m,
  output [3:0] led
);

reg [7:0] r160k;
wire clk_160k= r160k[7];
always @( posedge clk_40m)
  if( r160k < 8'd249)
    r160k <= r160k+8'b1;
  else
    r160k <= 8'b0;
reg [7:0] r800hz;
wire clk_800hz= r800hz[7];
always @( posedge clk_160k)
  if( r800hz < 8'd199)
    r800hz <= r800hz+8'b1;
  else
    r800hz <= 8'b0;
reg [7:0] r4hz;
wire ce_4hz= (r4hz == 8'd199);
always @( posedge clk_800hz)
  if( r4hz < 8'd199)
    r4hz <= r4hz+8'b1;
  else
    r4hz <= 8'b0;
reg [3:0] led_ring;
initial
  led_ring <= 4'b1110;
always @( posedge clk_800hz)
  if( ce_4hz)
    led_ring <= {led_ring[2:0],led_ring[3]};
assign led= led_ring;
endmodule
