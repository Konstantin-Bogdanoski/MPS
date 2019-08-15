; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    N db ?
    S db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    mov ah, 1
    int 21h
    mov bl, al
    sub bl, 30h
    sub al, 30h
    mov ah, 0d
    mov cl, 10d
    mul cl ; ednocifren, da stane dvocifren broj
    mov bl, al
    
    
    mov ah, 1
    int 21h
    sub al, 30h
    add bl, al
    mov N, bl
    
    mov cl, 1d
    mov S, 0d
    
    sumiranje:
        cmp N, cl
        jl kraj
        mov ah, 0d
        mov al, cl
        mov bx, 3d
        div bx
        
            cmp dl, 1d ; ostatokot e vo ah, proveri dali == 1
            je dodadi
            inc cl
            jmp sumiranje
            
            dodadi:
            add S, cl
            inc cl
            jmp sumiranje
    
    
    
    kraj:
    
    mov al, S
    mov bl, 10d
    div bl
    
    mov al, ah
    mov ah, 0d
    push ax ;edinica
    
    mov al, S
    mov bl, 100d
    div bl
    
    mov al, ah
    mov ah, 0d
    push ax ;desetka
    
    mov al, S
    mov bl, 100d
    div bl
    
    mov ah, 0d
    push ax ;stotka
    
    pop bx
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h   ;pecati stotka
    
    pop bx
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h   ;pecati desetka
    
    pop bx
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h   ;pecati edinica
    
    
    
            
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
