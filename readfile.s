section .text

global _start
_start:
    CMP rsp, 2
    JL missing_arguments

    MOV rax, 2
    MOV rdi, [rsp + 16]
    MOV rsi, 0
    MOV rdx, 0
    SYSCALL

    MOV rbx, rax
file_reading:
    MOV rdi, rbx
    MOV rax, 0
    MOV rsi, buffer
    MOV rdx, BUFFER_SIZE
    SYSCALL

    CMP rax, 0
    JLE exit

    MOV rdx, rax
    MOV rax, 1
    MOV rdi, 1
    MOV rsi, buffer
    SYSCALL

    JMP file_reading
exit:
    MOV rax, 60
    MOV rdi, 0
    SYSCALL

missing_arguments:
    MOV rax, 1
    MOV rdi, 1
    MOV rsi, ERR_FILE_REQUIRED
    MOV rdx, ERR_FILE_REQUIRED_LENGTH
    SYSCALL

    JMP exit

section .data
BUFFER_SIZE: equ 4096
ERR_FILE_REQUIRED: db "No file was provided.", 10
ERR_FILE_REQUIRED_LENGTH: equ $ - ERR_FILE_REQUIRED

section .bss
    buffer RESB BUFFER_SIZE