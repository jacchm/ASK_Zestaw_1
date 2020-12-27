program segment
org 100h
assume cs:program

start:
        mov cx, 0h
        mov cx, 10h
        mov ax, 0
        mov ax, 118
        mov bx, 0
        mov bx, 10              ; dzielnik
        mov dx, 0
        
        ;div bx         ; AX = (DX:AX div BX),
                        ; DX = (DX:AX mod BX)

petla:
        push ax
        mov dx, 0

        div bx                  ; dzielenie ax/bx
        add dx, 48              ; dodajemy kod znaku '0' 
        push dx                 ; 8 jest na spodzie stosu
        xor dx, dx

        div bx                  ; dzielenie ax/bx
        add dx, 48              ; dodajemy kod znaku '0' 
        push dx ; 1 jest na górze stosu
        xor dx, dx
         
        div bx                  ; dzielenie ax/bx
        add dx, 48              ; dodajemy kod znaku '0'
        mov ah, 02h             ; display character
        int 21h                 ; interrupt

        xor dx, dx
        pop dx
        mov ah, 02h             ; display character
        int 21h                 ; interrupt
        
        xor dx, dx
        pop dx
        mov ah, 02h             ; display character
        int 21h                 ; interrupt

;        xor dx, dx
        mov dx, '['
        int 21h                 ; interrupt
        
        xor dx, dx
        pop dx
        int 21h                 ; interrupt
        push dx

        mov dx, ']'
        int 21h                 ; interrupt
        
        ; drukowanie znaku nowej linii, powrot karetki
        mov dl, 0Ah
        int 21h
        mov dl, 0Dh
        int 21h

        xor ax, ax
        pop ax
        inc ax

loop petla                ; skaczemy jesli flaga jest 0


koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start