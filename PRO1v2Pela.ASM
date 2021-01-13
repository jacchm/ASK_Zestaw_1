DOSSEG
	.model small
	.stack 100h
	.code

start:
        mov dl, '*'
        mov ah, 02h
        int 21h

koniec:
        mov ax, 4c00h
        int 21h

end start