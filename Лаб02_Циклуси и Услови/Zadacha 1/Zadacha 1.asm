; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    a db 10
    b db 10
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
    
    cmp a, 3d ;a<3
    jl pecati1
    
    cmp b, 3d ;b<=3
    jle pecati1
    
    jmp nepecati
    
    pecati1:
    mov dl, 1d
    add dl, 30h
    mov ah, 02h
    int 21h
    jmp kraj

    
    nepecati:
    mov bl, b
    cmp a, bl
    jge pecati2
    
    jmp inaku3

    
    pecati2:
    mov dl, 2d
    add dl, 30h
    mov ah, 02h
    int 21h
    jmp kraj

    
    
    
    inaku3:
    mov dl, 3d
    add dl, 30h
    mov ah, 02h
    int 21h

    
    kraj:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
