; Programming Assignment #2 - Fibonacci Sequencer

; Author: Jon Palmer
; CS_271_400_F2017     Date: 10/15/2017
; Description: This program calculates the number of Fibonacci numbers based on a value entered.

INCLUDE Irvine32.inc

UPPER_LIM = 46
LOWER_LIM = 0

.data
intro_string		BYTE	"Jon Palmer - Fibonacci Sequencer", 0
instruction_string	BYTE	"***You will be asked to enter a number in the range [1 .. 46] to display that number of Fibbonaci terms***", 0
prompt_1_string		BYTE	"What is your name? ", 0
prompt_2_string		BYTE	"Hello, ", 0
prompt_3_string		BYTE	", Please enter a number [1 .. 46]: ", 0
prompt_4_string		BYTE	"The number you entered is out of range, please enter another number between 1 and 46: ", 0
user_num			DWORD	?
username_count		DWORD	?
username_string		BYTE	21 DUP(0)
fib_total			DWORD	?
n_1					DWORD	?
n_2					DWORD	?
temp_count			DWORD	?
first_terms			BYTE	"1     ", 0
spacing				BYTE	"     ", 0
exception_rule		BYTE	"2     ", 0
space_modul			DWORD	5
terminate_string	BYTE	"Goodbye, "

.code
main PROC

; Introduction - Display name and program title on the output screen.
	mov		edx,	OFFSET	intro_string
	call	WriteString
	call	CrLf
	call	CrLf

; Instructions - Display user instructions on the output screen
	mov		edx,	OFFSET	instruction_string
	call	WriteString
	call	CrLF
	call	CrLf

; Input - Obtain user name and desired number
	; Prompt user for name
	mov		edx,	OFFSET	prompt_1_string
	call	WriteString
	mov		edx,	OFFSET	username_string
	mov		ecx,	SIZEOF	username_string
	call	ReadString
	mov		username_count,	eax

	; Greet user and prompt for number
	call	CrLf
	mov		edx,	OFFSET	prompt_2_string
	call	WriteString
	mov		edx,	OFFSET	username_string
	call	WriteString
	mov		edx,	OFFSET	prompt_3_string
	call	WriteString
	call	ReadInt
	mov		user_num,	eax
	call	CrLf
	jmp		validate_upper 
	;jump to validation

; Validate user input
validate_upper:
	mov		eax,	UPPER_LIM
	cmp		user_num,	eax
	jg		exceed_range
	jle		validate_lower
	;jump to second validation

validate_lower:
	mov		eax,	LOWER_LIM
	cmp		user_num,	eax
	jle		exceed_range
	jg		first_term_calc
	;proceed to first calculation if both conditons are met

; User entered number outside of range
exceed_range:
	mov		edx,	OFFSET	prompt_4_string
	call	WriteString
	call	ReadInt
	call	CrLf
	mov		user_num,	eax
	jmp		validate_upper
	;proceed to error message and obtain new value

; Calculate and display the first two terms
first_term_calc:
	mov		edx,	OFFSET	first_terms
	call	WriteString
	cmp		user_num,	1
	jg		second_term_calc
	je		terminate
	;if the value entered is larger than 1, proceeed to second term

second_term_calc:
	mov		edx,	OFFSET	first_terms
	call	WriteString
	cmp		user_num,	2
	je		terminate
	jmp		disp_fib
	;if the value entered is larger than 2, proceed to the third term

; Stops overflow from occuring if the user inputs 3
exception_handler:
	mov		edx,	OFFSET	exception_rule
	call	WriteString
	jmp		terminate

; Display Fibonacci Sequence - Calculate and display Fibonacci sequence	
disp_fib:
	cmp		user_num,	3
	je		exception_handler	
	mov		ecx,	user_num
	sub		ecx,	3
	mov		temp_count,	ecx
	mov		eax,	2
	call	WriteDec
	mov		edx,	OFFSET	spacing
	call	WriteString
	mov		n_2,	1
	mov		n_1,	eax
	
calc_fib:
	add		eax,	n_2
	call	WriteDec
	mov		edx,	OFFSET	spacing
	call	WriteString
	mov		temp_count,	eax
	mov		eax,	n_1
	mov		n_2,	eax
	mov		eax,	temp_count
	mov		n_1,	eax

	;spacing
	mov		edx,	ecx
	cdq
	div		space_modul	
	cmp		edx,	0
	jne		space_skip
	call	CrLf

space_skip:
	mov		eax,	temp_count
	loop	calc_fib

	jmp		terminate

; Farewell - Display terminating message.
terminate:
	Call	CrLf
	call	CrLf
	mov		edx,	OFFSET	terminate_string
	call	WriteString
	mov		edx,	OFFSET	username_string
	call	WriteString
	call	CrLf
	call	CrLf

	exit	; exit to operating system
main ENDP

END main
