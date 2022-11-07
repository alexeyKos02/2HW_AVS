	.file	"main.c"
	.intel_syntax noprefix
	.text
	.local	START							# ������ � ������� ���� ���������.
	.comm	START,1000,32					# ��������� ������ �� ������.
	.local	SEARCHABLE						# ������� ���������.
	.comm	SEARCHABLE,1000,32				# ��������� ������ � ���������.
	.globl	randomDate						# ���������� ������� ��������� ��������� ������.
	.type	randomDate, @function
randomDate:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16								# ��� ������� ���������� time(null)
	mov	edi, 0								#
	call	time@PLT						# ��� ������� ���� 
	mov	edi, eax							# ���������� scrand
	call	srand@PLT						#
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 274877907
	shr	rdx, 32
	sar	edx, 6
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	mov	DWORD PTR -12[rbp], edx
	mov	edx, DWORD PTR -12[rbp]
	imul	edx, edx, 1000
	sub	eax, edx
	mov	DWORD PTR -12[rbp], eax				# � ���������� rand_count ������ ������������ ��������
	mov	DWORD PTR -4[rbp], 0				# � ����� for � ���������� i ������ 0
	jmp	.L2									# ������� � �����.
.L3:
	call	rand@PLT
	cdq
	shr	edx, 25
	add	eax, edx
	and	eax, 127
	sub	eax, edx
	mov	ecx, eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, START[rip]
	mov	BYTE PTR [rax+rdx], cl				# � ������ START ��������� ������
	add	DWORD PTR -4[rbp], 1				# ����������� i �� ������� 
.L2:
	mov	eax, DWORD PTR -4[rbp]				# � eax ������ �������� i
	cmp	eax, DWORD PTR -12[rbp]				# ���������� i � rand_count
	jl	.L3									# ������� � ����.
	mov	DWORD PTR -8[rbp], 0				# �� ������ ����� ����������� i �������.
	jmp	.L4
.L5:
	call	rand@PLT
	cdq
	shr	edx, 25
	add	eax, edx
	and	eax, 127
	sub	eax, edx
	mov	ecx, eax
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, SEARCHABLE[rip]
	mov	BYTE PTR [rax+rdx], cl			# ��������� � ��������� ������.
	add	DWORD PTR -8[rbp], 1			# ����������� i �� �������.
.L4:
	mov	eax, DWORD PTR -8[rbp]			# ���������� � eax �������� i
	cmp	eax, DWORD PTR -12[rbp]			# ���������� i  � rand_count
	jl	.L5								# ������� � ����.
	nop
	nop
	leave
	ret
	.size	randomDate, .-randomDate
	.section	.rodata
.LC0:
	.string	"-c"
.LC1:
	.string	"incorrect input"
.LC2:
	.string	"string not found"
	.align 8
.LC3:
	.string	"The search string starts with the character %ld\n"
.LC4:
	.string	"-f"
.LC5:
	.string	"r"
.LC6:
	.string	"w"
.LC7:
	.string	"%s"
.LC8:
	.string	"not found"
	.align 8
.LC9:
	.string	"The search string starts with the character "
.LC10:
	.string	"%s%ld\n"
.LC11:
	.string	"-r"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160
	mov	DWORD PTR -148[rbp], edi
	mov	QWORD PTR -160[rbp], rsi
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]				# � rax �������� argv[1]
	lea	rdx, .LC0[rip]						# � rsi �������� ������ "-c"
	mov	rsi, rdx							# � rsi �������� ������
	mov	rdi, rax							# �������� argv[1]
	call	strcmp@PLT						# ���������� ���������
	test	eax, eax
	jne	.L7									# ������� � else if
	sub	DWORD PTR -148[rbp], 2				# �������� �� args ���
	cmp	DWORD PTR -148[rbp], 2				# ���������� args � �������
	je	.L8									# ���� �� ����������, ���������� ����
	lea	rax, .LC1[rip]						# � rax ������ ������ "incorrect input"
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						# �������� ������� ����������� �� �������.
	mov	eax, 0
	jmp	.L19								# return 0.
