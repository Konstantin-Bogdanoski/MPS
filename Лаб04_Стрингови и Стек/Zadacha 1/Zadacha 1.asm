; multi-segment executable file template.

data segment
    ; add your data here!
    break db ".$"
    enterChar db "Vnesi char:$"
    enterString db "Vnesi string:$"
    string db 20 dup(?)
    char db ?
    count db 0d
ends

stack segment
    dw   128  dup(0)
ends

code segment
    
    newline proc
        mov ah, 2
        mov dl, 10d
        int 21h
        mov dl, 13d
        int 21h
        ret
    newline endp
        
    charCount proc
        pop ax ; adr
        pop cx ; char
        pop bx ; string adr
        
        mov di, cx
        mov cx, 0d
        mov cx, [di]
        
        mov dx, 0d
        
        looper:
            cmp [bx], '.' ;tochka -> end
            je isOver
            
            mov si, bx
            mov bx, 0d
            mov bx, [si]
            
            cmp bl, cl
            mov bx, si
            je isChar
            inc bx
            jmp looper
            
            isChar:
            inc dx
            inc bx
            jmp looper
            
            
        isOver:
        mov bx, ax
        mov cx, dx
        mov dl, cl
        add dl, 30h
        mov ah, 2
        int 21h        
        push bx
        ret
    charCount endp
            
        
    
    
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
                                      
    lea dx, enterChar
    mov ah, 9
    int 21h
    call newline
    
    lea bx, char
    mov ah, 1
    int 21h    
    mov [bx], al
    call newline 
    
    
    lea bx, string
    
    lea dx, enterString
    mov ah, 9
    int 21h
    call newline
    
    inputStrings:
        mov ah, 1
        int 21h
        cmp al, '.'
        je stringIn
        
        mov [bx], al
        inc bx
        jmp inputStrings
        
        
        
        stringIn:
        mov [bx], al
        lea si, string ; proverka dali e tochka samo
        lea di, break
        mov cx, 1d
        repe cmpsb
        je inputOver
        
        
        ;prv vlez StringAdr, vtor Char
        
        lea bx, string
        push bx  
        
        lea bx, char
        push bx   
        
        call charCount
        lea bx, string
        
        call newline
        
        lea dx, enterString
        mov ah, 9
        int 21h
        call newline
        
        jmp inputStrings
        
        
    inputOver:        
        
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
