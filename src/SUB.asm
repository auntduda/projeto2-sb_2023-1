section .text
; dados externos
extern aux_str, tamanho, msg_numero, msg_resultado
; funcoes externas
extern print32, print16, printstr, read32, read16

; funcoes publicas
global sub
sub:    ; se tamanho = 0, vai para subtracao de 16 bits
        cmp byte [tamanho], 0
        je sub16
        ; 32 bits
        ; comeca o frame de pilha com 4 bytes reservados para uma variavel local
        enter 4, 0

        push msg_numero
        call printstr
        ; ler numero usuario
        push aux_str
        call read32
        ; guarda o primeiro numero como variavel local
        mov [ebp-4], eax

        push msg_numero
        call printstr
        ; ler segundo numero
        push aux_str
        call read32

        ; subtrae segundo numero do primeiro numero
        sub [ebp-4], eax

        ; imprime resultado
        push msg_resultado
        call printstr
        ; printa resultado de 32 bits
        push dword [ebp-4]
        push aux_str
        call print32
    
        leave
        ret

        ; 16 bits
sub16:  ; comeca o frame de pilha com 2 bytes reservados para uma variavel local
        enter 2, 0
        
        push msg_numero
        call printstr
        ; ler numero usuario
        push aux_str
        call read16
        ; guarda o primeiro numero como variavel local
        mov [ebp-2], ax

        push msg_numero
        call printstr
        ; ler segundo numero
        push aux_str
        call read16

        ; subtrae segundo numero do primeiro numero
        sub [ebp-2], ax

        ; imprime resultado
        push msg_resultado
        call printstr
        ; printa resultado de 32 bits
        movsx eax, word [ebp-2]
        ; push word [ebp-2]
        push eax
        push aux_str
        ;call print16
        call print32
    
        leave
        ret
