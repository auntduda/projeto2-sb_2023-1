section .text
extern resultado, tamanho, print32, print16, read32, read16
global sub

sub:
    push ebp
    mov ebp, esp
    cmp byte [tamanho], 0
    je sub16

    ; 32 bits
    ; ler numero usuario
    call read32
    mov ebx, eax
    call read32
    add eax, ebx
    ; imprime resultado
    push eax
    push resultado
    call print32

    mov esp, ebp
    pop ebp
    ret

    ; 16 bits
sub16:
    ; ler numero usuario
    call read16
    mov bx, ax
    call read16
    add ax, bx
    ; imprime resultado
    push eax
    push resultado
    call print16

    mov esp, ebp
    pop ebp
    ret