module LED_FLASH(clk,sw,led);
  input         clk;
  input  [1:0]   sw;    // 入力をsw[1:0]とする.
  output [15:0] led;
  wire        mxout;    // マルチプレクサの出力
   
  reg      CLK025Hz;    // 0.25Hzのクロック変数, レジスタ型
  reg      CLK05Hz;
  reg      CLK1Hz;
  reg      CLK2Hz;

  reg   [31:0] Count1;    // カウンタ, 32ビットのレジスタ型
  reg   [31:0] Count2;
  reg   [31:0] Count3;
  reg   [31:0] Count4;

  parameter num1 = 199_999_999;
  parameter num2 = 99_999_999;
  parameter num3 = 49_999_999;
  parameter num4 = 24_999_999;

  // プリスケーラ PS(0.25Hz)
  always@(posedge clk)begin
    if(Count1 >= num1)begin
        CLK025Hz <= ~CLK025Hz;   // 0.25Hzのクロックを反転
        Count1 <= 0;
    end
    else
        Count1 <= Count1 + 1;
  end

  // プリスケーラ PS(0.5Hz)
    always@(posedge clk)begin
    if(Count2 >= num2)begin
        CLK05Hz <= ~CLK05Hz;   // 0.5Hzのクロックを反転
        Count2 <= 0;
    end
    else
        Count2 <= Count2 + 1;
  end

  // プリスケーラ PS(1Hz)
    always@(posedge clk)begin
    if(Count3 >= num3)begin
        CLK1Hz <= ~CLK1Hz;   // 1Hzのクロックを反転
        Count3 <= 0;
    end
    else
        Count3 <= Count3 + 1;
  end

  // プリスケーラ PS(2Hz)
    always@(posedge clk)begin
    if(Count4 >= num4)begin
        CLK2Hz <= ~CLK2Hz;   // 2Hzのクロックを反転
        Count4 <= 0;
    end
    else
        Count4 <= Count4 + 1;
  end

  // マルチプレクサ
  assign mxout = (sw[1:0]==0)? CLK025Hz : 
                 (sw[1:0]==1)? CLK05Hz :
                 (sw[1:0]==2)? CLK1Hz :
                               CLK2Hz;

assign led = { 16{mxout} };    // {mxout, mxout, ...}の意

endmodule
