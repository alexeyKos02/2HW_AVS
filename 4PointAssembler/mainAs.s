	.file	"main.c"
	.intel_syntax noprefix
	.text
	.local	START							# строка в которой ищем подстроку.
	.comm	START,1000,32					# выделение памяти на строку.
	.local	SEARCHABLE						# искомая подстрока.
	.comm	SEARCHABLE,1000,32				# выделение памяти в подстроку.
	.globl	randomDate						# объявление функции рандомной генерации данных.
	.type	randomDate, @function
randomDate:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
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
	mov	DWORD PTR -12[rbp], eax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
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
	mov	BYTE PTR [rax+rdx], cl
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	jl	.L3
	mov	DWORD PTR -8[rbp], 0
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
	mov	BYTE PTR [rax+rdx], cl
	add	DWORD PTR -8[rbp], 1
.L4:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	jl	.L5
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
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L7
	sub	DWORD PTR -148[rbp], 2
	cmp	DWORD PTR -148[rbp], 2
	je	.L8
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L19
.L8:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	Find@PLT
	mov	QWORD PTR -40[rbp], rax
	cmp	QWORD PTR -40[rbp], 0
	jne	.L10
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	jmp	.L11
.L10:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -40[rbp]
	sub	rax, rdx
	add	rax, 1
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	jmp	.L11
.L7:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L12
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC6[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, START[rip]
	lea	rcx, .LC7[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	je	.L13
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 15
	mov	esi, 1
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L19
.L13:
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, SEARCHABLE[rip]
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
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC11[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L17
	mov	eax, 0
	call	randomDate
	lea	rax, SEARCHABLE[rip]
	mov	rsi, rax
	lea	rax, START[rip]
	mov	rdi, rax
	call	Find@PLT
	mov	QWORD PTR -8[rbp], rax
	lea	rax, START[rip]
	mov	rdi, rax
	call	puts@PLT
	lea	rax, SEARCHABLE[rip]
	mov	rdi, rax
	call	puts@PLT
	cmp	QWORD PTR -8[rbp], 0
	jne	.L18
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
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
	call	printf@PLT
	jmp	.L11
.L17:
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
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
