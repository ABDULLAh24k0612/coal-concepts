INCLUDE irvine32.inc

.data

arr dword 1,2,3,4,
          5,6,7,8,
          9,10,11,12
sum dword ?
msg byte"the of all teh elments of the array is = ",0
row=3
col=4

.code
main PROC

mov esi,offset arr
mov edi,esi
mov ecx,row*col

mov eax,0

sum_loop:

add eax,[esi]
add esi,4

cmp ecx,0
je print_sum
loop sum_loop

print_sum:

mov edx,offset msg
call writestring
call crlf
mov sum,eax
mov eax,sum
call writedec

exit 
main ENDP
END main

