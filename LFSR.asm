%macro _output 2		;%1=format,%2=value
        push	%2
        push	%1
        call	printf
        add	esp,8
%endmacro
section .text
        global 	main
        extern 	printf
        LFSR_MASK	equ	0Ch 	;define LFSR MASK for  x^4+x^3+1
        LFSR_SEED	equ	0Fh 	;define SEED
main:
        xor	eax,eax			;eax=0
        xor	ebx,ebx			;ebx=0
        mov	eax,LFSR_SEED		;eax=LFSR_SEED


print_loop:
        call	shift_lfsr		;call to shif_lfsr procedure
        ;push	eax			;save eax on stack
        ;_output	format_out,eax		;print number
        ;pop	eax			;get eax
        cmp	eax,LFSR_SEED		;compare with seed
        jne	print_loop		;continue loop

        mov	al,1			;al=1
        xor	ebx,ebx			;ebx=0
        int	80h			;int 80h

shift_lfsr:
        mov	ebx,eax			;save eax in ebx
        and	ebx,1			;ebx=ebx AND 1
        shr	eax,1			;shift right eax with 1
        cmp	ebx,1			;compare ebx with 1
        jne	end			;if not equal, end
        mov	ebx,LFSR_MASK		;if equal, ebx=mask and
        xor	eax,ebx			; apply mask to eax
end:
        ret

section .data
        format_out	db	"0x%08x",10
