INCLUDE irvine32.inc
.data

inputstr byte "a b c d e f g h ", 0
msg1 byte "the number of alphabets in the string are : "
wordCount dword 0

.code

main PROC

mov esi, offset inputstr
mov ecx,LENGTHOF inputstr

count_loop:

lodsb
cmp al,0
je done

cmp al,' '
je skip_space

mov eax,wordCount
inc eax
mov wordCount,eax



skip_space:
loop count_loop


done:
mov edx,offset inputstr
call writestring
call crlf
mov edx,offset msg1
call writestring
mov eax,wordCount
call writedec

exit
main endP
end main
