program segment
org 100h
assume cs:program

start:
        mov cx, 5                ; dl boku kwadratu
        mov bx, cx               ; dl boku kwadratu


        mov ah, 02h              ; display character 
; gorna krawedz bedzie drukowana zawsze na start
gorna_kraw:
        mov dx, 201
        int 21h

        sub cx, 2               ; dl poziomej kreski to zawsze dl. boku kwadratu minus 2

        kreska_pozioma:
                mov dx, 205
                int 21h
        loop kreska_pozioma
        
        mov dx, 187
        int 21h

        ; drukowanie znaku nowej linii, powrot karetki
        mov dl, 0Ah
        int 21h
        mov dl, 0Dh
        int 21h


; ilosc wierszy posrednich kwadratu (nie gorna i nie dolna krawedz)
        mov cx, bx
        sub cx, 2
; drukowanie posrednich wierszy kwadratu
petla:
        push cx                 ; odkladamy cx na stos
        ; drukowanie pionowej kreski
        mov dx, 186
        int 21h

        mov cx, bx
        sub cx, 2
        wnetrze_kwadr:
                mov dx, ' '
                int 21h
        loop wnetrze_kwadr
        
        
        ; drukowanie pionowej kreski
        mov dx, 186
        int 21h         
        
        ; drukowanie znaku nowej linii, powrot karetki
        mov dl, 0Ah
        int 21h
        mov dl, 0Dh
        int 21h
        pop cx
loop petla

mov cx, bx
dolna_kraw:
        mov dx, 200
        int 21h

        sub cx, 2               ; dl poziomej kreski to zawsze dl. boku kwadratu minus 2

        kreska_poz:
                mov dx, 205
                int 21h
        loop kreska_poz
        
        mov dx, 188
        int 21h


koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start