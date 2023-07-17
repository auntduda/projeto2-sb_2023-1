section .text
; dados externos
extern aux_str, tamanho, msg_numero, msg_resultado, msg_overflow, mul
; funcoes externas
extern print32, print16, printstr, read32, read16, exit
global exp

;;;;;;;;;;;;;;;;; TA TUDO ERRADO PROQUE ESQUECI QUE OPERACAO DE MULTIPLICACAO E DIVISAO SO OPERA COM REGISTRADOR AAAAAAAAAAAAAA

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
            ; colocando o primeiro numero em ebx para trocar os dados de endereco depois
            mov ebx, eax

            push msg_numero
            call printstr
            ; ler segundo numero
            push aux_str
            call read32

            ; troca troca jequiti - trocando os operandos de lugar pra fazer a divisao direito

            mov [ebp-4], eax        ; guarda o primeiro numero (dividendo) como variavel local
            mov eax, ebx            ; o segundo numero (divisor) estara em eax

            mov esi, 0

loop_exp32: imul [ebp-4], [ebp-4]
            jo exp_of
            inc esi
            cmp esi, eax
            jne loop_exp32

            mov eax, [ebp-4]        ; agora a resposta ta em eax

            ; imprime resultado
            push msg_resultado
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
            ; colocando o primeiro numero em ebx para trocar os dados de endereco depois
            mov bx, ax

            push msg_numero
            call printstr
            ; ler segundo numero
            push aux_str
            call read16

            ; troca troca jequiti - trocando os operandos de lugar pra fazer a divisao direito

            mov [ebp-2], ax        ; guarda o primeiro numero (dividendo) como variavel local
            mov ax, bx            ; o segundo numero (divisor) estara em eax

            mov esi, 0

loop_exp16: imul [ebp-2], [ebp-2]
            jo exp_of
            inc esi
            cmp esi, ax
            jne loop_exp16

            mov ax, [ebp-2]        ; agora a resposta ta em eax

            ; imprime resultado
            push msg_resultado
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




