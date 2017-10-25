; Programming Assignment #1 - Simple Calculator

; Author: Jon Palmer
; CS_271_400_F2017                Date:10/10/2017
; Description: This program will introduce the programmer, prompt the user for two numbers, 
;	and calculate the sum, difference, product, and quotient with remainder of the numbers.

INCLUDE Irvine32.inc

.data
intro_string		BYTE	"Jon Palmer - Simple Calculator", 0
instruction_string	BYTE	"This Program will calculate the sum, difference, product and quotient of two numbers entered", 0
prompt_1_string		BYTE	"Please enter a number ", 0
prompt_2_string		BYTE	"Please enter another number ", 0
number_1			DWORD	?
number_2			DWORD	?
sum					DWORD	?
difference			DWORD	?
product				DWORD	?
quotient			DWORD	?
remainder			DWORD	?
sum_string			BYTE	" + ", 0
difference_string	BYTE	" - ", 0
product_string		BYTE	" * ", 0
quotient_string		BYTE	" / ", 0
remainder_string	BYTE	" with a remainder of ", 0
equals_string		BYTE	" = ", 0
terminate_string	BYTE	"Goodbye!", 0

.code
main PROC

; Display name and program title on the output screen.

	mov		edx,	OFFSET	intro_string
	call	WriteString
	call	CrLF

; Display instruction for the user

	mov		edx,	OFFSET	instruction_string
	call	WriteString
	call	CrLf

; Prompt user to enter two numbers.

	; first number
	mov		edx,	OFFSET	prompt_1_string
	call	WriteString
	call	ReadInt
	mov		number_1, eax

	; second number
	mov		edx,	OFFSET	prompt_2_string
	call	WriteString
	call	ReadInt
	mov		number_2,	eax

; Calculate sum, difference, product and quotient.

	; sum
	mov		eax,	number_1
	add		eax,	number_2
	mov		sum,	eax

	; difference
	mov		eax,	number_1
	sub		eax,	number_2
	mov		difference,	eax

	; product
	mov		eax,	number_1
	mov		ebx,	number_2
	mul		ebx
	mov		product,	eax

	; quotient
	mov		eax,	number_1
	mov		ebx,	number_2
	div		ebx
	mov		quotient,	eax
	mov		remainder,	edx

; Display results

	; sum
	mov		eax,	number_1
	call	WriteDec
	mov		edx,	OFFSET	sum_string
	call	WriteString
	mov		eax,	number_2
	call	WriteDec
	mov		edx,	OFFSET	equals_string
	call	WriteString
	mov		eax,	sum
	call	WriteDec
	call	CrLf

	; difference
	mov		eax,	number_1
	call	WriteDec
	mov		edx,	OFFSET	difference_string
	call	WriteString
	mov		eax,	number_2
	call	WriteDec
	mov		edx,	OFFSET	equals_string
	call	WriteString
	mov		eax,	difference
	call	WriteDec
	call	CrLf

	; product
	mov		eax,	number_1
	call	WriteDec
	mov		edx,	OFFSET	product_string
	call	WriteString
	mov		eax,	number_2
	call	WriteDec
	mov		edx,	OFFSET	equals_string
	call	WriteString
	mov		eax,	product
	call	WriteDec
	call	CrLf

	; quotient
	mov		eax,	number_1
	call	WriteDec
	mov		edx,	OFFSET	quotient_string
	call	WriteString
	mov		eax,	number_2
	call	WriteDec
	mov		edx,	OFFSET	equals_string
	call	WriteString
	mov		eax,	quotient
	call	WriteDec
	mov		edx,	OFFSET	remainder_string
	call	WriteString
	mov		eax,	remainder
	call	WriteDec
	call	CrLF

; Display terminating message.

	mov		edx,	OFFSET	terminate_string
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

END main
