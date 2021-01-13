DOSSEG
	.model small
	.stack 100h
        .data
        message db '*$'
	.code

start:
        mov ax, @data
        mov ds, ax                      ; ustawienie segmentu danych   

        mov dx, offset message
        mov ah, 09h
        int 21h

koniec:
        mov ax, 4c00h
        int 21h

end start