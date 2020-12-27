program segment
org 100h
assume cs:program

start:
        mov cx, 15                ; dl boku kwadratu
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
                push ax
                push bx
                push cx
                call set_sign             ; call set_sign
                mov ah, 09h             
                int 10h

                pop cx
                pop bx
                pop ax

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
                mov al, 201
                mov bl, byte ptr ds:[color]
                mov cx, 1
                jmp return
                ; result for 1st row, last col
                last_col_of_1st_row:
                mov al, 187
                mov bl, byte ptr ds:[color]
                mov cx, 1
                jmp return
                ; result for 1st row, intermediate col
                int_col_of_1st_row:
                mov al, 205
                mov bl, byte ptr ds:[color]
                mov cx, 1
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
                mov al, 200
                mov bl, byte ptr ds:[color]
                mov cx, 1
                jmp return
                ; result for last row, last col
                last_col_of_last_row:
                mov al, 188
                mov bl, byte ptr ds:[color]
                mov cx, 1
                jmp return
                ; result for last row, intermediate col
                int_col_of_last_row:
                mov al, 205
                mov bl, byte ptr ds:[color]
                mov cx, 1
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
                mov al, 186
                mov bl, byte ptr ds:[color]
                mov cx, 1
                jmp return
                ; result for last row, last col
                last_col_of_int_row:
                mov al, 186
                mov bl, byte ptr ds:[color]
                mov cx, 1
                jmp return
                ; result for last row, intermediate col
                int_col_of_int_row:
                mov al, 177
                mov bl, byte ptr ds:[color]
                mov cx, 1
                jmp return

        return:
        RET
set_sign endp

color db 1                     ; kolor do ustawienia

koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start