section .text
global _start

_start:
    CMP [rsp], 2
    JL missing_arguments

    ; getting umask
    MOV rax, 95
    MOV rdi, 0
    SYSCALL

    MOV rsi, 777q
    NOT rax
    AND rsi, rax

    MOV rax, 83
    MOV rdi, [rsp + 16]
    SYSCALL

exit:
    MOV rax, 60
    MOV rdi, 0
    SYSCALL

missing_arguments:
    MOV rax, 1
    MOV rdi, 1
    MOV rsi, ERR_NO_FOLDERS
    MOV rdx, ERR_NO_FOLDERS_LENGTH
    SYSCALL
    JMP exit

section .data
ERR_NO_FOLDERS: db "No folder was provided.", 10
ERR_NO_FOLDERS_LENGTH: equ $ - ERR_NO_FOLDERS