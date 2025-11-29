INCLUDE Irvine32.inc

.data
ROWS = 3
COLS = 4

array DWORD 10,20,30,40,
       50,60,70,80,
       90,100,110,120

rowIndex DWORD 1       ; 2nd row
colIndex DWORD 2       ; 3rd column
element DWORD ?

.code
main PROC
    mov ebx, OFFSET array
    mov eax, rowIndex
    imul eax, COLS        ; multiply row index by number of columns
    add eax, colIndex     ; add column index
    imul eax, 4           ; multiply by 4 (DWORD size)
    add ebx, eax          ; EBX points to array[row][col]
    mov eax, [ebx]        ; load element
    mov element, eax

    call WriteDec
    call Crlf
    exit
main ENDP
END main
