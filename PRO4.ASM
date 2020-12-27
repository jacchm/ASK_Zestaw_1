program segment
org 100h
assume cs:program

start:
        mov cx, 03h             ; liczba wierszy
        mov bx, 03h             ; liczba drukowanych liter

print:
        push cx                 ; odklada cx na stos - wartosc 3 jest na spodzie stosu
        mov dl, 'A'             ; litera od jakiej zaczynamy

        mov cx, bx             ; ilosc drukowanych liter w kazdym wierszu

        char_loop:
                mov ah, 02h     ; display character
                int 21h         ; interrupt
                inc dl          ; zwiekszamy dl zeby otrzymac kolejna literke
        loop char_loop           ; jump not zero
        
        add bx, 3

        ; po wydrukowaniu znaków przechodzimy do kolejnej linii
        mov dl, 0Ah
        int 21h
        mov dl, 0Dh
        int 21h

        pop cx                  ; wrzucamy do cx pozostala liczbe wierszy
loop print                      ; dekrementujemy liczbe wierszy pozostalych do wydrukowania
                                ; jesli mamy jakis wiersz do wydrukowania to skaczemy do etykiety print

koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start