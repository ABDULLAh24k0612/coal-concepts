INCLUDE Irvine32.inc

.data
mainStr     BYTE "i like assembly",0
searchStr   BYTE "assembly",0
replaceStr  BYTE "asm",0
outStr      BYTE 80 DUP(?)
searchLen   DWORD 8
replaceLen  DWORD 3

.code
main PROC
    mov esi, OFFSET mainStr
    mov edi, OFFSET outStr

next_char:
    mov al, [esi]
    cmp al, 0
    je finish

    mov ecx, searchLen
    mov ebx, 0
match_loop:
    mov dl, [searchStr+ebx]
    cmp dl, [esi+ebx]
    jne no_match
    inc ebx
    loop match_loop

    mov ecx, replaceLen
    mov ebx, 0
copy_replace:
    mov al, [replaceStr+ebx]
    mov [edi], al
    inc edi
    inc ebx
    loop copy_replace

    add esi, searchLen
    jmp next_char

no_match:
    mov [edi], al
    inc esi
    inc edi
    jmp next_char

finish:
    mov byte ptr [edi], 0
    mov edx, OFFSET outStr
    call WriteString
    call CrLf
    exit
main ENDP
END main
