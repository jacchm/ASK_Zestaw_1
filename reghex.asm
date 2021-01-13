program segment
org 100h
assume cs:program

start:
   mov dx, 2154h
   mov bx, 02h             ; liczba spacji na start
   mov cx, 03h             ; liczba wierszy

print:

   char_loop:
      mov ah, 02h     ; display character
      int 21h         ; interrupt

      inc dl          ; zwiekszamy dl zeby otrzymac kolejna literke
      dec cx          ; zmniejszamy cx zeby miec ilosc 
   jnz char_loop           ; jump not zero












koniec:                         ; oddajemy kontrole
        mov ax, 4c00h
        int 21h

program ends
end start
  