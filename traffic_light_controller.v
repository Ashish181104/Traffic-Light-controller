module traffic_light_controller(input clk,reset,
output reg[2:0]M1,output reg[2:0]M2,output reg[2:0]Mt,output reg[2:0]S);

reg[2:0] ps;
reg[31:0]dur;
wire t1;
reg[2:0] prev_ps;
wire rst_tim;


parameter S1=3'b001, S2=3'b010,S3=3'b011, S4=3'b100,S5=3'b101,S6=3'b110;
always@(posedge clk or posedge reset)begin
    if(reset)
     prev_ps<=S1;
    else
     prev_ps<=ps;
    end
  assign rst_tim=reset|(prev_ps!=ps);
    
    

timer A(.clk(clk),.rst(rst_tim),.dur(dur ),.timeup(t1));


always@(posedge clk or posedge reset )begin

   if(reset==1)begin
   dur<=32'd350_000_000; 
        
        M1<=3'b001;
        M2<=3'b001;
        Mt<=3'b100;
        S<=3'b100;
    ps<=S1;
    
    end
    else begin
    
    
    case(ps)
    
    S1:begin
    dur<=32'd35; 
        if(t1)ps<=S2;
        M1<=3'b001;
        M2<=3'b001;
        Mt<=3'b100;
        S<=3'b100;
        end
        
    S2:begin 
    dur<=32'd10;
     if(t1)ps<=S3;
      M1<=3'b001;
        M2<=3'b010;
        Mt<=3'b100;
        S<=3'b100;
     end
        
    S3: 
    begin dur<=32'd25;
    if(t1) ps<=S4;
     M1<=3'b001;
        M2<=3'b100;
        Mt<=3'b001;
        S<=3'b100;
    end
        
        
    S4:begin dur<=32'd10;
    if(t1)ps<=S5;
     M1<=3'b010;
        M2<=3'b100;
        Mt<=3'b010;
        S<=3'b100;
    end
        
    S5:begin dur<=32'd15;
     if(t1)ps<=S6;
      M1<=3'b100;
        M2<=3'b100;
        Mt<=3'b100;
        S<=3'b001;
     
     end
        
    S6: begin dur<=32'd15;
    if(t1)ps<=S1;
     M1<=3'b100;
        M2<=3'b100;
        Mt<=3'b100;
        S<=3'b010;
    
    end
    
    default:begin ps<=S1;
    dur <= 32'd350_000_000;
     M1<=3'b001;
        M2<=3'b001;
        Mt<=3'b100;
        S<=3'b100;
        end
    
    
    endcase
    end
end
endmodule

module timer(input clk,input rst,input[31:0]dur,output reg timeup);
reg[31:0]count;

always@(posedge clk or posedge rst)begin
if(rst) begin
count<=0;
timeup<=0;
end

else begin 
if(dur==0)begin
timeup<=0;
count<=0;
end

else if(count>=dur-1)begin
timeup<=1;
count<=0;
end
else begin
timeup<=0;
count<=count+1;
end

end

end






endmodule

