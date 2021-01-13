program segment
org 100h
assume cs:program

start:
        mov cx, 0Ah
        mov dl, 'A'

print:
        mov ah, 02h     ; display character
        int 21h         ; interrupt

        inc dl          ; increment dl register
        dec cx          ; decrement cx register
        cmp cx, 00h     ; compare cx register with 0
jnz print               ; jump not zero

koniec:       
        mov ax, 4c00h
        int 21h

program ends
end start