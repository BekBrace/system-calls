section .data                           ; Data segment
   userMsg db 'Please enter a number: ' ; Ask the user to enter a number
   lenUserMsg equ $-userMsg             ; The length of the message
   dispMsg db 'You have entered: '
   lenDispMsg equ $-dispMsg                 

section .bss           ; Uninitialized data
   num resb 5
	
section .text          ; Code Segment
   global _start
	
_start:                ; User prompt
   mov eax, 4         ; Set the system call number to 4 (sys_write)
   mov ebx, 1         ; Set the file descriptor to 1 (stdout)
   mov ecx, userMsg   ; Set the address of the user message to write
   mov edx, lenUserMsg ; Set the length of the user message
   int 0x80           ; Call the kernel to perform the system call

   ; Read and store the user input
   mov eax, 3         ; Set the system call number to 3 (sys_read)
   mov ebx, 2         ; Set the file descriptor to 2 (stdin)
   mov ecx, num       ; Set the address to store the user input
   mov edx, 5         ; Set the maximum number of bytes to read
   int 0x80           ; Call the kernel to perform the system call
	
   ; Output the message 'The entered number is: '
   mov eax, 4         ; Set the system call number to 4 (sys_write)
   mov ebx, 1         ; Set the file descriptor to 1 (stdout)
   mov ecx, dispMsg   ; Set the address of the display message to write
   mov edx, lenDispMsg ; Set the length of the display message
   int 0x80           ; Call the kernel to perform the system call

   ; Output the number entered
   mov eax, 4         ; Set the system call number to 4 (sys_write)
   mov ebx, 1         ; Set the file descriptor to 1 (stdout)
   mov ecx, num       ; Set the address of the number to write
   mov edx, 5         ; Set the length of the number
   int 0x80           ; Call the kernel to perform the system call  
    
   ; Exit code
   mov eax, 1         ; Set the system call number to 1 (sys_exit)
   mov ebx, 0         ; Set the exit status to 0
   int 0x80           ; Call the kernel to perform the system call
