; Programming Assignment #3 - Accumulated Arithmetic

; Author: Jon Palmer
; CS_271_400_F2017     Date: 10/29/2017
; Description: This program repeatedly prompts the user to enter a number validated between [-100, -1].
;			   The program displays the number of negative numbers entered, their sum and average rounded to the nearest integer.

INCLUDE Irvine32.inc

UPPER_LIM = -1
LOWER_LIM = -100

.data
intro_string		BYTE	"Jon Palmer - Accumulated Arithmetic", 0
instruction_string1	BYTE	"***You will be asked to enter an arbitrary amount of numbers in the range [-100, -1].***", 0
instruction_string2	BYTE	"***The program will calculate their sum and average***", 0
prompt_1_string		BYTE	"What is your name? ", 0
prompt_2_string		BYTE	"Hello, ", 0
prompt_3_string		BYTE	"Please enter numbers in the range [-100...-1] ", 0
prompt_4_string		BYTE	"Enter a non-negative number once you are finished to see results. ", 0
prompt_5_string		BYTE	" Enter number: ", 0
prompt_6_string		BYTE	"You failed to enter a negative number.", 0
prompt_7_string		BYTE	"The number you entered is outside of range. Calculating...", 0
user_num			DWORD	?
username_count		DWORD	?
username_string		BYTE	21 DUP(0)
loop_count			DWORD	?
sum_total			DWORD	0
accumulator			DWORD	0
quotient			DWORD	?
total_string		BYTE	"Numbers Entered: ", 0
sum_string			BYTE	"Sum: ", 0
ave_string			BYTE	"Rounded Average: ", 0
terminate_string	BYTE	"Goodbye, ", 0
extra_credit		BYTE	"**EC: Numbered lines during user input", 0


.code

main PROC

; Introduction - Display name and program title on the output screen.
	mov		edx,	OFFSET	intro_string
	call	WriteString
	call	CrLf
	call	CrLf
	mov		edx,	OFFSET	extra_credit
	call	WriteString
	call	CrLf
	call	CrLf

; Instructions - Display user instructions on the output screen
	mov		edx,	OFFSET	instruction_string1
	call	WriteString
	call	CrLF
	mov		edx,	OFFSET	instruction_string2
	call	WriteString
	call	CrLF
	call	CrLf

; Input - Obtain user name and desired numbers
	; Prompt user for name
	mov		edx,	OFFSET	prompt_1_string
	call	WriteString
	mov		edx,	OFFSET	username_string
	mov		ecx,	SIZEOF	username_string
	call	ReadString
	mov		username_count,	eax

	; Greet user 
	call	CrLf
	mov		edx,	OFFSET	prompt_2_string
	call	WriteString
	mov		edx,	OFFSET	username_string
	call	WriteString
	call	CrLf
	call	CrLf
	mov		edx,	OFFSET	prompt_3_string
	call	WriteString
	call	CrLf
	mov		edx,	OFFSET	prompt_4_string
	call	WriteString
	call	CrLf
	call	CrLf
	jmp		user_input

; Loop to prompt user for numbers
user_input:
	;increment counter
	mov		eax,	loop_count
	add		eax,	1
	mov		loop_count,	eax
	call	WriteDec

	;prompt for user number
	mov		edx,	OFFSET	prompt_5_string
	call	WriteString
	call	ReadInt
	mov		user_num,	eax

	jmp		validate_upper



; Validate user input
validate_upper:
	;jump to second validation
	mov		eax,	UPPER_LIM
	cmp		user_num,	eax
	jg		exceed_range
	jle		validate_lower

validate_lower:
	; jump to add if negative, otherwise jump to terminate
	mov		eax,	LOWER_LIM
	cmp		user_num,	eax
	jl		exceed_range
	jge		add_value



; Add user value to sum total
add_value:
	mov		eax,	user_num
	add		eax,	sum_total
	mov		sum_total,	eax
	jmp		user_input



; User entered non-negative number, display error message
exceed_range:

	; Display message indicating a number is entered outside of range
	mov		edx,	OFFSET	prompt_7_string
	call	WriteString
	call	CrLf	
	call	CrLf
	mov		eax,	sum_total
	cmp		eax,	0
	je		no_number
	jne		print_results

; User entered no number
no_number:
	call	CrLf
	mov		edx,	OFFSET	prompt_6_string
	call	WriteString
	call	CrLf
	jmp		terminate


; Print results
print_results:
	; decrement loop_count to compensate for last input
	mov		eax,	loop_count
	sub		eax,	1
	mov		loop_count,	eax

	; Print total numbers entered
	mov		edx,	OFFSET	total_string
	call	WriteString
	mov		eax,	loop_count
	call	WriteDec
	call	CrLf
	
	; print sum
	mov		edx,	OFFSET	sum_string 
	call	WriteString
	mov		eax,	sum_total
	call	WriteInt
	call	CrLf

	; print average
	mov		edx,	OFFSET	ave_string
	call	WriteString
	mov		eax,	0
	mov		eax,	sum_total
	cdq
	mov		ebx,	loop_count
	idiv	ebx
	mov		quotient,	eax
	call	WriteInt

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