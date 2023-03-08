# ==== Address Mapping ==== #
# DataMem         0000 ~ 2FFF
# Timer0          7F00 ~ 7F0B
# UART            7F30 ~ 7F4B
# DigitalTube     7F50 ~ 7F57
# DipSwitch0~3    7F60 ~ 7F63
# DipSwitch4~7    7F64 ~ 7F67
# UserKey         7F68 ~ 7F6B
# LED             7F70 ~ 7F73
# 'C'             43
.text
addi    $t0, $zero, 0x2401
mtc0    $t0, $12        # Enable Interrupt

loop:

addi  $t0, $zero, 0x2
sw  $t0, 0x7F00($zero)  # TODO: stop Timer ��ǰ

lb  $s5, 0x7f68($zero)     # UserKey[7:0]
andi    $s0, $s5, 0x0001    # UserKey[0]      #TODO: �ֶ�����������0
andi    $s1, $zero, 0x0002    # UserKey[1]    #TODO: ����ɳ������
andi    $s2, $s5, 0x00FC    # UserKey[7:2], 2'b0    #TODO: ��ι��ܸı�
lw  $s3, 0x7F60($zero)  # DipSwitch0~3  TODO: �ڶ���������num2
lw  $s4, 0x7F64($zero)  # DipSwitch4~7  TODO: ��һ��������num1

beq $s0, $zero, Calculator  # UserKey[0] == 0, goto calculator
nop
Timer:
    beq $t1, $s3, loop      # wait for interrupt
    nop
    addi    $t0, $zero, 25000000
    sw  $t0, 0x7F04($zero)  # set preset
    addi    $t0, $zero, 0xB
    sw  $t0, 0x7F00($zero)  # set ctrl
    add $t1, $zero, $s3     # $t1 for count
    add $t2, $zero, $zero   # $t2: 0 --> $s3
    add $t3, $zero, $s3     # $t3: $s3 --> 0
    andi    $t4, $s2, 0x4   # $t4: UserKey[2]
    addi  $t0, $zero, 0x4
    beq $t4, $t0, UserKey2
    nop
        add $v0, $t2, $zero
        jal Display
        nop
        beq $zero, $zero, loop  # loop
        nop
    UserKey2:
        add $v0, $t3, $zero
        jal Display
        nop
        beq $zero, $zero, loop  # loop
        nop
Calculator:
    # addi  $t0, $zero, 0x2
    # sw  $t0, 0x7F00($zero)  # stop Timer
    ADD:                            # UserKey[2]
        addi    $t0, $zero, 0x4
        bne $s2, $t0, SUB
        nop
        add $v0, $s4, $s3
        jal Display
        nop
        beq $zero, $zero, loop
        nop
    SUB:                            # UserKey[3]
        addi    $t0, $zero, 0x8
        bne $s2, $t0, MULT
        nop
        sub $v0, $s4, $s3
        jal Display
        nop
        beq $zero, $zero, loop
        nop
    MULT:                           # UserKey[4]
        addi    $t0, $zero, 0x10
        bne $s2, $t0, DIV
        nop
        mult    $s4, $s3
        mflo    $v0
        jal Display
        nop
        beq $zero, $zero, loop
        nop
    DIV:                            # UserKey[5]
        addi    $t0, $zero, 0x20
        bne $s2, $t0, AND
        nop
        beq $s3, $zero, SPECIAL233
        nop 
        div $s4, $s3
        mflo    $v0
        SPECIAL233:
        add $v0, $zero, $zero
        jal Display
        nop
        beq $zero, $zero, loop
        nop
    AND:
        addi    $t0, $zero, 0x40
        bne $s2, $t0, OR
        nop
        and $v0, $s4, $s3
        jal Display
        nop
        beq $zero, $zero, loop
        nop
    OR:
        addi    $t0, $zero, 0x80
        bne $s2, $t0, Default
        nop
        or  $v0, $s4, $s3
        jal Display
        nop
        beq $zero, $zero, loop
        nop
    Default:
        beq $zero, $zero, loop
        nop

