TITLE Chess Board with Alternating Colors(8B(YounghyunKwon).asm)
;a program that draws an 8 X 8 chess board, with alternating 16 colors and white squares.

; Younghyun Kwon
INCLUDE C:\Irvine\Irvine32.inc
WaitMsg			PROTO
WriteChar		PROTO
SetTextColor	PROTO
CrLf			PROTO
Clrscr			PROTO
Delay			PROTO
UpdateColor		PROTO
WriteEvenRow	PROTO, times:BYTE, color:DWORD
WriteOddRow		PROTO, times:BYTE, color:DWORD
WriteSquare		PROTO color:DWORD
WriteBoard		PROTO color:DWORD


.data
    whiteSquare	= white + (white * 16)
    default		= white + (black * 16)
    BOARDROWS	= 8
    BOARDCOLUMNS = 8
	count DWORD 0

.code
    main PROC
		mov ecx, 16					;iterate 16 times
		mov edx, 0
		L1:
			call UpdateColor		;first board color
			invoke WriteBoard, edx	;call WriteBoard PROC with gray color
			inc count				;increase the count
			mov eax, 500			;500 milliseconds to delay
			call Delay				;call Delay
			call Clrscr				;clear the console
			loop L1
		call RestoreDefaultColor	;reset the text color
		call WaitMsg				;call wait msg
		exit						;end the program
    main ENDP

	UpdateColor PROC
		mov edx, count				;move a current count in edx
		imul edx, 16				;multiply by 16
		add edx, count				;add count to edx again
		ret							;return the procedure
	UpdateColor ENDP

    WriteBoard PROC USES ecx, color:DWORD
            mov ecx, BOARDCOLUMNS / 2					;times to write even and odd rows
        Output:											;iterate 4 times
            invoke WriteEvenRow, BOARDROWS / 2, color	;draw an even row
            invoke WriteOddRow, BOARDROWS / 2, color	;draw an odd row
        LOOP Output
        call RestoreDefaultColor						;reset the text color
        ret												;return the procedure
    WriteBoard ENDP

    WriteEvenRow PROC USES ecx, times:BYTE, color:DWORD
        movzx ecx, times						;times to write even and odd rows
        OutputEven:								;iterate 4 times
            invoke WriteSquare, whiteSquare		;draw a white square and a designated colored square 4 times
            invoke WriteSquare, color			
        LOOP OutputEven
        call RestoreDefaultColor				;reset the text color
        call CrLf								;endline
        ret										;return the procedure
    WriteEvenRow ENDP

    WriteOddRow PROC USES ecx, times:BYTE, color:DWORD
        movzx ecx,times							;times to write even and odd rows
        OutputOdd:								;iterate 4 times
            invoke WriteSquare, color			;draw a designated colored square and a white square 4 times
            invoke WriteSquare, whiteSquare
        LOOP OutputOdd
		call RestoreDefaultColor				;reset the text color
        call CrLf								;endline
        ret										;return the procedure
    WriteOddRow ENDP

    WriteSquare PROC USES eax, color:DWORD
        mov eax, color		;move a designated color in eax
        call SetTextColor	;set the text color
        mov al,' '
        call WriteChar		;draw a space with the designated color twice
        call WriteChar
        ret					;return the procedure
    WriteSquare ENDP

    RestoreDefaultColor PROC USES eax
       mov eax, default		;move a default color in eax
       call SetTextColor	;set the text color
       ret					;return the procedure
    RestoreDefaultColor ENDP

END main