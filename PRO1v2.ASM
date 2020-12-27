program segment
org 100h
assume cs:program

start:
        mov ah, 09h
        mov dx, offset message
        int 21h

        mov ah, 09h
        mov dx, offset wiadomosc
        int 21h
        
koniec:

        mov ax, 4c00h
        int 21h

message db '*$'
wiadomosc db 'wiadomosc$'

program ends
end start