// sobel edge detection
//        sobel edge detection

//        | 1 0 -1 |           | 1 2 1 |
//        | 2 0 -2 |           | 0 0 0 |
//        | 1 0 -1 |           |-1 -2 -1 |


module edge_detection(
    input [23:0]colour_i0,
    input [23:0]colour_i1,
    input [23:0]colour_i2,
    input [23:0]colour_i3,
    input [23:0]colour_i4,
    input [23:0]colour_i5,
    input [23:0]colour_i6,
    input [23:0]colour_i7,
    input [23:0]colour_i8,
    output [23:0]colour_out);

    wire[7:0]red0, red1, red2, red3, red4, red5, red6, red7, red8;
    wire[7:0]green0, green1, green2, green3, green4, green5, green6, green7, green8;
    wire[7:0]blue0, blue1, blue2, blue3, blue4, blue5, blue6, blue7, blue8;

    wire[31:0] red_x, blue_x;
    reg[31:0] green_x;

    assign red0 = colour_i0[23:16];
    assign red1 = colour_i1[23:16];
    assign red2 = colour_i2[23:16];
    assign red3 = colour_i3[23:16];
    assign red4 = colour_i4[23:16];
    assign red5 = colour_i5[23:16];
    assign red6 = colour_i6[23:16];
    assign red7 = colour_i7[23:16];
    assign red8 = colour_i8[23:16];

    assign green0 = colour_i0[15:8];
    assign green1 = colour_i1[15:8];
    assign green2 = colour_i2[15:8];
    assign green3 = colour_i3[15:8];
    assign green4 = colour_i4[15:8];
    assign green5 = colour_i5[15:8];
    assign green6 = colour_i6[15:8];
    assign green7 = colour_i7[15:8];
    assign green8 = colour_i8[15:8];

    assign blue0 = colour_i0[7:0];
    assign blue1 = colour_i1[7:0];
    assign blue2 = colour_i2[7:0];
    assign blue3 = colour_i3[7:0];
    assign blue4 = colour_i4[7:0];
    assign blue5 = colour_i5[7:0];
    assign blue6 = colour_i6[7:0];
    assign blue7 = colour_i7[7:0];
    assign blue8 = colour_i8[7:0];

//        | 1 0 -1 |           | 1 2 1 |
//        | 2 0 -2 |           | 0 0 0 |
//        | 1 0 -1 |           |-1 -2 -1 |
//    | 0 1 2 |
//    | 3 4 5 |
//    | 6 7 8 |
    assign red_x = red0 - red2 +2*red3 -2*red5 + red6 - red8;
    assign blue_x = red0 +2*red1 + red2 - red6 - 2*red7 - red8;

    always@(*)begin

     if(red_x > 1024 & blue_x > 1024)begin
        green_x = -(red_x + blue_x)/2;
    end else if(red_x > 1024 & blue_x < 1024)begin
      green_x = (-red_x  + blue_x)/2;
    end else if(red_x < 1024 & blue_x < 1024)begin
      green_x = (red_x + blue_x)/2;
    end else begin
      green_x = (red_x - blue_x)/2;
    end

    end

    assign colour_out[23:16] = green_x;
    assign colour_out[15:8] = green_x;
    assign colour_out[7:0] = green_x;


endmodule