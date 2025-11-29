INCLUDE irvine32.inc
.data

inputstr byte "a b c d e f g", 0
outputstr byte 50 dup(?)

.code

main PROC

mov esi, offset inputstr
mov edi, offset outputstr
mov ecx,LENGTHOF inputstr

remove_loop:

lodsb
cmp al,0
je done

cmp al,' '
je skip_space
stosb


skip_space:
loop remove_loop


done:
mov edx,offset outputstr
call writestring
call crlf

exit
main endP
end main
