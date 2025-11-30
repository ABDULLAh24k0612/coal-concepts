; Sum all elements of an array using MASM and Irvine32 library

INCLUDE Irvine32.inc

.data
array DWORD 1, 2, 3, 4, 5      ; Array of 5 integers
count DWORD LENGTHOF array      ; Number of elements
sum   DWORD 0

.code
main PROC
    mov ecx, count              ; Set loop counter
    mov esi, OFFSET array       ; Point ESI to start of array
    mov eax, 0                  ; Clear EAX (sum)

    L1:
        add eax, [esi]          ; Add current element to sum
        add esi, 4              ; Move to next element (DWORD = 4 bytes)
        loop L1

    mov sum, eax                ; Store result in sum

    ; Display the sum
    mov eax, sum
    call WriteInt
    call Crlf

    exit
main ENDP

END main
