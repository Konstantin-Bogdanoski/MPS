; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
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
    mov ah, 01h
    int 21h         ;vnesuvanje char
    mov bx, 100h
    mov ds:[bx], al   
    
    inc al
    inc bx
    mov [ds][bx], al
    
    inc al
    inc bx
    mov ds:[102h], al
    
    inc al
    inc bx
    mov [ds+3][bx], al
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
