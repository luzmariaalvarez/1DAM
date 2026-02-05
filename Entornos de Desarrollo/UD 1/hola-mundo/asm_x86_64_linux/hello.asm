; Programa: Hola mundo en x86-64 Linux (syscall write + exit)
; Ensamblador NASM, enlazado con ld
section .data
msg db "Hola mundo", 10   ; Cadena a imprimir con salto de linea
len equ $ - msg           ; Longitud de la cadena

section .text
global _start
_start:
    ; write(1, msg, len)
    mov rax, 1            ; 1 = sys_write
    mov rdi, 1            ; fd = 1 (stdout)
    mov rsi, msg          ; puntero al mensaje
    mov rdx, len          ; longitud
    syscall               ; llamar al kernel

    ; exit(0)
    mov rax, 60           ; 60 = sys_exit
    xor rdi, rdi          ; codigo de salida 0
    syscall
