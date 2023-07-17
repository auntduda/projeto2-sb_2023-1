section .text
; dados externos
extern aux_str, tamanho, msg_numero, msg_resultado, msg_overflow
; funcoes externas
extern print32, print16, printstr, read32, read16, exit

; funcoes publicas
global div
div:    ; se tamanho = 0, vai para divisao de 16 bits
        cmp byte [tamanho], 0
        je div16
        ; 32 bits
        ; comeca o frame de pilha com 4 bytes reservados para uma variavel local
        enter 4, 0

        push msg_numero
        call printstr
        ; ler numero usuario
        push aux_str
        call read32
        ; guarda o primeiro numero como variavel local
        mov ebx, eax

        push msg_numero
        call printstr
        ; ler segundo numero
        push aux_str
        call read32

        ; troca troca jequiti - trocando os operandos de lugar pra fazer a divisao direito
        mov [ebp-4], eax
        mov eax, ebx

        ; divide os dois numeros
        idiv dword [ebp-4]
        jo div_of

        ; imprime resultado
        push msg_resultado
        call printstr
        ; printa resultado de 32 bits
        push eax
        push aux_str
        call print32
    
        leave
        ret

        ; 16 bits
div16:  ; comeca o frame de pilha com 2 bytes reservados para uma variavel local
        enter 2, 0
        
        push msg_numero
        call printstr
        ; ler numero usuario
        push aux_str
        call read16
        ; guarda o primeiro numero como variavel local
        mov bx, ax

        push msg_numero
        call printstr
        ; ler segundo numero
        push aux_str
        call read16

        ; troca troca jequiti - trocando os operandos de lugar pra fazer a divisao direito
        mov [ebp-2], ax
        mov ax, bx

        ; divide os dois numeros
        idiv word [ebp-2]
        jo div_of

        ; imprime resultado
        push msg_resultado
        call printstr
        ; printa resultado de 32 bits
        push ax
        push aux_str
        call print16
    
        leave
        ret

div_of: push msg_overflow
        call printstr
        jmp exit

