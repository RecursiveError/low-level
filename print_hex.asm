;programa print_hex
;Autor: RecursiveError
;exibe o valor em hexdecimal na saida

section .data
codes:
    db '0123456789ABCDF'


section .text
global _start
_start:
    mov rax, 0x4A

    mov rdi, 1
    mov rdx, 1
    mov rcx, 64
    .loop:
        push rax
        sub rcx, 4
        sar rax, cl
        and rax, 0b1111

        lea rsi, [codes + rax]
        mov rax, 1

        push rcx
        syscall

        pop rcx
        pop rax
        test rcx, rcx 
        jnz .loop

    mov rax, 60
    xor rdi, rdi
    syscall
