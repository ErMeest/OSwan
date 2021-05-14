mov ah, 0x0e
mov al, 'S'         
int 0x10                
mov al, 'y'
int 0x10
mov al, 's'
int 0x10
mov al, 'L'
int 0x10
mov al, 'o'
int 0x10
mov al, 'a'
int 0x10
mov al, 'd'
int 0x10
mov al, 'e'
int 0x10
mov al, 'r'
int 0x10
mov al, ' '
int 0x10
mov al, 'v'
int 0x10
mov al, '0'
int 0x10
mov al, '.'
int 0x10
mov al, '2'
int 0x10
mov al, 0x0d
int 0x10
mov al, 0x0a
int 0x10
mov al, 0x0d
int 0x10
mov al, 0x0a
int 0x10
mov ah, 0x08			;get drive number
int 0x13
mov ah, 0x00			;reset drive
int 0x13
;Load from disk
mov ah, 0x02	;Function 2 (read disk)
mov al, 0x01	;Sector read count
mov ch, 0x00	;cylinder/track
mov cl, 0x02	;sector
mov dh, 0x00	;head/side
mov bx, 0x8000	;buffer
mov [es:bx], bx	;actually load the buffer into the correct
int 0x13
cmp ah, 0x00
jne derr
je jcma
derr:
	mov al, ah
	mov ah, 0x0e
	int 0x10
	jmp $
jcma:
	jmp 0x8000      ;jump to the correct memory address        
times 510-($-$$) db 0
db 0x55, 0xAA           
times 512 db 0
jmp prompt
prompt:
    mov ah, 0x0e
    mov al, '>'
    int 0x10
    mov al, ' '
    int 0x10
    mov eax, 0
    mov ah, 0x00        
    jmp ktest

ktest:
    int 0x16    
    cmp al, 1   
    jg ktest2   
    jmp ktest   
ktest2:
    cmp eax, 1
    je eax1
    cmp eax, 2
    je eax2
    add eax, 1
    mov ah, 0x0e
    cmp al, 0x0d    
    je enter    
    cmp al, 0x08    
    je bspace   
    int 0x10
    mov ah, 0x00
    jmp ktest

eax1:
    lea eax, 0x00000501
    movzx eax, al
    jmp ktest2

eax2:
    lea eax, 0x00000502
    movzx eax, al
    jmp ktest2

enter:
    int 0x10
    mov al, 0x0a
    int 0x10
    mov ah, 0x00
    jmp ctest

bspace:
    int 0x10
    mov al, 0x20
    int 0x10
    mov al, 0x08
    int 0x10
    mov ah, 0x00
    sub eax, 1
    jmp ktest

ctest:
    lea eax, 0x00000501
    cmp eax, 'T'
    je ctet
    jne cerr

ctet:
    lea eax, 0x00000502
    cmp eax, 'S'
    je ts
    jne cerr

ts:
    mov ah, 0x0e
    mov al, 'H'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'y'
    int 0x10
    mov al, '!'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'I'
    int 0x10
    mov al, 't'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'w'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 'r'
    int 0x10
    mov al, 'k'
    int 0x10
    mov al, 's'
    int 0x10
    mov al, '!'
    int 0x10
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    mov ah, 0x00
    jmp ktest

cerr:
    mov ah, 0x0e
    mov al, 'E'
    int 0x10
    mov al, 'R'
    int 0x10
    mov al, 'R'
    int 0x10
    mov al, 'R'
    int 0x10
    mov al, 'O'
    int 0x10
    mov al, 'R'
    int 0x10
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    mov ah, 0x00
    jmp ktest