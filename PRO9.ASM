program segment
org 100h
assume cs:program

start:
        mov cx, 10                ; dl boku kwadratu
        mov bx, cx                

        ; domyslna pozycja kursora na start - lewy gorny rog kwadratu
        mov  dl, 30               ; pozycja kursora - kolumna
        mov  dh, 7                ; pozycja kursora - wiersz
        ; rejestr do porownywania, uzyty w procedurze wyboru znaku do druku
        mov ax, dx

zmien_kolumne:
        push cx
        ; wypychamy na stos pierwsza pozycje kursora
        push dx
        ; reset cx do poczatkowej wartosci
        mov cx, bx
        zmien_wiersz:
                push dx                 ; wypychamy na stos biezaca pozycje kursora

                call set_cursor

                ; wybor znaku do druku
                call set_sign             ; call set_sign

                push ax                 ; rejestr do porownan na stos
                ; display character - wywolanie funkcji
                mov ah, 02h             
                int 21h
                pop ax                  ; rejestr do porownan ze stosu

                ; ustawienie kolejnego wiersza
                pop dx
                inc dh                  ; zmiana wiersza na kolejny
        loop zmien_wiersz
        pop dx
        pop cx
        ; ustawienie kolejnej kolumny
        inc dl
loop zmien_kolumne

; procedura do ustalenia pozycji kursora
;INPUT : DL=X, DH=Y.
set_cursor proc                
        push ax                 ; rejestr do porownan na stos
        mov  ah, 02h                ; to set cursor position
        int  10h                    ; interrupt
        pop ax
        RET
set_cursor endp


; procedura do ustalenia jaki znak ma zostac wyswietlony w aktualnej pozycji kursora
; porownujemy obecna pozycje kursora, ktora jest w rejestrze dx, z wyjsciowa pozycja kursora
; ktora jest w rejestrze ah
set_sign proc
        push ax

        cmp dh, ah
        je first_row

        add ah, bl
        sub ah, 1
        cmp dh, ah
        je last_row

        jmp int_row

        ; result for 1st row
        first_row:
                cmp dl, al
                ; jesli 1 kol
                je first_col_of_1st_row
                add al, bl
                sub al, 1
                cmp dl, al
                ; jesli ostatnia kol
                je last_col_of_1st_row
                ; jesli posrednia kol
                jmp int_col_of_1st_row

                ; result for 1st row, 1st col
                first_col_of_1st_row:
                mov dx, 201
                jmp return
                ; result for 1st row, last col
                last_col_of_1st_row:
                mov dx, 187
                jmp return
                ; result for 1st row, intermediate col
                int_col_of_1st_row:
                mov dx, 205
                jmp return

        ; result for last row
        last_row:
                cmp dl, al
                ; jesli 1 kol
                je first_col_of_last_row
                add al, bl
                sub al, 1
                cmp dl, al
                ; jesli ostatnia kol
                je last_col_of_last_row
                ; jesli posrednia kol
                jmp int_col_of_last_row

                ; result for last row, 1st col
                first_col_of_last_row:
                mov dx, 200
                jmp return
                ; result for last row, last col
                last_col_of_last_row:
                mov dx, 188
                jmp return
                ; result for last row, intermediate col
                int_col_of_last_row:
                mov dx, 205
                jmp return

        ; result for intermediate row
        int_row:
                cmp dl, al
                ; jesli 1 kol
                je first_col_of_int_row
                add al, bl
                sub al, 1
                cmp dl, al
                ; jesli ostatnia kol
                je last_col_of_int_row
                ; jesli posrednia kol
                jmp int_col_of_int_row

                ; result for last row, 1st col
                first_col_of_int_row:
                mov dx, 186
                jmp return
                ; result for last row, last col
                last_col_of_int_row:
                mov dx, 186
                jmp return
                ; result for last row, intermediate col
                int_col_of_int_row:
                mov dx, 177
                jmp return

        return: 
        pop ax
        RET
set_sign endp

koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start