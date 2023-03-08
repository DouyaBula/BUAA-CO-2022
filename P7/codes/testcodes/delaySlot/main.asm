.data
.globl TC0_BASE TC1_BASE cnt0 cnt1 cnt0_double cnt1_double
TC0_BASE: .word 0x7f00
TC1_BASE: .word 0x7f10
cnt0: .word 5
cnt1: .word 5
cnt0_double: .word 0
cnt1_double: .word 0
	
.text 
	ori	$28, $0, 0x0000
	ori	$29, $0, 0x0f00
	mtc0	$0, $12
	
	#save start address 
	ori 	$t0, $0, 0x7f00
	sw 	$t0, 0($0)
	ori 	$t1, $0, 0x7f10
	sw 	$t1, 4($0)
	
	#set SR included IM, IE, EXL
	ori 	$t0,$0, 0x0c01
	mtc0 	$t0,$12
	
	#set Timer0
	la 	$t1, TC0_BASE
	lw 	$t1, 0($t1)
	sw 	$0, 0($t1)		# disable Timer0.CTRL
	
	addi 	$t0, $0, 0x80		# set Timer0.PRESET
	sw 	$t0, 4($t1)
	addi 	$t0, $0, 9		# set Timer0.CTRL
	sw 	$t0, 0($t1)
	
	#set Timer1
	la 	$t1, TC1_BASE
	lw 	$t1, 0($t1)
	sw 	$0, 0($t1)		# disable Timer1.CTRL
	
	addi 	$t0, $0, 0x40		# set Timer1.PRESET
	sw 	$t0, 4($t1)
	addi 	$t0, $0, 9		# set Timer1.CTRL
	sw 	$t0, 0($t1)
	
	lui	$8, 0x7fff
	lui	$9, 0x7fff
	ori	$8, $8, 0xffff
	beq $zero, $zero, slot_ov1
	add	$10, $8, $9	        # �����ӳٲ��� add ���Ͻ����
slot_ov1:
	lui     $t0,0x8000
	jal	slot_ov2
	addi	$10, $8, -1     # �����ӳٲ��� addi ���½����
slot_ov2:
	ori	$t1, $0, 0x0ba0
	lui	$8, 0x8000
	lui	$9, 0x1000
	beq $zero, $zero, slot_ov3
	sub	$10, $8, $9			# �����ӳٲ��� sub ���½����
slot_ov3:
	ori	$t2, $0, 0x93ac
	lui	$8, 0x7fff
	lui	$9, 0x7fff
	beq $zero, $zero, slot_ov4
	add     $10, $8, $9		# �����ӳٲ��� add ���½����
slot_ov4:
	ori     $t2, $0, 0x5daa
	lui	$8, 0x7fff
	lui	$9, 0x8000
	sub	$10, $8, $9			# �����ӳٲ��� sub ���Ͻ����
	lui	$8, 0x8111
	lui	$9, 0x8111
	add     $10, $8, $9
	addi    $10, $8,-2
	beq     $0,$0,slot_adel1
	addi    $10, $8,-3
	add     $10, $8, $9
	sub	$10, $8, $9
slot_adel1:	
slot_adel2:
	addi $8, $zero, 0x801
	addi $9, $zero, 0x800
	sw      $9,0($9)
	lh      $9,0($8)         # ����lh��ַ�쳣��������λΪ1
	beq $zero, $zero, slot_adel3
	nop
	
slot_adel3:
	addi $8, $zero, 0x802
	lw      $9,0($8)         # ����lw��ַ�쳣��������λΪ2
	beq $zero, $zero, slot_adel4
	nop
	
slot_adel4:
	addi $8, $zero, 0x803
	lh      $9,0($8)        # ����lhu��ַ�쳣��������λΪ3
                            # �Ѹ�Ϊlh
	beq $zero, $zero, slot_adel5
	nop
	
slot_adel5:
	addi $8, $zero, 0x803
	lw      $9,0($8)         # ����lw��ַ�쳣��������λΪ3
	beq $zero, $zero, slot_ades1
	nop
	
slot_ades1:
	addi $8, $zero, 0x801
	sh      $9,0($8)         # ����sh��ַ�쳣��������λΪ1
	beq $zero, $zero, slot_ades2
	nop
	
slot_ades2:
	addi $8, $zero, 0x802
	sw      $9,0($8)         # ����sw��ַ�쳣��������λΪ2
	beq $zero, $zero, slot_ades3
	nop
slot_ades3:
	addi $8, $zero, 0x801
	sw      $9,0($8)         # ����sw��ַ�쳣��������λΪ1
	beq $zero, $zero, slot_combination
	nop
	
slot_combination:
	lui      $s0,0x8000 # �쳣��ϲ��ԣ������������쳣�в�ӳ˳�ָ����漰���ӳٲ��е��쳣���漰���ĳ�ͻ�С���add ���½����,addi���Ͻ����,sub���½����,sw�ĵ�ַ�쳣,sh�ĵ�ַ�쳣,lw�ĵ�ַ�쳣,lh�ĵ�ַ�쳣,lhu�ĵ�ַ�쳣.
	lui      $s1,0x7fff
	ori      $s1,$s1,0xffff
	add     $10,$s0,$s0
	sub     $10,$s0,$s1
	addi    $10,$s1,10
	sw      $10,0x1002($0)
	sh      $10,0x1001($0)
	mult    $10,$10
	lw      $10,0x1002($0)
	lh      $10,0x1001($0)
	mult    $10,$10
	lh      $10,0x1001($0)
	sub     $10,$s0,$s1
	addi    $10,$s1,10
	sw      $10,0x1002($0)
	sh      $10,0x1001($0)
	mult    $10,$10
	sw      $10,0x1002($0)
	sh      $10,0x1001($0)
	lw      $10,0x1002($0)
	lh      $10,0x1001($0)
	mult    $10,$10
	sh      $10,0x1001($0)
	add     $10,$s0,$s0
	sub     $10,$s0,$s1
	mult    $10,$10
	add     $10,$s0,$s0
	sub     $10,$s0,$s1
	beq $zero, $zero, label_1
	add     $10,$s0,$s0
	sub     $10,$s0,$s1
label_1:
	mult    $10,$10
	add     $10,$s0,$s0
	sub     $10,$s0,$s1
	mult    $10,$10
	sh      $10,0x1001($0)
	lw      $10,0x1002($0)
	add     $10,$s0,$s0
	bne     $0,$10,label_2
	lw      $10,0x1002($0)
	sh      $10,0x1001($0)
label_2:
	sub     $10,$s0,$s1
	mult    $10,$10
	sh      $10,0x1001($0)
	lw      $10,0x1002($0)
	nop
	
	ori	$t0, $0, 0x0005
wait:						# ����ÿ���������Ƿ�ǡ���ж� 5 ��
	lw	$k0, 8($0)
	lw	$k1,12($0)
	bne	$k0, $t0, wait
	nop
	bne	$k1, $t0, wait
	nop
	ori	$t0, $0, 0xffff
	ori	$t1, $0, 0xffff	

dead_loop:
	beq $zero, $zero, dead_loop
	nop
