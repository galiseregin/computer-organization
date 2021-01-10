# 322060187 Gali Seregin
.section	.rodata
error: 		.string "invalid input!\n"
.text
.globl pstrlen
 	.type pstrlen, @function
pstrlen:
	movzbq	(%rdi), %rax    #   move arg to rdi and this is len
	ret

.globl replaceChar
 	.type replaceChar, @function
replaceChar:
	pushq	%r11
	pushq	%r10
	pushq	%rdi
	call	pstrlen     #    find len of str
	addq	$1, %rdi
	xor	    %r10, %r10
	xor	    %r11, %r11

.replace_loop: # if counter==len end else replace
	cmpq	%rax, %r10
	je	    .replace_end
	movb	(%rdi), %r11b
	cmpq	%r11, %rsi
	je 	    .replace

.replace_iterator: # counter ++ 
	addq	$1, %r10
	addq	$1, %rdi
	jmp	    .replace_loop

.replace:   # new instead old
	movb	%dl, (%rdi)
	jmp	    .replace_iterator

.replace_end:   #   free  all memory and finish
	popq	%rdi
	movq	%rdi, %rax
	popq	%r10
	popq	%r11
	ret

.globl pstrijcpy
 	.type pstrijcpy, @function
pstrijcpy:
	pushq 	%r15
	movq	%rdi, %r13
	movq	%rsi, %r14
	subb	$48, %dl
	subb	$48, %cl
	call 	pstrlen     # get len src
	movq 	%rax, %r10
	movq	%rsi, %rdi
	xor	    %rax, %rax
	call 	pstrlen     #   get len dsc
	movq	%rax, %r11
    cmpq 	$0, %rcx
	jl   	.pstrijcpy_erorr    #   j<0
	cmpq 	$0, %rdx
	jl 	    .pstrijcpy_erorr    #   i<0
	cmpq	%rcx, %rdx
	jg 	    .pstrijcpy_erorr    #   i>j
	cmpq 	%r10, %rcx
	jge 	.pstrijcpy_erorr    #   j> src
	cmpq 	%r11, %rcx
	jge 	.pstrijcpy_erorr    #   j>dsc
	addq	$1, %r13
	addq	$1, %r14
	addq	%rdx, %r13
	addq	%rdx, %r14

.pstrijcpy_loop:    # if count==j end else count++ 
	cmpq	%rcx, %rdx
	ja  	.pstrijcpy_end
	movb	(%r13), %r15b
	movb	%r15b, (%r14)
	addq	$1, %r13
	addq	$1, %r14
	addq	$1, %rdx
	jmp 	.pstrijcpy_loop

.pstrijcpy_erorr:   #   erorr
	movq	%rdi, %r15
	movq	$error, %rdi
	xor	    %rax, %rax
	call 	printf
	movq	%r15, %rdi

.pstrijcpy_end:
	movq	%rdi, %rax
	popq %r15
	ret

.globl swapCase
    .type swapCase, @function
swapCase:   #   swap every  chars i j
	pushq	%r15
	movq 	%rdi, %r15
	call	pstrlen
	addq	$1, %rdi
	xor	    %r10, %r10
	xor	    %r11, %r11

.swap_loop:	# if count==len end 
	cmpq	%rax, %r10
	je	    .swap_end
	movb	(%rdi), %r11b
	cmpb	$65, %r11b  	#   if == 'A' in asky
	jl	    .swap_iterator
	cmpb	$90, %r11b  	#   if == 'Z' in asky
	jle	    .low
	cmpb	$97, %r11b      #   if == 'a' in asky
	jl	    .swap_iterator
	cmpb	$122, %r11b	    #   if == 'z' in asky
	jle	    .upper
	jmp	    .swap_iterator  #   next letter

.swap_iterator: # counter++
	addq	$1, %r10
	addq	$1, %rdi
	jmp	    .swap_loop

.upper: #    add 32 to make low (using aski) 
	subq	$32, %r11
	movb	%r11b, (%rdi)
	jmp	    .swap_iterator
	
.low:   #    -32 to make upper (using aski)
	addq	$32, %r11
	movb	%r11b, (%rdi)
	jmp	.swap_iterator

.swap_end:
	movq	%r15, %rax
	popq	%r15
	ret

.globl pstrijcmp
    .type pstrijcmp, @function
pstrijcmp:
    pushq   %rbp
    movq    %rsp, %rbp
    cmpl    $0, %edx    # i<0
    jl      .mistake
    cmpb    (%rsi), %cl # j>src  
    jge     .mistake
    cmpb    (%rdi), %cl # j>dst
    jge     .mistake
    cmpl    %edx, %ecx  # i>j
    jl      .mistake
    jmp     .ok
.mistake:   #   print mistake
    movq    $0, %rax
    movq    $error, %rdi
    call    printf
    movq    $0, %rax
    xorq    %r8, %r8
    movq    $-2, %r8
    movq    %r8, %rax
    jmp     .finish
.ok:    #   dst +=1, src+=1
    movq    $0, %rax
    leaq    1(%rdx, %rdi), %rdi
    leaq    1(%rdx, %rsi), %rsi
.pstrijcmp_loop:
    movq    (%rdi), %r11    # r11==dst
    cmpb    %r11b, (%rsi)   # compear
    jl      .bigger         # case big
    cmpb    %r11b, (%rsi)   # compear
    jg      .smaller        # case small 
    jmp     .equal      
.bigger:   # put 1 in return
    movq    $1, %rax
    jmp     .finish
.smaller:   #   put -1 in retun
    movq    $-1, %rax
    jmp     .finish    
.equal:     #   while i<j loop
    incq    %rdi
    incq    %rsi
    incq    %rdx
    cmpl    %edx, %ecx
    jge     .pstrijcmp_loop
.finish:    # omg doneeeeee
    movq    %rbp, %rsp
    popq    %rbp
    ret
    