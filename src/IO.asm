section .text
global read16, read32, readstr, print16, print32, printstr

read16: ret


read32: ret


readstr:
    push ebp
    mov ebp, esp

    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp+8]
    mov edx, 100
    int 80h

    mov esp, ebp
    pop ebp
    ret 4


; imprime um inteiro de 16 bits
print16: ret

; imprime um inteiro de 32 bits
; testar antes de reescrever para 16 bits
; primeiro parametro = numero de 32 bits (ebp+12)
; segundo parametro = ponteiro da string resultado (ebp+8)
print32:
    push ebp
    mov ebp, esp

    push ebx
    push edx

    ; empilha 0, que representa o final da string
    ; o desempilhamento eh de tras pra frente, por isso empilhamos o 0 primeiro
    push 0
    
    ; i = 0 do {str[i] = (char)((Valor % 10) + 0x30);Valor = (int) (Valor / 10);If Valor != 0  str[i+1]= str[i]i = i+1} while (Valor != 0)str[i] = '/0'
    mov eax, [ebp+12]
    ; converte o inteiro para caracteres
print32_cv_loop:
    cdq
    idiv 10
    add edx, 0x30
    push edx
    cmp eax, 0
    jne print32_cv_loop

    cmp [ebp+12], 0
    jge print32_gz
    push '-'
    ; constroe a string, desempilhando os caracteres
print32_gz: mov ebx, [ebp+8]
print32_sb_loop:
    pop eax
    mov [ebx], al
    inc ebx
    cmp eax, 0
    jne print32_sb_loop

    ; call printstr
    push [ebp+8]
    call printstr

    pop edx
    pop ebx

    mov esp, ebp
    pop ebp
    ret 8

printstr:
    push ebp
    mov ebp, esp

    mov ebx, 1
    mov ecx, [ebp+8]

    push [ebp+8]
    call strlen
    mov edx, eax

    mov eax, 4
    int 80h

    mov esp, ebp
    pop ebp
    ret 4

strlen:
    push ebp
    mov ebp, esp
    push ebx

    sub eax, eax
    mov ebx, [ebp+8]

strlen_loop:
    inc eax
    inc ebx
    cmp [ebx], 0
    jne strlen_loop
    
    pop ebx
    mov esp, ebp
    pop ebp
    ret 4
