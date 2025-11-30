include irvine32.inc

.data
msg1 byte "Enter String: ",0
msg2 byte "Largest Palindromic Substring: ",0
arr byte 50 dup(?)
palindromic byte 50 dup(?)
start dword 0
endd dword 0

n DWORD ?
.code
checkPalindromic PROC
	
	
	mov esi,0
	mov edi,n
	dec edi
	mov edx,0
	mov ebx,2
	mov eax,n
	
	div ebx
	mov ecx,eax
	mov start,esi
	dec start
	mov endd,edi
	inc endd
	L1:
		mov al,arr[esi]
		cmp al,arr[edi]
		je skip
			mov start,esi
			mov endd,edi
		skip:
		inc esi
		dec edi
	loop L1

	mov eax,start
	mov ebx,endd
	sub ebx,eax
	dec ebx
	mov ecx,ebx
	mov ebx,endd
	inc eax
	dec endd
	mov esi,eax
	mov edi,0
	printt:
		mov al,arr[esi]
		mov palindromic[edi],al
		inc esi
		inc edi
	loop printt

	mov edx,offset palindromic
	call writestring
	ret

checkPalindromic ENDP

	main proc
		
		mov edx, offset msg1
		call writestring
		
		mov edx, offset arr
		mov ecx, 50
		call readstring

		mov n, eax

		call checkPalindromic

		exit
	main endp
end main
