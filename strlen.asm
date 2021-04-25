;Programa: strlen
;Autor: RecursiveError
;programa que mostra o tamanho da string  

section .bss
valor: resb 1

section .data
string: db 'abcdefgh', 0
nova_linha: db 10

section .text
global _start

;retorna o tamanho da string
strlen:
    xor rax, rax 
    .loop:
        cmp byte [rdi+rax],0
        je .end
        inc rax
        jmp .loop
    .end:
        ret
;recebe um numero e escreve na saida
print:  
    mov [valor], rdi
    add byte[valor], 0x30
    mov rsi, valor
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
ret

;pula uma linha
new_line:
    mov rsi, nova_linha
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
ret


_start:
 mov rdi, string
 call strlen
 
 mov rdi, rax
 call print
 call new_line

 mov rax, 60
 syscall
