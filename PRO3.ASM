program segment
org 100h
assume cs:program

start:
        mov bx, 02h             ; liczba spacji na start
        mov cx, 03h             ; liczba wierszy

print:
        push cx                 ; odklada cx na stos - wartosc 3 jest na spodzie stosu
        mov dl, 'A'             ; litera od jakiej zaczynamy

        mov cx, 08h             ; ilosc drukowanych liter w kazdym wierszu

        char_loop:
                mov ah, 02h     ; display character
                int 21h         ; interrupt

                inc dl          ; zwiekszamy dl zeby otrzymac kolejna literke
                dec cx          ; zmniejszamy cx zeby miec ilosc 
        jnz char_loop           ; jump not zero


        ; po wydrukowaniu znaków przechodzimy do kolejnej linii... 
        mov dl, 0Ah
        int 21h
        mov dl, 0Dh
        int 21h
        ; ... i drukujemy spacje
        mov cx, bx
        space_loop:
                mov dl, ' '     ; wstawiamy spacje
                int 21h         ; drukujemy spacje
                dec cx          ; dekrementujemy ilosc spacji w cx
        jnz space_loop          ; jesli mamy spacje do wydrukowania to zaczynamy kolejna petle space_loop
                add bx, 2       ; w kazdym wierszu dajemy dodatkowe 2 spacje

        pop cx                  ; wrzucamy do cx pozostala liczbe wierszy
        dec cx                  ; dekrementujemy liczbe wierszy jaka nam pozostala do wydrukowania
jnz print                       ; jesli mamy jakis wiersz do wydrukowania to skaczemy do etykiety print

koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start