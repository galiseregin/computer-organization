# 322060187 Gali Seregin
.section	.rodata
.align	8
int:	.string "%d"
string:	.string "%s"
.text
.globl run_main
	.type run_main, @function
run_main:
	pushq	%rbp		        #   put rbp
	movq	%rsp, %rbp	        #   rsp to rbp
	pushq	%r13 		        #   first string
	pushq	%r12 		        #   second string
	leaq	4(%rsp), %rsp
	movq	$int, %rdi	        #   prepear to scanf
	movq	%rsp, %rsi 	        #   prepear to scanf
	xor	    %rax, %rax	        #   rax=0
	call 	scanf		        #   scan
	movl	(%rsp), %r12d 	    #   length string		
	leaq	-4(%rsp), %rsp
	addq	$1, %r12	        #   \0
	subq	%r12, %rsp
	movq	$string, %rdi	    #   prepear scanf
	movq	%rsp, %rsi 	        #   prepear scanf
	xor	    %rax, %rax	        #   rax=0
	call 	scanf		        #   scan
	subq	$1, %r12 	        #   length string
	subq	$1, %rsp        	#   \0 in rsp
	movb	%r12b, (%rsp) 	    #   move
	movq	%rsp, %r12	        #   1 string  r12
	subq	$4, %rsp
	movq	$int, %rdi	        #   prepear to scan
	movq	%rsp, %rsi 	        #   prepear scanf
	xor	    %rax, %rax	        #   rax=0
	call 	scanf		        #   scan
	movl	(%rsp), %r13d 	    #   len string		
	addq	$4, %rsp            #   add for memory
	addq	$1, %r13	        #   \0
	subq	%r13, %rsp	        #   string
	movq	$string, %rdi	    #   prepear scanf
	movq	%rsp, %rsi 	        #   prepear scanf
	xor	    %rax, %rax	        #   rax=0
	call 	scanf		        #   scan
	subq	$1, %r13 	        #   len string
	subq	$1, %rsp 	        #   \0 in rsp
	movb	%r13b, (%rsp)       #   move
	movq	%rsp, %r13	        #   prepear scanf
	subq	$4, %rsp	        #   add 4 for int
	movq	$int, %rdi	        #   prepear scanf
	movq	%rsp, %rsi	        #   prepear scanf
	xor	    %rax, %rax	        #   rax=0
	call	scanf
	movl	(%rsp), %edi
	movq	%r13, %rdx	        #   string 2
	movq 	%r12, %rsi	        #   string 1
	call	run_func
	xor	    %rax, %rax	        #   rax=0
	popq	%r12                #   free 
	popq	%r13                #   free
	movq 	%rbp, %rsp
	popq	%rbp                #   free
	ret
