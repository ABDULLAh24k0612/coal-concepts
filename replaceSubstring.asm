INCLUDE Irvine32.inc

.data
inputstr  byte "i like assembly language",0
outputstr byte 50 dup(?)
temp      byte "assembly",0
replace   byte "asm",0

.code
main PROC

    mov esi, offset inputstr     
    mov edi, offset outputstr    

next_char:
    lodsb                        
    cmp al, 0
    je finish                   

    mov bl, al                  
   
    lea edx, [esi - 1]           
    mov ecx, LENGTHOF temp - 1   
    mov ebx, 0                  

match_loop:
    mov dl, [edx + ebx]         
    cmp dl, [temp + ebx]        
    jne not_match
    inc ebx
    loop match_loop           

   
    mov esi, offset replace

copy_replace:
    lodsb
    cmp al, 0
    je skip_input
    stosb                      
    jmp copy_replace

skip_input:
    
    lea esi, [edx + ebx]        
    jmp next_char


not_match:
    mov al, bl                   
    stosb                        
    jmp next_char

finish:
    mov al, 0
    stosb                        

   
    mov edx, offset inputstr
    call WriteString
    call CrLf

   
    mov edx, offset outputstr
    call WriteString
    call CrLf

    exit
main ENDP
END main
