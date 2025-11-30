include irvine32.inc

.data
buffer db 100 DUP (?)
prompt db "Enter string: ", 0
count dd 0

.code
main PROC

mov edx, offset prompt
call writestring

mov edx, offset buffer
mov ecx, sizeof buffer
call readstring

mov esi, offset buffer

push esi
inc count

scan:
mov al, [esi]
cmp al, 0
je done
cmp al, ' '
jne next
mov byte ptr [esi], 0
inc esi
push esi
inc count
jmp scan

next:
inc esi
jmp scan

done:
mov ecx, count

print:
pop edx
call writestring
mov al, ' '
call writechar
loop print

call crlf
exit
main endp
end main
