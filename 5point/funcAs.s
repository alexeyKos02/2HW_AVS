	.file	"func.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC1:
	.string	"ms"
.LC2:
	.string	"%lld %s\n"
	.text
	.globl	diff
	.type	diff, @function
diff:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi					# � ���� end
	mov	QWORD PTR -48[rbp], rdx					# � ���� ������ st
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rax						# ����������� � ������ �������� st.tv_sec � xmm1
	movsd	xmm0, QWORD PTR .LC0[rip]			# � xmm0 ������ �������� 10�8
	mulsd	xmm1, xmm0							# st.tv_sec *10e8
	mov	rax, QWORD PTR -24[rbp]					# � rax ������ st.tv_nsec
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax						# � xmm0 ������ st.tv_nsec
	addsd	xmm0, xmm1							# ���������� ��� �����
	cvttsd2si	rax, xmm0						# � rax ������ �������� �����
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]					# � rax ������ end.tv_sec
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rax						# � xmm1 ������ end.tv_sec			
	movsd	xmm0, QWORD PTR .LC0[rip]			# � xmm0 ������ �������� 10�8
	mulsd	xmm1, xmm0							
	mov	rax, QWORD PTR -40[rbp]					# end.tv_sec *10e8
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax						# � xmm0 ������ end.tv_nsec
	addsd	xmm0, xmm1							# ���������� ��� �����
	cvttsd2si	rax, xmm0						# ����������� � ������ � rax �����
	mov	QWORD PTR -16[rbp], rax					# � ���� ������ �������� ������ �����
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]					# tot1-tot2
	lea	rdx, .LC1[rip]
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT							# �������� ������� printf
	nop
	leave
	ret
	.size	diff, .-diff
	.globl	Find
	.type	Find, @function
Find:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR -56[rbp], rdi
	mov	QWORD PTR -64[rbp], rsi
	lea	rax, -32[rbp]							# � rax ������ �� st
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT					# ����� ������� clock_gettime
	mov	rdx, QWORD PTR -64[rbp]					# � rdx �������� searchable
	mov	rax, QWORD PTR -56[rbp]					# � rax �������� start
	mov	rsi, rdx
	mov	rdi, rax
	call	strstr@PLT							# ���������� ������� strstr
	mov	QWORD PTR -8[rbp], rax
	lea	rax, -48[rbp]							# � rax ������ �� end					
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT					# ����� ������� clock_gettime
	mov	rax, QWORD PTR -32[rbp]					# � rax ������ �� st
	mov	rdx, QWORD PTR -24[rbp]
	mov	rdi, QWORD PTR -48[rbp]				    # � rdi ������ �� end	
	mov	rsi, QWORD PTR -40[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	diff
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.size	Find, .-Find
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
