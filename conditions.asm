INCLUDE irvine32.inc
.data
   
    arr         BYTE 9, 12, 18, 65, 128, 240, 72, 27
    arrSize     DWORD LENGTHOF arr

    cond1Arr    BYTE 20 DUP(?)
    cond2Arr    BYTE 20 DUP(?)
    cond3Arr    BYTE 20 DUP(?)
    cond4Arr    BYTE 20 DUP(?)

    c1          DWORD 0
    c2          DWORD 0
    c3          DWORD 0
    c4          DWORD 0

    msgC1       BYTE 0Ah, 0Dh, "Condition 1 (MSB Set): ", 0
    msgC2       BYTE 0Ah, 0Dh, "Condition 2 (Sum digits % 3 == 0): ", 0
    msgC3       BYTE 0Ah, 0Dh, "Condition 3 (ROL 3 > Original): ", 0
    msgC4       BYTE 0Ah, 0Dh, "Condition 4 (None of the above): ", 0
    msgCount    BYTE "Count: ", 0
    space       BYTE " ", 0

.code
main PROC
   
    mov ecx, arrSize       
    mov esi, 0              

LoopProcess:
    movzx eax, arr[esi]    
    mov dl, 0               

    push eax               
    test al, 80h           
    jz SkipCond1          

    mov edi, c1
    mov cond1Arr[edi], al   
    inc c1                
    mov dl, 1               

SkipCond1:
    pop eax                

    push eax
    call CheckSumDiv3       
    jnz SkipCond2         

    mov edi, c2
    mov cond2Arr[edi], al
    inc c2
    mov dl, 1              

SkipCond2:
    pop eax
    push eax
    
    mov bl, al            
    rol bl, 3             
    cmp bl, al             
    jna SkipCond3         

   
    mov edi, c3
    mov cond3Arr[edi], al
    inc c3
    mov dl, 1               

SkipCond3:
    pop eax

    cmp dl, 0            
    jne NextIter         
  
    mov edi, c4
    mov cond4Arr[edi], al
    inc c4

NextIter:
    inc esi                 
    loop LoopProcess

    call DisplayAllResults
    exit
main ENDP

CheckSumDiv3 PROC USES ebx ecx edx
    mov ebx, 0             
    mov ecx, 10             

SplitDigits:
    cmp al, 0
    je CheckDivisibility   
    
    mov ah, 0              
    div cl                 
    add bl, ah             
    jmp SplitDigits

CheckDivisibility:

    mov al, bl            
    mov ah, 0
    mov cl, 3
    div cl                
    cmp ah, 0              
    ret                   
CheckSumDiv3 ENDP

DisplayAllResults PROC
    mov edx, OFFSET msgC1
    call WriteString
    mov ecx, c1
    mov esi, OFFSET cond1Arr
    call PrintByteArray

    mov edx, OFFSET msgC2
    call WriteString
    mov ecx, c2
    mov esi, OFFSET cond2Arr
    call PrintByteArray

    mov edx, OFFSET msgC3
    call WriteString
    mov ecx, c3
    mov esi, OFFSET cond3Arr
    call PrintByteArray

    mov edx, OFFSET msgC4
    call WriteString
    mov ecx, c4
    mov esi, OFFSET cond4Arr
    call PrintByteArray

    call Crlf
    ret
DisplayAllResults ENDP

PrintByteArray PROC
    cmp ecx, 0
    je PrintCnt            
    
PrintLoop:
    movzx eax, BYTE PTR [esi]  
    call WriteDec
    mov edx, OFFSET space
    call WriteString
    inc esi
    loop PrintLoop

PrintCnt:
    call Crlf
    mov edx, OFFSET msgCount
    call WriteString
    
    ret
PrintByteArray ENDP

END main
