section .data
    msg: db 'ola mundo', 10
    msg2: db 'primeiro programa em asm', 10

section .text
global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 10
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, 25
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
