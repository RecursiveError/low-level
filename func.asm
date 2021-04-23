;Programa:Func.asm
;Autor: RecursiveError
;Exemplo de funções em ASM
;escreve o numero em HEX na saida
section .data

nova_linha: db 10
codes: db '0123456789ABCDEF'
demo1: dq 0x1122334455667788
demo2: db 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88

section .text
global _start

_pula_linha:
    mov rax, 1
    mov rdi, 1
    mov rsi, nova_linha
    mov rdx, 1
    syscall
ret

_print_hex:
    mov rax, rdi
    mov rdi, 1
    mov rdx, 1
    mov rcx, 64
    .loop:
        push rax
        sub rcx, 4
        sar rax, cl
        and rax, 0xf

        lea rsi, [codes + rax ]
        mov rax, 1 
        push rcx
        syscall

        pop rcx
        pop rax
        test rcx, rcx
        jnz .loop
    call _pula_linha
    ret

_start:
    ; semelhente a void _print_hex(demo1); de forma analoga
    mov rdi, [demo1] 
    call _print_hex 
    
    mov rdi, [demo2]
    call _print_hex
    

    mov rax, 60
    xor rdi, rdi
    syscall
