# 322060187 Gali Seregin
.section	    .rodata
Case5060:	    .string "first pstring length: %d, second pstring length: %d \n"
Case52:	        .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
Case5354:     	.string "length: %d, string: %s\n"
Case55:         .string "compare result: %d\n"
invalid:	    .string	"invalid option!\n"
char:       	.string " %c"
int:		    .string "%d"
int_scan:	    .string	"%d %d"
.align	8

.cases:
	.quad	.case5060
	.quad	.case51     # fake case
	.quad	.case52
	.quad	.case53
	.quad	.case54
	.quad	.case55
.text
.globl run_func
	.type run_func, @function
run_func:
    leaq	-50(%rdi), %rdi	#   getting last number 0,2,3,4,5
	cmpq	$10, %rdi       #   if it is 60 
	je      .case5060       #   go to the 5060 case  
	cmpq	$0, %rdi		#   if less then 0
	jb	    .invalid		#   invalid
	cmpq	$5, %rdi		#   if more then 5
	ja	    .invalid		#   invalid
	jmp	*   .cases(,%rdi,8)	#   swich cases

.case5060:
	pushq	%r14            #   push
	pushq	%r15            #   push
	movq	%rsi, %rdi	    #   1 string
	xor	    %rax, %rax      #   rax=0
	call	pstrlen         #   pstrlen
	movq	%rax, %r14	    #   save len in 14
	movq	%rdx, %rdi	    #   2 string
	xor	    %rax, %rax      #   rax=0
	call	pstrlen         #   pstrlen
	movq	%rax, %r15	    #   save len in 15
	movq	%r14, %rsi	    
	movq	%r15, %rdx      
	movq	$Case5060, %rdi #   go to case 5060
	xor	    %rax, %rax      
	call	printf          #   print it
	popq	%r15            #   free
	popq	%r14            #   free
	ret

.case51:
	ret                     #   fake case

.case52:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	movq	%rsi, %r14
	movq	%rdx, %r15
	subq	$1, %rsp	    #   add place in stuck
	movq	$char, %rdi
	movq	%rsp, %rsi
	xor	    %rax, %rax	    #   rax=0
	call	scanf		    #   scan
	movzbq 	(%rsp), %r12
	movq	$char, %rdi	    #   scan char
	movq	%rsp, %rsi
	xor	    %rax, %rax  	#   rax=0
	call	scanf		    #   scan
	movzbq 	(%rsp), %r13
	addq    $1, %rsp
	movq	%r12, %rsi
	movq	%r13, %rdx
	movq 	%r14, %rdi
	call 	replaceChar     #   replaceChar
	movq 	%rax, %rcx
	movq 	%r15, %rdi
	call 	replaceChar
	movq 	%rax, %r8
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq 	$Case52, %rdi   #   print massege 52 
	addq	$1, %rcx
	addq	$1, %r8
	xor 	%rax, %rax
	call 	printf
	popq	%r12            #   free memory
	popq	%r13
	popq	%r14
	popq	%r15
	ret

.case53:
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rsi, %r14
	movq	%rdx, %r15
	subq 	$1, %rsp
	movq 	$char, %rdi	    #    scan i
	leaq 	(%rsp), %rsi
	xor 	%rax, %rax	    
	call 	scanf
	movq 	(%rsp), %r12	#   save i in r12
	addq	$1, %rsp	    #   deallocate i
	subq 	$1, %rsp	    #   allocate memory for j
	movq 	$char, %rdi	    #   scan j
	leaq 	(%rsp), %rsi
	xor 	%rax, %rax
	call 	scanf
	movq 	(%rsp), %r13	#   save j in r13
	addq	$1, %rsp	    #   deallocate j
	movq 	%r14, %rsi	    #   1 str in rdi
	movq 	%r15, %rdi	    #   2 str to rsi
	movq 	%r12, %rdx    	#    i to rdx
	movq 	%r13, %rcx 	    #   j to rcx
	xor 	%rax, %rax 	   
	call 	pstrijcpy
	movq	%rax, %r14
	movq 	%rax, %rdi
	xor 	%rax, %rax
	call 	pstrlen 
	movq 	%rax, %rsi
	movq	%r14, %rdx
	addq	$1, %rdx
	movq 	$Case5354, %rdi	 #  print case5354
	xor	    %rax, %rax
	call	printf
	movq 	%r15, %rdi
	xor 	%rax, %rax
	call 	pstrlen 
	movq 	%rax, %rsi
	movq	%r15, %rdx
	addq	$1, %rdx
	movq 	$Case5354, %rdi
	xor	    %rax, %rax
	call	printf
	movq	%r15, %rdx
	movq 	$Case5354, %rdi
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	ret

.case54:
	pushq	%r14
	pushq	%r15
	movq	%rsi, %r14
	movq	%rdx, %r15
	movq 	%r14, %rdi 	        #   swap case
	pushq 	%rdi
	call 	swapCase
	popq	%rdi
	movq 	%rax, %rdx
	movq 	%rax, %rdi
	call 	pstrlen
	movq 	%rax, %rsi
	movq 	%r15, %rdi      	#   swap case
	pushq 	%rdi
	call 	swapCase
	popq	%rdi
	movq 	%rax, %r8
	movq 	%rax, %rdi
	call 	pstrlen
	movq 	%rax, %rcx
	addq	$1, %rdx	        #   delete str len to not print
	addq	$1, %r8
	movq 	$Case5354, %rdi	    #   print case 5354
	xor 	%rax, %rax
	pushq 	%r8		            #   save registers
	pushq 	%rcx
	call 	printf
	popq 	%rcx
	popq 	%r8
	movq 	$Case5354, %rdi   	#  print case 5354
	movq	%rcx, %rsi
	movq	%r8, %rdx
	xor 	%rax, %rax
	call 	printf
	popq	%r15
	popq	%r14
	ret

.case55:
    subq    $8, %rsp            # 8 byte for i j
    pushq   %rdx                #  str2
    pushq   %rsi                #   str1
    movq    $int_scan,  %rdi    #   scan
    leaq    16(%rsp),   %rsi
    leaq    20(%rsp),   %rdx
    movq    $0, %rax
    call    scanf
    popq    %rdi                #    make the pstrijcpy
    movq    %rdi,   %r12        
    popq    %rsi
    movq    %rsi,   %r14
    movl    (%rsp), %edx
    movl    4(%rsp),    %ecx
    call    pstrijcmp
    movq    $Case55,  %rdi      #   print case55 string
    xorq    %rsi,   %rsi
    movq    %rax,   %rsi
    movq    $0, %rax
    call    printf
    movq    $0, %rax
    movq    $0, %rax
    addq    $8, %rsp
    jmp     .end                #   finish

.invalid:
	movq	$invalid, %rdi  #   print invalid string
	xor	%rax, %rax
	call 	printf
	ret

.end:
    movq    %rbp,   %rsp
    popq    %rbp
    ret
