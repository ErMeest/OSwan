mov [0x1000], dl			;save drive number
cmp byte[0x1000], 0x80
jle iafd
iafd:
	mov byte[0x1001], 0x12
	and byte[0x1001], 3Fh
	mov byte[0x1002], 0x12
	and byte [0x1001], 3Fh
	mov byte[0x1003], 0x50
	jmp etc
jge iahd
iahd:
	mov ah, 0x08
	int 0x13
	mov [0x1001], cl			;save sectors per track number
	and byte[0x1001], 3Fh
	mov [0x1002], cl			;copy it
	and byte[0x1002], 3Fh
	mov [0x1003], ch			;save number of tracks
	jmp etc
etc:
org 0x7c00					;i dont fuckin know
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00
jmp 0:h
h:
	mov ah, 0
	int 0x13
	cli
	xor ax, ax					;clear ah and al
	add ah, 0x02				;set funtcion number
	add al, 0x01				;set sectors to read count	
	xor cx, cx					;clear the sector and track number
	xor dh, dh					;clear head number
	add cl, 0x02&0x3F			;set sector number
	mov dl, [0x1000]			;set drive number	
	mov bx, 0x7e00
	sti
	int 0x13
	mov al, ah
	mov ah, 0x0E
	int 0x10
	mov al, [0x7e00]
	mov ah, 0x02
	inc cl
	mov bx, 0x8000
	int 0x13
	jmp hh
times 510-($-$$) db 0
db 0x55, 0xAA
db 0x01
times 1024-($-$$) db 0
hh:
	mov byte[0x0600], 'I'
	mov byte[0x0601], 't'
	mov byte[0x0602], ' '
	mov byte[0x0603], 'w'
	mov byte[0x0604], 'o'
	mov byte[0x0605], 'r'
	mov byte[0x0606], 'k'
	mov byte[0x0607], 's'
	mov byte[0x0608], '!'
	mov byte[0x0609], 0x00
	mov bx, 0x00
	jmp print1
print1:
	mov ch, 0x00
	cmp [0x0600+bx], ch
	jg print2
	je $
print2:
	mov ah, 0x0e
	mov al, [0x0600+bx]
	int 0x10
	inc bx
	jmp print1
times 10705920-($-$$) db 0