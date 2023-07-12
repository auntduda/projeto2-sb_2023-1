section .data

msg_entrada db 'Bem-vindo! Digite seu nome:\n',0
msg_rola db 'Hola,',0
msg_bemvindo db ', bem-vindo ao programa de CALC IA-32\n',0
msg_16ou32 db 'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):\n', 0
msg_menu db 'Menu:\n1-SOMA\n2-SUBSTRACAO\n3-MULTIPLICACAO\n4-DIBIDIR\n5-EXPONENCIAR\n6-MOD OPERATION\n7-SAIR\n', 0

extern read16, read32, readstr, print16, print32, printstr
extern soma, sub, mul, div, exp, mod

section .bss

user_name resb 100
tamanho resb 1
op resb 1
resultado resb 100

global tamanho
global resultado

section .text
global _start

_start: push msg_entrada
        call printstr
        push user_name
        call readstr
        push msg_rola
        call printstr
        push user_name
        call printstr
        push msg_bemvindo
        call printstr
        push msg_16ou32
        call printstr
        push tamanho
        call readstr
        sub byte [tamanho], 0x30
menu:   push msg_menu
        call printstr
        push op
        call readstr
        sub byte [op], 0x30
        cmp byte [op], 1
        je _soma
        cmp byte [op], 2
        je _sub
        cmp byte [op], 3
        je _mul
        cmp byte [op], 4
        je _div
        cmp byte [op], 5
        je _exp
        cmp byte [op], 6
        je _mod
        call exit
          

_soma:  call soma
        jmp menu
_sub:   call sub
        jmp menu
_mul:   call mul
        jmp menu
_div:   call div
        jmp menu
_exp:   call exp
        jmp menu
_mod:   call mod
        jmp menu
exit:   mov eax, 1
        mov ebx, 0
        int 80h
