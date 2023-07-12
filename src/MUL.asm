section .text
extern resultado, tamanho, print32, print16, read32, read16, printstr, msg_overflow
global mul

mul:        
            push ebp
            mov ebp, esp
            cmp byte [tamanho],0
            je mul16

            ; 32 bits
            ; ler numero usuario
            call read32
            mov ebx, eax
            call read32
            imul ebx
            jo overflow

            ; imprime resultado
            push eax
            push resultado
            call print32

            mov esp, ebp
            pop ebp
            ret

            ; 16 bits
mul16:      
            ; ler numero usuario
            call read16
            mov bx, ax
            call read16
            imul bx
            jo overflow

            ; imprime resultado
            push eax
            push resultado
            call print16

            mov esp, ebp
            pop ebp
            ret

overflow:   
            push msg_overflow
            call printstr
            ret