%define READ_ONLY 0
%define READ 0x1
%define MAP_PRIVATE 0x2

section .data
fname: db "texto.txt", 0 ;nome do arquivo

section .text
global _start
;função para calcular o tamanho de uma string
string_length:
    xor rax, rax
    .loop:
        cmp byte[rdi+rax], 0
        je .end
        inc rax
        jmp .loop
    .end:
        ret

;função q escreve a string na tela
print_string:
    push rdi
    call string_length
    pop rsi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    syscall
    ret

_start:
    ;open syscall
    mov rax, 2
    mov rdi, fname
    mov rsi, READ_ONLY
    mov rdx, 0
    syscall
    ;mmap sycall
    mov r8, rax
    mov rax, 9
    mov rdi, 0
    mov rsi, 4096
    mov rdx, READ
    mov r10, MAP_PRIVATE
    mov r9, 0
    syscall
    mov rdi, rax

    call print_string

    ;close syscall
    mov rax, 2
    mov rdi, fname
    mov rsi, READ_ONLY
    MOV rdx, 0
    syscall

    ;sai do programa e retorna o codigo de saida de close
    mov rdi, rax
    mov rax, 60
    syscall