# Function
# v0�洢Ҫ��ʾ������
beq $zero, $zero, DisplayEnd
nop
Display:
andi    $s1, $v0, 1
beq $s1, $zero, UART_233
nop 
# ����ܺ�LED��ʾģʽ
slt $v1, $v0, $zero
sw  $v1, 0x7F54($zero)  # ����λ�����
sw  $v0, 0x7F50($zero)
sw  $v0, 0x7F70($zero)  # Ӳ���������LED, �������LED�Ĵ�����Ϊ�н�ת�͵�UART
beq $zero, $zero, dead_loop
nop

UART_233:
# UART��ʾģʽ
sw  $v0, 0x7F70($zero)  # LED�Ĵ�����Ϊ�н�
addi    $a0, $zero, 0x20
# �����ֽ�3
lb  $v0, 0x7F73($zero)
wait3:
nop                     # ��ȡtx״̬ʱͣһ��, �ȴ�д��
lb  $v1, 0x7F34($zero)
andi    $v1, $v1, 0x20
bne $v1, $a0, wait3
nop
sw  $v0, 0x7F30($zero)
# �����ֽ�2
lb  $v0, 0x7F72($zero)
wait2:
nop                     # ��ȡtx״̬ʱͣһ��, �ȴ�д��
lb  $v1, 0x7F34($zero)
andi    $v1, $v1, 0x20
bne $v1, $a0, wait2
nop
sw  $v0, 0x7F30($zero)
# �����ֽ�1
lb  $v0, 0x7F71($zero)
wait1:
nop                     # ��ȡtx״̬ʱͣһ��, �ȴ�д��
lb  $v1, 0x7F34($zero)
andi    $v1, $v1, 0x20
bne $v1, $a0, wait1
nop
sw  $v0, 0x7F30($zero)
# �����ֽ�0
lb  $v0, 0x7F70($zero)
wait0:
nop                     # ��ȡtx״̬ʱͣһ��, �ȴ�д��
lb  $v1, 0x7F34($zero)
andi    $v1, $v1, 0x20
bne $v1, $a0, wait0
nop
sw  $v0, 0x7F30($zero)

bne $s0, $zero, DisplayBack     # ��ʱ��ģʽ��, UART��������ѭ�� # ������
nop

dead_loop:
    # �ȴ�һ�� TODO: tb: 300����
    addi    $t0, $zero, 300
    sw  $t0, 0x7F04($zero)  # set preset
    addi    $t0, $zero, 0xB
    sw  $t0, 0x7F00($zero)  # set ctrl

    dead_loop_233:                      
        lb  $t0, 0x7F68($zero)
        bne $t0, $s5, loop
        nop
        beq $zero, $zero, dead_loop_233     # ��һ������ж�
        nop
# ���ع���
DisplayBack:
jr  $ra
nop
DisplayEnd:
# bottom

.ktext 0x4180
mfc0    $k0, $13
andi    $k0, $k0, 0xFC00
addi    $k1, $zero, 0x2000
beq $k0, $k1, UARTHandler   # HWInt == 001000, goto UARTHandler
nop
TimerHandler:
    add $s4, $zero, $v0
    bne $s4, $zero, ABCDE233  # �����һ����������Ϊ0, �����õڶ���ҲΪ0, �Ӷ���֤֮�������Ϊ0
    nop
    add $s3, $zero, $zero
    ABCDE233:
    la  $k1, Calculator # TODO: αָ��
    mtc0    $k1, $14
    # beq $zero, $zero, Calculator    # �����¼��� #�����������жϣ�
    nop
    nop
    nop
    eret

endTimerHandler:
    eret

UARTHandler:
    lw  $k0, 0x7F30($zero)
    addi    $k1, $zero, 43
    beq $k0, $k1, TAIL
    nop
    eret
    TAIL:
        addi    $k1, $zero, 0x21371136      # TODO: αָ����
        sw  $zero, 0x7F54($zero)
        sw  $k1, 0x7F50($zero)
        sw  $k1, 0x7f70($zero) 
        GOODBYE:
        beq $zero, $zero, GOODBYE
        nop