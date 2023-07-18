section .text
; dados externos
extern aux_str, tamanho, msg_numero, msg_resultado, msg_overflow, mul
; funcoes externas
extern print32, print16, printstr, read32, read16, exit
global exp

exp:        ;se tamanho = 0, vai para divisao de 16 bits
            cmp byte [tamanho], 0
            je exp16
            ; 32 bits
            ; comeca o frame de pilha com 4 bytes reservados para uma variavel local
            enter 4, 0

            push msg_numero
            call printstr
            ; ler numero usuario
            push aux_str
            call read32
            ; colocando o primeiro numero (base) em ebx para trocar os dados de endereco depois
            mov ebx, eax

            push msg_numero
            call printstr
            ; ler segundo numero (exp)
            push aux_str
            call read32

            ; troca troca jequiti - trocando os operandos de lugar pra fazer a exponenciacao direito

            mov [ebp-4], eax        ; guarda o segundo numero (exp) como variavel local
            mov eax, ebx            ; o primeiro numero (base) estara em eax

            mov esi, 1              ; iniciando o contador em 1, ja que tem base^1 em eax

loop_exp32: cmp esi, [ebp-4]
            jge fim
            imul ebx
            jo exp_of
            inc esi
            jmp loop_exp32

; loop_exp32: imul eax
;             jo exp_of
;             inc esi
;             cmp esi, [ebp-4]
;             jne loop_exp32


            ; imprime resultado
fim:        push msg_resultado
            call printstr
            ; printa resultado de 32 bits
            push eax
            push aux_str
            call print32
        
            leave
            ret

exp16:      ; 16 bits
            ; comeca o frame de pilha com 2 bytes reservados para uma variavel local
            enter 2, 0

            push msg_numero
            call printstr
            ; ler numero usuario
            push aux_str
            call read16
            ; colocando o primeiro numero (base) em bx para trocar os dados de endereco depois
            mov bx, ax

            push msg_numero
            call printstr
            ; ler segundo numero
            push aux_str
            call read16

            ; troca troca jequiti - trocando os operandos de lugar pra fazer a divisao direito

            mov [ebp-2], ax        ; guarda o segundo numero (exp) como variavel local
            mov ax, bx             ; o primeiro numero (base) estara em ax

            mov esi, 1             ; iniciando o contador em 1, ja que tem base^1 em ax

; loop_exp16: imul ax
;             jo exp_of
;             inc esi
;             cmp esi, [ebp-2]
;             jne loop_exp16

loop_exp16: cmp esi, [ebp-2]
            jge fim16
            imul bx
            jo exp_of
            inc esi
            jmp loop_exp16

            ; imprime resultado
fim16:      push msg_resultado
            call printstr
            ; printa resultado de 32 bits
            push ax
            push aux_str
            call print16
        
            leave
            ret

exp_of:     push msg_overflow
            call printstr
            jmp exit