.L8:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24								
	mov	rdx, QWORD PTR [rax]				#  �������� argv[3]
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16								
	mov	rax, QWORD PTR [rax]				#  �������� argv[2]
	mov	rsi, rdx
	mov	rdi, rax
	call	Find@PLT						# �������� ������� find
	mov	QWORD PTR -40[rbp], rax				# � istr ������ �������� find.
	cmp	QWORD PTR -40[rbp], 0				# istr ��������� � null 
	jne	.L10
	lea	rax, .LC2[rip]						# � rax ������ ������ "string not found\n"				
	mov	rdi, rax
	call	puts@PLT
	jmp	.L11								
.L10:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rdx, QWORD PTR [rax]				# � rdx ������ �������� argv[2]
	mov	rax, QWORD PTR -40[rbp]				# � rax ������ �������� istr
	sub	rax, rdx							# �������� �� rax rdx
	add	rax, 1								# ���������� � rax �������.
	mov	rsi, rax
	lea	rax, .LC3[rip]						# � rax ������ ������ "The search string starts with the character %ld\n"			
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	jmp	.L11
.L7:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]				# � rax ������ �������� argv[1]
	lea	rdx, .LC4[rip]						# � rdx ������ ������ "-f"
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT						# ���������� ������ �� �������� argv[1]
	test	eax, eax
	jne	.L12
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]				# � rax ������ argv[2]
	lea	rdx, .LC5[rip]						# � rdx ������ "r"
	mov	rsi, rdx							
	mov	rdi, rax
	call	fopen@PLT						# �������� ������� fopen
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]				# � rax ������ argv[3]				
	lea	rdx, .LC6[rip]						# � rdx ������ "w"
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT						# �������� ������� fopen
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -16[rbp]				
	lea	rdx, START[rip]						# � rdx �������� ������ ������ START 
	lea	rcx, .LC7[rip]						# � rcx ������ "%s"					
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT				# ���������� fscanf
	cmp	eax, 1								#���������� ������������ ������ � ��������
	je	.L13
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 15
	mov	esi, 1
	lea	rax, .LC1[rip]						# � rax ������ "incorrect input"		
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L19
.L13:
	mov	rax, QWORD PTR -16[rbp]				
	lea	rdx, SEARCHABLE[rip]				# � rdx ������ ������ ������.
	lea	rcx, .LC7[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	je	.L14
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 15
	mov	esi, 1
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L19
.L14:
	lea	rdx, -144[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC7[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	jne	.L15
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 15
	mov	esi, 1
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L19
.L15:
	lea	rax, SEARCHABLE[rip]
	mov	rsi, rax
	lea	rax, START[rip]
	mov	rdi, rax
	call	Find@PLT
	mov	QWORD PTR -32[rbp], rax
	cmp	QWORD PTR -32[rbp], 0
	jne	.L16
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 9
	mov	esi, 1
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	fwrite@PLT
	jmp	.L11
.L16:
	lea	rdx, START[rip]
	mov	rax, QWORD PTR -32[rbp]
	sub	rax, rdx
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rdx
	lea	rdx, .LC9[rip]
	lea	rsi, .LC10[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	jmp	.L11
.L12:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]				# � rax �������� argv[1]
	lea	rdx, .LC11[rip]						# � rdx �������� "-r"
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT						# ���������� ������� ���������
	test	eax, eax
	jne	.L17
	mov	eax, 0
	call	randomDate						# ���������� ������� randomDate
	lea	rax, SEARCHABLE[rip]
	mov	rsi, rax							# � rsi �������� ������ �� ������ ����� SEARCHABLE
	lea	rax, START[rip]
	mov	rdi, rax							# � rdi �������� ������ �� ������ ����� START
	call	Find@PLT						# ���������� ������� find
	mov	QWORD PTR -8[rbp], rax
	lea	rax, START[rip]
	mov	rdi, rax							
	call	puts@PLT						# printf(START)			
	lea	rax, SEARCHABLE[rip]
	mov	rdi, rax
	call	puts@PLT						# printf(SEARCHABLE)		
	cmp	QWORD PTR -8[rbp], 0				# ��������� istr � null
	jne	.L18
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT						# printf("string not found\n")					
	jmp	.L11
.L18:
	lea	rdx, START[rip]
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, rdx
	add	rax, 1
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						# printf ("The search string starts with the character %ld\n", istr - (const char *) START + 1);
	jmp	.L11
.L17:
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						# printf("incorrect input");
.L11:
	mov	eax, 0
.L19:
	leave
	ret
	.size	main, .-main
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
