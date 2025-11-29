INCLUDE Irvine32.inc

.data
arr dword 2,3,6,8,65,4,32,9
n = LENGTHOF arr

.code
main PROC

mov ecx, n
dec ecx

outerloop:
    push ecx
    mov esi, OFFSET arr
    mov edi, esi
    mov edx, n
    dec edx

innerloop:
    mov eax, [edi]
    mov ebx, [edi+4]
    cmp eax, ebx
    jle noswap

    mov [edi], ebx
    mov [edi+4], eax

noswap:
    add edi, 4
    dec edx
    jnz innerloop

    pop ecx
    dec ecx
    jnz outerloop

mov esi, OFFSET arr
mov ecx, n

printloop:
    mov eax, [esi]
    call WriteDec
    call CrLf
    add esi, 4
    loop printloop

exit
main ENDP
END main
