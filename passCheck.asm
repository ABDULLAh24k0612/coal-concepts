INCLUDE irvine32.inc
.data

pass byte "FastUniX", 0
msgStrong byte "Password is Strong.", 0
msgWeak byte "Password must include at least 1 digit.", 0

.code

main PROC

mov esi, offset pass
mov ecx, lengthof pass
mov bl, 0

check:

lodsb
cmp al, 0
je done

cmp al, '0'
jb next

cmp al,'9'
ja next

mov bl, 1
jmp done

next:

loop check

done:

cmp bl, 1
je strong

mov edx, offset msgWeak
call writestring
jmp exit1

strong:

mov edx, offset msgStrong
call writestring

exit1:

call crlf

exit
main endP
end main
