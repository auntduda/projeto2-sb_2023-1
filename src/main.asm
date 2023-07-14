section .data
msg_entrada db 'Bem-vindo! Digite seu nome: ',0
msg_rola db 'Hola, ',0
msg_bemvindo db ', bem-vindo ao programa de CALC IA-32',10,0
msg_16ou32 db 'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32): ',0
msg_menu db 10,'Menu:',10,'1-SOMA',10,'2-SUBSTRACAO',10,'3-MULTIPLICACAO',10,'4-DIBIDIR',10,'5-EXPONENCIAR',10,'6-MOD OPERATION',10,'7-SAIR',10,0
msg_numero db 'Insira um numero: ',0
msg_resultado db 'Resultado: ',0
msg_overflow db 10,'OCORREU OVERFLOW',10,0
newline db 10,0

section .bss
user_name resb 100
tamanho resb 1
op resb 1
aux_str resb 100

section .text
; funcoes publicos
global _start
; dados publicos
global tamanho, aux_str, msg_overflow, msg_numero, msg_resultado
; funcoes externas
extern readstr, printstr, soma, sub, mul, div, exp, mod, exit

%macro print 1
        push %1
        call printstr
%endmacro
%macro read 1
        push %1
        call readstr
%endmacro

_start: print msg_entrada
        read user_name
        print msg_rola
        print user_name
        print msg_bemvindo
        print msg_16ou32
        read tamanho
        ; transforma o tamanho de ASCII para inteiro
        sub byte [tamanho], 0x30
menu:   print msg_menu
        read op
        print newline
        ; transforma o op de ASCII para inteiro
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
        jmp exit

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
