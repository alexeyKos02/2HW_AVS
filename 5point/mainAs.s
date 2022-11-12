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
	sub	rsp, 16								# две строчки реализация time(null)
	mov	edi, 0								#
	call	time@PLT						# три строчки вниз
	mov	edi, eax							# реализация scrand
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
	mov	DWORD PTR -12[rbp], eax				# в переменную rand_count кладем получившееся значение
	mov	DWORD PTR -4[rbp], 0				# в цикле for в переменную i кладем 0
	jmp	.L2									# переход к циклу.
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
	mov	BYTE PTR [rax+rdx], cl				# в строку START добавляет символ
	add	DWORD PTR -4[rbp], 1				# увеличивает i на единицу
.L2:
	mov	eax, DWORD PTR -4[rbp]				# в eax кладем значение i
	cmp	eax, DWORD PTR -12[rbp]				# сравниваем i с rand_count
	jl	.L3									# заходим в цикл.
	mov	DWORD PTR -8[rbp], 0				# во втором цикле присваивает i единицу.
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
	mov	BYTE PTR [rax+rdx], cl			# добавляет в подстроку символ.
	add	DWORD PTR -8[rbp], 1			# увеличивает i на единицу.
.L4:
	mov	eax, DWORD PTR -8[rbp]			# перемещает в eax значение i
	cmp	eax, DWORD PTR -12[rbp]			# сравнивает i  с rand_count
	jl	.L5								# заходит в цикл.
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
	mov	rax, QWORD PTR [rax]				# в rax кладется argv[1]
	lea	rdx, .LC0[rip]						# в rsi кладется строка "-c"
	mov	rsi, rdx							# в rsi кладется строка
	mov	rdi, rax							# кладется argv[1]
	call	strcmp@PLT						# вызывается сравнение
	test	eax, eax
	jne	.L7									# переход к else if
	sub	DWORD PTR -148[rbp], 2				# отнимаем из args два
	cmp	DWORD PTR -148[rbp], 2				# сравниваем args с двойкой
	je	.L8									# если не выполнется, пропускаем цикл
	lea	rax, .LC1[rip]						# в rax кладем строку "incorrect input"
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						# вызываем функция отображения не консоли.
	mov	eax, 0
	jmp	.L19								# return 0.
.L8:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]				#  получаем argv[3]
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]				#  получаем argv[2]
	mov	rsi, rdx
	mov	rdi, rax
	call	Find@PLT						# вызываем функцию find
	mov	QWORD PTR -40[rbp], rax				# в istr кладем значение find.
	cmp	QWORD PTR -40[rbp], 0				# istr сравнивем с null
	jne	.L10
	lea	rax, .LC2[rip]						# в rax кладем строку "string not found\n"
	mov	rdi, rax
	call	puts@PLT
	jmp	.L11
.L10:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rdx, QWORD PTR [rax]				# в rdx кладем значение argv[2]
	mov	rax, QWORD PTR -40[rbp]				# в rax кладем значение istr
	sub	rax, rdx							# вычитаем из rax rdx
	add	rax, 1								# прибавляем к rax единицу.
	mov	rsi, rax
	lea	rax, .LC3[rip]						# в rax кладем строку "The search string starts with the character %ld\n"
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	jmp	.L11
.L7:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]				# в rax кладем значение argv[1]
	lea	rdx, .LC4[rip]						# в rdx кладем строку "-f"
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT						# сравниваем строку со значение argv[1]
	test	eax, eax
	jne	.L12
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]				# в rax кладем argv[2]
	lea	rdx, .LC5[rip]						# в rdx кладем "r"
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT						# вызываем фукнция fopen
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]				# в rax кладем argv[3]
	lea	rdx, .LC6[rip]						# в rdx кладем "w"
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT						# вызываем фукнция fopen
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, START[rip]						# в rdx кладется начало строки START
	lea	rcx, .LC7[rip]						# в rcx кладем "%s"
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT				# вызывается fscanf
	cmp	eax, 1								#сравнивает возвращенные данные с единицей
	je	.L13
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 15
	mov	esi, 1
	lea	rax, .LC1[rip]						# в rax кладем "incorrect input"
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L19
.L13:
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, SEARCHABLE[rip]				# в rdx кладем начало строки.
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
	mov	rax, QWORD PTR [rax]				# в rax кладется argv[1]
	lea	rdx, .LC11[rip]						# в rdx кладется "-r"
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT						# вызывается функция сравнения
	test	eax, eax
	jne	.L17
	mov	eax, 0
	call	randomDate						# вызывается функция randomDate
	lea	rax, SEARCHABLE[rip]
	mov	rsi, rax							# в rsi кладется ссылка на начало слова SEARCHABLE
	lea	rax, START[rip]
	mov	rdi, rax							# В rdi кладется ссылка на начало слова START
	call	Find@PLT						# вызывается функция find
	mov	QWORD PTR -8[rbp], rax
	lea	rax, START[rip]
	mov	rdi, rax
	call	puts@PLT						# printf(START)
	lea	rax, SEARCHABLE[rip]
	mov	rdi, rax
	call	puts@PLT						# printf(SEARCHABLE)
	cmp	QWORD PTR -8[rbp], 0				# сравнение istr с null
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
