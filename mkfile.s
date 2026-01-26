section .text

global _start

_start:
    CMP qword [rsp], 2
    JL .missing_arguments

    MOV rax, 2
    MOV rdi, [rsp + 16]
    MOV rsi, 101q ; result from O_WRONLY | O_CREAT
    MOV rdx, 644q ; result from S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
    SYSCALL

.exit:
    MOV rax, 60
    MOV rdi, 0
    SYSCALL

.missing_arguments:
    MOV rax, 1
    MOV rdi, 1
    MOV rsi, ERR_FILE_REQUIRED
    MOV rdx, ERR_FILE_REQUIRED_LENGTH
    SYSCALL

    JMP .exit

section .data:
ERR_FILE_REQUIRED: db "Please provide a filename.", 10
ERR_FILE_REQUIRED_LENGTH: equ $ - ERR_FILE_REQUIRED