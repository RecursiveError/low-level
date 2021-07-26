%define READ_ONLY 0
%define MAP_READ 0x1
%define MAP_PRIVATE 0x2

section .bss
 stat resb 144

struc STAT
    .st_dev         resq 1
    .st_ino         resq 1
    .st_nlink       resq 1
    .st_mode        resd 1
    .st_uid         resd 1
    .st_gid         resd 1
    .pad0           resb 4
    .st_rdev        resq 1
    .st_size        resq 1
    .st_blksize     resq 1
    .st_blocks      resq 1
    .st_atime       resq 1
    .st_atime_nsec  resq 1
    .st_mtime       resq 1
    .st_mtime_nsec  resq 1
    .st_ctime       resq 1
    .st_ctime_nsec  resq 1
endstruc

section .data
name_text: db 10, "nome: ",     0
name_size: db 10, "tamanho: ",  0
name_cont: db 10, "conteudo: ", 0

fname: db "texto.txt", 0 ;nome do arquivo
next_line: db 10

section .text
global _start

print_uint:
    mov rax,rdi
    mov rdi, rsp
    push 0
    sub rsp,16

    dec rdi
    mov r8, 10

    .loop:
        xor rdx, rdx
        div r8
        or dl, 0x30
        dec rdi
        mov[rdi], dl
        test rax, rax
        jnz .loop

    call print_string

    add rsp, 24
    ret

;função q escreve a string na tela
print_string:
    mov rsi, rdi
    mov rdx, 1
    mov rax, 1
    mov rdi, 1
    .loop:
    cmp byte[rsi], 0
    je .end
    syscall
    inc rsi
    jmp .loop
    .end:
        mov rsi, next_line
        syscall
        ret

_start:
    xor rax,rax

    ;open syscall
    mov rax, 2
    mov rdi, fname
    mov rsi, READ_ONLY
    mov rdx, 0
    syscall
    push rax

    ;stat sycall
    mov rax, 4
    mov rdi, fname
    mov rsi, stat
    syscall

    ;mmap sycall
    pop r8
    mov rax, 9
    mov rdi, 0
    mov rsi, 4096
    mov rdx, MAP_READ
    mov r10, MAP_PRIVATE
    mov r9, 0
    syscall
    push rax

    ;escreve o nome do arquivo
    mov rdi, name_text
    call print_string
    mov rdi, fname
    call print_string

    ;esceve o tamanho em bytes do conteudo
    mov rdi, name_size
    call print_string
    mov rdi, [stat + STAT.st_size]
    call print_uint

    ;escreve "conteudo na tela
    mov rdi, name_cont
    call print_string
    pop rdi
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