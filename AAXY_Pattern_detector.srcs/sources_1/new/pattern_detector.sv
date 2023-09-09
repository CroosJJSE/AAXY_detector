typedef enum logic [4:0] { 
    IDLE,
    SA,
    SAA,
    SAAX,
    SAAXY      
} states;

module pattern_detector  (
    input logic [7:0] data_in,
    input logic clk,
    input logic reset,
    input logic data_valid,
    output logic data_out,
    output  logic [2:0]state_data

);
 states state;


always_ff @(posedge clk or posedge reset) begin : FSM_block
    if (reset) begin
        state = IDLE;    
    end
    else begin case (state)
        IDLE: begin
        if (data_in=="A" & data_valid) begin
            state <= SA;
               
        end
        else state = IDLE;
             
        end
        SA: begin
            if (data_in == "A" & data_valid) begin
                state = SAA;
                
            end
            else state= IDLE;
        
         end

        SAA: begin
            if (data_in=="X" & data_valid) begin
                state = SAAX;                
            end
            else if (data_in=="A" & data_valid) begin
                state =SAA;
            end
            else state = IDLE;
         end

         SAAX: begin
            if (data_in== "Y" & data_valid ) begin
                state=SAAXY;
                 
            end
            else if (data_in=="A" & data_valid) begin
                state = SA;
            end
         end
         SAAXY: begin
            if(data_in=="A" & data_valid)begin
               
            end
            else state=IDLE;
         end
         default : state=IDLE;
        
    endcase
    end
end
always_ff @( posedge clk ) begin : state_Check
    unique case (state)
    IDLE: state_data<=3'b0;
    SA:   state_data<=3'd1;
    SAA:  state_data<=3'd2;
    SAAX: state_data<=3'd3;
    SAAXY : state_data<=3'd4;
        
    endcase
end

always_ff @( posedge clk ) begin : outputCheck
    unique case (state)
         
    SAAXY : data_out<=1'b1;
        default: data_out<=1'b0;
    endcase
end



    
endmodule