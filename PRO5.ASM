program segment
org 100h
assume cs:program

start:
        mov cx, 03h             ; liczba wierszy

print:
        push cx                 ; odklada cx na stos
        mov dl, 'A'             ; litera od jakiej zaczynamy

        mov cx, 04h             ; ilosc drukowanych liter w kazdym wierszu

        char_loop:
                mov ah, 02h     ; display character
                int 21h         ; interrupt
                inc dl          ; zwiekszamy dl zeby otrzymac kolejna literke
        loop char_loop          ; zmniejszamy cx i wykonujemy skok jesli cx > 0 (pozostala liczba liter do wydrukowania > 0)
        

        mov cx, word ptr ds:[nostars]
        ; if cx = 0 [1] omijamy drukowanie jesli cx = 0, bo drukuje kosmiczna liczbe gwiazdek
        cmp cx, 0
        je next_line

        mov dl, '*'             ; litera od jakiej zaczynamy
        star_loop:
                mov ah, 02h     ; display character
                int 21h
        loop star_loop
        sub word ptr ds:[nostars], 03h

        ; [1] then
        ; po wydrukowaniu znaków przechodzimy do kolejnej linii... 
        next_line:
        mov dl, 0Ah
        int 21h
        mov dl, 0Dh
        int 21h
        ; ... i drukujemy spacje
        mov cx, word ptr ds:[noSpaces]
        space_loop:
                mov dl, ' '     ; wstawiamy spacje
                int 21h         ; drukujemy spacje
        loop space_loop         ; jesli mamy spacje do wydrukowania to zaczynamy kolejna petle space_loop
        add word ptr ds:[noSpaces], 03h
           
        pop cx                  ; wrzucamy do cx pozostala liczbe wierszy
loop print                      ; zmniejszamy cx i wykonujemy skok jesli cx > 0 (pozostala liczba wierszy do wydrukowania > 0)


noSpaces dw 03h
noStars  dw 06h

koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start