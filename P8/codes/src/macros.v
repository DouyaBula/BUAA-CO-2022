// �쳣���жϱ���
`define None 5'd31          //���쳣
`define Int 5'd0            //�ⲿ�ж�
`define AdEL 5'd4           //ȡָ�쳣 �� ȡ���쳣
`define AdES 5'd5           //�����쳣
`define Syscall 5'd8        //ϵͳ����
`define RI 5'd10            //δָ֪��
`define Ov 5'd12            //����쳣

// ��ַ�ռ���� 
`define DataMemStart 32'h0000_0000
`define DataMemEnd 32'h0000_2FFF

`define IMStart 32'h0000_3000
`define IMEnd 32'h0000_6FFF

`define Timer0Start 32'h0000_7F00
`define Timer0End 32'h0000_7F0B

`define UARTStart 32'h0000_7F30
`define UARTEnd 32'h0000_7F4B

`define DigitalTubeStart 32'h0000_7F50
`define DigitalTubeEnd 32'h0000_7F57

`define DipSwitch0_3Start 32'h0000_7F60
`define DipSwitch0_3End 32'h0000_7F63

`define DipSwitch4_7Start 32'h0000_7F64
`define DipSwitch4_7End 32'h0000_7F67

`define UserKeyStart 32'h0000_7F68
`define UserKeyEnd 32'h0000_7F6B
// ��32λ�Ĵ���, ��ֻ�õ���8λ, ����һ���ֽ�.

`define LEDStart 32'h0000_7F70
`define LEDEnd 32'h0000_7F73

// ��������
// baud = clk_freq / num_cycles
`define PERIOD_BAUD_9600    32'd2604    // 10^9ns / 9600baud / 40ns(25MHz)  
`define PERIOD_BAUD_38400   32'd651
`define PERIOD_BAUD_57600   32'd434
`define PERIOD_BAUD_115200  32'd217

