; CE-158_ROM_HI.lh5801.asm
; High Bank of Sharp CE-158 RS232/LPT interface
; To fold: Hightlight Ctrl+K Ctrl+,
;

#INCLUDE    "lib/PC-1500.lib"
; #INCLUDE    "lib/CE-150.lib"
; #INCLUDE    "lib/CE-158.lib"
; #INCLUDE    "lib/CE-158N.lib"
#INCLUDE    "lib/PC-1500_Macros.lib"

; Modifications enabled by uncommenting #DEFINEs. Not all defines used in both banks.
; BUGFIX    - (HB)    Fixed 'off by one bug' found in original ROM
; CE158_48  - (HB,LB) Original HW build 4800bps (not finished yet)

.org $C000

; $C000
ST_MAIN_ROM:
    .BYTE  $55

; $C001
SA_XREG_2RAM:
    POP  U
    LIN  U
    PSH  U
    STA  UL
    LDI  UH,$78
    LDA  XH
    SIN  U
    LDA  XL
    STA  (U)
    RTN

; $C00E
SAVEVARPTR_ARX_SRC:
    LDA  (ARX + $07)

; $C011
SAVEVARPTR_A:
    STA  (CURVARTYPE)   ; CURVARTYPE = $7885
    LDA  UL
    STA  (CURVARADD_L)
    LDA  UH
    STA  (CURVARADD_H)
    RTN

; $C01D
TRACE_VEC:
    .BYTE  $C4,$AF
    .BYTE  $FF

.END 
; ***

; $C020
ST_BAS_TBL:
    .BYTE  $C0,$56,$C0,$99,$C0,$A2,$C0,$E2
    .BYTE  $C1,$0E,$C1,$28,$C1,$30,$00,$00
    .BYTE  $C1,$63,$00,$00,$00,$00,$C1,$87
    .BYTE  $C1,$C2,$C1,$D3,$C1,$EC,$C2,$0A
    .BYTE  $00,$00,$C2,$5F,$C2,$B8,$C2,$F6
    .BYTE  $C3,$2A,$C3,$3F,$C3,$47,$00,$00
    .BYTE  $00,$00,$00,$00

; $C054
TOKEN_TBL:
    .BYTE  $B5,$41,$52,$45,$41,$44,$F1,$80
    .BYTE  $C6,$84,$A3,$41,$4E,$44,$F1,$50
    .BYTE  $CD,$89,$A3,$41,$42,$53,$F1,$70
    .BYTE  $F5,$97,$A3,$41,$54,$4E,$F1,$75
    .BYTE  $F4,$96,$A3,$41,$53,$4E,$F1,$73
    .BYTE  $F4,$9A,$A3,$41,$43,$53,$F1,$74
    .BYTE  $F4,$92,$A3,$41,$53,$43,$F1,$60
    .BYTE  $D9,$DD,$84,$41,$52,$55,$4E,$F1
    .BYTE  $81,$C6,$84,$B4,$42,$45,$45,$50
    .BYTE  $F1,$82,$E5,$C1,$D4,$43,$4F,$4E
    .BYTE  $54,$F1,$83,$C8,$C7,$86,$43,$55
    .BYTE  $52,$53,$4F,$52,$F0,$84,$E8,$46
    .BYTE  $C5,$43,$4C,$45,$41,$52,$F1,$87
    .BYTE  $C8,$5F,$C3,$43,$4C,$53,$F0,$88
    .BYTE  $E8,$65,$C3,$43,$4F,$53,$F1,$7E
    .BYTE  $F3,$91,$A4,$43,$48,$52,$24,$F1
    .BYTE  $63,$D9,$B1,$A4,$43,$41,$4C,$4C
    .BYTE  $F1,$8A,$C8,$63,$D3,$44,$49,$4D
    .BYTE  $F1,$8B,$C9,$88,$C6,$44,$45,$47
    .BYTE  $52,$45,$45,$F1,$8C,$C6,$97,$C3
    .BYTE  $44,$45,$47,$F1,$65,$F5,$31,$A3
    .BYTE  $44,$4D,$53,$F1,$66,$F5,$64,$A4
    .BYTE  $44,$41,$54,$41,$F1,$8D,$C6,$84
    .BYTE  $B3,$45,$4E,$44,$F1,$8E,$C5,$0D
    .BYTE  $A3,$45,$58,$50,$F1,$78,$F1,$CB
    .BYTE  $A5,$45,$52,$52,$4F,$52,$F1,$B4
    .BYTE  $CD,$89,$B3,$46,$4F,$52,$F1,$A5
    .BYTE  $C7,$11,$B4,$47,$4F,$54,$4F,$F1
    .BYTE  $92,$C5,$15,$C5,$47,$4F,$53,$55
    .BYTE  $42,$F1,$94,$C6,$4E,$A6,$47,$50
    .BYTE  $52,$49,$4E,$54,$F0,$9F,$E7,$AC
    .BYTE  $C7,$47,$43,$55,$52,$53,$4F,$52
    .BYTE  $F0,$93,$E8,$3E,$C4,$47,$52,$41
    .BYTE  $44,$F1,$86,$C6,$A8,$D5,$49,$4E
    .BYTE  $50,$55,$54,$F0,$91,$C8,$FA,$C2
    .BYTE  $49,$46,$F1,$96,$C5,$B4,$A3,$49
    .BYTE  $4E,$54,$F1,$71,$F5,$BE,$A6,$49
    .BYTE  $4E,$4B,$45,$59,$24,$F1,$5C,$D9
    .BYTE  $AA,$D4,$4C,$49,$53,$54,$F0,$90
    .BYTE  $C9,$6E,$83,$4C,$4F,$47,$F1,$77
    .BYTE  $F1,$65,$A2,$4C,$4E,$F1,$76,$F1
    .BYTE  $61,$A3,$4C,$45,$54,$F1,$98,$C4
    .BYTE  $58,$A3,$4C,$45,$4E,$F1,$64,$D9
    .BYTE  $DD,$85,$4C,$45,$46,$54,$24,$F1
    .BYTE  $7A,$D9,$F3,$C4,$4C,$4F,$43,$4B
    .BYTE  $F1,$B5,$C9,$68,$D3,$4D,$45,$4D
    .BYTE  $F1,$58,$DA,$5D,$C4,$4D,$49,$44
    .BYTE  $24,$F1,$7B,$D9,$F3,$D4,$4E,$45
    .BYTE  $58,$54,$F1,$9A,$C7,$05,$A3,$4E
    .BYTE  $4F,$54,$F1,$6D,$59,$9E,$A3,$4E
    .BYTE  $45,$57,$F1,$9B,$C8,$0A,$92,$4F
    .BYTE  $4E,$F1,$9C,$C5,$E0,$A2,$4F,$52
    .BYTE  $F1,$51,$CD,$89,$A3,$4F,$50,$4E
    .BYTE  $F1,$9D,$E4,$57,$C3,$4F,$46,$46
    .BYTE  $F1,$9E,$CD,$89,$B5,$50,$52,$49
    .BYTE  $4E,$54,$F0,$97,$E4,$EB,$C2,$50
    .BYTE  $49,$F1,$5D,$F5,$B5,$C5,$50,$45
    .BYTE  $45,$4B,$23,$F1,$6E,$D9,$93,$A4
    .BYTE  $50,$45,$45,$4B,$F1,$6F,$D9,$93
    .BYTE  $A5,$50,$4F,$4B,$45,$23,$F1,$A0
    .BYTE  $C7,$78,$C4,$50,$4F,$4B,$45,$F1
    .BYTE  $A1,$C7,$77,$C5,$50,$4F,$49,$4E
    .BYTE  $54,$F1,$68,$EE,$CB,$A5,$50,$41
    .BYTE  $55,$53,$45,$F1,$A2,$E6,$A5,$A5
    .BYTE  $50,$20,$20,$20,$20,$F1,$A3,$CD
    .BYTE  $89,$B3,$52,$55,$4E,$F1,$A4,$C8
    .BYTE  $B4,$86,$52,$45,$54,$55,$52,$4E
    .BYTE  $F1,$99,$C6,$AC,$A4,$52,$45,$41
    .BYTE  $44,$F1,$A6,$C7,$B8,$A7,$52,$45
    .BYTE  $53,$54,$4F,$52,$45,$F1,$A7,$C7
    .BYTE  $A2,$A3,$52,$4E,$44,$F1,$7C,$F5
    .BYTE  $DD,$A6,$52,$41,$4E,$44,$4F,$4D
    .BYTE  $F1,$A8,$F6,$41,$C6,$52,$49,$47
    .BYTE  $48,$54,$24,$F1,$72,$D9,$F3,$C6
    .BYTE  $52,$41,$44,$49,$41,$4E,$F1,$AA
    .BYTE  $C6,$A4,$C3,$52,$45,$4D,$F1,$AB
    .BYTE  $C6,$76,$B4,$53,$54,$4F,$50,$F1
    .BYTE  $AC,$C4,$B6,$A3,$53,$51,$52,$F1
    .BYTE  $6B,$F0,$E9,$A3,$53,$49,$4E,$F1
    .BYTE  $7D,$F3,$A2,$A3,$53,$47,$4E,$F1
    .BYTE  $79,$F5,$9D,$A4,$53,$54,$52,$24
    .BYTE  $F1,$61,$D9,$CE,$A6,$53,$54,$41
    .BYTE  $54,$55,$53,$F1,$67,$5A,$44,$A4
    .BYTE  $53,$54,$45,$50,$F1,$AD,$CD,$89
    .BYTE  $B4,$54,$48,$45,$4E,$F1,$AE,$CD
    .BYTE  $89,$A3,$54,$41,$4E,$F1,$7F,$F3
    .BYTE  $9E,$A4,$54,$49,$4D,$45,$F1,$5B
    .BYTE  $DE,$82,$C4,$54,$52,$4F,$4E,$F1
    .BYTE  $AF,$C6,$8C,$C5,$54,$52,$4F,$46
    .BYTE  $46,$F1,$B0,$C6,$93,$C2,$54,$4F
    .BYTE  $F1,$B1,$CD,$89,$B5,$55,$53,$49
    .BYTE  $4E,$47,$F0,$85,$C6,$7C,$C6,$55
    .BYTE  $4E,$4C,$4F,$43,$4B,$F1,$B6,$C9
    .BYTE  $6A,$D3,$56,$41,$4C,$F1,$62,$D9
    .BYTE  $D7,$94,$57,$41,$49,$54,$F1,$B3
    .BYTE  $E8,$6A,$D0

; $C34F
SM_NEW0:
    .BYTE  $4E,$45,$57,$30,$3F,$20,$3A,$43
    .BYTE  $48,$45,$43,$4B,$20

; $C35C
SM_BREAK:
    .BYTE  $42,$52,$45,$41,$4B,$20

; $C362
SM_IN:
    .BYTE  $49,$4E,$20

; $C36B
SM_ERROR:
    .BYTE  $45,$52,$52,$4F,$52,$20

; $C36B
DEFKEY_TBL:
    .BYTE  $20,$41,$42,$43,$44,$F0,$46,$47
    .BYTE  $48,$F0,$4A,$4B,$4C,$4D,$4E,$F0
    .BYTE  $F0,$F0,$F1,$53,$F1,$F0,$56,$F0
    .BYTE  $58,$F1,$5A,$20,$20,$3D,$20,$20

; $C38B
EDCTRL_TBL:
    .BYTE  $CA,$64,$CB,$61,$CA,$55,$CA,$80
    .BYTE  $CB,$C7,$CB,$CF,$CB,$9C,$CB,$A0
    .BYTE  $CC,$22,$CB,$69,$CC,$48,$CC,$38
    .BYTE  $CB,$E4,$CC,$C1,$C4

; $C3A8
FVAL_TBLE:
    .BYTE  $C6,$CD,$71,$2B,$81,$3F,$08,$00
    .BYTE  $2D,$81,$3F,$08,$00,$2A,$82,$22
    .BYTE  $04,$E2,$2F,$82,$22,$04,$E2,$5E
    .BYTE  $84,$22,$04,$E2,$3D,$80,$22,$04
    .BYTE  $32,$3C,$80,$22,$3D,$15,$3E,$80
    .BYTE  $22,$3D,$29,$0D,$00,$22,$01,$E1
    .BYTE  $2C,$60,$22,$01,$E2,$28,$20,$1D
    .BYTE  $01,$0A,$29,$10,$22,$20,$E2,$2E
    .BYTE  $00,$1D,$00,$58,$22,$00,$1D,$00
    .BYTE  $35,$5D,$F1,$1D,$00,$5A,$5B,$F1
    .BYTE  $1D,$10,$64,$26,$00,$1D,$00,$39

; $ C400
BASIC_INT:
    VEJ  (C0)
    VEJ  (D8)
    BZR  BASIC_INT_1 ; $C409
    CPI  UL,$0D
    VZS  ($42)($21)
    VEJ  (E4)

BASIC_INT_1: ; $C409
    VMJ  ($04) \ ABRF(BCMD_STOP_1) ; $C4C5

BASIC_INT_7: ; $C40C
    VMJ  ($18)

BASIC_INT_9: ; $C40E
    LDI  S,(CPU_STACK + $4F)
    BCS  BASIC_INT_2 ; $C42A

BASIC_INT_8: ; $C413
    LDI  A,$00
    VMJ  ($3E)
    BZR  BCMD_STOP_1 ; $C4C5
    LDA  (CURS_CTRL)
    SHL
    BCR  BASIC_INT_2 ; $C42A
    CPI  A,$C0
    BCR  BCMD_LET_4  ; $C4A5
    SJP  (KEY2ASCII)
    CPI  A,$0A
    BZR BCMD_LET_4  ; $C4A5

BASIC_INT_2: ; $C42A
    VMJ  ($A6)($53)  
    BZR  BCMD_STOP_2 ; $C4BA

BASIC_INT_11: ; $C42E
    LDA  (CURR_LINE_H)
    INC  A
    BZS  BCMD_END_1  ; $C510
    LDA  YH
    SHL
    BCS  BASIC_INT_3 ; $C444

BASIC_INT_10: ; $C438
    LDI  A,$01
    VMJ  ($3E)
    VZR  ($00) \ ABYT($CD) \ ABYT($22) \ ABRF(BCMD_STOP_3) ; $C4C2
    LDA  (X)

BASIC_INT_3: ; $C444
    BCH  BASIC_INT_1; $C409 
    SHR
    STA  YH

BASIC_INT_12: ; $C446
    VEJ  (C0)

BASIC_INT_6: ; $C447
    LDI  S,(CPU_STACK + $4F)
    CPI  UH,$E0
    BCR  BASIC_INT_4 ; $C457
    CPI  UL,$80
    BCR  BASIC_INT_5 ; $C456
    VMJ  ($1C) \ ABYT($00)
    VEJ  (E0)

BASIC_INT_5: ; $C456
    DEC  Y

BASIC_INT_4: ; $C457
    DEC  Y 

; $C458
BCMD_LET:
    VEJ  (D8)
    BZR  BCMD_LET_1 ; $C461
    LDI  A,$02
    VMJ  ($3E)
    BZR  BCMD_STOP_4 ; $C4C4

BCMD_LET_1: ; $C461
    VEJ  (CE) \ ABYT($58) \ ABRF(BCMD_LET_2); $C489
    VEJ  (DA)
    VEJ  (C2) \ ACHR($3D) \ ABRF(BCMD_LET_3); $C499
    VEJ  (DE) \ ABRF(BCMD_STOP_4) ; $C4C4
    VMJ  ($08) \ ABRF(BCMD_STOP_4) ; $C4C4
    VEJ  (D8)
    BZR  BCMD_LET_5 ; $C476
    
BCMD_LET_8: ; $C470  
    LDI  A,$04
    VMJ  ($3E)
    BZR  BCMD_STOP_4 ; $C4C4

BCMD_LET_5: ; $C476
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_LET_6) ; $C47B
    BCH BCMD_LET_1 ; $C461

BCMD_LET_6: ; $C47B
    LDI  A,$20
    STA  (DISPARAM)
    VMJ  ($04) \ ABRF(BCMD_STOP_1) ; $C4C5
    VEJ  (D8)
    VZR  ($40)($20)
    JMP  BUTTON_CL_4 ; $CA7D

BCMD_LET_2: ; $C489
    CPI  UH,$15
    BZR BCMD_STOP_4 ; $C4C4
    VEJ  (D8)
    BZR BCMD_STOP_4 ; $C4C4
    DEC  Y
    LDA  UL
    BZS BCMD_LET_7 ; $C495
    DEC  Y

BCMD_LET_7: ; $C495
    VEJ  (DE) \ ABRF(BCMD_STOP_4); $C4C4
    BCH BCMD_LET_8 ; $C470

BCMD_LET_3: ; $C499
    VEJ  (D8)
    BZR BCMD_STOP_1 ; $C4C5
    VEJ  (C6)
    VMJ  ($0A)
    SJP  (DEC2HEX_1) ; $D6D9
    SBC  (U)
    BCH BCMD_LET_8 ; $C470

BCMD_LET_4: ; $C4A5
    LDI  UL,$01 
    VEJ  (CC) \ ABYTL(TRACE_ON); $788D
    BZS BCMD_STOP_6 ; $C4AD
    LDI  UL,$00
    BCH BCMD_STOP_5 ; $C4BC



TRCROUTINE: ; $C4AF
    VEJ  (CC) \ ABYTL($788E)
    BZS $C4AB
    LDI  UH,$00
    RTN



BCMD_STOP: ; $C4B6
    VEJ  (C8) \ ABRF(BCMD_STOP_1) ; $C4C5
    VMJ  ($18)

BCMD_STOP_2: ; $C4BA
    LDI  UL,$02 
    PSH  U

BCMD_STOP_5: ; $C4BC
    VEJ  (D4) \ ABYT($AC)
    POP  U

BCMD_STOP_3: ; $C4C2
    BCH BCMD_STOP_7 ; $C4D9 

BCMD_STOP_4: ; $C4C4
    VEJ  (E0) 

BCMD_STOP_1: ; $C4C5
    VEJ  (E4)  

BCMD_STOP_9: ; $C4C6   
    ANI  #(PC1500_IF_REG),$FD
    BII  (DISP_BUFF + $4F),$40
    VZS  ($42)($21)
    BII  (BREAKPARAM),$60
    VZS  ($42)($21)
    LDI  UL,$02

BCMD_STOP_7: ; $C4D9
    ORI  (BREAKPARAM),$80
    ANI  (BREAKPARAM),$EF
    PSH  U
    SJP  (SAVELCD2BUF)
    POP  U
    LDI  A,$01
    STA  (DISPARAM)
    ANI  #(PC1500_IF_REG),$FD
    DEC  UL
    VZS  ($46)($23)
    LDI  YL,$10
    LDI  YH,$7A
    PSH  Y
    LDI  A,$3A
    BCR BCMD_STOP_7 ; $C505
    VMJ  ($2A) \ ABYT($5B) \ ABYT($09)
    LDI  A,$20

BCMD_STOP_8: ; $C505
    PSH  A
    VEJ  (CC) \ ABYTL(PREV_LINE_H) ; $78A2
    JMP  ERRN_5 ; $CDD4

BCMD_STOP_6: ; $C4AD
    NOP


; $C50D
BCMD_END:
    VEJ  (C2) \ ACHR($0D) \ ABRF(BCMD_ON_1) ; $C5F9

BCMD_END_1:; $C510
    SJP  (PRGLINE_TDI_1) ; $CFF7
    VMJ  ($42)($21)



BCMD_GOTO: ; $C515
    VEJ  (D8)
    BZR DEFKEY_EVAL_1 ; $C5A2
    LDI  UH,$1A
    BII  (DISP_BUFF + $4F),$40
    VZS  ($E0)
    SJP  (BTN_DOWN_1) ; $CC86
    BII  (V),$C1
    DEC  XL
    VEJ  (F2)
    BCH DEFKEY_EVAL_2 ; $C578



DEFKEY_EVAL: ; $C529
    STA  XL
    STA  (BAS_DATA_STK_L)
    SJP  (ISARXBCD_1) ; $DBF5
    ADI  (FORNXT_STK_PTR),$04
    REC
    SJP  (STRXFR)
    SJP  (BTN_ENTER_1) ; $CCDE
    LDA  UH
    LDI  XL,$82
    LDI  XH,$78
    STA  (X)
    LDI  A,$01
    VMJ  ($24)
    LDI  UH,$FF
    SJP  (LINESEARCH) \ ABRF(DEFKEY_EVAL_3); $C589
    VEJ  (D6) \ ABYT($A6)
    VMJ  ($22)
    BCS DEFKEY_EVAL_2 ; $C578
    VEJ  (C4) \ AWRD($F180) \ ABRF(DEFKEY_EVAL_2) ; $C578
    VEJ  (CE) \ ABYT($58) \ ABRF(DEFKEY_EVAL_4) ; $C59F
    VEJ  (DA)
    VEJ  (CC) \ ABYTL(DISPARAM) ; $7880
    BII  A,$40
    BZS DEFKEY_EVAL_5 ; $C57D
    PSH  Y
    SJP  (VAR_TYPE)
    BCR DEFKEY_EVAL_6 ; $C597
    POP  Y
    BZR DEFKEY_EVAL_7 ; $C575

DEFKEY_EVAL_8: ; $C56A
    VEJ  (EC)
    VEJ  (CC) \ ABYTL(CURVARTYPE) ; $7885
    SHL
    LDI  A,$D0
    BCS DEFKEY_EVAL_7 ;  $C575
    STA  (ARX + $04)

DEFKEY_EVAL_7: ; $C575
    VMJ  ($08) \ ABRF(DEFKEY_EVAL_4) ; $C59F

DEFKEY_EVAL_2: ; $C578
    VMJ  ($3A)
    JMP  BCMD_READ_1 ; $C8C2

DEFKEY_EVAL_5: ; $C57D
    BII  A,$22
    BZS DEFKEY_EVAL_8 ; $C56A
    SEC
    SJP  (STRXFR)
    VMJ  ($30)
    BCH DEFKEY_EVAL_7 ; $C575

DEFKEY_EVAL_3: ; $C589
    BII  (DISPARAM),$40
    BZR DEFKEY_EVAL_9 ; $C592
    SJP  (INBUF_CLRRST_1) ; $D02B

DEFKEY_EVAL_9: ; $C592
    NOP
    NOP
    VEJ  (C0)
    LDI  UH,$0B

DEFKEY_EVAL_6: ; $C597
    ANI  (CURR_LINE_L),$00
    ANI  (CURR_LINE_H),$00

DEFKEY_EVAL_4: ; $C59F
    VMJ  ($3A)
    VEJ  (E0)

DEFKEY_EVAL_1: ; $C5A2
    VMJ  ($2E) \ ABRF(BCMD_GOSUB_1) ; $C675
    VEJ  (D0) \ ABYT($83) \ ABRF(BCMD_GOSUB_1) ; $C675
    VMJ  ($1A) \ ABRF(BCMD_GOSUB_1) ; $C675

DEFKEY_EVAL_10: ; $C5AB
    VEJ  (C2) \ ACHR($0D) \ ABRF(BCMD_ON_1) ; $C5F9
    VEJ  (D4) \ ABYT($A0)
    VEJ  (D6) \ ABYT($A6)
    BCH $C671


; $C5B4
BCMD_IF:
    VEJ  (DE) \ ABRF(BCMD_GOSUB_1) ; $C675
    LDI  XL,$04
    LDI  XH,$7A
    LIN  X
    CPI  A,$B2
    BCR BCMD_IF_1 ; $C5C5
    BZS BCMD_IF_2 ; $C5C7
    LDI  XL,$07
    BCH BCMD_IF_3 ; $C5CB

BCMD_IF_1: ; $C5C5
    LDI  XL,$01

BCMD_IF_2: ; $C5C7
    LIN  X
    SHL
    BCS BCMD_REM

BCMD_IF_3: ; $C5CB
    LDA  (X)
    BZS BCMD_REM
    VEJ  (C2) \ AWRD($F1AE) \ ABRF(BCMD_IF_4) ; $C5D9 , $F1AE = THEN token
    VEJ  (C0)
    BCR BCMD_IF_5 ; $C5DD
    CPI  UL,$80
    BCR BCMD_IF_6 ; $C5DC

BCMD_IF_4: ; $C5D9
    JMP  BASIC_INT_6 ; $C447
    
BCMD_IF_6: ; $C5DC    
    DEC  Y

BCMD_IF_5: ; $C5DD
    DEC  Y
    BCH DEFKEY_EVAL_1 ; $C5A2


; $C5E0
BCMD_ON:
    VEJ  (C2) \ AWRD($F1B4) \ ABRF(BCMD_ON_2) ; $C605
    VEJ  (C2) \ AWRD($F192) \ ABRF(BCMD_ON_1) ; $C5F9
    VMJ  ($2E) \ ABRF(BCMD_GOSUB_1) ; $C675
    VEJ  (D0) \ ABYT($82) \ ABRF(BCMD_GOSUB_1) ; $C675
    LDA  UL
    BZR BCMD_ON_3 ; $C5FA
    LDA  UH
    BZR BCMD_ON_3 ; $C5FA
    ORI  (ON_ERR_ADD_H),$80
    VEJ  (E2)

BCMD_ON_1: ; $C5F9
    VEJ  (E4)

BCMD_ON_3: ; $C5FA
    VMJ  ($1A) \ ABRF(BCMD_GOSUB_1) ; $C675
    LDI  UL,$A6
    LDI  XL,$B8
    SJP  (BCMD_TIME_1) ; $DF06
    VEJ  (E2)

BCMD_ON_2: ; $C605
    VEJ  (C6)
    VEJ  (DE) \ ABRF(BCMD_GOSUB_1) ; $C675
    VMJ  ($26)
    LDI  UL,$D0
    EOR  (X)
    ADC  XL
    BCH BCMD_ON_4 ; $C612
    LDI  A,$50

BCMD_ON_4: ; $C612
    PSH  A
    VEJ  (C2) \ AWRD($F192) \ ABRF(BCMD_ON_5) ; $C61A
    BCH BCMD_ON_9 ; $C61E

BCMD_ON_5: ; $C61A
    VEJ  (C4) \ AWRD($F194) \ ABRF(BCMD_ON_6) ; $C64D

BCMD_ON_9: ; $C61E
    PSH  A
    POP  U
    PSH  U
    DEC  UL
    BZS BCMD_ON_7 ; $C62D
    SJP  (BCMD_TIME_2) ; $DF44
    INC  UL
    BZR BCMD_ON_8 ; $C642

BCMD_ON_7: ; $C62D
    VMJ  ($2E) \ ABRF(BCMD_GOSUB_1) ; $C675
    VEJ  (D0) \ ABYT($83) \ ABRF(BCMD_GOSUB_1) ; $C675
    VMJ  ($1A) \ ABRF(BCMD_GOSUB_1) ; $C675
    SJP  (BCMD_TIME_3) ; $DF42
    POP  U
    LDA  UH
    SHR
    SHR
    BCR BCMD_GOSUB_2 ; $C65A
    BCH DEFKEY_EVAL_10 ; $C5AB

BCMD_ON_8: ; $C642
    LDI  A,$0D
    CPA  (Y)
    POP  U
    VCS  ($E2)
    DEC  UH
    VHS  ($E2)

BCMD_ON_6: ; $C64D
    VEJ  (E4)


; $C64E
BCMD_GOSUB:
    VMJ  ($2E) \ ABRF(BCMD_GOSUB_1) ; $C675
    VEJ  (D0) \ ABYT($83) \ ABRF(BCMD_GOSUB_1) ; $C675
    VMJ  ($1A) \ ABRF(BCMD_GOSUB_1) ; $C675
    VEJ  (C8) \ ABRF(BCMD_NEXT_1) ; $C710
    DEC  Y

BCMD_GOSUB_2: ; $C65A
    LDA  (GOSB_STK_PTR_L)
    SEC
    SBI  A,$05
    CPA  (FORNXT_STK_PTR)
    BCR BCMD_GOSUB_3 ; $C673
    STA  (STK_PTR_GSB_FOR)
    DEC  A
    STA  (GOSB_STK_PTR_L)
    SJP  (BCMD_TIME_5) ; $DEFC
    VEJ  (D6) \ ABYT($A6)
    BCH BCMD_RETURN_1 ; $C6BF

BCMD_GOSUB_3: ; $C673
    LDI  UH,$0F

BCMD_GOSUB_1: ; $C675
    VEJ  (E0)



BCMD_REM: ; $C676
    VMJ  ($20)
    REC
    JMP  BASIC_INT_7 ; $C40C



; $C67C
BCMD_USING:
    LDI  A,$01
    SJP  (EVAL_USING_1) ; $DAB4
    VEJ  (DE) \ ABRF(BCMD_FOR_1) ; $C760 ***wrong original calc
    VEJ  (E2)




BCMD_DATA: ; $C684
    DEC  Y
    LDI  S,(CPU_STACK + $4F)
    SJP  (BCMD_TIME_3) ; $DF42
    VEJ  (E2)


; $C68C
BCMD_TRON:
    LDA  (OPN)

BCMD_TRON_1: ; $C68F
    STA  (TRACE_ON)
    VEJ  (E2)

; $C693
BCMD_TROFF:
    LDI  A,$00
    BCH BCMD_TRON_1 ; $C68F

; $C697
BCMD_DEGREE:
    LDI  UL,$03

BCMD_DEGREE_1: ; $C699
    LDA  (DISP_BUFF + $4F)
    ANI  A,$F8
    REC
    ADC  UL
    STA  (DISP_BUFF + $4F)
    VEJ  (E2)

; $C6A4
BCMD_RADIAN:
    LDI  UL,$04
    BCH BCMD_DEGREE_1 ; $C699

; $C6A8
BCMD_GRAD:
    LDI  UL,$06
    BCH BCMD_DEGREE_1 ; $C699

; $C6AC
BCMD_RETURN:
    VEJ  (C2) \ ACHR($0D) \ ABRF(BCMD_NEXT_1) ; $C710
    LDA  (GOSB_STK_PTR_L)
    INC  A
    BCS BCMD_NEXT_2 ; $C70D
    STA  (STK_PTR_GSB_FOR)
    ADI  (GOSB_STK_PTR_L),$06

BCMD_RETURN_5: ; $C6BC
    SJP  (BCMD_TIME_4) ; $DEC7

BCMD_RETURN_1: ; $C6BF
    JMP  BASIC_INT_8 ; $C413

BCMD_RETURN_6: ; $C6C2
    PSH  Y
    ADI  A,$09
    STA  (FORNXT_STK_PTR)
    VEJ  (DA)
    LDX  U
    SJP  (ISARXBCD_2) ; $DC20
    VEJ  (D2) \ ABRF(BCMD_NEXT_1) \ ABYT($80) ; $C710
    VMJ  ($08) \ ABRF(BCMD_RETURN_2) ; $C6D5
    
BCMD_RETURN_2: ; $C6D5  
    VEJ  (E6)
    VMJ  ($06)
    VMJ  ($10) \ ABYT($80)
    SJP  (SUBTR)
    VMJ  ($06)
    LDI  YL,$02
    LDE  Y
    BZS BCMD_RETURN_3 ; $C6FD
    LDA  UH
    EOR  (Y)
    ROL
    BCS BCMD_RETURN_3 ; $C6FD
    VMJ  ($10) \ ABYT($80)
    VEJ  (E6)
    VEJ  (CC) \ ABYTL(CURVARADD_H) ; $7883
    SJP  (ISARXBCD_2) ; $DC20
    VEJ  (F0)
    VMJ  ($08) \ ABRF(BCMD_RETURN_4) ; $C6F7
    
BCMD_RETURN_4: ; $C6F7
    POP  Y
    VEJ  (C8) \ ABRF(BCMD_NEXT_1) ; $C710
    BCH BCMD_RETURN_5 ; $C6BC

BCMD_RETURN_3: ; $C6FD
    POP  Y
    ADI  (FORNXT_STK_PTR),$F4
    VEJ  (E2)


; $C704
BCMD_NEXT:
    VEJ  (C6)
    VEJ  (CE) \ ABYT($68) \ ABRF($C70F)
    SJP  (VARONBSTK)

BCMD_NEXT_2: ; $C70D
    BCS BCMD_RETURN_6 ; $C6C2
    LDI  UH,$02
    VEJ  (E0)

BCMD_NEXT_1: ; $C710
    VEJ  (E4)


; $C711
BCMD_FOR:
    VEJ  (CE) \ ABYT($68) \ ABRF(BCMD_FOR_2) ; $C776
    VEJ  (DA)
    SJP  (VARONBSTK)
    BCS BCMD_FOR_3 ; $C73D
    LDA  (FORNXT_STK_PTR)
    STA  (STK_PTR_GSB_FOR)
    DEC  A
    ADI  A,$0A
    BCS BCMD_FOR_4 ; $C774
    CPA  (GOSB_STK_PTR_L)
    BCS BCMD_FOR_4 ; $C774
    CPI  UH,$80
    BCR BCMD_FOR_5 ; $C73B
    CPI  UH,$DB
    BZS BCMD_FOR_5 ; $C73B
    VEJ  (F4) \ AWRD(VAR_START_H)
    LDI  A,$F8
    ADR  U
    DEC  UH

BCMD_FOR_5: ; $C73B
    VMJ  ($32)

BCMD_FOR_3: ; $C73D
    VEJ  (C2) \ ACHR($3D) \ ABRF(BCMD_POKE_1) ; $C7A1
    VEJ  (DE) \ ABRF(BCMD_FOR_2) ; $C776
    VMJ  ($08) \ ABRF(BCMD_FOR_2) ; $C776
    VEJ  (C2) \ AWRD($F1B1) \ ABRF(BCMD_POKE_1) ; $C7A1
    VEJ  (DE) \ ABRF(BCMD_FOR_2) ; $C776
    VEJ  (D0) \ ABYT($04) \ ABRF(BCMD_FOR_2) ; $C776
    VMJ  ($32)
    VEJ  (C2) \ AWRD($F1AD) \ ABRF(BCMD_FOR_6) ; $C761
    VEJ  (DE) \ ABRF(BCMD_FOR_2) ; $C776
    VEJ  (D0) \ ABYT($04) \ ABRF(BCMD_FOR_2) ; $C776
    ORA  (ARX + $05) 
    BZR BCMD_FOR_7 ; $C766
    LDI  UH,$13

BCMD_FOR_1: ; $C760
    VEJ  (E0)

BCMD_FOR_6: ; $C761
    VEJ  (C6)
    LDI  UL,$01
    LDI  UH,$00

BCMD_FOR_7: ; $C766
    VMJ  ($32)
    VEJ  (C8) \ ABRF(BCMD_POKE_1) ; $C7A1)
    SJP  (BCMD_TIME_6) ; $DEFE
    LDA  XL
    STA  (FORNXT_STK_PTR)
    JMP  BASIC_INT_9 ; $C40E

BCMD_FOR_4: ; $C774
    LDI  UH,$0E

BCMD_FOR_2: ; $C776
    VEJ  (E0)   


; $C777
BCMD_POKE:
    REC
    LDA  XL
    PSH  A
    VEJ  (DE) \ ABRF(BCMD_READ_2) ; $C7F1
    VEJ  (D0) \ ABYT($00) \ ABRF(BCMD_READ_2) ; $C7F1
    PSH  U
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_POKE_1) ; $C7A1

BCMD_POKE_3: ; $C785
    VEJ  (DE) \ ABRF(BCMD_READ_2) ; $C7F1
    VEJ  (D0) \ ABYT($08) \ ABRF(BCMD_READ_2) ; $C7F1
    POP  X
    POP  A
    PSH  A
    ROR
    LDA  UL
    BCR BCMD_POKE_2 ; $C797
    SIN  X
    BCH BCMD_POKE_4 ; $C79A

BCMD_POKE_2: ; $C797
    STA  #(X)
    INC  X

BCMD_POKE_4: ; $C79A
    PSH  X
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_READ_7) ; $C7E4
    BCH BCMD_POKE_3 ; $C785

BCMD_POKE_1: ; $C7A1
    VEJ  (E4)


; $C7A2
BCMD_RESTORE:
    SJP  (BTN_DOWN_2) ; $CC8B
    ORI  (X),$62
    VEJ  (CC) \ ABYTL(CURR_TOP_H) ; $789E
    INC  X
    INC  X
    INC  X
    LDA  XH
    BCR $C7B1
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    ORI  A,$80
    STA  XH
    VEJ  (CA) \ ABYTL(DATA_PTR_H) ; $78BE
    DEC  Y
    VEJ  (E2)

BCMD_RESTORE_1: ; $C7B8
    VEJ  (CE) \ ABYT($58) \ ABRF(BCMD_READ_2) ; $C7F1

; $C7BB
BCMD_READ:
    VEJ  (DA)
    PSH  Y
    VEJ  (CC) \ ABYTL(DATA_PTR_H) ; $78BE
    STX  Y
    ROL
    BCR BCMD_READ_3 ; $C7C9
    SHR
    STA  YH
    BCH BCMD_READ_4 ; $C7F4

BCMD_READ_3: ; $C7C9
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_READ) ; $C7E6

BCMD_READ_10: ; $C7CC
    VEJ  (DE) \ ABRF(BCMD_READ_6) ; $C7EF
    VEJ  (C8) \ ABRF($C7D2)
    BCH $C7D5
    VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_READ_6) ; $C7EF
    DEC  Y
    LDX  Y
    VEJ  (CA) \ ABYTL(DATA_PTR_H) ; $78BE
    POP  Y
    VMJ  ($08) \ ABRF(BCMD_READ_2) ; $C7F1
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_READ_7) ; $C7E4
    BCH BCMD_RESTORE_1 ; $C7B8

BCMD_READ_7: ; $C7E4
    VMJ  ($40)($20)

BCMD_READ_5: ; $C7E6
    DEC  Y
    VMJ  ($20)

BCMD_READ_11: ; $C7E9
    LIN  Y
    INC  A
    BZR BCMD_READ_8 ; $C7F2
    LDI  UH,$04

BCMD_READ_6: ; $C7EF
    POP  Y

BCMD_READ_2: ; $C7F1 
    VEJ  (E0)

BCMD_READ_8: ; $C7F2
    INC  Y
    INC  Y

BCMD_READ_4: ; $C7F4
    PSH  Y
    VMJ  ($22)
    BCS BCMD_READ_9 ; $C802
    VEJ  (C4) \ AWRD($F18D) \ ABRF(BCMD_READ_9) ; $C802
    POP  X
    BCH BCMD_READ_10 ; $C7CC

BCMD_READ_9: ; $C802
    POP  Y
    DEC  Y
    LIN  Y
    ADR  Y
    BCH BCMD_READ_11 ; $C7E9
    SBC  VL
    SHR
    BHR BCMD_READ_12 ; $C81B
    VEJ  (C8) \ ABRF(BCMD_CONT_1) ; $C8F0
    VMJ  ($38)
    VCR  ($E0)
    LDI  UL,$BC
    SJP  (DEL_DIM_VARS_1) ; $D0AE
    VMJ  ($42)($21)

BCMD_READ_12: ; $C81B
    VEJ  (C8) \ ABRF(BCMD_READ_13) ; $C821
    VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865
    BCH BCMD_READ_14 ; $C855

BCMD_READ_13: ; $C821
    VEJ  (C6)
    VEJ  (DE) \ ABRF(BCMD_CONT_2) ; $C8F1
    VEJ  (D0) \ ABYT($00) \ ABRF(BCMD_CONT_2) ; $C8F1
    VEJ  (C8) \ ABRF(BCMD_CONT_1) ; $C8F0
    VEJ  (DC)
    LDA  (ST_ROM_MOD) ; $7860
    SHL
    LDA  XL
    BZR BCMD_READ_15 ; $C840
    LDA  XH
    BZR BCMD_READ_15 ; $C840
    BCR BCMD_READ_16 ; $C838
    LDI  XL,$C5

BCMD_READ_16: ; $C838
    LDA  (RAM_ST_H)
    SJP  (UNLOCK)
    BCH BCMD_READ_17 ; $C853

BCMD_READ_15: ; $C840
    LDI  UH,$19
    VCR  ($E0)
    LDA  XL
    SBI  A,$C5
    LDA  XH
    SBC  (RAM_ST_H)
    VCR  ($E0)
    LDA  XH
    CPA  (RAM_END_H)
    VCS  ($E0)

BCMD_READ_17: ; $C853
    VEJ  (CA) \ ABYTL(BASPRG_ST_H) ; $7865

BCMD_READ_14: ; $C855
    VEJ  (CA) \ ABYTL(BASPRG_EDT_H) ; $7869

BCMD_READ_20: ; $C857
    ORI  (X),$FF
    VEJ  (CA) \ ABYTL(BASPRG_END_H) ; $7867
    DEC  Y
    SJP  (PRGLINE_TDI_2) ; $D00D
    SJP  (DELSVARS)
    VEJ  (E2)
    VEJ  (DE) \ ABRF(BCMD_CONT_2) ; $C8F1
    VEJ  (D0) \ ABYT($00) \ ABRF(BCMD_CONT_2) ; $C8F1
    PSH  U
    VEJ  (C8) \ ABRF(BCMD_READ_18) ; $C871
    LDI  UH,$80
    VEJ  (DA)
    BCH BCMD_READ_19 ; $C889

BCMD_READ_18: ; $C871
    VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_CONT_1) ; $C8F0
    VEJ  (CE) \ ABYT($58) \ ABRF(BCMD_CONT_2) ; $C8F1
    CPI  UH,$80
    BCS BCMD_INPUT_1 ; $C965
    VEJ  (DA)
    VEJ  (C8) \ ABRF(BCMD_CONT_1) ; $C8F0
    VEJ  (DC)
    CPI  A,$80
    BCR BCMD_READ_19 ; $C889
    VMJ  ($0A)
    VEJ  (D0) \ ABYT($04) \ ABRF(BCMD_CONT_2) ; $C8F1
    VEJ  (DC)

BCMD_READ_19: ; $C889    
    DEC  Y
    POP  U
    PSH  Y
    LDI  YL,$97
    LDI  YH,$C8
    PSH  Y
    PSH  U
    RTN
    POP  Y
    VCR  ($E2)
    BII  (CURVARADD_H),$80
    VZR  ($E2)
    BII  (CURVARTYPE),$80 ; $7885
    BZS BCMD_READ_22 ; $C8B0
    STX  U
    SJP  (ARUINT2ARX)

BCMD_READ_21: ; $C8AC
    VMJ  ($08) \ ABRF(BCMD_CONT_2) ; $C8F1
    VEJ  (E2)

BCMD_READ_22: ; $C8B0
    VMJ  ($24)
    BCH BCMD_READ_21 ; $C8AC
    INC  XL
    SJP  (BTN_DOWN_1) ; $CC86
    NOP
    VCR  ($42)($21)
    SJP  (DELDVARS)
    SJP  (PRGLINE_TDI_2) ; $D00D

BCMD_READ_23: ; $C8C1
    VEJ  (F2)

BCMD_READ_1: ; $C8C2
    VEJ  (D6) \ ABYT($A6)
    JMP  BASIC_INT_10 ; $C438



BCMD_CONT: ; $C8C7
    INC  XL
    VEJ  (C8) \ ABRF(BCMD_CONT_1) ; $C8F0
    BII  (BREAKPARAM),$E0
    VZS  ($E4)
    ANI  (CURS_CTRL),$7F
    VEJ  (F2)

BCMD_CONT_3: ; $C8D5
    ORI  (DISP_BUFF + $4E),$01
    VEJ  (D6) \ ABYT($AC)
    LDA  (BREAKPARAM)
    ANI  (BREAKPARAM),$0F
    ROL
    ROL
    BCR $C8F2
    SJP  (INBUF_CLRRST_1) ; $D02B
    ORI  (BREAKPARAM),$50
    JMP  BUTTON_CL_2 ; $CA75

BCMD_CONT_1: ; $C8F0
    VEJ  (E4)

BCMD_CONT_2: ; $C8F1
    VEJ  (E0)
    ROL
    BCR BCMD_READ_20 ; $C8F7

; $C8F5
BCMD_CLEAR:
    DEC  Y
    VEJ  (E2)
    JMP  BASIC_INT_11 ; $C42E

; $C8FA
BCMD_INPUT:
    VEJ  (C2) \ ACHR($23) \ ABRF(BCMD_INPUT_2) ; $C900
    JMP  $E4E7

BCMD_INPUT_2: ; $C900
    VEJ  (D8)
    BZR BCMD_INPUT_3 ; $C906
    LDI  UH,$1A
    VEJ  (E0)

BCMD_INPUT_3: ; $C906
    VEJ  (C6)

BCMD_INPUT_9: ; $C907
    SJP  (INBUF_CLR)
    VEJ  (C2) \ ACHR($22) \ ABRF(BCMD_INPUT_4) ; $C95D
    VMJ  ($0C)
    PSH  Y
    LDI  YL,$B0
    LDI  YH,$7B
    LDA  (ARX + $07)
    STA  UL
    SJP  (XREG2YREG)
    LDA  YL
    STA  (INBUFPTR_L)
    POP  Y
    VEJ  (C2) \ ACHR($3B) \ ABRF(BCMD_INPUT_5) ; $C929
    LDI  A,$40
    BCH BCMD_INPUT_6 ; $C933

BCMD_INPUT_5: ; $C929
    VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_DIM_6) ; $C9E3
   
BCMD_INPUT_8: ; $C92C  
    LDI  A,$B0
    STA  (INBUFPTR_L)
    LDI  A,$00

BCMD_INPUT_6: ; $C933
    STA  (DISPARAM)
    VEJ  (CE) \ ABYT($58) \ ABRF(BCMD_INPUT_7) ; $C967
    VEJ  (F6) \ AWRD(LASTVARADD_H)
    INC  X
    LDA  (ARX + $07)
    STA  (X)
    ORI  (BREAKPARAM),$50
    VEJ  (D4) \ ABYT($A0)
    VEJ  (D4) \ ABYT($AC)
    LDA  (INBUFPTR_L)
    STA  YL
    LDI  YH,$7B
    ANI  (CURS_CTRL),$9F
    SJP  (PREPLCDOUT)
    LDI  UH,$20
    VCS  ($E0)
    JMP  BUTTON_CL_4 ; $CA7D

BCMD_INPUT_4: ; $C95D
    VEJ  (C6)
    LDI  A,$3F
    STA  (IN_BUF)
    BCH BCMD_INPUT_8 ; $C92C

BCMD_INPUT_1: ; $C965
    LDI  UH,$07

BCMD_INPUT_7: ; $C967
    VEJ  (E0)


; $C968
BCMD_LOCK:
    LDI  A,$00


; $C96A
BCMD_UNLOCK:
    STA  (UNDEF_REG_79FF)
    VEJ  (E2)


; $C96E
BCMD_LIST:
    SBC  UL
    SJP  (BTN_DOWN_1); $CC86
    LDA  XL
    BCS BCMD_LIST_1 ; $C97D
    VMJ  ($42)($21)
    VCR  ($E0)
    CPI  UH,$0B
    VZR  ($E0)

BCMD_LIST_1: ; $C97D
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    DEC  X
    DEC  X
    SJP  (BCD_Y2ARX_1) ; $D2D0
    LDI  A,$14
    VMJ  ($44)($22)


; $C988
BCMD_DIM:
    VEJ  (CE) \ ABYT($14) \ ABRF(BCMD_DIM_1) ; $C9D4
    VEJ  (DA)
    VMJ  ($2C) \ ABRF(BCMD_DIM_1) ; $C9D4
    PSH  U
    LDI  A,$88
    BII  (CURVARADD_L),$20
    BZS BCMD_DIM_2 ; $C9A1
    VEJ  (C2) \ ACHR($2A) \ ABRF(BCMD_DIM_1) ; $C9D5
    VEJ  (DE) \ ABRF(BCMD_DIM_1) ; $C9D4
    VEJ  (D0) \ ABYT($0D) \ ABRF(BCMD_DIM_1) ; $C9D4
    
BCMD_DIM_2: ; $C9A1    
    STA  (CURVARTYPE) ; $7885
    POP  U
    PSH  Y
    PSH  U
    LDA  UH
    STA  YL
    LDI  UH,$00
    LDI  YH,$00
    INC  U
    INC  Y
    VMJ  ($50)($28)
    BCS BCMD_DIM_3 ; $C9CE
    LDA  (CURVARTYPE) ; $7885
    ANI  A,$7F
    STA  UL
    VMJ  ($50)($28)
    BCS BCMD_DIM_3 ; $C9CE
    POP  U
    SJP  (SRCHPRGLINE_1) ; $D386
    BCS BCMD_DIM_3 ; $C9D2
    POP  Y
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_DIM_4) ; $C9DC
    BCH BCMD_DIM

BCMD_DIM_8: ; $C9CE
    LDI  UH,$0A
    POP  X

BCMD_DIM_3: ; $C9D2
    POP  Y

BCMD_DIM_1: ; $C9D4
    VEJ  (E0)
    VEJ  (C6)
    LDI  A,$10
    BCH BCMD_DIM_2 ; $C9A1

BCMD_DIM_7: ; $C9DA
    VEJ  (C8) \ ABRF(BCMD_DIM_5) ; $C9DE
    
BCMD_DIM_4: ; $C9DC   
    VMJ  ($40)($20)

BCMD_DIM_5: ; $C9DE
    VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_DIM_6) ; $C9E3
    BCH BCMD_INPUT_9 ; $C907

BCMD_DIM_6: ; $C9E3
    VEJ  (E4)



COLD_START: ; $C9E4
    SJP  (PRGLINE_TDI_3) ; $CFCC
    SJP  (INBUF_INIT)
    LDI  UL,$0C
    LDA  (ARV + $01)
    STA  UH
    LDI  XL,$4F
    LDA  (ARV)
    BZR COLD_START_1 ; $CA24
    LDI  XL,$55
    LDI  UL,$06
    LDA  UH
    ORA  (ARV + $02)
    BZR COLD_START_2 ; $CA29
    BII  (DISP_BUFF + $4F),$40
    BZS BTN_SHCL
    SJP  (PRGST2XREG)
    LDI  A,$00

COLD_START_7: ; $CA0C
    BCR BTN_SHCL
    PSH  A
    SJP  (DEL_DIM_VARS_2) ; $D0B4
    STX  Y
    VMJ  ($22)
    BCS COLD_START_3 ; $CA4A
    VEJ  (C4) \ AWRD($F181) \ ABRF(COLD_START_3); $CA4A
    ORI  (DISP_BUFF + $4E),$01
    JMP  BCMD_READ_23 ; $C8C1

COLD_START_1: ; $CA24
    LDI  A,$23
    STA  (DISP_BUFF + $4F)

COLD_START_2: ; $CA29
    SJP  (SYSMSG)
    LDI  XL,$30
    LDA  (ARV + $02)

COLD_START_6: ; $CA32
    STA  XH
    LDA  XH
    SHR
    STA  XH
    LDA  UH
    ROR
    STA  UH
    BCR COLD_START_4 ; $CA3C
    LDA  XL
    SIN  Y

COLD_START_4: ; $CA3C
    INC  XL
    CPI  XL,$3A
    BZR COLD_START_5 ; $CA43
    LDI  XL,$41

COLD_START_5: ; $CA43
    DEC  UL
    BHS COLD_START_6 ; $CA32
    LDI  A,$80
    VMJ  ($44)($22)

COLD_START_3: ; $CA4A
    POP  A
    DEC  A
    BCS BTN_SHCL
    VMJ  ($14)
    LDI  A,$FF
    BCH COLD_START_7 ; $CA0C


BTN_SHCL: ; $CA55
    SJP  (PRGLINE_TDI_3) ; $CFCC


WARM_START: ; $CA58
CA58   BE D0 2B                   SJP  (INBUF_CLRRST_1) ; $D02B
CA5B   B5 3E                      LDI  A,$3E
CA5D   1E                         STA  (Y)
CA5E   E9 78 8A EF                ANI  (BREAKPARAM),$EF
CA62   8E 14                      BCH BUTTON_CL_3 ; $CA78


BUTTON_CL: ; CA64
CA64   81 01                      BCR BUTTON_CL_1 ; $CA67
CA66   F2                         VEJ  (F2)

BUTTON_CL_1: ; $CA67
CA67   BE D0 11                   SJP  (PRGLINE_TDI_4) ; $D011
CA6A   91 14                      BCR- WARM_START
CA6C   BE D0 21                   SJP  (INBUF_CLRRST)
CA6F   B5 40                      LDI  A,$40
CA71   5E B0                      CPI  YL,$B0
CA73   89 05                      BZR BUTTON_CL_5 ; $CA7A

BUTTON_CL_2: ; $CA75
CA75   B5 3F                      LDI  A,$3F
CA77   1E                         STA  (Y)

BUTTON_CL_3: ; $CA78
CA78   B5 00                      LDI  A,$00

BUTTON_CL_5: ; $CA7A
CA7A   AE 78 80                   STA  (DISPARAM)

BUTTON_CL_4: ; $CA7D
CA7D   BE E8 CA                   SJP  (PRGMDISP)
CA80   E9 78 9D 00                ANI  (CURR_LINE_L),$00
CA84   E9 78 9C 00                ANI  (CURR_LINE_H),$00
CA88   E9 76 4E FE                ANI  (DISP_BUFF + $4E),$FE
CA8C   AA 78 4F                   LDI  S,(CPU_STACK + $4F)
CA8F   BE E2 43                   SJP  (WAIT4KB)
CA92   2A                         STA  UL
CA93   CC 80                      VEJ  (CC) \ ABYTL(DISPARAM) ; $7880
CA95   6E 19                      CPI  UL,$19
CA97   8B C8                      BZS BTN_RCL
CA99   6E 09                      CPI  UL,$09
CA9B   8B CC                      BZS RSV_CHNG
CA9D   28                         STA  UH
CA9E   D1                         ROR
CA9F   81 0D                      BCR BUTTON_CL_7 ; $CAAE
CAA1   FD 62                      DEC  UH
CAA3   FD A8                      PSH  U
CAA5   BE EE 99                   SJP  (BUF2LCD)
CAA8   FD 2A                      POP  U
CAAA   E9 78 80 FE                ANI  (DISPARAM),$FE

BUTTON_CL_7: ; $CAAE
CAAE   24                         LDA  UL
CAAF   B7 20                      CPI  A,$20
CAB1   81 2C                      BCR BUTTON_CL_6 ; $CADF
CAB3   6C 80                      CPI  UH,$80
CAB5   C3 46                      VCS  ($46)($23)
CAB7   BF 60                      BII  A,$60
CAB9   68 00                      LDI  UH,$00
CABB   89 1D                      BZR BUTTON_CL_16 ; $CADA
CABD   4A EB                      LDI  XL,$EB
CABF   48 C2                      LDI  XH,$C2
CAC1   FD CA                      ADR  X
CAC3   05                         LDA  (X)
CAC4   B7 E0                      CPI  A,$E0
CAC6   83 11                      BCS $CAD9
CAC8   2A                         STA  UL
CAC9   ED 76 4F 40                BII  (DISP_BUFF + $4F),$40
CACD   8B 0B                      BZS BUTTON_CL_16 ; $CADA
CACF   EB 76 4E 01                ORI  (DISP_BUFF + $4E),$01
CAD3   28                         STA  UH
CAD4   CD 3A                      VMJ  ($3A)
CAD6   BA C5 29                   JMP  DEFKEY_EVAL ; $C529
CAD9   28                         STA  UH

BUTTON_CL_16: ; $CADA
CADA   BE CE 4A                   SJP  (DEFEVAL)
CADD   9E 62                      BCH BUTTON_CL_4 ; $CA7D

BUTTON_CL_6: ; $CADF
CADF   D9                         SHL
CAE0   85 16                      BHR BUTTON_CL_8 ; $CAF8
CAE2   BF 20                      BII  A,$20
CAE4   8B 02                      BZS BUTTON_CL_9 ; $CAE8
CAE6   B9 0E                      ANI  A,$0E

BUTTON_CL_9: ; $CAE8
CAE8   6A 8B                      LDI  UL,$8B
CAEA   68 C3                      LDI  UH,$C3
CAEC   FD EA                      ADR  U
CAEE   65                         LIN  U
CAEF   08                         STA  XH
CAF0   25                         LDA  (U)
CAF1   0A                         STA  XL
CAF2   A5 78 80                   LDA  (DISPARAM)
CAF5   D9                         SHL
CAF6   FD 5E                      STX  P

BUTTON_CL_8: ; $CAF8
CAF8   6C 80                      CPI  UH,$80
CAFA   C3 46                      VCS  ($46)($23)

BUTTON_CL_15: ; $CAFC
CAFC   BE CE 87                   SJP  (DEFEVAL_1) ; $CE87
CAFF   ED 76 4F 10                BII  (DISP_BUFF + $4F),$10
CB03   8B 28                      BZS BUTTON_CL_10 ; $CB2D
CB05   BE D0 30                   SJP  (INBUF_INIT)
CB08   B5 46                      LDI  A,$46
CB0A   51                         SIN  Y
CB0B   A4                         LDA  UH
CB0C   BB 30                      ORI  A,$30
CB0E   51                         SIN  Y
CB0F   B5 3A                      LDI  A,$3A
CB11   51                         SIN  Y
CB12   14                         LDA  YL
CB13   AE 78 8B                   STA  (INBUFPTR_L)
CB16   CD 38                      VMJ  ($38)
CB18   BE CE C4                   SJP  (RESKEY_SRCH)
CB1B   B5 48                      LDI  A,$48
CB1D   81 0C                      BCR BUTTON_CL_11 ; $CB2B
CB1F   45                         LIN  X
CB20   BF E0                      BII  A,$E0
CB22   8B 03                      BZS BUTTON_CL_12 ; $CB27
CB24   51                         SIN  Y
CB25   9E 08                      BCH $CB1F

BUTTON_CL_12: ; $CB27
CB27   5A B3                      LDI  YL,$B3
CB29   B5 08                      LDI  A,$08

BUTTON_CL_11: ; $CB2B
CB2B   CD 44                      VMJ  ($44)($22)

BUTTON_CL_10: ; $CB2D
CB2D   CD 38                      VMJ  ($38)
CB2F   68 00                      LDI  UH,$00
CB31   BE CE C4                   SJP  (RESKEY_SRCH)
CB34   91 5C                      BCR- BUTTON_CL_16 ; $CADA
CB36   45                         LIN  X
CB37   B7 40                      CPI  A,$40
CB39   8B E2                      BZS PRG_ENTER
CB3B   2A                         STA  UL

BUTTON_CL_14: ; $CB3C
CB3C   24                         LDA  UL
CB3D   68 00                      LDI  UH,$00
CB3F   B7 E0                      CPI  A,$E0
CB41   81 03                      BCR BUTTON_CL_13 ; $CB46
CB43   28                         STA  UH
CB44   45                         LIN  X
CB45   2A                         STA  UL

BUTTON_CL_13: ; $CB46
CB46   BE CE 4A                   SJP  (DEFEVAL)
CB49   45                         LIN  X
CB4A   2A                         STA  UL
CB4B   B7 20                      CPI  A,$20
CB4D   91 D2                      BCR- BUTTON_CL_4 ; $CA7D
CB4F   B7 40                      CPI  A,$40
CB51   8B CA                      BZS PRG_ENTER
CB53   15                         LDA  (Y)
CB54   B7 0D                      CPI  A,$0D
CB56   9B 1C                      BZS BUTTON_CL_14 ; $CB3C
CB58   B7 27                      CPI  A,$27
CB5A   9B 20                      BZS BUTTON_CL_14 ; $CB3C
CB5C   BE CD E6                   SJP  (INS2INBUF)
CB5F   9E 25                      BCH BUTTON_CL_14 ; $CB3C



BTN_RCL: ; $CB61
CB61   D1                         ROR
CB62   83 2F                      BCS RSV_CHNG_1 ; $CB93

BTN_RCL_1: ; $CB64
CB64   BE EE 80                   SJP  (SAVELCD2BUF)
CB67   8E 1E                      BCH RSV_CHNG_2 ; $CB87



RSV_CHNG: ; $CB69
CB69   4A 4E                      LDI  XL,$4E
CB6B   48 76                      LDI  XH,$76
CB6D   05                         LDA  (X)
CB6E   49 8F                      ANI  (X),$8F
CB70   B9 70                      ANI  A,$70
CB72   D5                         SHR
CB73   85 02                      BHR RSV_CHNG_3 ; $CB77
CB75   B5 40                      LDI  A,$40

RSV_CHNG_3: ; $CB77
CB77   0B                         ORA  (X)
CB78   0E                         STA  (X)
CB79   A5 78 80                   LDA  (DISPARAM)
CB7C   BF 09                      BII  A,$09
CB7E   9B 1C                      BZS BTN_RCL_1 ; $CB64
CB80   D1                         ROR
CB81   A5 78 84                   LDA  (CURVARADD_L)
CB84   91 8A                      BCR- BUTTON_CL_15 ; $CAFC
CB86   38                         NOP

RSV_CHNG_2: ; $CB87
CB87   EB 78 80 01                ORI  (DISPARAM),$01
CB8B   BE CE AF                   SJP  (DEFEVAL_2) ; $CEAF
CB8E   BE EF 44                   SJP  (TXT2LCD)
CB91   CD 46                      VMJ  ($46)($23)

RSV_CHNG_1: ; $CB93
CB93   E9 78 80 FE                ANI  (DISPARAM),$FE
CB97   BE EE 99                   SJP  (BUF2LCD)
CB9A   CD 46                      VMJ  ($46)($23)



BTN_SHMODE: ; $CB9C
CB9C   6A 10                      LDI  UL,$10
CB9E   8E 02                      BCH $CBA2



BTN_MODE: ; $CBA0
CBA0   6A 40                      LDI  UL,$40
CBA2   C3 46                      VCS  ($46)($23)
CBA4   4A 4F                      LDI  XL,$4F
CBA6   48 76                      LDI  XH,$76
CBA8   A5 79 FF                   LDA  (UNDEF_REG_79FF)
CBAB   CB 46                      VZS  ($46)($23)
CBAD   24                         LDA  UL
CBAE   09                         AND  (X)
CBAF   8B 06                      BZS BTN_MODE_1 ; $CBB7
CBB1   D5                         SHR
CBB2   85 02                      BHR BTN_MODE_2 ; $CBB6
CBB4   B5 40                      LDI  A,$40

BTN_MODE_2: ; $CBB6
CBB6   2A                         STA  UL

BTN_MODE_1: ; CBB7
CBB7   49 0F                      ANI  (X),$0F
CBB9   24                         LDA  UL
CBBA   0B                         ORA  (X)
CBBB   0E                         STA  (X)
CBBC   BE D0 17                   SJP  ($D017)
CBBF   81 04                      BCR BTN_MODE_3 ; $CBC5
CBC1   EB 78 8A 80                ORI  (BREAKPARAM),$80

BTN_MODE_3: ; $CBC5
CBC5   CD 42                      VMJ  ($42)($21)



BTN_INS: ; $CBC7
CBC7   D9                         SHL
CBC8   C1 46                      VCR  ($46)($23)
CBCA   BE CD E6                   SJP  (INS2INBUF)
CBCD   8E 12                      BCH BTN_DEL_2 ; $CBE1



BTN_DEL: ; $CBCF
CBCF   D9                         SHL
CBD0   C1 46                      VCR  ($46)($23)
CBD2   15                         LDA  (Y)
CBD3   B7 0D                      CPI  A,$0D
CBD5   CB 46                      VZS  ($46)($23)
CBD7   B7 E0                      CPI  A,$E0
CBD9   81 03                      BCR BTN_DEL_1 ; $CBDE
CBDB   BE CE 38                   SJP  (DELFRMINBUF)

BTN_DEL_1: ; $CBDE
CBDE   BE CE 38                   SJP  (DELFRMINBUF)

BTN_DEL_2: ; $CBE1
CBE1   BA CA 7D                   JMP  BUTTON_CL_4 ; $CA7D




BTN_RIGHT: ; $CBE4
CBE4   DB                         ROL
CBE5   83 18                      BCS BTN_RIGHT_1 ; $CBFF
CBE7   DB                         ROL
CBE8   81 2B                      BCR BTN_RIGHT_2 ; $CC15
CBEA   D1                         ROR
CBEB   D1                         ROR
CBEC   83 3A                      BCS BTN_LRFT_1 ; $CC28
CBEE   56                         DEC  Y
CBEF   5A B0                      LDI  YL,$B0

BTN_RIGHT_3: ; $CBF1
CBF1   E9 78 80 5B                ANI  (DISPARAM),$5B
CBF5   EB 78 80 40                ORI  (DISPARAM),$40
CBF9   EB 7B 0E 40                ORI  (CURS_CTRL),$40
CBFD   9E 1E                      BCH BTN_DEL_2 ; $CBE1

BTN_RIGHT_1: ; $CBFF
CBFF   15                         LDA  (Y)
CC00   B7 0D                      CPI  A,$0D
CC02   9B 13                      BZS BTN_RIGHT_3 ; $CBF1
CC04   B7 E0                      CPI  A,$E0
CC06   81 08                      BCR  BTN_RIGHT_4 ; $CC10
CC08   50                         INC  YL
CC09   50                         INC  YL
CC0A   91 1B                      BCR- BTN_RIGHT_3 ; $CBF1
CC0C   52                         DEC  YL

BTN_RIGHT_5: ; $CC0D
CC0D   52                         DEC  YL
CC0E   9E 1F                      BCH BTN_RIGHT_3 ; $CBF1

BTN_RIGHT_4: ; $CC10
CC10   50                         INC  YL

BTN_RIGHT_6: ; $CC11
CC11   91 22                      BCR- BTN_RIGHT_3 ; $CBF1
CC13   9E 08                      BCH BTN_RIGHT_5 ; $CC0D

BTN_RIGHT_2: ; $CC15
CC15   DB                         ROL
CC16   93 27                      BCS BTN_RIGHT_3 ; $CBF1
CC18   DB                         ROL
CC19   C1 46                      VCR  ($46)($23)
CC1B   9E 2C                      BCH BTN_RIGHT_3 ; $CBF1



PRG_ENTER: ; $CC1D
CC1D   CC 80                      VEJ  (CC) \ ABYTL(DISPARAM) ; $7880
CC1F   DB                         ROL
CC20   8E A1                      BCH BTN_ENTER_2 ; $CCC3



BTN_LRFT: ; CC22
CC22   DB                         ROL
CC23   83 04                      BCS BTN_LRFT_2 ; $CC29
CC25   DB                         ROL
CC26   91 13                      BCR- BTN_RIGHT_2 ; $CC15

BTN_LRFT_1: ; $CC28
CC28   F2                         VEJ  (F2)

BTN_LRFT_2: ; $CC29
CC29   14                         LDA  YL
CC2A   BE DC AE                   SJP  (ISARXBCD_3) ; $DCAE
CC2D   91 3E                      BCR- BTN_RIGHT_3 ; $CBF1
CC2F   56                         DEC  Y
CC30   9B 41                      BZS BTN_RIGHT_3 ; $CBF1
CC32   56                         DEC  Y
CC33   55                         LIN  Y
CC34   B7 E0                      CPI  A,$E0
CC36   9E 27                      BCH BTN_RIGHT_6 ; $CC11



BTN_UP: ; $CC38
CC38   EB 7B 0E 40                ORI  (CURS_CTRL),$40
CC3C   A5 76 4F                   LDA  (DISP_BUFF + $4F)
CC3F   DB                         ROL
CC40   B9 C0                      ANI  A,$C0
CC42   CB 46                      VZS  ($46)($23)
CC44   D9                         SHL
CC45   2A                         STA  UL
CC46   8E 34                      BCH BTN_DOWN_3 ; $CC7C



BTN_DOWN: ; $CC48
CC48   C3 46                      VCS  ($46)($23)
CC4A   A5 76 4F                   LDA  (DISP_BUFF + $4F)
CC4D   DB                         ROL
CC4E   DB                         ROL
CC4F   81 22                      BCR BTN_DOWN_4 ; $CC73
CC51   ED 78 8A E0                BII  (BREAKPARAM),$E0
CC55   CB 46                      VZS  ($46)($23)
CC57   BE D0 11                   SJP  (PRGLINE_TDI_4) ; $D011
CC5A   81 06                      BCR BTN_DOWN_5 ; $CC62
CC5C   EB 7B 0E C0                ORI  (CURS_CTRL),$C0
CC60   9E 45                      BCH PRG_ENTER

BTN_DOWN_5: ; $CC62
CC62   A5 7B 0E                   LDA  (CURS_CTRL)
CC65   BF 40                      BII  A,$40
CC67   8B 02                      BZS BTN_DOWN_6 ; $CC6B
CC69   BB 20                      ORI  A,$20

BTN_DOWN_6: ; $CC6B
CC6B   BB C0                      ORI  A,$C0
CC6D   AE 7B 0E                   STA  (CURS_CTRL)
CC70   BA C8 D5                   JMP  BCMD_CONT_3 ; $C8D5

BTN_DOWN_4: ; $CC73
CC73   EB 7B 0E 40                ORI  (CURS_CTRL),$40
CC77   DB                         ROL
CC78   C1 46                      VCR  ($46)($23)
CC7A   6A 01                      LDI  UL,$01

BTN_DOWN_3: ; $CC7C
CC7C   FD A8                      PSH  U
CC7E   BE DF F3                   SJP  (PRGST2XREG)
CC81   C1 46                      VCR  ($46)($23)
CC83   BA DC 32                   JMP  ISARXBCD_4 ; $DC32

BTN_DOWN_1: ; $CC86
CC86   BE DF F3                   SJP  (PRGST2XREG)
CC89   C1 4C                      VCR  ($4C)($26)

BTN_DOWN_2: ; $CC8B
CC8B   C8 09                      VEJ  (C8) \ ABRF(BTN_DOWN_7) ; $CC96

BTN_DOWN_12: ; $CC8D
CC8D   CD 12                      VMJ  ($12)
CC8F   BE D0 B4                   SJP  (DEL_DIM_VARS_2) ; $D0B4
CC92   6A 00                      LDI  UL,$00
CC94   8E 24                      BCH BTN_DOWN_8 ; $CCBA

BTN_DOWN_7: ; $CC96
CC96   C6                         VEJ  (C6)
CC97   CD 2E 25                   VMJ  ($2E) \ ABRF(BTN_DOWN_9) ; $CCBF
CC9A   C8 21                      VEJ  (C8) \ ABRF(BTN_DOWN_10) ; $CCBD
CC9C   D0 82 20                   VEJ  (D0) \ ABYT($82) \ ABRF(BTN_DOWN_9) ; $CCBF
CC9F   24                         LDA  UL
CCA0   89 03                      BZR BTN_DOWN_11 ; $CCA5
CCA2   A4                         LDA  UH
CCA3   9B 18                      BZS BTN_DOWN_12 ; $CC8D

BTN_DOWN_11: ; $CCA5
CCA5   D8                         VEJ  (D8)
CCA6   89 0D                      BZR BTN_DOWN_13 ; $CCB5
CCA8   CD 12                      VMJ  ($12)
CCAA   94                         LDA  YH
CCAB   89 02                      BZR BTN_DOWN_14 ; $CCAF
CCAD   CC 65                      VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865

BTN_DOWN_14: ; $CCAF
CCAF   BE D2 EC 0C                SJP  (SRCHPRGLINE) \ ABRF(BTN_DOWN_9) ; $CCBF
CCB3   8E 03                      BCH BTN_DOWN_15 ; $CCB8

BTN_DOWN_13: ; $CCB5
CCB5   CD 1A 07                   VMJ  ($1A) \ ABRF(BTN_DOWN_9) ; $CCBF

BTN_DOWN_15: ; $CCB8
CCB8   6A 01                      LDI  UL,$01

BTN_DOWN_8: ; $CCBA
CCBA   FB                         SEC
CCBB   CD 4C                      VMJ  ($4C)($26)

BTN_DOWN_10: ; $CCBD
CCBD   68 01                      LDI  UH,$01

BTN_DOWN_9: ; $CCBF
CCBF   CD 48                      VMJ  ($48)($24)



BTN_ENTER: ; $CCC1
CCC1   C3 46                      VCS  ($46)($23)

BTN_ENTER_2: ; $CCC3
CCC3   EB 76 4E 01                ORI  (DISP_BUFF + $4E),$01
CCC7   DB                         ROL
CCC8   83 22                      BCS BTN_ENTER_3 ; $CCEC
CCCA   ED 76 4F 40                BII  (DISP_BUFF + $4F),$40
CCCE   CB 42                      VZS  ($42)($21)
CCD0   CC 8A                      VEJ  (CC) \ ABYTL(BREAKPARAM) ; $788A
CCD2   D9                         SHL
CCD3   C3 42                      VCS  ($42)($21)
CCD5   D9                         SHL
CCD6   83 38                      BCS BTN_ENTER_4 ; $CD10
CCD8   D9                         SHL
CCD9   C1 42                      VCR  ($42)($21)
CCDB   BA C8 D5                   JMP  BCMD_CONT_3 ; $C8D5

BTN_ENTER_1: ; $CCDE
CCDE   4A FE                      LDI  XL,$FE
CCE0   48 7B                      LDI  XH,$7B
CCE2   05                         LDA  (X)
CCE3   B7 E0                      CPI  A,$E0
CCE5   B5 0D                      LDI  A,$0D
CCE7   83 01                      BCS BTN_ENTER_5 ; $CCEA
CCE9   44                         INC  X

BTN_ENTER_5: ; $CCEA
CCEA   0E                         STA  (X)
CCEB   9A                         RTN

BTN_ENTER_3: ; $CCEC
CCEC   BE CC DE                   SJP  (BTN_ENTER_1) ; $CCDE
CCEF   BE D0 11                   SJP  (PRGLINE_TDI_4) ; $D011
CCF2   81 25                      BCR BTN_ENTER_6 ; $CD19
CCF4   F4 78 86                   VEJ  (F4) \ AWRD(LASTVARADD_H)
CCF7   CC 88                      VEJ  (CC) \ ABYTL($7888)
CCF9   BE C0 11                   SJP  (SAVEVARPTR_A)
CCFC   BE F9 7B                   SJP  (VAR_TYPE)
CCFF   81 8A                      BCR ERRN
CD01   06                         CPA  XL
CD02   8B 0C                      BZS BTN_ENTER_4 ; $CD10
CD04   CD 08 84                   VMJ  ($08) \ ABRF(ERRN)
CD07   E9 78 8A 0F                ANI  (BREAKPARAM),$0F
CD0B   D6 AC                      VEJ  (D6) \ ABYT($AC)
CD0D   BA C9 DA                   JMP  BCMD_DIM_7 ; $C9DA

BTN_ENTER_4: ; $CD10
CD10   E9 78 8A 0F                ANI  (BREAKPARAM),$0F
CD14   D6 AC                      VEJ  (D6) \ ABYT($AC)
CD16   BA C6 76                   JMP  BCMD_REM ; $C676

BTN_ENTER_6: ; $CD19
CD19   BE F9 57                   SJP  (TOKENIZE_INBUF)
CD1C   8B 6D                      BZS ERRN
CD1E   4E B0                      CPI  XL,$B0
CD20   CB 42                      VZS  ($42)($21)
CD22   A5 76 4F                   LDA  (DISP_BUFF + $4F)
CD25   D9                         SHL
CD26   DB                         ROL
CD27   83 3C                      BCS BTN_ENTER_7 ; $CD65
CD29   8D 13                      BVR+ BTN_ENTER_8 ; $CD3E
CD2B   BE CF 27                   SJP  (PRGLINE_TDI)
CD2E   0D                         EOR  (X)
CD2F   5B 34                      ORI  (Y),$34
CD31   00                         SBC  XL
CD32   A4                         LDA  UH
CD33   1A                         STA  YL
CD34   B5 14                      LDI  A,$14

BTN_ENTER_10: ; $CD36
CD36   58 7B                      LDI  YH,$7B
CD38   C3 E0                      VCS  ($E0)
CD3A   CD 44                      VMJ  ($44)($22)
CD3C   CD 42                      VMJ  ($42)($21)

BTN_ENTER_8: ; $CD3E
CD3E   ED 78 80 08                BII  (DISPARAM),$08
CD42   8B 11                      BZS BTN_ENTER_9 ; $CD55
CD44   14                         LDA  YL
CD45   00                         SBC  XL
CD46   BD FF                      EAI  $FF
CD48   FD 18                      LDX  Y
CD4A   CD 24                      VMJ  ($24)
CD4C   BE CE D0                   SJP  (TXFR_RSV_KEY)
CD4F   5A B3                      LDI  YL,$B3
CD51   B5 08                      LDI  A,$08
CD53   9E 1F                      BCH BTN_ENTER_10 ; $CD36

BTN_ENTER_9: ; $CD55
CD55   C2 22 0D                   VEJ  (C2) \ ACHR($22) \ ABRF(BTN_ENTER_7) ; $CD65
CD58   CD 0C                      VMJ  ($0C)
CD5A   C8 2D                      VEJ  (C8) \ ABRF(ERR1)
CD5C   BE CF 0B                   SJP  (TXFR_RSV_KEY_1) ; $CF0B
CD5F   5A B0                      LDI  YL,$B0
CD61   B5 20                      LDI  A,$20
CD63   9E 2F                      BCH BTN_ENTER_10 ; $CD36

BTN_ENTER_7: ; $CD65
CD65   5A B0                      LDI  YL,$B0
CD67   BA C4 46                   JMP  BASIC_INT_12 ; $C446



UNLOCK: ; $CD6A
CD6A   08                         STA  XH
CD6B   B5 FF                      LDI  A,$FF
CD6D   AE 79 FF                   STA  (UNDEF_REG_79FF)
CD70   9A                         RTN



BTN_OFF: ; $CD71
CD71   4A 10                      LDI  XL,$10
CD73   48 7A                      LDI  XH,$7A
CD75   B5 50                      LDI  A,$50
CD77   6A 0F                      LDI  UL,$0F

BTN_OFF_1: ; $CD79
CD79   41                         SIN  X
CD7A   DD                         INC  A
CD7B   88 04                      LOP  UL,BTN_OFF_1 ; $CD79
CD7D   CD A6                      VMJ  ($A6)($53)
CD7F   89 02                      BZR BTN_OFF_2 ; $CD83
CD81   FD 4C                      OFF

BTN_OFF_2: ; $CD83
CD83   D8                         VEJ  (D8)
CD84   CB 46                      VZS  ($46)($23)
CD86   BA C4 C6                   JMP  BCMD_STOP_9 ; $C4C6



ERR1: ; $CD89
CD89   68 01                      LDI  UH,$01



ERRN: ; $CD8B
CD8B   A4                         LDA  UH
CD8C   AE 78 9B                   STA  (ERL)
CD8F   AA 78 4F                   LDI  S,(CPU_STACK + $4F)
CD92   D8                         VEJ  (D8)
CD93   8B 14                      BZS ERRN_1 ; $CDA9
CD95   D4 B2                      VEJ  (D4) \ ABYT($B2)
CD97   CC 9B                      VEJ  (CC) \ ABYTL(ERL) ; $789B
CD99   DF                         DEC  A
CD9A   8B 13                      BZS ERRN_2 ; $CDAF
CD9C   ED 78 B8 80                BII  (ON_ERR_ADD_H),$80
CDA0   89 0D                      BZR ERRN_2 ; $CDAF
CDA2   D4 A0                      VEJ  (D4) \ ABYT($A0)
CDA4   D6 B8                      VEJ  (D6) \ ABYT($B8)
CDA6   BA C4 13                   JMP  BASIC_INT_8 ; $C413

ERRN_1: ; $CD8B
CDA9   B5 A0                      LDI  A,$A0
CDAB   5C 00                      CPI  YH,$00
CDAD   89 02                      BZR ERRN_3 ; $CDB1

ERRN_2: ; $CDAF
CDAF   B5 80                      LDI  A,$80

ERRN_3: ; $CDB1
CDB1   AE 78 80                   STA  (DISPARAM)
CDB4   FD 98                      PSH  Y
CDB6   5A 10                      LDI  YL,$10
CDB8   58 7A                      LDI  YH,$7A
CDBA   CD 2A 64 06                VMJ  ($2A) \ ABYT($64) \ ABYT($06)
CDBE   A5 78 9B                   LDA  (ERL)
CDC1   2A                         STA  UL
CDC2   68 00                      LDI  UH,$00
CDC4   CD 10 40                   VMJ  ($10) \ ABYT($40)
CDC7   D8                         VEJ  (D8)
CDC8   8B 11                      BZS ERRN_4 ; $CDDB
CDCA   CD 2A 61 03                VMJ  ($2A) \ ABYT($61) \ ABYT($03)
CDCE   B5 20                      LDI  A,$20
CDD0   FD C8                      PSH  A
CDD2   CC B4                      VEJ  (CC) \ ABYTL(ERR_LINE_H) ; $78B4

ERRN_5: ; $CDD4
CDD4   BE DD 2F                   SJP  (LOAD_NEXT_1) ; $DD2F
CDD7   40                         INC  XL
CDD8   FD 8A                      POP  A
CDDA   51                         SIN  Y

ERRN_4: ; $CDDB
CDDB   59 00                      ANI  (Y),$00
CDDD   FD 18                      LDX  Y
CDDF   FD 1A                      POP  Y
CDE1   BE EF 5B                   SJP  (TXT2LCD_ARY)
CDE4   CD 46                      VMJ  ($46)($23)



INS2INBUF: ; $CDE6
CDE6   15                         LDA  (Y)
CDE7   B7 0D                      CPI  A,$0D
CDE9   8B 24                      BZS INS2INBUF_1 ; $CE0F
CDEB   F9                         REC
CDEC   B5 FF                      LDI  A,$FF
CDEE   10                         SBC  YL
CDEF   81 1B                      BCR INS2INBUF_2 ; $CE0C
CDF1   FD A8                      PSH  U
CDF3   FD 88                      PSH  X
CDF5   2A                         STA  UL
CDF6   5A FF                      LDI  YL,$FF
CDF8   FD 18                      LDX  Y
CDFA   46                         DEC  X
CDFB   05                         LDA  (X)
CDFC   B7 E0                      CPI  A,$E0
CDFE   81 02                      BCR INS2INBUF_3 ; $CE02
CE00   B5 0D                      LDI  A,$0D

INS2INBUF_3: ; $CE02
CE02   0E                         STA  (X)

INS2INBUF_4: ; $CE03
CE03   47                         LDE  X
CE04   53                         SDE  Y
CE05   88 04                      LOP  UL,INS2INBUF_4 ; $CE03
CE07   FB                         SEC
CE08   FD 0A                      POP  X
CE0A   FD 2A                      POP  U

INS2INBUF_2: ; $CE0C
CE0C   B5 27                      LDI  A,$27
CE0E   1E                         STA  (Y)

INS2INBUF_1: ; $CE0F
CE0F   9A                         RTN



CHAR2INBUF: ; $CE10
CE10   A4                         LDA  UH
CE11   8B 1A                      BZS CHAR2INBUF_1 ; $CE2D
CE13   5E FF                      CPI  YL,$FF
CE15   83 15                      BCS CHAR2INBUF_2 ; $CE2C
CE17   15                         LDA  (Y)
CE18   B7 0D                      CPI  A,$0D
CE1A   8B 07                      BZS CHAR2INBUF_3 ; $CE23
CE1C   B7 E0                      CPI  A,$E0
CE1E   83 03                      BCS CHAR2INBUF_3 ; $CE23
CE20   BE CD E6                   SJP  (INS2INBUF)

CHAR2INBUF_3: ; $CE23
CE23   A4                         LDA  UH
CE24   51                         SIN  Y
CE25   24                         LDA  UL
CE26   51                         SIN  Y
CE27   14                         LDA  YL
CE28   89 02                      BZR CHAR2INBUF_2 ; $CE2C
CE2A   56                         DEC  Y

CHAR2INBUF_4: ; $CE2B
CE2B   56                         DEC  Y

CHAR2INBUF_2: ; $CE2C
CE2C   9A                         RTN

CHAR2INBUF_1: ; $CE2D
CE2D   15                         LDA  (Y)
CE2E   B7 E0                      CPI  A,$E0
CE30   24                         LDA  UL
CE31   51                         SIN  Y
CE32   83 04                      BCS DELFRMINBUF
CE34   14                         LDA  YL
CE35   9B 0C                      BZS CHAR2INBUF_4 ; $CE2B
CE37   9A                         RTN



DELFRMINBUF: ; $CE38
CE38   FD 98                      PSH  Y
CE3A   FD 18                      LDX  Y
CE3C   14                         LDA  YL
CE3D   BD FF                      EAI  $FF
CE3F   2A                         STA  UL
CE40   44                         INC  X
CE41   BE D0 49                   SJP  (XREG2YREG)
CE44   B5 0D                      LDI  A,$0D
CE46   1E                         STA  (Y)
CE47   FD 1A                      POP  Y
CE49   9A                         RTN



DEFEVAL: ; $CE4A
CE4A   FD 88                      PSH  X
CE4C   ED 78 80 40                BII  (DISPARAM),$40
CE50   89 2F                      BZR DEFEVAL_3 ; $CE81
CE52   FD A8                      PSH  U
CE54   BE D0 2B                   SJP  (INBUF_CLRRST_1) ; $D02B
CE57   ED 78 80 20                BII  (DISPARAM),$20
CE5B   8B 1D                      BZS DEFEVAL_4 ; $CE7A
CE5D   FD 2A                      POP  U
CE5F   FD A8                      PSH  U
CE61   A4                         LDA  UH
CE62   89 16                      BZR DEFEVAL_4 ; $CE7A
CE64   24                         LDA  UL
CE65   6A 07                      LDI  UL,$07
CE67   BE DA 98                   SJP  (MULT16B_1) ; $DA98
CE6A   89 0E                      BZR DEFEVAL_4 ; $CE7A
CE6C   D2 0C 80                   VEJ  (D2) \ ABRF($CE7B) \ ABYT($80)
CE6F   BE EF 1B                   SJP  (ARX2STRNG)
CE72   DC                         VEJ  (DC)
CE73   5A B0                      LDI  YL,$B0
CE75   58 7B                      LDI  YH,$7B
CE77   BE D0 49                   SJP  (XREG2YREG)

DEFEVAL_4: ; $CE7A
CE7A   FD 2A                      POP  U
CE7C   B5 40                      LDI  A,$40
CE7E   AE 78 80                   STA  (DISPARAM)

DEFEVAL_3: ; $CE81
CE81   BE CE 10                   SJP  (CHAR2INBUF)
CE84   FD 0A                      POP  X
CE86   9A                         RTN

DEFEVAL_1: ; $CE87
CE87   B5 10                      LDI  A,$10
CE89   22                         ADC  UL
CE8A   2A                         STA  UL
CE8B   B9 07                      ANI  A,$07
CE8D   28                         STA  UH
CE8E   A5 76 4E                   LDA  (DISP_BUFF + $4E)
CE91   B9 30                      ANI  A,$30
CE93   B7 30                      CPI  A,$30
CE95   81 02                      BCR DEFEVAL_5 ; $CE99
CE97   B5 20                      LDI  A,$20

DEFEVAL_5: ; $CE99
CE99   D5                         SHR
CE9A   A2                         ADC  UH
CE9B   AE 78 84                   STA  (CURVARADD_L)
CE9E   9A                         RTN
CE9F   A5 78 60                   LDA  (ST_ROM_MOD) ; $7860
CEA2   08                         STA  XH
CEA3   DB                         ROL
CEA4   68 18                      LDI  UH,$18
CEA6   81 04                      BCR DEFEVAL_6 ; $CEAC
CEA8   A5 78 63                   LDA  (RAM_ST_H)
CEAB   08                         STA  XH

DEFEVAL_6: ; $CEAC
CEAC   4A 08                      LDI  XL,$08
CEAE   9A                         RTN


DEFEVAL_2: ; $CEAF
CEAF   A5 76 4E                   LDA  (DISP_BUFF + $4E)
CEB2   6A 08                      LDI  UL,$08
CEB4   DB                         ROL
CEB5   DB                         ROL
CEB6   83 07                      BCS DEFEVAL_7 ; $CEBF
CEB8   6A 22                      LDI  UL,$22
CEBA   DB                         ROL
CEBB   83 02                      BCS DEFEVAL_7 ; $CEBF
CEBD   6A 3C                      LDI  UL,$3C

DEFEVAL_7: ; $CEBF
CEBF   CD 38                      VMJ  ($38)
CEC1   24                         LDA  UL
CEC2   0A                         STA  XL
CEC3   9A                         RTN



RESKEY_SRCH: ; $CEC4
CEC4   4A 56                      LDI  XL,$56

RESKEY_SRCH_2: ; $CEC6
CEC6   F9                         REC
CEC7   45                         LIN  X
CEC8   8B 05                      BZS RESKEY_SRCH_1 ; $CECF
CECA   A7 78 84                   CPA  (CURVARADD_L)
CECD   99 09                      BZR- RESKEY_SRCH_2 $CEC6

RESKEY_SRCH_1: ; $CECF
CECF   9A                         RTN



TXFR_RSV_KEY: ; $CED0
CED0   CD 38                      VMJ  ($38)
CED2   81 51                      BCR TXFR_RSV_KEY_2 ; $CF25
CED4   BE CE C4                   SJP  (RESKEY_SRCH)
CED7   FD 5A                      STX  Y
CED9   81 17                      BCR TXFR_RSV_KEY_3 ; $CEF2
CEDB   B5 1F                      LDI  A,$1F

TXFR_RSV_KEY_4: ; $CEDD
CEDD   F7                         CIN
CEDE   91 03                      BCR- TXFR_RSV_KEY_4 ; $CEDD
CEE0   46                         DEC  X
CEE1   56                         DEC  Y
CEE2   B5 C5                      LDI  A,$C5
CEE4   00                         SBC  XL
CEE5   2A                         STA  UL

TXFR_RSV_KEY_5: ; $CEE6
CEE6   F5                         TIN
CEE7   88 03                      LOP  UL,TXFR_RSV_KEY_5 ; $CEE6
CEE9   6A 6F                      LDI  UL,$6F
CEEB   5A 56                      LDI  YL,$56

TXFR_RSV_KEY_6: ; $CEED
CEED   55                         LIN  Y
CEEE   8B 02                      BZS TXFR_RSV_KEY_3 ; $CEF2
CEF0   88 05                      LOP  UL,TXFR_RSV_KEY_6 ; $CEED

TXFR_RSV_KEY_3: ; $CEF2
CEF2   52                         DEC  YL
CEF3   DC                         VEJ  (DC)
CEF4   68 0D                      LDI  UH,$0D
CEF6   62                         DEC  UL
CEF7   81 11                      BCR TXFR_RSV_KEY_7 ; $CF0A
CEF9   14                         LDA  YL
CEFA   22                         ADC  UL
CEFB   83 0D                      BCS TXFR_RSV_KEY_7 ; $CF0A
CEFD   B7 C4                      CPI  A,$C4
CEFF   83 09                      BCS TXFR_RSV_KEY_7 ; $CF0A
CF01   A5 78 84                   LDA  (CURVARADD_L)
CF04   51                         SIN  Y

TXFR_RSV_KEY_8: ; $CF05
CF05   F5                         TIN
CF06   88 03                      LOP  UL,TXFR_RSV_KEY_8 ; $CF05
CF08   59 00                      ANI  (Y),$00

TXFR_RSV_KEY_7: ; $CF0A
CF0A   9A                         RTN

TXFR_RSV_KEY_1: ; $CF0B
CF0B   BE CE AF                   SJP  (DEFEVAL_2) ; $CEAF
CF0E   81 15                      BCR $TXFR_RSV_KEY_2 ; CF25
CF10   FD 5A                      STX  Y
CF12   DC                         VEJ  (DC)
CF13   68 00                      LDI  UH,$00
CF15   B7 1A                      CPI  A,$1A
CF17   81 03                      BCR TXFR_RSV_KEY_9 ; $CF1C
CF19   6A 1A                      LDI  UL,$1A
CF1B   28                         STA  UH

TXFR_RSV_KEY_9: ; $CF1C
CF1C   BE D0 49                   SJP  (XREG2YREG)
CF1F   A4                         LDA  UH
CF20   89 01                      BZR TXFR_RSV_KEY_10 ; $CF23
CF22   1E                         STA  (Y)

TXFR_RSV_KEY_10: ; $CF23
CF23   F9                         REC
CF24   9A                         RTN

TXFR_RSV_KEY_2: ; $CF25
CF25   FB                         SEC
CF26   9A                         RTN



PRGLINE_TDI: ; $CF27
CF27   FD 88                      PSH  X
CF29   5A B0                      LDI  YL,$B0
CF2B   BE D3 D5                   SJP  (DEC2HEX)
CF2E   89 04                      BZR PRGLINE_TDI_5 ; $CF34
CF30   B5 02                      LDI  A,$02
CF32   8E 94                      BCH PRGLINE_TDI_6 ; $CFC8

PRGLINE_TDI_5: ; $CF34
CF34   B5 01                      LDI  A,$01
CF36   83 90                      BCS PRGLINE_TDI_6 ; $CFC8
CF38   FD 0A                      POP  X
CF3A   04                         LDA  XL
CF3B   10                         SBC  YL
CF3C   FD 98                      PSH  Y
CF3E   FD C8                      PSH  A
CF40   FD A8                      PSH  U
CF42   BE CF D0                   SJP  (PRGLINE_TDI_7) ; $CFD0
CF45   FD 2A                      POP  U
CF47   FD A8                      PSH  U
CF49   BE D2 E0                   SJP  (BCD_Y2ARX_2) ; $D2E0
CF4C   1E                         STA  (Y)
CF4D   FD 0A                      POP  X
CF4F   CC A6                      VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
CF51   46                         DEC  X
CF52   FD 5A                      STX  Y
CF54   45                         LIN  X
CF55   FD CA                      ADR  X
CF57   56                         DEC  Y
CF58   56                         DEC  Y
CF59   46                         DEC  X
CF5A   CD 16                      VMJ  ($16)
CF5C   44                         INC  X


PRGLINE_TDI_8: ; $CF5D
CF5D   F5                         TIN
CF5E   88 03                      LOP  UL,PRGLINE_TDI_8 ; $CF5D
CF60   FD 62                      DEC  UH
CF62   93 07                      BCS PRGLINE_TDI_8 ; $CF5D
CF64   FD 18                      LDX  Y
CF66   46                         DEC  X
CF67   CA 67                      VEJ  (CA) \ ABYTL(BASPRG_END_H) ; $7867
CF69   8E 06                      BCH $CF71
CF6B   FD 0A                      POP  X
CF6D   CA A8                      VEJ  (CA) \ ABYTL(SRCH_LINE_H) ; $78A8
CF6F   CC 67                      VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867
CF71   FD 8A                      POP  A
CF73   DD                         INC  A
CF74   8B 52                      BZS PRGLINE_TDI_6 ; $CFC8
CF76   FD C8                      PSH  A
CF78   B3 04                      ADI  A,$04
CF7A   FD 5A                      STX  Y
CF7C   FD DA                      ADR  Y
CF7E   94                         LDA  YH
CF7F   A7 78 64                   CPA  (RAM_END_H)
CF82   83 3E                      BCS PRGLINE_TDI_9 ; $CFC2
CF84   FD 98                      PSH  Y
CF86   CC A6                      VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
CF88   46                         DEC  X
CF89   46                         DEC  X
CF8A   46                         DEC  X
CF8B   CA A6                      VEJ  (CA) \ ABYTL(SRCH_ADD_H) ; $78A6
CF8D   46                         DEC  X
CF8E   CD 16                      VMJ  ($16)
CF90   44                         INC  X
CF91   CC 67                      VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867

PRGLINE_TDI_10: ; $CF93
CF93   47                         LDE  X
CF94   53                         SDE  Y
CF95   88 04                      LOP  UL,PRGLINE_TDI_10 ; $CF93
CF97   FD 62                      DEC  UH
CF99   93 08                      BCS PRGLINE_TDI_10 ; $CF93
CF9B   FD 0A                      POP  X
CF9D   CA 67                      VEJ  (CA) \ ABYTL(BASPRG_END_H) ; $7867
CF9F   CC A6                      VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
CFA1   FD 5A                      STX  Y
CFA3   CC A8                      VEJ  (CC) \ ABYTL(SRCH_LINE_H) ; $78A8
CFA5   51                         SIN  Y
CFA6   04                         LDA  XL
CFA7   51                         SIN  Y
CFA8   FD 8A                      POP  A
CFAA   2A                         STA  UL
CFAB   DD                         INC  A
CFAC   51                         SIN  Y
CFAD   FD 0A                      POP  X
CFAF   04                         LDA  XL
CFB0   28                         STA  UH

PRGLINE_TDI_11: ; $CFB1
CFB1   F5                         TIN
CFB2   88 03                      LOP  UL,PRGLINE_TDI_11 ; $CFB1
CFB4   BE D0 9C                   SJP  (DEL_DIM_VARS)
CFB7   B5 03                      LDI  A,$03

PRGLINE_TDI_12: ; $CFB9
CFB9   FD 0A                      POP  X
CFBB   FD CA                      ADR  X
CFBD   45                         LIN  X
CFBE   FD CA                      ADR  X
CFC0   FD 5E                      STX  P

PRGLINE_TDI_9: ; $CFC2
CFC2   FD 8A                      POP  A
CFC4   68 0D                      LDI  UH,$0D
CFC6   B5 01                      LDI  A,$01

PRGLINE_TDI_6: ; $CFC8
CFC8   FD 1A                      POP  Y
CFCA   9E 13                      BCH PRGLINE_TDI_12 ; $CFB9

PRGLINE_TDI_3: ; $CFCC
CFCC   E9 78 8D 00                ANI  (TRACE_ON),$00

PRGLINE_TDI_7: ; $CFD0
CFD0   CD 12                      VMJ  ($12)

PRGLINE_TDI_14: ; $CFD2
CFD2   44                         INC  X
CFD3   44                         INC  X
CFD4   44                         INC  X
CFD5   84                         LDA  XH
CFD6   BB 80                      ORI  A,$80
CFD8   08                         STA  XH
CFD9   CA BE                      VEJ  (CA) \ ABYTL(DATA_PTR_H) ; $78BE
CFDB   B5 00                      LDI  A,$00
CFDD   6A A2                      LDI  UL,$A2
CFDF   61                         SIN  U
CFE0   61                         SIN  U
CFE1   6A B4                      LDI  UL,$B4
CFE3   61                         SIN  U
CFE4   61                         SIN  U
CFE5   AE 78 9B                   STA  (ERL)
CFE8   48 78                      LDI  XH,$78
CFEA   4A 71                      LDI  XL,$71
CFEC   6A 0D                      LDI  UL,$0D

PRGLINE_TDI_13: ; $CFEE
CFEE   41                         SIN  X
CFEF   88 03                      LOP  UL,PRGLINE_TDI_13 ; $CFEE
CFF1   4A 95                      LDI  XL,$95
CFF3   41                         SIN  X
CFF4   41                         SIN  X
CFF5   41                         SIN  X
CFF6   41                         SIN  X

PRGLINE_TDI_1: ; $CFF7
CFF7   EB 78 B8 80                ORI  (ON_ERR_ADD_H),$80
CFFB   E9 7B 0E 1F                ANI  (CURS_CTRL),$1F
CFFF   E9 78 8A 00                ANI  (BREAKPARAM),$00
D003   EB 78 91 FF                ORI  (GOSB_STK_PTR_L),$FF
D007   B5 38                      LDI  A,$38
D009   AE 78 90                   STA  (FORNXT_STK_PTR)
D00C   9A                         RTN

PRGLINE_TDI_2: ; $D00D
D00D   CC AA                      VEJ  (CC) \ ABYTL(SRCH_TOP_H) ; $78AA
D00F   9E 3F                      BCH PRGLINE_TDI_14 ; $CFD2

PRGLINE_TDI_4: ; $D011
D011   ED 76 4F 40                BII  (DISP_BUFF + $4F),$40
D015   8B 08                      BZS PRGLINE_TDI_15 ; $D01F
D017   A5 78 8A                   LDA  (BREAKPARAM)
D01A   D9                         SHL
D01B   83 02                      BCS PRGLINE_TDI_15 ; $D01F
D01D   DB                         ROL
D01E   9A                         RTN

PRGLINE_TDI_15: ; $D01F
D01F   F9                         REC
D020   9A                         RTN

.END 
; ***

INBUF_CLRRST: ; $D021
D021   A5 78 8B                   LDA  (INBUFPTR_L)
D024   0A                         STA  XL
D025   1A                         STA  YL
D026   BD FF                      EAI  $FF
D028   2A                         STA  UL
D029   8E 0D                      BCH INBUF_CLR_1 ; $D038

INBUF_CLRRST_1: ; $D02B
D02B   B5 B0                      LDI  A,$B0
D02D   AE 78 8B                   STA  (INBUFPTR_L)



INBUF_INIT: ; $D030
D030   5A B0                      LDI  YL,$B0
D032   58 7B                      LDI  YH,$7B



INBUF_CLR: ; $D034
D034   4A B0                      LDI  XL,$B0
D036   6A 50                      LDI  UL,$50

INBUF_CLR_1: ; $D038
D038   48 7B                      LDI  XH,$7B
D03A   B5 0D                      LDI  A,$0D
D03C   8E 72                      BCH DEL_DIM_VARS_3 ; $D0B0
D03E   FD 2A                      POP  U
D040   65                         LIN  U
D041   0A                         STA  XL
D042   65                         LIN  U
D043   FD A8                      PSH  U
D045   2A                         STA  UL



SYSMSG: ; $D046
D046   48 C3                      LDI  XH,$C3

SYSMSG_1: ; $D048
D048   F5                         TIN



XREG2YREG: ; $D049
D049   88 03                      LOP  UL,SYSMSG_1 ; $D048
D04B   9A                         RTN



VARONBSTK: ; $D04C
D04C   A5 78 90                   LDA  (FORNXT_STK_PTR)
D04F   48 7A                      LDI  XH,$7A
D051   B7 39                      CPI  A,$39
D053   81 27                      BCR PSHBSTK_3 ; $D07C
D055   B1 0C                      SBI  A,$0C
D057   0A                         STA  XL
D058   45                         LIN  X
D059   A6                         CPA  UH
D05A   89 05                      BZR VARONBSTK_1 ; $D061
D05C   45                         LIN  X
D05D   26                         CPA  UL
D05E   8B 1B                      BZS PSHBSTK_2 ; $D07B
D060   46                         DEC  X

VARONBSTK_1: ; $D061
D061   46                         DEC  X
D062   04                         LDA  XL
D063   9E 14                      BCH $D051



POPBSTK: ; $D065
D065   A5 78 82                   LDA  (STK_PTR_GSB_FOR)
D068   0A                         STA  XL
D069   48 7A                      LDI  XH,$7A
D06B   45                         LIN  X
D06C   28                         STA  UH
D06D   45                         LIN  X
D06E   2A                         STA  UL
D06F   8E 0A                      BCH PSHBSTK_2 ; $D07B



PSHBSTK: ; $D071
D071   A5 78 82                   LDA  (STK_PTR_GSB_FOR)
D074   0A                         STA  XL
D075   48 7A                      LDI  XH,$7A
D077   A4                         LDA  UH
D078   41                         SIN  X
D079   24                         LDA  UL
D07A   41                         SIN  X

PSHBSTK_2: ; $D07B
D07B   04                         LDA  XL

PSHBSTK_3: ; $D07C
D07C   AE 78 82                   STA  (STK_PTR_GSB_FOR)
D07F   9A                         RTN



DELSVARS: ; $D080
D080   48 76                      LDI  XH,$76
D082   BE D0 AA                   SJP  (DEL_DIM_VARS_1) ; $D0AA
D085   BE D0 AA                   SJP  (DEL_DIM_VARS_1) ; $D0AA
D088   4A C0                      LDI  XL,$C0
D08A   6A 0F                      LDI  UL,$0F
D08C   68 01                      LDI  UH,$01
D08E   BE D3 C7                   SJP  (DELU_FROMX_1) ; $D3C7



DELDVARS: ; $D091
D091   A5 78 64                   LDA  (RAM_END_H)
D094   AE 78 99                   STA  (VAR_START_H)
D097   E9 78 9A 00                ANI  (VAR_START_L),$00
D09B   9A                         RTN



DEL_DIM_VARS: ; $D09C
D09C   CC 67                      VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867
D09E   FB                         SEC
D09F   04                         LDA  XL
D0A0   A1 78 9A                   SBC  (VAR_START_L)
D0A3   84                         LDA  XH
D0A4   A1 78 99                   SBC  (VAR_START_H)
D0A7   93 18                      BCS DELDVARS
D0A9   9A                         RTN

DEL_DIM_VARS_1: ; $D0AA
D0AA   4A 50                      LDI  XL,$50
D0AC   6A AF                      LDI  UL,$AF

DEL_DIM_VARS_1: ; $D0AE
D0AE   B5 00                      LDI  A,$00

DEL_DIM_VARS_3: ; $D0B0
D0B0   41                         SIN  X
D0B1   88 03                      LOP  UL,DEL_DIM_VARS_3 ; $D0B0
D0B3   9A                         RTN

DEL_DIM_VARS_2: ; $D0B4
D0B4   84                         LDA  XH
D0B5   AE 78 AA                   STA  (SRCH_TOP_H)
D0B8   04                         LDA  XL
D0B9   AE 78 AB                   STA  (SRCH_TOP_L)

DEL_DIM_VARS_14: ; $D0BC
D0BC   45                         LIN  X
D0BD   AE 78 A8                   STA  (SRCH_LINE_H)
D0C0   45                         LIN  X
D0C1   AE 78 A9                   STA  (SRCH_LINE_L)
D0C4   44                         INC  X
D0C5   84                         LDA  XH
D0C6   AE 78 A6                   STA  (SRCH_ADD_H)
D0C9   04                         LDA  XL
D0CA   AE 78 A7                   STA  (SRCH_ADD_L)
D0CD   9A                         RTN
D0CE   08                         STA  XH
D0CF   BA C8 53                   JMP  BCMD_READ_17 ; $C853

DEL_DIM_VARS_16: ; $D0D2
D0D2   FD C8                      PSH  A
D0D4   A5 7A 01                   LDA  (ARX + $01)
D0D7   AD 7A 11                   EOR  (ARY + $01)
D0DA   89 08                      BZR DEL_DIM_VARS_4 ; $D0E4
D0DC   BE EF B6                   SJP  (SUBTR)
D0DF   A5 7A 02                   LDA  (ARX + $02)
D0E2   8B 5E                      BZS $D142

DEL_DIM_VARS_4: ; $D0E4
D0E4   A5 7A 01                   LDA  (ARX + $01)
D0E7   D9                         SHL

DEL_DIM_VARS_13: ; $D0E8
D0E8   FD 8A                      POP  A
D0EA   8B 4C                      BZS DEL_DIM_VARS_5 ; $D138
D0EC   BD 04                      EAI  $04
D0EE   8B 07                      BZS DEL_DIM_VARS_6 ; $D0F7
D0F0   83 02                      BCS DEL_DIM_VARS_7 ; $D0F4
D0F2   BD 03                      EAI  $03

DEL_DIM_VARS_7: ; $D0F4
D0F4   D5                         SHR
D0F5   83 41                      BCS DEL_DIM_VARS_5 ; $D138

DEL_DIM_VARS_6: ; $D0F7
D0F7   EC                         VEJ  (EC)
D0F8   9A                         RTN

DEL_DIM_VARS_15: ; $D0F9
D0F9   FD C8                      PSH  A
D0FB   6A 15                      LDI  UL,$15
D0FD   BE DE BE                   SJP  (BCMD_TIME_7) ; $DEBE
D100   FD 5A                      STX  Y
D102   FD C8                      PSH  A
D104   DC                         VEJ  (DC)
D105   FD 8A                      POP  A
D107   68 01                      LDI  UH,$01
D109   26                         CPA  UL
D10A   8B 0F                      BZS DEL_DIM_VARS_8 ; $D11B
D10C   68 02                      LDI  UH,$02
D10E   83 03                      BCS DEL_DIM_VARS_9 ; $D113
D110   68 00                      LDI  UH,$00
D112   2A                         STA  UL

DEL_DIM_VARS_9: ; $D113
D113   FD 8A                      POP  A
D115   B7 04                      CPI  A,$04
D117   9B 22                      BZS DEL_DIM_VARS_6 ; $D0F7
D119   FD C8                      PSH  A

DEL_DIM_VARS_8: ; $D11B
D11B   62                         DEC  UL
D11C   81 20                      BCR DEL_DIM_VARS_10 ; $D13E
D11E   55                         LIN  Y
D11F   F7                         CIN
D120   9B 07                      BZS DEL_DIM_VARS_8 ; $D11B
D122   FD 8A                      POP  A
D124   8B 12                      BZS DEL_DIM_VARS_5 ; $D138
D126   FD C8                      PSH  A
D128   BF 03                      BII  A,$03
D12A   8B 1C                      BZS DEL_DIM_VARS_11 ; $D148
D12C   81 02                      BCR DEL_DIM_VARS_12 ; $D130
D12E   BD 03                      EAI  $03

DEL_DIM_VARS_12: ; $D130
D130   D5                         SHR
D131   83 15                      BCS DEL_DIM_VARS_11 ; $D148
D133   38                         NOP
D134   38                         NOP
D135   38                         NOP
D136   FD 8A                      POP  A

DEL_DIM_VARS_5: ; $D138
D138   EC                         VEJ  (EC)
D139   EB 7A 02 10                ORI  (ARX + $02),$10
D13D   9A                         RTN

DEL_DIM_VARS_10: ; $D13E
D13E   6C 01                      CPI  UH,$01
D140   99 5A                      BZR DEL_DIM_VARS_13 ; $D0E8
D142   FD 8A                      POP  A
D144   D5                         SHR
D145   D5                         SHR
D146   9E 54                      BCH DEL_DIM_VARS_7 ; $D0F4

DEL_DIM_VARS_11: ; $D148
D148   FD 8A                      POP  A
D14A   9E 55                      BCH DEL_DIM_VARS_6 ; $D0F7

DEL_DIM_VARS_17: ; $D14C
D14C   DC                         VEJ  (DC)
D14D   FD 5A                      STX  Y



BCD_Y2ARX: ; $D14F
D14F   FD A8                      PSH  U
D151   EC                         VEJ  (EC)
D152   46                         DEC  X
D153   24                         LDA  UL
D154   0E                         STA  (X)
D155   FD 2A                      POP  U
D157   68 00                      LDI  UH,$00
D159   4A 02                      LDI  XL,$02

BCD_Y2ARX_13: ; $D15B
D15B   62                         DEC  UL
D15C   81 5E                      BCR BCD_Y2ARX_3 ; $D1BC
D15E   15                         LDA  (Y)
D15F   B7 30                      CPI  A,$30
D161   89 10                      BZR BCD_Y2ARX_4 ; $D173
D163   A4                         LDA  UH
D164   D5                         SHR
D165   83 37                      BCS BCD_Y2ARX_5 ; $D19E
D167   D5                         SHR
D168   83 14                      BCS BCD_Y2ARX_6 ; $D17E
D16A   D5                         SHR
D16B   81 37                      BCR BCD_Y2ARX_7 ; $D1A4
D16D   EF 7A 07 FF                ADI  (ARX + $07),$FF
D171   8E 31                      BCH BCD_Y2ARX_7 ; $D1A4

BCD_Y2ARX_4: ; $D173
D173   81 36                      BCR BCD_Y2ARX_8 ; $D1AB
D175   B7 3A                      CPI  A,$3A
D177   83 32                      BCS BCD_Y2ARX_8 ; $D1AB
D179   A4                         LDA  UH
D17A   D5                         SHR
D17B   83 21                      BCS BCD_Y2ARX_5 ; $D19E
D17D   D5                         SHR

BCD_Y2ARX_6: ; $D17E
D17E   D5                         SHR
D17F   83 04                      BCS BCD_Y2ARX_9 ; $D185
D181   EF 7A 07 01                ADI  (ARX + $07),$01

BCD_Y2ARX_9: ; $D185
D185   4E 07                      CPI  XL,$07
D187   83 10                      BCS BCD_Y2ARX_10 ; $D199
D189   4C 7A                      CPI  XH,$7A
D18B   48 7A                      LDI  XH,$7A
D18D   15                         LDA  (Y)
D18E   B9 0F                      ANI  A,$0F
D190   81 05                      BCR BCD_Y2ARX_11 ; $D197
D192   D3                         DDR  (X)
D193   48 00                      LDI  XH,$00
D195   8E 02                      BCH BCD_Y2ARX_10 ; $D199

BCD_Y2ARX_11: ; $D197
D197   03                         ADC  (X)
D198   41                         SIN  X

BCD_Y2ARX_10: ; $D199
D199   A4                         LDA  UH
D19A   BB 02                      ORI  A,$02
D19C   8E 07                      BCH BCD_Y2ARX_12 ; $D1A5

BCD_Y2ARX_5: ; $D19E
D19E   4A 00                      LDI  XL,$00
D1A0   48 7A                      LDI  XH,$7A
D1A2   15                         LDA  (Y)
D1A3   D3                         DDR  (X)

BCD_Y2ARX_7: ; $D1A4
D1A4   A4                         LDA  UH

BCD_Y2ARX_12: ; $D1A5
D1A5   BB 80                      ORI  A,$80
D1A7   28                         STA  UH

BCD_Y2ARX_27: ; $D1A8
D1A8   54                         INC  Y
D1A9   9E 50                      BCH BCD_Y2ARX_13 ; $D15B

BCD_Y2ARX_8: ; $D1AB
D1AB   FD 88                      PSH  X
D1AD   CD 34 04 20 63 2E 47 2D    VMJ  ($34) \ ABYT($04) \ ABYT($20) \ 
                                       ABRF(BCD_Y2ARX_14) \ ABYT($2E) \ ABRF(BCD_Y2ARX_15) \ 
                                       ABYT($2D) \ ABRF(BCD_Y2ARX_16) \ ABYT($2B) \ 
                                       ABRF(BCD_Y2ARX_17) \ ABYT($45) \ ABRF(BCD_Y2ARX_18)

BCD_Y2ARX_25: ; $D1BA
D1BA   FD 0A                      POP  X

BCD_Y2ARX_3: ; $D1BC
D1BC   4A 02                      LDI  XL,$02
D1BE   48 7A                      LDI  XH,$7A
D1C0   47                         LDE  X
D1C1   8B 25                      BZS BCD_Y2ARX_19 ; $D1E8
D1C3   46                         DEC  X
D1C4   B5 00                      LDI  A,$00
D1C6   D3                         DDR  (X)
D1C7   B9 0F                      ANI  A,$0F
D1C9   2A                         STA  UL
D1CA   05                         LDA  (X)

BCD_Y2ARX_21: ; $D1CB
D1CB   62                         DEC  UL
D1CC   81 04                      BCR BCD_Y2ARX_20
D1CE   B3 09                      ADI  A,$09
D1D0   9E 07                      BCH BCD_Y2ARX_21 ; $D1CB

BCD_Y2ARX_20: ; $D1D2
D1D2   41                         SIN  X
D1D3   05                         LDA  (X)
D1D4   D9                         SHL
D1D5   43                         SDE  X
D1D6   A5 7A 07                   LDA  (ARX + $07)
D1D9   E9 7A 07 00                ANI  (ARX + $07),$00
D1DD   81 0C                      BCR BCD_Y2ARX_22 ; $D1EB
D1DF   01                         SBC  (X)
D1E0   B7 64                      CPI  A,$64
D1E2   81 14                      BCR BCD_Y2ARX_23 ; $D1F8
D1E4   B7 9D                      CPI  A,$9D
D1E6   83 10                      BCS BCD_Y2ARX_23 ; $D1F8

BCD_Y2ARX_19: ; $D1E8
D1E8   EC                         VEJ  (EC)
D1E9   CD 4C                      VMJ  ($4C)($26)

BCD_Y2ARX_22: ; $D1EB
D1EB   03                         ADC  (X)
D1EC   B7 9D                      CPI  A,$9D
D1EE   83 08                      BCS BCD_Y2ARX_23 ; $D1F8
D1F0   B7 64                      CPI  A,$64
D1F2   81 04                      BCR BCD_Y2ARX_23 ; $D1F8
D1F4   68 10                      LDI  UH,$10
D1F6   CD 48                      VMJ  ($48)($24)

BCD_Y2ARX_23: ; $D1F8
D1F8   0E                         STA  (X)
D1F9   CD 4C                      VMJ  ($4C)($26)

BCD_Y2ARX_15: ; $D1FB
D1FB   D5                         SHR
D1FC   83 02                      BCS BCD_Y2ARX_24 ; $D200
D1FE   BB 02                      ORI  A,$02

BCD_Y2ARX_24: ; $D200
D200   DB                         ROL
D201   FD 0A                      POP  X
D203   9E 60                      BCH BCD_Y2ARX_12 ; $D1A5

BCD_Y2ARX_16: ; $D205
D205   D9                         SHL
D206   93 4E                      BCS BCD_Y2ARX_25 ; $D1BA
D208   D1                         ROR
D209   D1                         ROR
D20A   B5 40                      LDI  A,$40
D20C   81 01                      BCR BCD_Y2ARX_26 ; $D20F
D20E   D9                         SHL

BCD_Y2ARX_26: ; $D20F
D20F   AD 7A 01                   EOR  (ARX + $01)
D212   AE 7A 01                   STA  (ARX + $01)

BCD_Y2ARX_14: ; $D215
D215   FD 0A                      POP  X
D217   9E 71                      BCH BCD_Y2ARX_27 ; $D1A8

BCD_Y2ARX_17: ; $D219
D219   D9                         SHL
D21A   93 62                      BCS BCD_Y2ARX_25 ; $D1BA
D21C   9E 09                      BCH BCD_Y2ARX_14 ; $D215

BCD_Y2ARX_18: ; $D21E
D21E   D5                         SHR
D21F   93 0C                      BCS BCD_Y2ARX_14 ; $D215
D221   68 01                      LDI  UH,$01
D223   9E 10                      BCH BCD_Y2ARX_14 ; $D215

BCD_Y2ARX_33: ; $D225
D225   FD 5A                      STX  Y
D227   CD 12                      VMJ  ($12)

BCD_Y2ARX_31: ; $D229
D229   FD 6A                      STX  U
D22B   56                         DEC  Y
D22C   64                         INC  U

BCD_Y2ARX_30: ; $D22D
D22D   64                         INC  U
D22E   65                         LIN  U
D22F   FD EA                      ADR  U
D231   FB                         SEC
D232   24                         LDA  UL
D233   10                         SBC  YL
D234   A4                         LDA  UH
D235   90                         SBC  YH
D236   83 09                      BCS BCD_Y2ARX_28 ; $D241

BCD_Y2ARX_29: ; $D238
D238   65                         LIN  U
D239   DD                         INC  A
D23A   93 04                      BCS BCD_Y2ARX_29 ; $D238
D23C   FD 28                      LDX  U
D23E   46                         DEC  X
D23F   9E 14                      BCH BCD_Y2ARX_30 ; $D22D

BCD_Y2ARX_28: ; $D241
D241   FD 5A                      STX  Y
D243   CA A6                      VEJ  (CA) \ ABYTL(SRCH_ADD_H) ; $78A6
D245   9A                         RTN

BCD_Y2ARX_45: ; $D246
D246   CC B2                      VEJ  (CC) \ ABYTL(ERR_ADD_H) ; $78B2
D248   FD 5A                      STX  Y
D24A   CC B6                      VEJ  (CC) \ ABYTL(ERR_TOP_H) ; $78B6
D24C   8E 06                      BCH $D254 ; ***

BCD_Y2ARX_44: ; $D24E
D24E   CC A0                      VEJ  (CC) \ ABYTL(PREV_ADD_H) ; $78A0
D250   FD 5A                      STX  Y
D252   CC A4                      VEJ  (CC) \ ABYTL(PREV_TOP_H) ; $78A4
D254   FD 98                      PSH  Y
D256   BE D2 29                   SJP  (BCD_Y2ARX_31) ; $D229
D259   FD 0A                      POP  X
D25B   F9                         REC
D25C   04                         LDA  XL
D25D   10                         SBC  YL
D25E   DF                         DEC  A
D25F   DF                         DEC  A
D260   DF                         DEC  A
D261   8B 1B                      BZS BCD_Y2ARX_32 ; $D27E
D263   2A                         STA  UL
D264   46                         DEC  X
D265   46                         DEC  X
D266   05                         LDA  (X)
D267   B7 E0                      CPI  A,$E0
D269   24                         LDA  UL
D26A   81 12                      BCR BCD_Y2ARX_32 ; $D27E
D26C   DF                         DEC  A
D26D   8E 0F                      BCH BCD_Y2ARX_32 ; $D27E

BCD_Y2ARX_47: ; $D26F
D26F   CD 12                      VMJ  ($12)

BCD_Y2ARX_38: ; $D271
D271   CA A6                      VEJ  (CA) \ ABYTL(SRCH_ADD_H) ; $78A6
D273   FD 5A                      STX  Y
D275   8E 05                      BCH $D27C

BCD_Y2ARX_46: ; $D277
D277   CC 67                      VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867

BCD_Y2ARX_42: ; $D279
D279   BE D2 25                   SJP  (BCD_Y2ARX_33) ; $D225
D27C   B5 00                      LDI  A,$00

BCD_Y2ARX_32: ; $D27E
D27E   FD C8                      PSH  A
D280   CC 65                      VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865
D282   94                         LDA  YH
D283   86                         CPA  XH
D284   83 08                      BCS BCD_Y2ARX_34 ; $D28E
D286   CC 60                      VEJ  (CC) \ ABYTL(ST_ROM_MOD) ; $7860
D288   4A 07                      LDI  XL,$07
D28A   05                         LDA  (X)
D28B   DB                         ROL
D28C   81 21                      BCR BCD_Y2ARX_35 ; $D2AF

BCD_Y2ARX_34: ; $D28E
D28E   BE D0 30                   SJP  (INBUF_INIT)
D291   CC A6                      VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
D293   45                         LIN  X
D294   28                         STA  UH
D295   45                         LIN  X
D296   2A                         STA  UL
D297   FD 88                      PSH  X
D299   CD 10 40                   VMJ  ($10) \ ABYT($40)
D29C   FD 0A                      POP  X
D29E   45                         LIN  X
D29F   DF                         DEC  A
D2A0   B9 7F                      ANI  A,$7F
D2A2   2A                         STA  UL
D2A3   FD 98                      PSH  Y

BCD_Y2ARX_36: ; $D2A5
D2A5   F5                         TIN
D2A6   88 03                      LOP  UL,BCD_Y2ARX_36 ; $D2A5
D2A8   FD 1A                      POP  Y

BCD_Y2ARX_37: ; $D2AA
D2AA   FD 8A                      POP  A
D2AC   FD DA                      ADR  Y
D2AE   9A                         RTN

BCD_Y2ARX_35: ; $D2AF
D2AF   68 1F                      LDI  UH,$1F
D2B1   9E 09                      BCH BCD_Y2ARX_37 ; $D2AA
D2B3   CC A6                      VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
D2B5   44                         INC  X
D2B6   44                         INC  X
D2B7   45                         LIN  X
D2B8   FD CA                      ADR  X
D2BA   05                         LDA  (X)
D2BB   DD                         INC  A
D2BC   91 4D                      BCR  BCD_Y2ARX_38 ; $D271
D2BE   CD 16                      VMJ  ($16)
D2C0   B5 FF                      LDI  A,$FF
D2C2   8E 07                      BCH BCD_Y2ARX_39 ; $D2CB

BCD_Y2ARX_40: ; $D2C4
D2C4   F7                         CIN
D2C5   89 09                      BZR BCD_Y2ARX_1 ; $D2D0
D2C7   88 05                      LOP  UL,BCD_Y2ARX_40 ; $D2C4
D2C9   FD 62                      DEC  UH

BCD_Y2ARX_39: ; $D2CB
D2CB   93 09                      BCS BCD_Y2ARX_40 ; $D2C4

BCD_Y2ARX_41: ; $D2CD
D2CD   68 00                      LDI  UH,$00
D2CF   9A                         RTN

BCD_Y2ARX_1: ; $D2D0
D2D0   46                         DEC  X
D2D1   9E 62                      BCH BCD_Y2ARX_38 ; $D271

BCD_Y2ARX_43: ; $D2D3
D2D3   CD 12                      VMJ  ($12)
D2D5   FD 6A                      STX  U
D2D7   CC A6                      VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
D2D9   BE DF E2                   SJP  (U_MINUS_X)
D2DC   93 11                      BCS BCD_Y2ARX_41 ; $D2CD
D2DE   9E 67                      BCH BCD_Y2ARX_42 ; $D279

BCD_Y2ARX_2: ; $D2E0
D2E0   CC 69                      VEJ  (CC) \ ABYTL($7869)
D2E2   FD 98                      PSH  Y
D2E4   8E 19                      BCH SRCHPRGLINE_2 ; $D2FF
D2E6   6C FF                      CPI  UH,$FF
D2E8   89 3D                      SRCHPRGLINE_3 ; BZR $D327



LINESEARCH: ; $D2EA
D2EA   CD 12                      VMJ  ($12)



SRCHPRGLINE: ; $D2EC
D2EC   FD 98                      PSH  Y
D2EE   FD A8                      PSH  U
D2F0   CA AA                      VEJ  (CA) \ ABYTL(SRCH_TOP_H) ; $78AA

SRCHPRGLINE_10: ; $D2F2
D2F2   FD 2A                      POP  U
D2F4   6C FF                      CPI  UH,$FF
D2F6   89 07                      BZR SRCHPRGLINE_2 ; $D2FF
D2F8   FD 88                      PSH  X
D2FA   E6                         VEJ  (E6)
D2FB   FD 0A                      POP  X

SRCHPRGLINE_8: ; $D2FD
D2FD   68 FF                      LDI  UH,$FF

SRCHPRGLINE_2: ; $D2FF
D2FF   BE D0 BC                   SJP  (DEL_DIM_VARS_14) ; $D0BC
D302   A5 78 A8                   LDA  (SRCH_LINE_H)
D305   B7 FF                      CPI  A,$FF
D307   81 38                      BCR SRCHPRGLINE_4 ; $D341
D309   6C FF                      CPI  UH,$FF
D30B   81 11                      BCR SRCHPRGLINE_5 ; $D31E
D30D   CD 16                      VMJ  ($16)
D30F   81 0D                      BCR SRCHPRGLINE_5 ; $D31E
D311   46                         DEC  X
D312   46                         DEC  X
D313   B5 FF                      LDI  A,$FF

SRCHPRGLINE_7: ; $D315
D315   F7                         CIN
D316   89 0A                      BZR SRCHPRGLINE_6 ; $D322
D318   88 05                      LOP  UL,SRCHPRGLINE_7 ; $D315
D31A   FD 62                      DEC  UH
D31C   93 09                      BCS SRCHPRGLINE_7 ; $D315

SRCHPRGLINE_5: ; $D31E
D31E   68 0B                      LDI  UH,$0B
D320   CD 4A                      VMJ  ($4A)($25)

SRCHPRGLINE_6: ; $D322
D322   46                         DEC  X
D323   CA AA                      VEJ  (CA) \ ABYTL(SRCH_TOP_H) ; $78AA
D325   9E 2A                      BCH SRCHPRGLINE_8 ; $D2FD

SRCHPRGLINE_3: ; $D327
D327   CC 9C                      VEJ  (CC) \ ABYTL(CURR_LINE_H) ; $789C
D329   24                         LDA  UL
D32A   00                         SBC  XL
D32B   A4                         LDA  UH
D32C   80                         SBC  XH
D32D   83 04                      BCS SRCHPRGLINE_9 ; $D333
D32F   CC AA                      VEJ  (CC) \ ABYTL(SRCH_TOP_H) ; $78AA
D331   9E 47                      BCH SRCHPRGLINE

SRCHPRGLINE_9: ; $D333
D333   FD 98                      PSH  Y
D335   FD A8                      PSH  U
D337   CC 9E                      VEJ  (CC) \ ABYTL(CURR_TOP_H) ; $789E
D339   CA AA                      VEJ  (CA) \ ABYTL(SRCH_TOP_H) ; $78AA
D33B   56                         DEC  Y
D33C   CD 20                      VMJ  ($20)
D33E   38                         NOP
D33F   9E 4F                      BCH SRCHPRGLINE_10 ; $D2F2

SRCHPRGLINE_4: ; $D341
D341   6C FF                      CPI  UH,$FF
D343   89 1D                      BZR SRCHPRGLINE_11 ; $D362
D345   45                         LIN  X
D346   B7 22                      CPI  A,$22
D348   89 11                      BZR SRCHPRGLINE_12 ; $D35B
D34A   FD 88                      PSH  X
D34C   FD 5A                      STX  Y
D34E   CD 0C                      VMJ  ($0C)
D350   B5 04                      LDI  A,$04
D352   BE D0 F9                   SJP  (DEL_DIM_VARS_15) ; $D0F9
D355   FD 0A                      POP  X
D357   68 FF                      LDI  UH,$FF
D359   89 14                      BZR SRCHPRGLINE_13 ; $D36F

SRCHPRGLINE_12: ; $D35B
D35B   46                         DEC  X

SRCHPRGLINE_14: ; $D35C
D35C   46                         DEC  X
D35D   45                         LIN  X
D35E   FD CA                      ADR  X
D360   9E 63                      BCH SRCHPRGLINE_2 ; $D2FF

SRCHPRGLINE_11: ; $D362
D362   A6                         CPA  UH
D363   91 09                      BCR  SRCHPRGLINE_14 ; $D35C
D365   99 49                      BZR  SRCHPRGLINE_5 ; $D31E
D367   A5 78 A9                   LDA  (SRCH_LINE_L)
D36A   26                         CPA  UL
D36B   91 11                      BCR  SRCHPRGLINE_14 ; $D35C
D36D   99 51                      BZR  SRCHPRGLINE_5 ; $D31E

SRCHPRGLINE_13: ; $D36F
D36F   CD 4E                      VMJ  ($4E)($27)

SRCHPRGLINE_16: ; $D371
D371   A5 78 84                   LDA  (CURVARADD_L)
D374   B9 20                      ANI  A,$20
D376   D5                         SHR
D377   1A                         STA  YL
D378   89 04                      BZR SRCHPRGLINE_15 ; $D37E
D37A   5A 08                      LDI  YL,$08
D37C   B5 88                      LDI  A,$88

SRCHPRGLINE_15: ; $D37E
D37E   AE 78 85                   STA  (CURVARTYPE) ; $7885
D381   B5 00                      LDI  A,$00
D383   18                         STA  YH
D384   2A                         STA  UL
D385   28                         STA  UH

SRCHPRGLINE_1 ; $D386
D386   FD A8                      PSH  U
D388   F4 78 99                   VEJ  (F4) \ AWRD(VAR_START_H)
D38B   B5 07                      LDI  A,$07
D38D   F9                         REC
D38E   12                         ADC  YL
D38F   0A                         STA  XL
D390   B5 00                      LDI  A,$00
D392   92                         ADC  YH
D393   08                         STA  XH
D394   83 39                      BCS DELU_FROMX_2 ; $D3CF
D396   BE DF E2                   SJP  (U_MINUS_X)
D399   81 34                      BCR DELU_FROMX_2 ; $D3CF
D39B   FD 28                      LDX  U
D39D   46                         DEC  X
D39E   CD 16                      VMJ  ($16)
D3A0   83 2D                      BCS DELU_FROMX_2 ; $D3CF
D3A2   44                         INC  X
D3A3   CA 99                      VEJ  (CA) \ ABYTL($7899)
D3A5   F4 78 83                   VEJ  (F4) \ AWRD(CURVARADD_H)
D3A8   B9 7F                      ANI  A,$7F
D3AA   41                         SIN  X
D3AB   24                         LDA  UL
D3AC   41                         SIN  X
D3AD   14                         LDA  YL
D3AE   2A                         STA  UL
D3AF   94                         LDA  YH
D3B0   28                         STA  UH
D3B1   54                         INC  Y
D3B2   54                         INC  Y
D3B3   54                         INC  Y
D3B4   94                         LDA  YH
D3B5   41                         SIN  X
D3B6   14                         LDA  YL
D3B7   41                         SIN  X
D3B8   FD 1A                      POP  Y
D3BA   14                         LDA  YL
D3BB   41                         SIN  X
D3BC   94                         LDA  YH
D3BD   41                         SIN  X
D3BE   A5 78 85                   LDA  (CURVARTYPE) ; $7885
D3C1   41                         SIN  X
D3C2   FD 5A                      STX  Y



DELU_FROMX: ; $D3C4
D3C4   66                         DEC  U
D3C5   B5 00                      LDI  A,$00

DELU_FROMX_1: ; $D3C7
D3C7   41                         SIN  X
D3C8   88 03                      LOP  UL,DELU_FROMX_1 ; $D3C7
D3CA   FD 62                      DEC  UH
D3CC   93 07                      BCS DELU_FROMX_1 ; $D3C7
D3CE   9A                         RTN

DELU_FROMX_2: ; $D3CF
D3CF   68 0A                      LDI  UH,$0A
D3D1   FB                         SEC
D3D2   FD 0A                      POP  X
D3D4   9A                         RTN

DEC2HEX:
D3D5   4A 00                      LDI  XL,$00
D3D7   48 00                      LDI  XH,$00

DEC2HEX_4: ; $D3D9
D3D9   FD 88                      PSH  X
D3DB   CD 02 30 3A 1E             VMJ  ($02) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_2) ; $D3FE
D3E0   FD 0A                      POP  X
D3E2   FD 98                      PSH  Y
D3E4   FD C8                      PSH  A
D3E6   FD 5A                      STX  Y
D3E8   6A 0A                      LDI  UL,$0A
D3EA   CD 50                      VMJ  ($50)($28)
D3EC   FD 8A                      POP  A
D3EE   68 1E                      LDI  UH,$1E
D3F0   FD 1A                      POP  Y
D3F2   83 12                      BCS DEC2HEX_3 ; $D406
D3F4   4C FF                      CPI  XH,$FF
D3F6   8B 0E                      BZS DEC2HEX_3 ; $D406
D3F8   B9 0F                      ANI  A,$0F
D3FA   FD CA                      ADR  X
D3FC   9E 25                      BCH DEC2HEX_4 ; $D3D9

DEC2HEX_2: ; $D3FE
D3FE   C6                         VEJ  (C6)
D3FF   FD 2A                      POP  U
D401   24                         LDA  UL
D402   F9                         REC
D403   89 01                      BZR DEC2HEX_3 ; $D406
D405   A4                         LDA  UH

DEC2HEX_3: ; $D406
D406   9A                         RTN

DEC2HEX_13: ; $D407
D407   C0                         VEJ  (C0)
D408   CD 00 40 5B 22             VMJ  ($00) \ ABYT($40) \ ABYT($5B) \ ABRF(DEC2HEX_4) ; $D42F

DEC2HEX_70: ; $D40D
D40D   24                         LDA  UL
D40E   08                         STA  XH
D40F   4A 00                      LDI  XL,$00

DEC2HEX_9: ; $D411
D411   FD 88                      PSH  X
D413   CD 02 41 5B 02             VMJ  ($02) \ ABYT($41) \ ABYT($5B) \ ABRF(EC2HEX_5) ; $D41A
D418   8E 08                      BCH DEC2HEX_7 ; $D422

DEC2HEX_5: ; $D41A
D41A   CD 00 30 3A 1C             VMJ  ($00) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_6) ; $D43B
D41F   B9 DF                      ANI  A,$DF
D421   2A                         STA  UL

DEC2HEX_7: ; $D422
D422   FD 0A                      POP  X
D424   4C 40                      CPI  XH,$40
D426   8B 31                      BZS DEC2HEX_8 ; $D459
D428   04                         LDA  XL
D429   99 1A                      BZR DEC2HEX_9 ; $D411
D42B   24                         LDA  UL
D42C   0A                         STA  XL
D42D   9E 1E                      BCH DEC2HEX_9 ; $D411

DEC2HEX_4: ; $D42F
D42F   C4 F1 5B 02                VEJ  (C4) \ AWRD($F15B) \ ABRF(DEC2HEX_10) ; $D435
D433   CD 4C                      VMJ  ($4C)($26)

DEC2HEX_10: ; $D435
D435   A4                         LDA  UH
D436   2A                         STA  UL
D437   68 15                      LDI  UH,$15
D439   CD 48                      VMJ  ($48)($24)

DEC2HEX_6: ; $D43B
D43B   C4 24 09                   VEJ  (C4) \ ACHR($24) \ ABRF(DEC2HEX_11) ; $D447
D43E   FD 2A                      POP  U
D440   B5 20                      LDI  A,$20
D442   FD EA                      ADR  U
D444   FD A8                      PSH  U
D446   C0                         VEJ  (C0)

DEC2HEX_11: ; $D447
D447   C4 28 08                   VEJ  (C4) \ ACHR($28) \ ABRF(DEC2HEX_12) ; $D452
D44A   FD 2A                      POP  U
D44C   B5 80                      LDI  A,$80
D44E   FD EA                      ADR  U
D450   CD 4C                      VMJ  ($4C)($26)

DEC2HEX_12: ; $D452
D452   C6                         VEJ  (C6)
D453   FD 2A                      POP  U
D455   6C 40                      CPI  UH,$40
D457   C9 4C                      VZR  ($4C)($26)

DEC2HEX_8: ; $D459
D459   68 14                      LDI  UH,$14
D45B   CD 48                      VMJ  ($48)($24)
D45D   BE D4 07                   SJP  (DEC2HEX_13) ; $D407
D460   58 FD                      LDI  YH,$FD
D462   0A                         STA  XL
D463   45                         LIN  X
D464   FD 88                      PSH  X
D466   46                         DEC  X
D467   FD C8                      PSH  A
D469   24                         LDA  UL
D46A   B9 A0                      ANI  A,$A0
D46C   0D                         EOR  (X)
D46D   BF C0                      BII  A,$C0
D46F   8B 9B                      BZS DEC2HEX_14 ; $D50C
D471   BF 30                      BII  A,$30
D473   8B 97                      BZS DEC2HEX_14 ; $D50C
D475   6C 40                      CPI  UH,$40
D477   8B 97                      BZS DEC2HEX_15 ; $D510
D479   6C 5B                      CPI  UH,$5B
D47B   81 03                      BCR DEC2HEX_16 ; $D480
D47D   BA D5 D8                   JMP  DEC2HEX_29 ; $D5D8

DEC2HEX_16: ; $D480
D480   24                         LDA  UL
D481   B9 DF                      ANI  A,$DF
D483   89 30                      BZR DEC2HEX_17 ; $D4B5

DEC2HEX_37: ; $D485
D485   A4                         LDA  UH
D486   B9 1F                      ANI  A,$1F
D488   4A F8                      LDI  XL,$F8
D48A   48 78                      LDI  XH,$78
D48C   6E 20                      CPI  UL,$20
D48E   81 13                      BCR DEC2HEX_18 ; $D4A3
D490   4A B0                      LDI  XL,$B0
D492   B7 05                      CPI  A,$05
D494   81 0C                      BCR DEC2HEX_19 ; $D4A2
D496   4A 00                      LDI  XL,$00
D498   48 76                      LDI  XH,$76
D49A   B7 10                      CPI  A,$10
D49C   81 04                      BCR DEC2HEX_19 ; $D4A2
D49E   4A 50                      LDI  XL,$50
D4A0   48 77                      LDI  XH,$77

DEC2HEX_19: ; $D4A2
D4A2   D9                         SHL

DEC2HEX_18: ; $D4A3
D4A3   D9                         SHL
D4A4   D9                         SHL
D4A5   D9                         SHL
D4A6   FD CA                      ADR  X
D4A8   68 00                      LDI  UH,$00
D4AA   FD 8A                      POP  A
D4AC   FD C8                      PSH  A
D4AE   D1                         ROR
D4AF   24                         LDA  UL
D4B0   83 4E                      BCS DEC2HEX_20 ; $D500
D4B2   BA D5 E6                   JMP  DEC2HEX_21 ; $D5E6

DEC2HEX_17: ; $D4B5
D4B5   CC 99                      VEJ  (CC) \ ABYTL(VAR_START_H) ; $7899
D4B7   8E 11                      BCH DEC2HEX_30 ; $D4CA
D4B9   FD 0A                      POP  X
D4BB   BA DC F6                   JMP  LOAD_NEXT_2 ; $DCF6

DEC2HEX_23: ; $D4BE
D4BE   44                         INC  X

DEC2HEX_24: ; $D4BF
D4BF   45                         LIN  X
D4C0   FD C8                      PSH  A
D4C2   45                         LIN  X
D4C3   F9                         REC
D4C4   02                         ADC  XL
D4C5   0A                         STA  XL
D4C6   FD 8A                      POP  A
D4C8   82                         ADC  XH
D4C9   08                         STA  XH

DEC2HEX_30: ; $D4CA
D4CA   A7 78 64                   CPA  (RAM_END_H)
D4CD   83 DA                      BCS DEC2HEX_22 ; $D5A9
D4CF   45                         LIN  X
D4D0   A6                         CPA  UH
D4D1   99 15                      BZR  DEC2HEX_23 ; $D4BE
D4D3   45                         LIN  X
D4D4   26                         CPA  UL
D4D5   99 18                      BZR  DEC2HEX_24 ; $D4BF
D4D7   FD 8A                      POP  A
D4D9   FD C8                      PSH  A
D4DB   D5                         SHR
D4DC   83 10                      BCS DEC2HEX_25 ; $D4EE
D4DE   44                         INC  X
D4DF   44                         INC  X
D4E0   D5                         SHR
D4E1   83 78                      BCS DEC2HEX_26 ; $D55B
D4E3   D5                         SHR
D4E4   81 60                      BCR DEC2HEX_27 ; $D546
D4E6   68 05                      LDI  UH,$05
D4E8   8E BB                      BCH DEC2HEX_28 ; $D5A5

DEC2HEX_31: ; $D4EA
D4EA   68 01                      LDI  UH,$01
D4EC   8E B7                      BCH DEC2HEX_28 ; $D5A5

DEC2HEX_25: ; $D4EE
D4EE   6E 80                      CPI  UL,$80

DEC2HEX_49: ; $D4F0
D4F0   68 01                      LDI  UH,$01
D4F2   81 0C                      BCR DEC2HEX_20 ; $D500
D4F4   68 21                      LDI  UH,$21

DEC2HEX_33: ; $D4F6
D4F6   55                         LIN  Y
D4F7   B7 2A                      CPI  A,$2A
D4F9   99 11                      BZR DEC2HEX_31 ; $D4EA
D4FB   55                         LIN  Y
D4FC   B7 29                      CPI  A,$29
D4FE   99 16                      BZR DEC2HEX_31 ; $D4EA

DEC2HEX_20: ; $D500
D500   FD 8A                      POP  A
D502   24                         LDA  UL
D503   B9 20                      ANI  A,$20
D505   D5                         SHR
D506   D5                         SHR
D507   A2                         ADC  UH
D508   FD 6A                      STX  U

DEC2HEX_45: ; $D50A
D50A   CD 4C                      VMJ  ($4C)($26)

DEC2HEX_14: ; $D50C
D50C   68 07                      LDI  UH,$07
D50E   8E 95                      BCH DEC2HEX_28 ; $D5A5

DEC2HEX_15: ; $D510
D510   FD 8A                      POP  A
D512   FD C8                      PSH  A
D514   B9 07                      ANI  A,$07
D516   8B 1B                      BZS DEC2HEX_32 ; $D533
D518   D5                         SHR
D519   91 0F                      BCR DEC2HEX_14 ; $D50C
D51B   4A C0                      LDI  XL,$C0
D51D   48 78                      LDI  XH,$78
D51F   68 10                      LDI  UH,$10
D521   6E A0                      CPI  UL,$A0
D523   93 2F                      BCS DEC2HEX_33 ; $D4F6
D525   0A                         STA  XL
D526   48 79                      LDI  XH,$79
D528   9E 34                      BCH DEC2HEX_33 ; $D4F6

DEC2HEX_78: ; $D52A
D52A   FD C8                      PSH  A
D52C   FD A8                      PSH  U
D52E   CD 28 C4                   VMJ  ($28) \ ABRF(DEC2HEX_34) ; $D5F5
D531   8E 07                      BCH DEC2HEX_35 ; $D53A

DEC2HEX_32: ; $D533
D533   FD A8                      PSH  U
D535   DE BE                      VEJ  (DE) \ ABRF(DEC2HEX_34) ; $D5F5
D537   C2 29 B9                   VEJ  (C2) \ ACHR($29) \ ABRF(DEC2HEX_36) ; $D5F3

DEC2HEX_35: ; $D53A
D53A   D0 0F B8                   VEJ  (D0) \ ABYT($0F) \ ABRF(DEC2HEX_34) ; $D5F5
D53D   FD 2A                      POP  U
D53F   28                         STA  UH
D540   24                         LDA  UL
D541   D9                         SHL
D542   D5                         SHR
D543   2A                         STA  UL
D544   9E C1                      BCH DEC2HEX_37 ; $D485

DEC2HEX_27: ; $D546
D546   6E 80                      CPI  UL,$80
D548   83 19                      BCS DEC2HEX_38 ; $D563
D54A   44                         INC  X
D54B   44                         INC  X
D54C   45                         LIN  X

DEC2HEX_42: ; $D54D
D54D   CD 24                      VMJ  ($24)
D54F   FD 6A                      STX  U
D551   FD 8A                      POP  A
D553   BF 08                      BII  A,$08
D555   89 02                      BZR DEC2HEX_39 ; $D559
D557   CD 0A                      VMJ  ($0A)

DEC2HEX_39: ; $D559
D559   CD 4C                      VMJ  ($4C)($26)

DEC2HEX_26: ; $D55B
D55B   FD 88                      PSH  X
D55D   BE D7 CA                   SJP  (DEC2HEX_40) ; $D7CA
D560   94                         LDA  YH
D561   8E 05                      BCH DEC2HEX_43 ; $D568

DEC2HEX_38: ; $D563
D563   FD 88                      PSH  X
D565   CD 2C 8D                   VMJ  ($2C) \ ABRF(DEC2HEX_34) ; $D5F5

DEC2HEX_43: ; $D568
D568   FD 0A                      POP  X
D56A   FD 98                      PSH  Y
D56C   45                         LIN  X
D56D   1A                         STA  YL
D56E   26                         CPA  UL
D56F   81 30                      BCR DEC2HEX_41 ; $D5A1
D571   45                         LIN  X
D572   A6                         CPA  UH
D573   81 2C                      BCR DEC2HEX_41 ; $D5A1
D575   45                         LIN  X
D576   FD C8                      PSH  A
D578   FD 88                      PSH  X
D57A   FD C8                      PSH  A
D57C   24                         LDA  UL
D57D   FD C8                      PSH  A
D57F   A4                         LDA  UH
D580   2A                         STA  UL
D581   58 00                      LDI  YH,$00
D583   68 00                      LDI  UH,$00
D585   54                         INC  Y
D586   CD 50                      VMJ  ($50)($28)
D588   FD 8A                      POP  A
D58A   FD DA                      ADR  Y
D58C   FD 8A                      POP  A
D58E   B9 7F                      ANI  A,$7F
D590   2A                         STA  UL
D591   CD 50                      VMJ  ($50)($28)
D593   FD 0A                      POP  X
D595   14                         LDA  YL
D596   02                         ADC  XL
D597   0A                         STA  XL
D598   94                         LDA  YH
D599   82                         ADC  XH
D59A   08                         STA  XH
D59B   FD 8A                      POP  A
D59D   FD 1A                      POP  Y
D59F   9E 54                      BCH DEC2HEX_42 ; $D54D

DEC2HEX_41: ; $D5A1
D5A1   68 09                      LDI  UH,$09

DEC2HEX_48: ; $D5A3
D5A3   FD 1A                      POP  Y

DEC2HEX_28: ; $D5A5
D5A5   FD 8A                      POP  A
D5A7   CD 48                      VMJ  ($48)($24)

DEC2HEX_22: ; $D5A9
D5A9   6E 80                      CPI  UL,$80
D5AB   FD 8A                      POP  A
D5AD   81 08                      BCR DEC2HEX_44 ; $D5B7
D5AF   BF 04                      BII  A,$04
D5B1   99 A9                      BZR DEC2HEX_45 ; $D50A
D5B3   68 06                      LDI  UH,$06
D5B5   CD 48                      VMJ  ($48)($24)

DEC2HEX_44: ; $D5B7
D5B7   FD C8                      PSH  A
D5B9   B9 07                      ANI  A,$07
D5BB   8B 23                      BZS DEC2HEX_46 ; $D5E0
D5BD   ED 78 79 80                BII  (CASS_FLAG),$80
D5C1   8B 2C                      BZS DEC2HEX_47 ; $D5EF
D5C3   DA                         VEJ  (DA)
D5C4   FD 98                      PSH  Y
D5C6   BE D3 71                   SJP  (SRCHPRGLINE_16) ; $D371
D5C9   93 28                      BCS DEC2HEX_48 ; $D5A3
D5CB   FD 18                      LDX  Y
D5CD   FD 1A                      POP  Y
D5CF   A5 78 84                   LDA  (CURVARADD_L)
D5D2   2A                         STA  UL
D5D3   46                         DEC  X
D5D4   46                         DEC  X
D5D5   46                         DEC  X
D5D6   9E E8                      BCH DEC2HEX_49 ; $D4F0

DEC2HEX_29: ; $D5D8
D5D8   FD 8A                      POP  A
D5DA   FD C8                      PSH  A
D5DC   B9 07                      ANI  A,$07
D5DE   99 D4                      BZR DEC2HEX_14 ; $D50C

DEC2HEX_46: ; $D5E0
D5E0   A4                         LDA  UH
D5E1   BB 80                      ORI  A,$80
D5E3   08                         STA  XH
D5E4   24                         LDA  UL
D5E5   0A                         STA  XL

DEC2HEX_21: ; $D5E6
D5E6   B9 20                      ANI  A,$20
D5E8   D5                         SHR
D5E9   99 9E                      BZR DEC2HEX_42 ; $D54D
D5EB   B5 88                      LDI  A,$88
D5ED   9E A2                      BCH DEC2HEX_42 ; $D54D

DEC2HEX_47: ; $D5EF
D5EF   68 15                      LDI  UH,$15
D5F1   9E 4E                      BCH DEC2HEX_28 ; $D5A5

DEC2HEX_36: ; $D5F3
D5F3   68 01                      LDI  UH,$01

DEC2HEX_34: ; $D5F5
D5F5   FD 0A                      POP  X
D5F7   9E 54                      BCH DEC2HEX_28 ; $D5A5
D5F9   FD 0A                      POP  X
D5FB   45                         LIN  X
D5FC   FD 88                      PSH  X
D5FE   FD 98                      PSH  Y
D600   FD C8                      PSH  A
D602   5A 00                      LDI  YL,$00
D604   58 00                      LDI  YH,$00
D606   A5 7A 04                   LDA  (ARX + $04)
D609   B7 B2                      CPI  A,$B2
D60B   81 33                      BCR DEC2HEX_50 ; $D640
D60D   89 11                      BZR DEC2HEX_51 ; $D620
D60F   DC                         VEJ  (DC)
D610   FD 5A                      STX  Y
D612   5C 80                      CPI  YH,$80
D614   81 31                      BCR DEC2HEX_52 ; $D647
D616   FD 8A                      POP  A
D618   B9 1F                      ANI  A,$1F
D61A   B7 04                      CPI  A,$04
D61C   CB 4E                      VZS  ($4E)($27)
D61E   8E 2B                      BCH DEC2HEX_53 ; $D64B

DEC2HEX_51: ; $D620
D620   2A                         STA  UL
D621   FD 8A                      POP  A
D623   DB                         ROL
D624   68 11                      LDI  UH,$11
D626   81 83                      BCR DEC2HEX_54 ; $D6AB
D628   6E C1                      CPI  UL,$C1
D62A   68 FF                      LDI  UH,$FF
D62C   89 3C                      BZR DEC2HEX_55 ; $D66A
D62E   DB                         ROL
D62F   81 39                      BCR DEC2HEX_55 ; $D66A
D631   D1                         ROR
D632   D5                         SHR
D633   FD C8                      PSH  A
D635   DC                         VEJ  (DC)
D636   8B 0F                      BZS DEC2HEX_52 ; $D647
D638   05                         LDA  (X)
D639   1A                         STA  YL
D63A   04                         LDA  XL
D63B   AE 78 94                   STA  (STR_BUF_PTR_L)
D63E   8E 07                      BCH DEC2HEX_52 ; $D647

DEC2HEX_50: ; $D640
D640   A5 7A 00                   LDA  (ARX)
D643   2A                         STA  UL
D644   D9                         SHL
D645   81 2F                      BCR DEC2HEX_56 ; $D676

DEC2HEX_52: ; $D647
D647   FD 8A                      POP  A
D649   B9 1F                      ANI  A,$1F

DEC2HEX_53: ; $D64B
D64B   D5                         SHR
D64C   81 08                      BCR DEC2HEX_57 ; $D656
D64E   5E 00                      CPI  YL,$00
D650   89 04                      BZR DEC2HEX_57 ; $D656
D652   5C 00                      CPI  YH,$00
D654   8B 53                      BZS DEC2HEX_58 ; $D6A9

DEC2HEX_57: ; $D656
D656   D9                         SHL
D657   4A AD                      LDI  XL,$AD
D659   48 D6                      LDI  XH,$D6
D65B   FD CA                      ADR  X
D65D   45                         LIN  X
D65E   12                         ADC  YL
D65F   05                         LDA  (X)
D660   92                         ADC  YH
D661   83 46                      BCS DEC2HEX_58 ; $D6A9
D663   14                         LDA  YL
D664   2A                         STA  UL
D665   94                         LDA  YH
D666   28                         STA  UH

DEC2HEX_61: ; $D667
D667   BE D9 E7                   SJP  (ARUINT2ARX)

DEC2HEX_55: ; $D66A
D66A   CD 4E                      VMJ  ($4E)($27)

DEC2HEX_60: ; $D66C
D66C   FD A8                      PSH  U
D66E   6A 0A                      LDI  UL,$0A
D670   CD 50                      VMJ  ($50)($28)
D672   FD 2A                      POP  U
D674   83 31                      BCS DEC2HEX_59 ; $D6A7

DEC2HEX_56: ; $D676
D676   4A 04                      LDI  XL,$04
D678   48 7A                      LDI  XH,$7A
D67A   D7                         DRL  (X)
D67B   46                         DEC  X
D67C   D7                         DRL  (X)
D67D   46                         DEC  X
D67E   D7                         DRL  (X)
D67F   B9 F0                      ANI  A,$F0
D681   F1                         AEX
D682   12                         ADC  YL
D683   1A                         STA  YL
D684   B5 00                      LDI  A,$00
D686   28                         STA  UH
D687   92                         ADC  YH
D688   18                         STA  YH
D689   83 1C                      BCS DEC2HEX_59 ; $D6A7
D68B   88 21                      LOP  UL,DEC2HEX_60 ; $D66C
D68D   28                         STA  UH
D68E   14                         LDA  YL
D68F   2A                         STA  UL
D690   ED 7A 01 80                BII  (ARX + $01),$80
D694   9B 4F                      BZS DEC2HEX_52 ; $D647
D696   BE DA A8                   SJP  (TWOSCOMP)
D699   6C 80                      CPI  UH,$80
D69B   81 0A                      BCR DEC2HEX_59 ; $D6A7
D69D   FD 8A                      POP  A
D69F   B9 1F                      ANI  A,$1F
D6A1   B7 04                      CPI  A,$04
D6A3   9B 3E                      BZS DEC2HEX_61 ; $D667
D6A5   8E 02                      BCH DEC2HEX_58 ; $D6A9

DEC2HEX_59: ; $D6A7
D6A7   FD 8A                      POP  A

DEC2HEX_58: ; $D6A9
D6A9   68 13                      LDI  UH,$13

DEC2HEX_54: ; $D6AB
D6AB   CD 4A                      VMJ  ($4A)($25)
D6AD   00                         SBC  XL
D6AE   00                         SBC  XL
D6AF   00                         SBC  XL
D6B0   01                         SBC  (X)
D6B1   00                         SBC  XL
D6B2   80                         SBC  XH
D6B3   00                         SBC  XL
D6B4   80                         SBC  XH
D6B5   00                         SBC  XL
D6B6   FF                         NOP
D6B7   64                         INC  U
D6B8   FF                         NOP
D6B9   AF FF E5                   BIT  ($FFE5)
D6BC   FF                         NOP
D6BD   E6                         VEJ  (E6)
D6BE   FF                         NOP
D6BF   38                         NOP
D6C0   FD 98                      PSH  Y
D6C2   BE D3 D5                   SJP  (DEC2HEX)
D6C5   83 16                      BCS DEC2HEX_62 ; $D6DD
D6C7   8B 14                      BZS DEC2HEX_62 ; $D6DD
D6C9   BE D9 E7                   SJP  (ARUINT2ARX)
D6CC   C2 2E 02                   VEJ  (C2) \ ACHR($2E) \ ABRF($D6D1)
D6CF   8E 0C                      BCH DEC2HEX_62 ; $D6DD
D6D1   C4 45 02                   VEJ  (C4) \ ACHR($45) \ ABRF($D6D6)
D6D4   8E 07                      BCH DEC2HEX_62 ; $D6DD
D6D6   FD 0A                      POP  X
D6D8   C6                         VEJ  (C6)

DEC2HEX_1:  ; $D6D9
D6D9   B5 02                      LDI  A,$02
D6DB   8E 04                      BCH DEC2HEX_63 ; $D6E1

DEC2HEX_62:  ; $D6DD
D6DD   FD 1A                      POP  Y
D6DF   B5 01                      LDI  A,$01

DEC2HEX_63:  ; $D6E1
D6E1   E9 78 89 FE                ANI  ($7889),$FE

DEC2HEX_127:  ; $D6E5
D6E5   AE 78 81                   STA  ($7881)
D6E8   CC 90                      VEJ  (CC) \ ABYTL($7890)
D6EA   F9                         REC
D6EB   B3 04                      ADI  A,$04
D6ED   08                         STA  XH
D6EE   CA 92                      VEJ  (CA) \ ABYTL($7892)
D6F0   64                         INC  U
D6F1   B5 10                      LDI  A,$10
D6F3   2E                         STA  (U)
D6F4   BA D8 26                   JMP  DEC2HEX_64 ; $D826

DEC2HEX_66:  ; $D6F7
D6F7   BA DA 25                   JMP  BCMD_RLM_STR_1 ; $DA25

DEC2HEX_87:  ; $D6FA
D6FA   CD 00 30 3A 0F             VMJ  ($00) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_65) ; $D70E
D6FF   ED 78 81 1D                BII  ($7881),$1D
D703   9B 0E                      BZS DEC2HEX_66 ; $D6F7

DEC2HEX_105:  ; $D705
D705   56                         DEC  Y
D706   6A 4F                      LDI  UL,$4F
D708   BE D1 4F E7                SJP  (BCD_Y2ARX) \ ABRF(DEC2HEX_67) ; $D7F3
D70C   8E 28                      BCH DEC2HEX_68 ; $D736

DEC2HEX_65:  ; $D70E
D70E   CD 00 40 5B 25             VMJ  ($00) \ ABYT($40) \ ABYT($5B) \ ABRF(DEC2HEX_69) ; $D738
D713   ED 78 81 1D                BII  ($7881),$1D
D717   9B 22                      BZS DEC2HEX_66 ; $D6F7
D719   BE D4 0D                   SJP  (DEC2HEX_70) ; $D40D
D71C   D6 6E                      VEJ  (D6) \ ABYT($6E)
D71E   80                         SBC  XH
D71F   81 11                      BCR DEC2HEX_71 ; $D732
D721   BE DB E0                   SJP  (ISARXBCD_5) ; $DBE0
D724   C3 48                      VCS  ($48)($24)
D726   B5 01                      LDI  A,$01
D728   AE 78 81                   STA  ($7881)
D72B   B5 01                      LDI  A,$01
D72D   AE 78 8C                   STA  (NUMARGS)
D730   8E 35                      BCH DEC2HEX_72 ; $D767

DEC2HEX_71:  ; $D732
D732   CD 0E 50 BD                VMJ  ($0E) \ ABYT($50) \ ABRF(DEC2HEX_67) ; $D7F3

DEC2HEX_68:  ; $D736
D736   8E E9                      BCH DEC2HEX_73 ; $D821

DEC2HEX_69:  ; $D738
D738   24                         LDA  UL
D739   6A 10                      LDI  UL,$10
D73B   BE DA 98                   SJP  (MULT16B_1) ; $DA98
D73E   2A                         STA  UL
D73F   45                         LIN  X
D740   28                         STA  UH
D741   45                         LIN  X
D742   A9 78 81                   AND  ($7881)
D745   9B 50                      BZS DEC2HEX_66 ; $D6F7
D747   45                         LIN  X
D748   FD C8                      PSH  A
D74A   45                         LIN  X
D74B   48 D7                      LDI  XH,$D7
D74D   4A 55                      LDI  XL,$55
D74F   FD CA                      ADR  X
D751   FD 8A                      POP  A
D753   FD 5E                      STX  P
D755   ED 78 81 1D                BII  ($7881),$1D
D759   8B DC                      BZS DEC2HEX_74 ; $D837
D75B   68 83                      LDI  UH,$83
D75D   B5 04                      LDI  A,$04

DEC2HEX_107:  ; $D75F
D75F   AE 78 81                   STA  ($7881)
D762   BE DB E0                   SJP  (ISARXBCD_5) ; $DBE0
D765   C3 48                      VCS  ($48)($24)

DEC2HEX_72:  ; $D767
D767   BA D8 9D                   JMP  DEC2HEX_75 ; $D89D
D76A   6A 01                      LDI  UL,$01
D76C   17                         CPA  (Y)
D76D   89 04                      BZR DEC2HEX_101 ; $D773
D76F   6A 05                      LDI  UL,$05
D771   8E 06                      BCH DEC2HEX_100 ; $D779

DEC2HEX_101:  ; $D773
D773   DD                         INC  A
D774   17                         CPA  (Y)
D775   89 03                      BZR DEC2HEX_99 ; $D77A
D777   6A 00                      LDI  UL,$00

DEC2HEX_100:  ; $D779
D779   54                         INC  Y

DEC2HEX_99:  ; $D77A
D77A   B5 08                      LDI  A,$08
D77C   8E B9                      BCH DEC2HEX_74 ; $D837
D77E   6A 02                      LDI  UL,$02
D780   17                         CPA  (Y)
D781   99 09                      BZR DEC2HEX_99 ; $D77A
D783   6A 06                      LDI  UL,$06
D785   9E 0E                      BCH DEC2HEX_100 ; $D779
D787   2A                         STA  UL
D788   9E 10                      BCH DEC2HEX_99 ; $D77A
D78A   CD 0C                      VMJ  ($0C)
D78C   8E 93                      BCH DEC2HEX_73 ; $D821
D78E   EC                         VEJ  (EC)

DEC2HEX_104:  ; $D78F
D78F   CD 02 30 3A 02             VMJ  ($02) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_102) ; $D796
D794   8E 07                      BCH $D79D

DEC2HEX_102:  ; $D796
D796   CD 00 41 47 16             VMJ  ($00) \ ABYT($41) \ ABYT($47) \ ABRF(DEC2HEX_103) ; $D7B1
D79B   B3 09                      ADI  A,$09
D79D   4A 06                      LDI  XL,$06
D79F   48 7A                      LDI  XH,$7A
D7A1   F1                         AEX
D7A2   D7                         DRL  (X)
D7A3   46                         DEC  X
D7A4   D7                         DRL  (X)
D7A5   B9 F0                      ANI  A,$F0
D7A7   68 10                      LDI  UH,$10
D7A9   C9 48                      VZR  ($48)($24)
D7AB   9E 1E                      BCH DEC2HEX_104 ; $D78F
D7AD   9E AA                      BCH DEC2HEX_105 ; $D705
D7AF   8E EF                      BCH DEC2HEX_106 ; $D8A0

DEC2HEX_103:  ; $D7B1
D7B1   C6                         VEJ  (C6)
D7B2   DC                         VEJ  (DC)
D7B3   BE DD 2F                   SJP  (LOAD_NEXT_1) ; $DD2F
D7B6   00                         SBC  XL
D7B7   8E 68                      BCH DEC2HEX_73 ; $D821
D7B9   6A 6B                      LDI  UL,$6B
D7BB   9E 5E                      BCH DEC2HEX_107 ; $D75F

DEC2HEX_89:  ; $D7BD
D7BD   CC 93                      VEJ  (CC) \ ABYTL($7893)

DEC2HEX_80:  ; $D7BF
D7BF   A7 78 91                   CPA  (GOSB_STK_PTR_L)
D7C2   89 34                      BZR DEC2HEX_108 ; $D7F8
D7C4   ED 78 89 01                BII  ($7889),$01
D7C8   8B 8E                      BZS DEC2HEX_109 ; $D858

DEC2HEX_40:  ; $D7CA
D7CA   EF 78 8C FD                ADI  (NUMARGS),$FD
D7CE   68 08                      LDI  UH,$08
D7D0   C3 48                      VCS  ($48)($24)
D7D2   BE F9 2B                   SJP  (ADD_ARU_ARX_1) ; $F92B
D7D5   C3 48                      VCS  ($48)($24)
D7D7   D0 08 19                   VEJ  (D0) \ ABYT($08) \ ABRF(DEC2HEX_67) ; $D7F3
D7DA   EF 78 8C 01                ADI  (NUMARGS),$01
D7DE   C1 4C                      VCR  ($4C)($26)
D7E0   FD A8                      PSH  U
D7E2   CD 30                      VMJ  ($30)
D7E4   BE F9 2B                   SJP  (ADD_ARU_ARX_1) ; $F92B
D7E7   C3 48                      VCS  ($48)($24)
D7E9   D0 08 05                   VEJ  (D0) \ ABYT($08) \ ABRF(DEC2HEX_110) ; $D7F1
D7EC   FD 2A                      POP  U
D7EE   28                         STA  UH
D7EF   CD 4C                      VMJ  ($4C)($26)

DEC2HEX_110:  ; $D7F1
D7F1   FD 0A                      POP  X

DEC2HEX_67:  ; $D7F3
D7F3   CD 48                      VMJ  ($48)($24)

DEC2HEX_93:  ; $D7F5
D7F5   BA D6 FA                   JMP  DEC2HEX_87 ; $D6FA

DEC2HEX_108:  ; $D7F8
D7F8   BE DB D3                   SJP  (ISARXBCD_7) ; $DBD3
D7FB   6C 60                      CPI  UH,$60
D7FD   89 06                      BZR DEC2HEX_88 ; $D805
D7FF   EF 78 8C 01                ADI  (NUMARGS),$01
D803   9E 48                      BCH DEC2HEX_89 ; $D7BD

DEC2HEX_88:  ; $D805
D805   6C 20                      CPI  UH,$20
D807   8B 94                      BZS DEC2HEX_75 ; $D89D
D809   48 10                      LDI  XH,$10
D80B   6C 5B                      CPI  UH,$5B
D80D   83 6B                      BCS DEC2HEX_76 ; $D87A
D80F   6C 40                      CPI  UH,$40
D811   81 67                      BCR DEC2HEX_76 ; $D87A
D813   89 08                      BZR DEC2HEX_77 ; $D81D
D815   B5 00                      LDI  A,$00
D817   BE D5 2A                   SJP  (DEC2HEX_78) ; $D52A
D81A   DC                         VEJ  (DC)

DEC2HEX_115:  ; $D81B
D81B   8E 04                      BCH DEC2HEX_73 ; $D821

DEC2HEX_77:  ; $D81D
D81D   CD 0E 52 D6                VMJ  ($0E) \ ABYT($52) \ ABRF(DEC2HEX_79) ; $D8F7

DEC2HEX_73:  ; $D821
D821   B5 02                      LDI  A,$02
D823   AE 78 81                   STA  ($7881)

DEC2HEX_64:  ; $D826
D826   CC 81                      VEJ  (CC) \ ABYTL($7881)
D828   D5                         SHR
D829   83 08                      BCS $D833 ; ***
D82B   BE DB 95                   SJP  (ISARXBCD_6) ; $DB95
D82E   04                         LDA  XL
D82F   BE DF A0                   SJP  (BCMD_TIME_8) ; $DFA0
D832   C4 BA D7                   VEJ  (C4) \ ACHR($BA) \ ABRF($D90C) ; ***
D835   2B                         ORA  (U)
D836   56                         DEC  Y

DEC2HEX_74:  ; $D837
D837   AE 78 81                   STA  ($7881)

DEC2HEX_116:  ; $D83A
D83A   CC 93                      VEJ  (CC) \ ABYTL($7893)
D83C   6C 10                      CPI  UH,$10
D83E   9B 81                      BZS DEC2HEX_80 ; $D7BF
D840   A7 78 91                   CPA  (GOSB_STK_PTR_L)
D843   89 1F                      BZR DEC2HEX_81 ; $D864
D845   A5 78 89                   LDA  ($7889)
D848   6C 10                      CPI  UH,$10
D84A   83 05                      BCS DEC2HEX_82 ; $D851
D84C   D5                         SHR
D84D   81 0A                      BCR DEC2HEX_83 ; $D859
D84F   8E 26                      BCH DEC2HEX_84 ; $D877

DEC2HEX_82:  ; $D851
D851   6C 60                      CPI  UH,$60
D853   89 3E                      BZR DEC2HEX_85 ; $D893
D855   D5                         SHR
D856   83 3B                      BCS DEC2HEX_85 ; $D893

DEC2HEX_109:  ; $D858
D858   56                         DEC  Y

DEC2HEX_83:  ; $D859
D859   CD 28 9B                   VMJ  ($28) \ ABRF(DEC2HEX_79) ; $D8F7
D85C   BE F9 2B                   SJP  (ADD_ARU_ARX_1) ; $F92B
D85F   C3 48                      VCS  ($48)($24)
D861   CD 4C                      VMJ  ($4C)($26)
D863   38                         NOP

DEC2HEX_81:  ; $D864
D864   0A                         STA  XL
D865   48 7A                      LDI  XH,$7A
D867   44                         INC  X
D868   05                         LDA  (X)
D869   A6                         CPA  UH
D86A   8B 1F                      BZS DEC2HEX_86 ; $D88B
D86C   81 25                      BCR DEC2HEX_85 ; $D893

DEC2HEX_92:  ; $D86E
D86E   FD 28                      LDX  U
D870   BE DB D3                   SJP  (ISARXBCD_7) ; $DBD3
D873   6C 70                      CPI  UH,$70
D875   83 03                      BCS DEC2HEX_76 ; $D87A

DEC2HEX_84:  ; $D877
D877   BA DA 25                   JMP  BCMD_RLM_STR_1 ; $DA25

DEC2HEX_76:  ; $D87A
D87A   FD 88                      PSH  X

DEC2HEX_111:  ; $D87C
D87C   FD 98                      PSH  Y
D87E   24                         LDA  UL
D87F   1A                         STA  YL
D880   A4                         LDA  UH
D881   18                         STA  YH
D882   B7 E0                      CPI  A,$E0
D884   81 51                      BCR DEC2HEX_90 ; $D8D7
D886   CD 1C 01                   VMJ  ($1C) \ ABYT($01)
D889   8E 67                      BCH DEC2HEX_91 ; $D8F2

DEC2HEX_86:  ; $D88B
D88B   6C 60                      CPI  UH,$60
D88D   8B 04                      BZS DEC2HEX_85 ; $D893
D88F   6C 84                      CPI  UH,$84
D891   99 25                      BZR DEC2HEX_92 ; $D86E

DEC2HEX_85:  ; $D893
D893   BE DB E0                   SJP  (ISARXBCD_5) ; $DBE0
D896   C3 48                      VCS  ($48)($24)
D898   BE DB F5                   SJP  (ISARXBCD_1); $DBF5
D89B   C3 48                      VCS  ($48)($24)

DEC2HEX_75:  ; $D89D
D89D   C0                         VEJ  (C0)
D89E   91 AB                      BCR DEC2HEX_93 ; $D7F5

DEC2HEX_106:  ; $D8A0
D8A0   A5 78 81                   LDA  ($7881)
D8A3   6E 80                      CPI  UL,$80
D8A5   81 06                      BCR DEC2HEX_94 ; $D8AD
D8A7   56                         DEC  Y
D8A8   56                         DEC  Y
D8A9   68 00                      LDI  UH,$00
D8AB   8E 12                      BCH DEC2HEX_95 ; $D8BF

DEC2HEX_94:  ; $D8AD
D8AD   6E 60                      CPI  UL,$60
D8AF   83 15                      BCS DEC2HEX_96 ; $D8C6
D8B1   6E 50                      CPI  UL,$50
D8B3   8B 04                      BZS DEC2HEX_97 ; $D8B9
D8B5   6E 51                      CPI  UL,$51
D8B7   89 16                      BZR DEC2HEX_98 ; $D8CF

DEC2HEX_97:  ; $D8B9
D8B9   6C F1                      CPI  UH,$F1
D8BB   89 12                      BZR DEC2HEX_98 ; $D8CF
D8BD   68 70                      LDI  UH,$70

DEC2HEX_95:  ; $D8BF
D8BF   BF 22                      BII  A,$22
D8C1   9B 4C                      BZS DEC2HEX_84 ; $D877
D8C3   BA D7 7A                   JMP  DEC2HEX_99 ; $D77A

DEC2HEX_96:  ; $D8C6
D8C6   BF 1D                      BII  A,$1D
D8C8   9B 53                      BZS DEC2HEX_84 ; $D877
D8CA   B5 10                      LDI  A,$10
D8CC   BA D7 5F                   JMP  DEC2HEX_107 ; $D75F

DEC2HEX_98:  ; $D8CF
D8CF   BF 1D                      BII  A,$1D
D8D1   9B 5C                      BZS DEC2HEX_84 ; $D877
D8D3   FD A8                      PSH  U
D8D5   9E 5B                      BCH DEC2HEX_111 ; $D87C

DEC2HEX_90:  ; $D8D7
D8D7   CD 28 18                   VMJ  ($28) \ ABRF($DEC2HEX_91) ; D8F2
D8DA   5C 83                      CPI  YH,$83
D8DC   89 2B                      BZR DEC2HEX_112 ; $D909
D8DE   D2 12 80                   VEJ  (D2) \ ABRF($D8F3) \ ABYT($80)
D8E1   5E 2D                      CPI  YL,$2D
D8E3   81 0B                      BCR DEC2HEX_113 ; $D8F0
D8E5   4A 02                      LDI  XL,$02
D8E7   48 7A                      LDI  XH,$7A
D8E9   47                         LDE  X
D8EA   8B 04                      BZS DEC2HEX_113 ; $D8F0
D8EC   B5 80                      LDI  A,$80
D8EE   0D                         EOR  (X)

DEC2HEX_124:  ; $D8EF
D8EF   0E                         STA  (X)

DEC2HEX_113:  ; $D8F0
D8F0   68 00                      LDI  UH,$00

DEC2HEX_91:  ; $D8F2
D8F2   FD 1A                      POP  Y
D8F4   FD 0A                      POP  X
D8F6   A4                         LDA  UH

DEC2HEX_79:  ; $D8F7
D8F7   C9 48                      VZR  ($48)($24)
D8F9   4C E0                      CPI  XH,$E0
D8FB   81 04                      BCR DEC2HEX_114 ; $D901
D8FD   4E 60                      CPI  XL,$60
D8FF   91 E6                      BCR DEC2HEX_115 ; $D81B

DEC2HEX_114:  ; $D901
D901   DD                         INC  A
D902   AE 78 8C                   STA  (NUMARGS)
D905   FD 6A                      STX  U
D907   9E CF                      BCH DEC2HEX_116 ; $D83A

DEC2HEX_112:  ; $D909
D909   8F 68                      BVS DEC2HEX_117 ; $D973
D90B   FD 98                      PSH  Y
D90D   BE DB 95                   SJP  (ISARXBCD_6) ; $DB95
D910   3E                         STA  (V)
D911   E6                         VEJ  (E6)
D912   CD 30                      VMJ  ($30)
D914   BE DB 95                   SJP  (ISARXBCD_6) ; $DB95
D917   55                         LIN  Y
D918   FD 1A                      POP  Y
D91A   94                         LDA  YH
D91B   DF                         DEC  A
D91C   85 25                      BHR DEC2HEX_118 ; $D943
D91E   DF                         DEC  A
D91F   87 4E                      BHS+ DEC2HEX_119 ; $D96F
D921   5E 2B                      CPI  YL,$2B
D923   89 4A                      BZR DEC2HEX_119 ; $D96F
D925   BE DF A0                   SJP  (BCMD_TIME_8) ; $DFA0
D928   48 DC                      LDI  XH,$DC
D92A   FD 5A                      STX  Y
D92C   FD A8                      PSH  U
D92E   6A 15                      LDI  UL,$15
D930   BE DE BE                   SJP  (BCMD_TIME_7) ; $DEBE
D933   BE DF A1 F2                SJP  (XREG2STRBUF) \ ABRF(BCMD_RLM_STR_2) ; $DA29
D937   A5 7A 07                   LDA  (ARX + $07)
D93A   FD 2A                      POP  U
D93C   22                         ADC  UL
D93D   FD 18                      LDX  Y
D93F   CD 24                      VMJ  ($24)

DEC2HEX_126:  ; $D941
D941   9E 53                      BCH DEC2HEX_113 ; $D8F0

DEC2HEX_118:  ; $D943
D943   14                         LDA  YL
D944   BE D0 F9                   SJP  (DEL_DIM_VARS_15) ; $D0F9
D947   9E 59                      BCH DEC2HEX_113 ; $D8F0

DEC2HEX_120:  ; $D949
D949   14                         LDA  YL
D94A   BE D0 D2                   SJP  (DEL_DIM_VARS_16) ; $D0D2
D94D   9E 5F                      BCH DEC2HEX_113 ; $D8F0
D94F   D2 01 80                   VEJ  (D2) \ ABRF($D953) \ ABYT($80)
D952   E6                         VEJ  (E6)
D953   CD 30                      VMJ  ($30)
D955   D2 16 80                   VEJ  (D2) \ ABRF($D96E) \ ABYT($80)
D958   FD 1A                      POP  Y
D95A   94                         LDA  YH
D95B   DF                         DEC  A
D95C   95 15                      BHR DEC2HEX_120 ; $D949
D95E   DF                         DEC  A
D95F   87 03                      BHS DEC2HEX_121 ; $D964
D961   BA EF 94                   JMP  OUTBUFCLR_1 ; $EF94

DEC2HEX_121:  ; $D964
D964   DF                         DEC  A
D965   87 03                      BHS DEC2HEX_122 ; $D96A
D967   BA EF A5                   JMP  OUTBUFCLR_2 ; $EFA5

DEC2HEX_122:  ; $D96A
D96A   BA EF B1                   JMP  OUTBUFCLR_3 ; $EFB1
D96D   FD 1A                      POP  Y

DEC2HEX_119:  ; $D96F
D96F   68 11                      LDI  UH,$11

DEC2HEX_125:  ; $D971
D971   9E 81                      BCH DEC2HEX_91 ; $D8F2

DEC2HEX_117:  ; $D973
D973   D0 04 B5                   VEJ  (D0) \ ABYT($04) \ ABRF(BCMD_RLM_STR_3) ; $DA2B
D976   FD A8                      PSH  U
D978   CD 30                      VMJ  ($30)
D97A   D0 04 AC                   VEJ  (D0) \ ABYT($04) \ ABRF(BCMD_RLM_STR_2) ; $DA29)
D97D   FD 2A                      POP  U
D97F   4A 06                      LDI  XL,$06
D981   48 7A                      LDI  XH,$7A
D983   24                         LDA  UL
D984   52                         DEC  YL
D985   87 06                      BHS DEC2HEX_123 ; $D98D
D987   09                         AND  (X)
D988   43                         SDE  X
D989   A4                         LDA  UH
D98A   09                         AND  (X)
D98B   9E 9E                      BCH DEC2HEX_124 ; $D8EF

DEC2HEX_123:  ; $D98D
D98D   0B                         ORA  (X)
D98E   43                         SDE  X
D98F   A4                         LDA  UH
D990   0B                         ORA  (X)
D991   9E A4                      BCH DEC2HEX_124 ; $D8EF



BCMD_PEEK: ; $D993
D993   D0 00 5C                   VEJ  (D0) \ ABYT($00) \ ABRF(ARUINT2ARX_1) ; $D9F2
D996   50                         INC  YL
D997   25                         LDA  (U)
D998   87 02                      BHS BCMD_PEEK_1 ; $D99C
D99A   FD 25                      LDA  #(U)

BCMD_PEEK_1: ; $D99C
D99C   8E 46                      BCH BCMD_LEN_1 ; $D9E4



BCMD_NOT: ; $D99E
D99E   D0 04 51                   VEJ  (D0) \ ABYT($04) \ ABRF(ARUINT2ARX_1) ; $D9F2
D9A1   BE DA A8                   SJP  (TWOSCOMP)
D9A4   66                         DEC  U
D9A5   BE D9 E7                   SJP  (ARUINT2ARX)
D9A8   8E 97                      BCH BCMD_RLM_STR_4 ; $DA41



BCMD_INKY: ; $D9AA
D9AA   BE E4 2C                   SJP  (KEY2ASCII)
D9AD   48 D0                      LDI  XH,$D0
D9AF   8E 05                      BCH BCMD_CHR_1 ; $D9B6



BCMD_CHR: ; $D981
D9B1   D0 08 3E                   VEJ  (D0) \ ABYT($08) \ ABRF(ARUINT2ARX_1) ; $D9F2
D9B4   48 C1                      LDI  XH,$C1

BCMD_CHR_1: ; $D9B6
D9B6   0A                         STA  XL
D9B7   2A                         STA  UL
D9B8   24                         LDA  UL
D9B9   8B 02                      BZS BCMD_CHR_2 ; $D9BD
D9BB   B5 01                      LDI  A,$01

BCMD_CHR_2: ; $D9B6
D9BD   BE DF B4                   SJP  (XREG2STRBUF_1) ; $DFB4
D9C0   83 30                      BCS ARUINT2ARX_1 ; $D9F2
D9C2   04                         LDA  XL
D9C3   8B 01                      BZS BCMD_CHR_3 ; $D9C6
D9C5   51                         SIN  Y

BCMD_CHR_3: ; $D9C6
D9C6   84                         LDA  XH
D9C7   18                         STA  YH
D9C8   BE DF C5                   SJP  (ARX2STRBUF_1) ; $DFC5
D9CB   94                         LDA  YH
D9CC   2E                         STA  (U)
D9CD   8E 72                      BCH BCMD_RLM_STR_4 ; $DA41



BCMD_STR: ; $D9CF
D9CF   D2 21 80                   VEJ  (D2) \ ABRF(BCMD_RLM_STR) \ ABYT($80)
D9D2   BE EF 1B                   SJP  (ARX2STRNG)
D9D5   8E 66                      BCH BCMD_RLM_STR_5 ; $DA3D



BCMD_LEN: ; $D9D7
D9D7   BE D1 4C                   SJP  (DEL_DIM_VARS_17) ; $D14C
D9DA   17                         CPA  (Y)
D9DB   8E 64                      BCH BCMD_RLM_STR_4 ; $DA41
D9DD   DC                         VEJ  (DC)
D9DE   8B 05                      BZS BCMD_LEN_2 ; $D9E5
D9E0   52                         DEC  YL
D9E1   87 02                      BHS BCMD_LEN_2 ; $D9E5
D9E3   05                         LDA  (X)

BCMD_LEN_1: ; $D9E4
D9E4   2A                         STA  UL

BCMD_LEN_2: ; $D9E5
D9E5   68 00                      LDI  UH,$00



ARUINT2ARX: ; $D9E7
D9E7   4A 04                      LDI  XL,$04
D9E9   48 7A                      LDI  XH,$7A
D9EB   B5 B2                      LDI  A,$B2
D9ED   41                         SIN  X
D9EE   A4                         LDA  UH
D9EF   41                         SIN  X
D9F0   24                         LDA  UL
D9F1   0E                         STA  (X)

ARUINT2ARX_1: ; $D9F2
D9F2   9A                         RTN



BCMD_RLM_STR: ; D9F3
D9F3   14                         LDA  YL
D9F4   B9 03                      ANI  A,$03
D9F6   BE DB B3                   SJP  (ISARXBCD_8) ; $DBB3
D9F9   9D D0                      BVR $D92B ; ***
D9FB   0C                         DCS  (X)
D9FC   9A                         RTN
D9FD   18                         STA  YH
D9FE   68 00                      LDI  UH,$00
DA00   5E 7B                      CPI  YL,$7B
DA02   89 07                      BZR BCMD_RLM_STR_6 ; $DA0B
DA04   CD 30                      VMJ  ($30)
DA06   D0 0D 8E                   VEJ  (D0) \ ABYT($0D) \ ABRF(MULT16B_2) ; $DA97
DA09   DF                         DEC  A
DA0A   28                         STA  UH

BCMD_RLM_STR_6: ; DA0B
DA0B   CD 30                      VMJ  ($30)
DA0D   BE DB 95                   SJP  (ISARXBCD_6) ; $DB95
DA10   86                         CPA  XH
DA11   4A 07                      LDI  XL,$07
DA13   48 7A                      LDI  XH,$7A
DA15   05                         LDA  (X)
DA16   FB                         SEC
DA17   A0                         SBC  UH
DA18   81 20                      BCR BCMD_RLM_STR_7 ; $DA3A
DA1A   90                         SBC  YH
DA1B   81 12                      BCR BCMD_RLM_STR_8 ; $DA2F
DA1D   5E 7A                      CPI  YL,$7A
DA1F   83 01                      BCS BCMD_RLM_STR_9 ; $DA22
DA21   28                         STA  UH

BCMD_RLM_STR_9: ; $DA22
DA22   94                         LDA  YH
DA23   8E 0B                      BCH BCMD_RLM_STR_10 ; $DA30

BCMD_RLM_STR_1: ; $DA25
DA25   68 01                      LDI  UH,$01
DA27   CD 48                      VMJ  ($48)($24)

BCMD_RLM_STR_2: ; $DA29
DA29   FD 0A                      POP  X

BCMD_RLM_STR_3: ; $DA2B
DA2B   9E BC                      BCH DEC2HEX_125 ; $D971
DA2D   9E EE                      BCH DEC2HEX_126 ; $D941

BCMD_RLM_STR_8: ; $DA2F
DA2F   92                         ADC  YH

BCMD_RLM_STR_10: ;$ DA30
DA30   43                         SDE  X
DA31   05                         LDA  (X)
DA32   F9                         REC
DA33   A2                         ADC  UH
DA34   43                         SDE  X
DA35   05                         LDA  (X)
DA36   B3 00                      ADI  A,$00
DA38   8E 02                      BCH BCMD_RLM_STR_11 ; $DA3C

BCMD_RLM_STR_7: ; $DA3A
DA3A   B5 00                      LDI  A,$00

BCMD_RLM_STR_11: ; $DA3C
DA3C   0E                         STA  (X)

BCMD_RLM_STR_5: ; $DA3D
DA3D   BE DF A0                   SJP  (BCMD_TIME_8) ; $DFA0
DA40   66                         DEC  U

BCMD_RLM_STR_4: ; $DA41
DA41   68 00                      LDI  UH,$00
DA43   9A                         RTN



BCMD_STATUS: ; $DA44
DA44   D0 08 60                   VEJ  (D0) \ ABYT($08) \ ABRF(MULT16B_3) ; $DAA7
DA47   62                         DEC  UL
DA48   81 13                      BCR BCMD_MEM
DA4A   8B 16                      BZS BCMD_MEM_1 ; $DA62
DA4C   CC 67                      VEJ  (CC) \ ABYTL($BASPRG_END_H) ; 7867
DA4E   44                         INC  X
DA4F   62                         DEC  UL
DA50   8B 07                      BZS BCMD_STATUS_1 ; $DA59
DA52   CC 99                      VEJ  (CC) \ ABYTL($7899)
DA54   62                         DEC  UL
DA55   8B 02                      BZS BCMD_STATUS_1 ; $DA59
DA57   CC A2                      VEJ  (CC) \ ABYTL(PREV_LINE_H) ; $78A2

BCMD_STATUS_1: ; $DA59
DA59   FD 6A                      STX  U
DA5B   8E 0F                      BCH BCMD_MEM_2 ; $DA6C



BCMD_MEM: ; $DA5D
DA5D   BE DF EE                   SJP  (MEM_IN_UREG)
DA60   8E 03                      BCH BCMD_MEM_3 ; $DA65

BCMD_MEM_1: ; $DA62
DA62   CD 14                      VMJ  ($14)
DA64   64                         INC  U

BCMD_MEM_3: ; $DA65
DA65   64                         INC  U
DA66   83 04                      BCS BCMD_MEM_2 ; $DA6C
DA68   6A 00                      LDI  UL,$00
DA6A   68 00                      LDI  UH,$00

BCMD_MEM_2: ; $DA6C
DA6C   CD 10 00                   VMJ  ($10) \ ABYT($00)
DA6F   9E 30                      BCH BCMD_RLM_STR_4 ; $DA41



MULT16B: ; $DA71
DA71   4A 00                      LDI  XL,$00
DA73   48 00                      LDI  XH,$00

MULT16B_8: ; $DA75
DA75   A4                         LDA  UH
DA76   D5                         SHR
DA77   28                         STA  UH
DA78   24                         LDA  UL
DA79   D1                         ROR
DA7A   2A                         STA  UL
DA7B   81 09                      BCR MULT16B_4 ; $DA86
DA7D   F9                         REC
DA7E   14                         LDA  YL
DA7F   02                         ADC  XL
DA80   0A                         STA  XL
DA81   94                         LDA  YH
DA82   82                         ADC  XH
DA83   08                         STA  XH
DA84   83 0E                      BCS MULT16B_5 ; $DA94

MULT16B_4: ; $DA86
DA86   24                         LDA  UL
DA87   89 03                      BZR MULT16B_6 ; $DA8C
DA89   A4                         LDA  UH
DA8A   8B 09                      BZS MULT16B_7 ; $DA95

MULT16B_6: ; $DA8C
DA8C   14                         LDA  YL
DA8D   D9                         SHL
DA8E   1A                         STA  YL
DA8F   94                         LDA  YH
DA90   DB                         ROL
DA91   18                         STA  YH
DA92   91 1F                      BCR MULT16B_8 ; $DA75

MULT16B_5: ; $DA94
DA94   9A                         RTN

MULT16B_7: ; $DA95
DA95   FD 5A                      STX  Y

MULT16B_2: ; $DA97
DA97   9A                         RTN

MULT16B_1: ; $DA98
DA98   4A A7                      LDI  XL,$A7
DA9A   48 C3                      LDI  XH,$C3

MULT16B_9: ; $DA9C
DA9C   44                         INC  X
DA9D   44                         INC  X
DA9E   44                         INC  X
DA9F   44                         INC  X
DAA0   F7                         CIN
DAA1   8B 04                      BZS MULT16B_3 ; $DAA7
DAA3   88 09                      LOP  UL,MULT16B_9 ; $DA9C
DAA5   4A D4                      LDI  XL,$D4

MULT16B_3: ; $DAA7
DAA7   9A                         RTN



TWOSCOMP: ; $DAA8
DAA8   A4                         LDA  UH
DAA9   BD FF                      EAI  $FF
DAAB   28                         STA  UH
DAAC   24                         LDA  UL
DAAD   BD FF                      EAI  $FF
DAAF   2A                         STA  UL
DAB0   64                         INC  U
DAB1   9A                         RTN



EVAL_USING: ; $DAB2
DAB2   B5 00                      LDI  A,$00

EVAL_USING_1: ; $DAB4
DAB4   AE 78 82                   STA  (STK_PTR_GSB_FOR)
DAB7   CD 36                      VMJ  ($36)
DAB9   81 05                      BCR EVAL_USING_2 ; $DAC0
DABB   FD 98                      PSH  Y
DABD   DC                         VEJ  (DC)
DABE   8E 08                      BCH EVAL_USING_3 ; $DAC8

EVAL_USING_2: ; $DAC0
DAC0   6C 15                      CPI  UH,$15
DAC2   89 80                      BZR EVAL_USING_4 ; $DB44
DAC4   6A 00                      LDI  UL,$00
DAC6   FD 88                      PSH  X

EVAL_USING_3: ; $DAC8
DAC8   B5 00                      LDI  A,$00
DACA   5A 08                      LDI  YL,$08
DACC   58 7A                      LDI  YH,$7A
DACE   28                         STA  UH
DACF   51                         SIN  Y
DAD0   51                         SIN  Y
DAD1   1E                         STA  (Y)
DAD2   62                         DEC  UL
DAD3   83 51                      BCS EVAL_USING_5 ; $DB26

EVAL_USING_12: ; $DAD5
DAD5   FD 1A                      POP  Y
DAD7   55                         LIN  Y
DAD8   B7 E0                      CPI  A,$E0
DADA   81 05                      BCR EVAL_USING_6 ; $DAE1
DADC   54                         INC  Y

EVAL_USING_9: ; $DADD
DADD   68 01                      LDI  UH,$01
DADF   CD 48                      VMJ  ($48)($24)

EVAL_USING_6: ; $DAE1
DAE1   B7 3B                      CPI  A,$3B
DAE3   8B 09                      BZS EVAL_USING_7 ; $DAEE
DAE5   B7 3A                      CPI  A,$3A
DAE7   8B 04                      BZS EVAL_USING_8 ; $DAED
DAE9   B7 0D                      CPI  A,$0D
DAEB   99 10                      BZR EVAL_USING_9 ; $DADD

EVAL_USING_8: ; $DAED
DAED   F9                         REC

EVAL_USING_7: ; $DAEE
DAEE   DB                         ROL
DAEF   AD 78 82                   EOR  (STK_PTR_GSB_FOR)
DAF2   D1                         ROR
DAF3   91 18                      BCR EVAL_USING_9 ; $DADD
DAF5   FD 98                      PSH  Y
DAF7   5A 95                      LDI  YL,$95
DAF9   58 78                      LDI  YH,$78
DAFB   4A 0A                      LDI  XL,$0A
DAFD   48 7A                      LDI  XH,$7A
DAFF   A4                         LDA  UH
DB00   8B 0D                      BZS EVAL_USING_10 ; $DB0F
DB02   51                         SIN  Y
DB03   4A 08                      LDI  XL,$08
DB05   F5                         TIN
DB06   45                         LIN  X
DB07   54                         INC  Y
DB08   53                         SDE  Y
DB09   05                         LDA  (X)
DB0A   CB 4E                      VZS  ($4E)($27)

EVAL_USING_11: ; $DB0C
DB0C   1E                         STA  (Y)
DB0D   CD 4E                      VMJ  ($4E)($27)

EVAL_USING_10: ; $DB0F
DB0F   5A 97                      LDI  YL,$97
DB11   05                         LDA  (X)
DB12   99 08                      BZR EVAL_USING_11 ; $DB0C
DB14   54                         INC  Y
DB15   53                         SDE  Y
DB16   53                         SDE  Y
DB17   53                         SDE  Y
DB18   9E 0E                      BCH EVAL_USING_11 ; $DB0C

EVAL_USING_13: ; $DB1A
DB1A   5F 01                      ADI  (Y),$01
DB1C   62                         DEC  UL
DB1D   91 4A                      BCR EVAL_USING_12 ; $DAD5
DB1F   F7                         CIN
DB20   9B 08                      BZS EVAL_USING_13 ; $DB1A
DB22   A4                         LDA  UH
DB23   89 1D                      BZR EVAL_USING_14 ; $DB42
DB25   46                         DEC  X

EVAL_USING_5: ; $DB26
DB26   45                         LIN  X
DB27   B7 26                      CPI  A,$26
DB29   9B 11                      BZS EVAL_USING_13 ; $DB1A
DB2B   5A 08                      LDI  YL,$08

EVAL_USING_24: ; $DB2D
DB2D   FD 88                      PSH  X
DB2F   CD 34 06 23 15 2A 10 2B    VMJ  ($34) \ ABYT($06) \ ABYT($23) \ 
                                       ABRF(EVAL_USING_15) \ ABYT($2A) \ ABRF(EVAL_USING_16) \ 
                                       ABYT($2B) \ ABRF(EVAL_USING_18) \ ABYT($5E) \ 
                                       ABRF(EVAL_USING_17) \ ABYT($2C) \ ABRF(EVAL_USING_19) \ 
                                       ABYT($2E) \ ABRF(EVAL_USING_20) \ ABYT($26) \ ABRF(EVAL_USING_21)

EVAL_USING_23: ; $DB40
DB40   FD 0A                      POP  X

EVAL_USING_14: ; $DB42
DB42   68 0C                      LDI  UH,$0C

EVAL_USING_4: ; $DB44
DB44   CD 4A                      VMJ  ($4A)($25)

EVAL_USING_16: ; $DB46
DB46   BB 40                      ORI  A,$40
DB48   28                         STA  UH

EVAL_USING_15: ; $DB49
DB49   15                         LDA  (Y)
DB4A   DD                         INC  A
DB4B   87 01                      BHS EVAL_USING_22 ; $DB4E
DB4D   1E                         STA  (Y)

EVAL_USING_22: ; $DB4E
DB4E   6C 80                      CPI  UH,$80
DB50   93 12                      BCS EVAL_USING_23 ; $DB40
DB52   A4                         LDA  UH
DB53   BB 01                      ORI  A,$01
DB55   28                         STA  UH

EVAL_USING_25: ; $DB56
DB56   FD 0A                      POP  X
DB58   45                         LIN  X
DB59   88 2E                      LOP  UL,EVAL_USING_24 ; $DB2D
DB5B   9E 88                      BCH EVAL_USING_12 ; $DAD5

EVAL_USING_18: ; $DB5D
DB5D   BB 20                      ORI  A,$20

EVAL_USING_26: ; $DB5F
DB5F   28                         STA  UH
DB60   9E 14                      BCH V ; $DB4E

EVAL_USING_20: ; $DB62
DB62   5E 08                      CPI  YL,$08
DB64   99 26                      BZR EVAL_USING_23 ; $DB40
DB66   54                         INC  Y
DB67   5B 01                      ORI  (Y),$01
DB69   9E 1D                      BCH EVAL_USING_22 ; $DB4E

EVAL_USING_17: ; $DB6B
DB6B   BB 80                      ORI  A,$80
DB6D   28                         STA  UH
DB6E   5A 08                      LDI  YL,$08
DB70   B5 02                      LDI  A,$02
DB72   17                         CPA  (Y)
DB73   91 1F                      BCR EVAL_USING_25 ; $DB56
DB75   1E                         STA  (Y)
DB76   9E 22                      BCH EVAL_USING_25 ; $DB56

EVAL_USING_21: ; $DB78
DB78   5A 0A                      LDI  YL,$0A
DB7A   15                         LDA  (Y)
DB7B   99 3D                      BZR EVAL_USING_23 ; $DB40
DB7D   FD 0A                      POP  X
DB7F   B5 26                      LDI  A,$26
DB81   9E 69                      BCH EVAL_USING_13 ; $DB1A

EVAL_USING_19: ; $DB83
DB83   BB 10                      ORI  A,$10
DB85   9E 28                      BCH EVAL_USING_26 ; $DB5F



ISARXBCD: ; $DB87
DB87   B5 B2                      LDI  A,$B2
DB89   A7 7A 04                   CPA  (ARX + $04)
DB8C   81 03                      BCR ISARXBCD_9 ; $DB91
DB8E   BA DC F1                   JMP  LOAD_NEXT_3 ; $DCF1

ISARXBCD_9: ; $DB91
DB91   68 11                      LDI  UH,$11
DB93   CD 48                      VMJ  ($48)($24)

ISARXBCD_6: ; $DB95
DB95   4A 04                      LDI  XL,$04
DB97   48 7A                      LDI  XH,$7A
DB99   45                         LIN  X
DB9A   B7 C1                      CPI  A,$C1
DB9C   91 0D                      BCR ISARXBCD_9 ; $DB91
DB9E   45                         LIN  X
DB9F   B7 7B                      CPI  A,$7B
DBA1   C9 4C                      VZR  ($4C)($26)
DBA3   05                         LDA  (X)
DBA4   B7 10                      CPI  A,$10
DBA6   C1 4C                      VCR  ($4C)($26)
DBA8   B7 60                      CPI  A,$60
DBAA   C3 4C                      VCS  ($4C)($26)
DBAC   AE 78 94                   STA  (STR_BUF_PTR_L)
DBAF   CD 4C                      VMJ  ($4C)($26)
DBB1   B5 01                      LDI  A,$01

ISARXBCD_8: ; $DBB3
DBB3   A7 78 8C                   CPA  (NUMARGS)
DBB6   CB 4C                      VZS  ($4C)($26)
DBB8   68 12                      LDI  UH,$12
DBBA   CD 48                      VMJ  ($48)($24)
DBBC   FD 2A                      POP  U
DBBE   65                         LIN  U
DBBF   64                         INC  U
DBC0   FD A8                      PSH  U
DBC2   66                         DEC  U
DBC3   FD C8                      PSH  A
DBC5   25                         LDA  (U)
DBC6   2A                         STA  UL
DBC7   FD 8A                      POP  A
DBC9   28                         STA  UH

ISARXBCD_10: ; $DBCA
DBCA   65                         LIN  U
DBCB   FD C8                      PSH  A
DBCD   25                         LDA  (U)
DBCE   2A                         STA  UL
DBCF   FD 8A                      POP  A
DBD1   28                         STA  UH
DBD2   9A                         RTN

ISARXBCD_7: ; $DBD3
DBD3   EF 78 93 02                ADI  (BAS_PENOP_STK_L),$02
DBD7   A5 78 93                   LDA  (BAS_PENOP_STK_L)
DBDA   2A                         STA  UL
DBDB   62                         DEC  UL
DBDC   68 7A                      LDI  UH,$7A
DBDE   9E 16                      BCH ISARXBCD_10 ; $DBCA

ISARXBCD_5: ; $DBE0
DBE0   A5 78 93                   LDA  (BAS_PENOP_STK_L)
DBE3   0A                         STA  XL
DBE4   A5 78 92                   LDA  (BAS_DATA_STK_L)
DBE7   06                         CPA  XL
DBE8   83 45                      BCS ISARXBCD_11 ; $DC2F
DBEA   48 7A                      LDI  XH,$7A
DBEC   24                         LDA  UL
DBED   43                         SDE  X
DBEE   A4                         LDA  UH
DBEF   43                         SDE  X
DBF0   04                         LDA  XL
DBF1   AE 78 93                   STA  (BAS_PENOP_STK_L)
DBF4   9A                         RTN

ISARXBCD_1: ; $DBF5
DBF5   A5 78 92                   LDA  (BAS_DATA_STK_L)
DBF8   0A                         STA  XL
DBF9   B7 38                      CPI  A,$38
DBFB   81 32                      BCR ISARXBCD_11 ; $DC2F
DBFD   B3 06                      ADI  A,$06
DBFF   83 2E                      BCS ISARXBCD_11 ; $DC2F
DC01   A7 78 93                   CPA  (BAS_PENOP_STK_L)
DC04   83 29                      BCS ISARXBCD_11 ; $DC2F
DC06   EF 78 92 08                ADI  (BAS_DATA_STK_L),$08
DC0A   48 7A                      LDI  XH,$7A

ISARXBCD_24: ; $DC0C
DC0C   FD 98                      PSH  Y
DC0E   FD 5A                      STX  Y
DC10   4A 00                      LDI  XL,$00
DC12   48 7A                      LDI  XH,$7A
DC14   8E 10                      BCH ISARXBCD_12 ; $DC26
DC16   EF 78 92 F8                ADI  (BAS_DATA_STK_L),$F8
DC1A   A5 78 92                   LDA  (BAS_DATA_STK_L)
DC1D   0A                         STA  XL
DC1E   48 7A                      LDI  XH,$7A

ISARXBCD_2: ; $ DC20
DC20   FD 98                      PSH  Y
DC22   5A 00                      LDI  YL,$00
DC24   58 7A                      LDI  YH,$7A

ISARXBCD_12: ; $ DC26
DC26   6A 07                      LDI  UL,$07

ISARXBCD_13: ; $ DC28
DC28   F5                         TIN
DC29   88 03                      LOP  UL,ISARXBCD_13 ; $DC28
DC2B   FD 1A                      POP  Y
DC2D   F9                         REC
DC2E   9A                         RTN

ISARXBCD_11: ; $ DC2F
DC2F   68 0E                      LDI  UH,$0E
DC31   9A                         RTN

ISARXBCD_4: ; $ DC32
DC32   FD 2A                      POP  U
DC34   FD 98                      PSH  Y
DC36   ED 78 80 10                BII  (DISPARAM),$10
DC3A   8B 0D                      BZS ISARXBCD_15 ; $DC49
DC3C   62                         DEC  UL
DC3D   8B 05                      BZS ISARXBCD_16 ; $DC44
DC3F   BE D2 D3                   SJP  (BCD_Y2ARX_43) ; $D2D3
DC42   8E 5C                      BCH ISARXBCD_17 ; $DCA0

ISARXBCD_16: ; $ DC44
DC44   BE D2 B3                   SJP  ($D2B3)
DC47   8E 57                      BCH ISARXBCD_17 ; $DCA0

ISARXBCD_15: ; $ DC49
DC49   ED 78 8A E0                BII  (BREAKPARAM),$E0
DC4D   8B 05                      BZS ISARXBCD_18 ; $DC54
DC4F   BE D2 4E                   SJP  (BCD_Y2ARX_44) ; $D24E
DC52   8E 0A                      BCH ISARXBCD_19 ; $DC5E

ISARXBCD_18: ; $ DC54
DC54   CC B4                      VEJ  (CC) \ ABYTL(ERR_LINE_H) ; $78B4
DC56   AB 78 B5                   ORA  (ERR_LINE_L)
DC59   8B 38                      BZS ISARXBCD_20 ; $DC93
DC5B   BE D2 46                   SJP  (BCD_Y2ARX_45) ; $D246

ISARXBCD_19: ; $ DC5E
DC5E   81 2F                      BCR ISARXBCD_21 ; $DC8F
DC60   B5 54                      LDI  A,$54
DC62   ED 76 4F 20                BII  (DISP_BUFF + $4F),$20
DC66   C9 44                      VZR  ($44)($22)
DC68   BE EE 80                   SJP  (SAVELCD2BUF)
DC6B   CC 80                      VEJ  (CC) \ ABYTL(DISPARAM) ; $7880)
DC6D   FD C8                      PSH  A
DC6F   B5 54                      LDI  A,$54
DC71   AE 78 80                   STA  (DISPARAM)
DC74   BE E8 CA                   SJP  (PRGMDISP)
DC77   E9 7B 0E BF                ANI  (CURS_CTRL),$BF
DC7B   BE E2 3D                   SJP  (WAITNOKEYS)
DC7E   BE EE 99                   SJP  (BUF2LCD)
DC81   FD 8A                      POP  A
DC83   B9 DF                      ANI  A,$DF
DC85   AE 78 80                   STA  (DISPARAM)
DC88   BF C0                      BII  A,$C0
DC8A   8B 03                      BZS ISARXBCD_21 ; $DC8F
DC8C   F2                         VEJ  (F2)
DC8D   CD 42                      VMJ  ($42)($21)

ISARXBCD_21: ; $DC8F
DC8F   FD 1A                      POP  Y
DC91   CD 46                      VMJ  ($46)($23)

ISARXBCD_20: ; $DC93
DC93   62                         DEC  UL
DC94   91 07                      BCR ISARXBCD_21 ; $DC8F
DC96   8B 05                      BZS ISARXBCD_22 ; $DC9D
DC98   BE D2 77                   SJP  (BCD_Y2ARX_46) ; $D277
DC9B   8E 03                      BCH ISARXBCD_17 ; $DCA0

ISARXBCD_22: ; $DC9D
DC9D   BE D2 6F                   SJP  (BCD_Y2ARX_47) ; $D26F

ISARXBCD_17: ; $DCA0
DCA0   91 13                      BCR ISARXBCD_21 ; $DC8F
DCA2   B5 14                      LDI  A,$14
DCA4   CD 44                      VMJ  ($44)($22)
DCA6   B5 01                      LDI  A,$01
DCA8   AE 78 89                   STA  ($7889)
DCAB   BA D6 E5                   JMP  DEC2HEX_127 ; $D6E5

ISARXBCD_3: ; $DCAE
DCAE   DF                         DEC  A
DCAF   A7 78 8B                   CPA  (INBUFPTR_L)
DCB2   9A                         RTN
DCB3   80                         SBC  XH
DCB4   00                         SBC  XL
DCB5   FF                         NOP
DCB6   C0                         VEJ  (C0)
DCB7   FD 0A                      POP  X
DCB9   A4                         LDA  UH
DCBA   89 39                      BZR LOAD_NEXT_4 ; $DCF5
DCBC   24                         LDA  UL
DCBD   F7                         CIN
DCBE   81 36                      BCR LOAD_NEXT_2 ; $DCF6
DCC0   F7                         CIN
DCC1   81 23                      BCR LOAD_NEXT_5 ; $DCE6
DCC3   8E 3E                      BCH LOAD_NEXT_6 ; $DD03
DCC5   C0                         VEJ  (C0)
DCC6   D8                         VEJ  (D8)
DCC7   8B 04                      BZS ISARXBCD_23 ; $DCCD
DCC9   6E 3A                      CPI  UL,$3A
DCCB   8B 24                      BZS LOAD_NEXT_3 ; $DCF1

ISARXBCD_23: ; $DCCD
DCCD   6E 0D                      CPI  UL,$0D
DCCF   F9                         REC
DCD0   8B 1F                      BZS LOAD_NEXT_3 ; $DCF1
DCD2   8E 2D                      BCH LOAD_NEXT_7 ; $DD01



LOAD_NEXT: ; $DCD4
DCD4   C0                         VEJ  (C0)
DCD5   FD 0A                      POP  X
DCD7   45                         LIN  X
DCD8   B7 E0                      CPI  A,$E0
DCDA   83 03                      BCS LOAD_NEXT_8 ; $DCDF
DCDC   46                         DEC  X
DCDD   B5 00                      LDI  A,$00

LOAD_NEXT_8: ; $DCDF
DCDF   A6                         CPA  UH
DCE0   89 14                      BZR LOAD_NEXT_2 ; $DCF6
DCE2   45                         LIN  X
DCE3   26                         CPA  UL
DCE4   89 1D                      BZR LOAD_NEXT_6 ; $DD03

LOAD_NEXT_5: ; $DCE6
DCE6   44                         INC  X
DCE7   FD 5E                      STX  P
DCE9   FD 0A                      POP  X
DCEB   8E 04                      BCH LOAD_NEXT_3 ; $DCF1
DCED   FD 0A                      POP  X
DCEF   FD 1A                      POP  Y

LOAD_NEXT_3: ; $DCF1
DCF1   FD 0A                      POP  X
DCF3   9E 0F                      BCH LOAD_NEXT_5 ; $DCE6

LOAD_NEXT_4: ; $DCF5
DCF5   44                         INC  X

LOAD_NEXT_2: ; $DCF6
DCF6   44                         INC  X
DCF7   8E 0A                      BCH LOAD_NEXT_6 ; $DD03
DCF9   FD 0A                      POP  X
DCFB   8E 04                      BCH LOAD_NEXT_7 ; $DD01
DCFD   FD 0A                      POP  X
DCFF   FD 1A                      POP  Y

LOAD_NEXT_7: ; $DD01
DD01   FD 0A                      POP  X

LOAD_NEXT_6: ; $DD03
DD03   45                         LIN  X
DD04   FD CA                      ADR  X
DD06   FD 5E                      STX  P
DD08   68 00                      LDI  UH,$00
DD0A   55                         LIN  Y
DD0B   B7 E0                      CPI  A,$E0
DD0D   81 02                      BCR LOAD_NEXT_9 ; $DD11
DD0F   28                         STA  UH
DD10   55                         LIN  Y

LOAD_NEXT_9: ; $DD11
DD11   2A                         STA  UL
DD12   9A                         RTN
DD13   6C 00                      CPI  UH,$00
DD15   8B 01                      BZS LOAD_NEXT_10 ; $DD18
DD17   56                         DEC  Y

LOAD_NEXT_10: ; $DD18
DD18   56                         DEC  Y
DD19   9A                         RTN
DD1A   A5 7A 04                   LDA  (ARX + $04)
DD1D   B7 B2                      CPI  A,$B2
DD1F   81 02                      BCR LOAD_NEXT_11 ; $DD23
DD21   99 22                      BZR LOAD_NEXT_7 ; $DD01

LOAD_NEXT_11: ; $DD23
DD23   FD 0A                      POP  X
DD25   44                         INC  X
DD26   91 42                      BCR LOAD_NEXT_5 ; $DCE6
DD28   FD 88                      PSH  X
DD2A   F4 7A 05                   VEJ  (F4) \ AWRD(ARX + $05)
DD2D   FD 28                      LDX  U

LOAD_NEXT_1: ; $DD2F
DD2F   FD 2A                      POP  U
DD31   65                         LIN  U
DD32   FD A8                      PSH  U
DD34   FD 98                      PSH  Y
DD36   FD C8                      PSH  A
DD38   FD 88                      PSH  X
DD3A   EC                         VEJ  (EC)
DD3B   BE F7 5B                   SJP  (CLR_ARZ)
DD3E   EB 7A 0C 10                ORI  (ARZ + $04),$10
DD42   FD 2A                      POP  U
DD44   FD 8A                      POP  A
DD46   D9                         SHL
DD47   FD C8                      PSH  A
DD49   58 7A                      LDI  YH,$7A
DD4B   81 0B                      BCR LOAD_NEXT_12 ; $DD58
DD4D   6C 80                      CPI  UH,$80
DD4F   81 07                      BCR LOAD_NEXT_12 ; $DD58
DD51   BE DA A8                   SJP  (TWOSCOMP)
DD54   EB 7A 01 80                ORI  (ARX + $01),$80

LOAD_NEXT_12: ; $DD58
DD58   4A 04                      LDI  XL,$04
DD5A   5A 0C                      LDI  YL,$0C
DD5C   24                         LDA  UL
DD5D   89 38                      BZR LOAD_NEXT_13 ; $DD97
DD5F   A4                         LDA  UH
DD60   89 36                      BZR LOAD_NEXT_14 ; $DD98
DD62   04                         LDA  XL
DD63   AE 7A 00                   STA  (ARX)
DD66   BE F6 5D                   SJP  (ARX2BCD_ABS)
DD69   A5 7A 00                   LDA  (ARX)
DD6C   2A                         STA  UL
DD6D   FD 8A                      POP  A
DD6F   D9                         SHL
DD70   FD 1A                      POP  Y
DD72   81 22                      BCR LOAD_NEXT_15 ; $DD96
DD74   4A 01                      LDI  XL,$01
DD76   D9                         SHL
DD77   81 0E                      BCR LOAD_NEXT_16 ; $DD87
DD79   47                         LDE  X
DD7A   D9                         SHL
DD7B   B5 20                      LDI  A,$20
DD7D   81 02                      BCR LOAD_NEXT_17 ; $DD81
DD7F   B5 2D                      LDI  A,$2D

LOAD_NEXT_17: ; $DD81
DD81   51                         SIN  Y
DD82   24                         LDA  UL
DD83   6A 01                      LDI  UL,$01
DD85   8B 0A                      BZS LOAD_NEXT_18 ; $DD91

LOAD_NEXT_16: ; $DD87
DD87   4A 04                      LDI  XL,$04
DD89   D7                         DRL  (X)
DD8A   46                         DEC  X
DD8B   D7                         DRL  (X)
DD8C   46                         DEC  X
DD8D   D7                         DRL  (X)
DD8E   F1                         AEX
DD8F   B9 0F                      ANI  A,$0F

LOAD_NEXT_18: ; $DD91
DD91   BB 30                      ORI  A,$30
DD93   51                         SIN  Y
DD94   88 0F                      LOP  UL,LOAD_NEXT_16 ; $DD87

LOAD_NEXT_15: ; $DD96
DD96   9A                         RTN

LOAD_NEXT_13: ; $DD97
DD97   A4                         LDA  UH

LOAD_NEXT_14: ; $DD98
DD98   D5                         SHR
DD99   28                         STA  UH
DD9A   24                         LDA  UL
DD9B   D1                         ROR
DD9C   2A                         STA  UL
DD9D   81 0B                      BCR LOAD_NEXT_19 ; $DDAA
DD9F   F9                         REC
DDA0   57                         LDE  Y
DDA1   8C                         DCA  (X)
DDA2   43                         SDE  X
DDA3   57                         LDE  Y
DDA4   8C                         DCA  (X)
DDA5   43                         SDE  X
DDA6   55                         LIN  Y
DDA7   8C                         DCA  (X)
DDA8   0E                         STA  (X)
DDA9   54                         INC  Y

LOAD_NEXT_19: ; $DDAA
DDAA   15                         LDA  (Y)
DDAB   9C                         DCA  (Y)
DDAC   53                         SDE  Y
DDAD   15                         LDA  (Y)
DDAE   9C                         DCA  (Y)
DDAF   53                         SDE  Y
DDB0   15                         LDA  (Y)
DDB1   9C                         DCA  (Y)
DDB2   1E                         STA  (Y)
DDB3   9E 5D                      BCH LOAD_NEXT_12 ; $DD58
DDB5   FD 0A                      POP  X
DDB7   45                         LIN  X
DDB8   44                         INC  X
DDB9   FD 88                      PSH  X
DDBB   46                         DEC  X
DDBC   FD C8                      PSH  A
DDBE   05                         LDA  (X)
DDBF   0A                         STA  XL
DDC0   FD 8A                      POP  A
DDC2   08                         STA  XH
DDC3   A4                         LDA  UH
DDC4   41                         SIN  X
DDC5   24                         LDA  UL
DDC6   0E                         STA  (X)
DDC7   9A                         RTN
DDC8   FD 0A                      POP  X
DDCA   45                         LIN  X
DDCB   FD 88                      PSH  X
DDCD   0A                         STA  XL
DDCE   48 78                      LDI  XH,$78
DDD0   45                         LIN  X
DDD1   FD C8                      PSH  A
DDD3   05                         LDA  (X)
DDD4   0A                         STA  XL
DDD5   FD 8A                      POP  A
DDD7   08                         STA  XH
DDD8   9A                         RTN
DDD9   FD 98                      PSH  Y
DDDB   CD 26                      VMJ  ($26)
DDDD   00                         SBC  XL
DDDE   D1                         ROR
DDDF   AD 78 85                   EOR  (CURVARTYPE) ; $7885
DDE2   D9                         SHL
DDE3   68 07                      LDI  UH,$07
DDE5   C3 4A                      VCS  ($4A)($25)
DDE7   CC 83                      VEJ  (CC) \ ABYTL(CURVARADD_H) ; $7883
DDE9   4C 80                      CPI  XH,$80
DDEB   81 0B                      BCR LOAD_NEXT_20 ; $DDF8
DDED   4C DB                      CPI  XH,$DB
DDEF   83 2C                      BCSLOAD_NEXT_21 ;  $DE1D
DDF1   BE D3 71                   SJP  (SRCHPRGLINE_16) ; $D371
DDF4   C3 4A                      VCS  ($4A)($25)
DDF6   FD 18                      LDX  Y

LOAD_NEXT_20: ; $DDF8
DDF8   ED 78 85 80                BII  (CURVARTYPE),$80 ; $7885
DDFC   8B 05                      BZS LOAD_NEXT_22 ; $DE03
DDFE   BE DC 0C                   SJP  (ISARXBCD_24) ; $DC0C
DE01   CD 4E                      VMJ  ($4E)($27)

LOAD_NEXT_22: ; $DE03
DE03   FD 5A                      STX  Y
DE05   DC                         VEJ  (DC)
DE06   FB                         SEC
DE07   A1 78 85                   SBC  (CURVARTYPE); $7885
DE0A   68 00                      LDI  UH,$00
DE0C   81 06                      BCR LOAD_NEXT_23 ; $DE14
DE0E   A5 78 85                   LDA  (CURVARTYPE); $7885
DE11   2A                         STA  UL
DE12   68 01                      LDI  UH,$01

LOAD_NEXT_23: ; $DE14
DE14   BE D0 49                   SJP  (XREG2YREG)
DE17   A4                         LDA  UH
DE18   89 01                      BZR LOAD_NEXT_24 ; $DE1B
DE1A   1E                         STA  (Y)

LOAD_NEXT_24: ; $DE1B
DE1B   CD 4E                      VMJ  ($4E)($27)

LOAD_NEXT_21: ; $DE1D
DE1D   E6                         VEJ  (E6)
DE1E   A5 7A 00                   LDA  (ARX)
DE21   BF 80                      BII  A,$80
DE23   89 08                      BZR LOAD_NEXT_25 ; $DE2D
DE25   B1 06                      SBI  A,$06
DE27   81 0C                      BCR LOAD_NEXT_26 ; $DE35

LOAD_NEXT_31: ; $DE29
DE29   68 17                      LDI  UH,$17
DE2B   CD 4A                      VMJ  ($4A)($25)

LOAD_NEXT_25: ; $DE2D
DE2D   B7 FC                      CPI  A,$FC
DE2F   68 F6                      LDI  UH,$F6
DE31   81 03                      BCR LOAD_NEXT_27: ; $DE36
DE33   B3 F9                      ADI  A,$F9

LOAD_NEXT_26: ; $DE35
DE35   28                         STA  UH

LOAD_NEXT_27: ; $DE36
DE36   48 7A                      LDI  XH,$7A

LOAD_NEXT_29: ; $DE38
DE38   4A 02                      LDI  XL,$02
DE3A   FD 60                      INC  UH
DE3C   83 0A                      BCS LOAD_NEXT_28 ; $DE48
DE3E   6A 04                      LDI  UL,$04
DE40   B5 00                      LDI  A,$00

LOAD_NEXT_30: ; $DE42
DE42   D3                         DDR  (X)
DE43   44                         INC  X
DE44   88 04                      LOP  UL,LOAD_NEXT_30 ; $DE42
DE46   9E 10                      BCH LOAD_NEXT_29 ; $DE38

LOAD_NEXT_28: ; $DE48
DE48   05                         LDA  (X)
DE49   B7 13                      CPI  A,$13
DE4B   93 24                      BCS LOAD_NEXT_31 ; $DE29
DE4D   B7 10                      CPI  A,$10
DE4F   81 02                      BCR LOAD_NEXT_32 ; $DE53
DE51   B3 09                      ADI  A,$09

LOAD_NEXT_32: ; $DE53
DE53   B9 0F                      ANI  A,$0F
DE55   F1                         AEX
DE56   0E                         STA  (X)
DE57   BE E5 9A                   SJP  (ARX2TIME)
DE5A   CD 56                      VMJ  ($56)($2B)
DE5C   CD 4E                      VMJ  ($4E)($27)
DE5E   DC                         VEJ  (DC)
DE5F   4C 80                      CPI  XH,$80
DE61   B9 80                      ANI  A,$80
DE63   83 15                      BCS LOAD_NEXT_33 ; $DE7A
DE65   8B 03                      BZS LOAD_NEXT_34 ; $DE6A
DE67   BA DC 20                   JMP  ISARXBCD_2 ; $DC20

LOAD_NEXT_34: ; $DE6A
DE6A   FD 88                      PSH  X
DE6C   62                         DEC  UL
DE6D   68 00                      LDI  UH,$00

LOAD_NEXT_36: ; $DE6F
DE6F   45                         LIN  X
DE70   8B 04                      BZS LOAD_NEXT_35 ; $DE76
DE72   FD 60                      INC  UH
DE74   88 07                      LOP  UL,LOAD_NEXT_36 ; $DE6F

LOAD_NEXT_35: ; $DE76
DE76   FD 0A                      POP  X
DE78   8E 34                      BCH BCMD_TIME_9 ; $DEAE

LOAD_NEXT_33: ; $DE71
DE7A   8B 33                      BZS BCMD_TIME_10 ; $DEAF
DE7C   4C DB                      CPI  XH,$DB
DE7E   83 02                      BCS BCMD_TIME
DE80   EC                         VEJ  (EC)
DE81   9A                         RTN



BCMD_TIME: ; $DE82
DE82   EC                         VEJ  (EC)
DE83   BE E5 B4                   SJP  (TIME2ARX)
DE86   4A 02                      LDI  XL,$02
DE88   B5 00                      LDI  A,$00
DE8A   D3                         DDR  (X)
DE8B   B7 A0                      CPI  A,$A0
DE8D   81 02                      BCR BCMD_TIME_11 ; $DE91
DE8F   4F 06                      ADI  (X),$06

BCMD_TIME_11: ; $DE91
DE91   EB 7A 00 05                ORI  (ARX),$05
DE95   E8                         VEJ  (E8)
DE96   9A                         RTN
DE97   6A 50                      LDI  UL,$50
DE99   FD 18                      LDX  Y
DE9B   68 00                      LDI  UH,$00

BCMD_TIME_13: ; $DE9D
DE9D   62                         DEC  UL
DE9E   81 0E                      BCR BCMD_TIME_9 ; $DEAE
DEA0   55                         LIN  Y
DEA1   B7 22                      CPI  A,$22
DEA3   8B 09                      BZS BCMD_TIME_9 ; $DEAE
DEA5   B7 0D                      CPI  A,$0D
DEA7   8B 04                      BZS BCMD_TIME_12 ; $DEAD
DEA9   FD 60                      INC  UH
DEAB   9E 10                      BCH BCMD_TIME_13 ; $DE9D

BCMD_TIME_12: ; $DEAD
DEAD   56                         DEC  Y

BCMD_TIME_9: ; $DEAE
DEAE   A4                         LDA  UH

BCMD_TIME_10: ; $DEAF
DEAF   6A 07                      LDI  UL,$07
DEB1   68 7A                      LDI  UH,$7A
DEB3   63                         SDE  U
DEB4   04                         LDA  XL
DEB5   63                         SDE  U
DEB6   84                         LDA  XH
DEB7   63                         SDE  U
DEB8   B5 D0                      LDI  A,$D0
DEBA   2E                         STA  (U)
DEBB   9A                         RTN
DEBC   6A 05                      LDI  UL,$05

BCMD_TIME_7: ; $DEBE
DEBE   68 7A                      LDI  UH,$7A
DEC0   65                         LIN  U
DEC1   08                         STA  XH
DEC2   65                         LIN  U
DEC3   0A                         STA  XL
DEC4   25                         LDA  (U)
DEC5   2A                         STA  UL
DEC6   9A                         RTN

BCMD_TIME_4: ; $DEC7
DEC7   D4 A0                      VEJ  (D4) \ ABYT($A0)
DEC9   A5 78 82                   LDA  (STK_PTR_GSB_FOR)
DECC   2A                         STA  UL
DECD   68 7A                      LDI  UH,$7A
DECF   8E 08                      BCH BCMD_TIME_14 ; $DED9
DED1   FD 0A                      POP  X
DED3   45                         LIN  X
DED4   2A                         STA  UL
DED5   FD 88                      PSH  X
DED7   68 78                      LDI  UH,$78

BCMD_TIME_14: ; $DED9
DED9   4A 9C                      LDI  XL,$9C
DEDB   48 78                      LDI  XH,$78
DEDD   65                         LIN  U
DEDE   18                         STA  YH
DEDF   65                         LIN  U
DEE0   1A                         STA  YL
DEE1   8E 10                      BCH BCMD_TIME_15 ; $DEF3
DEE3   FD 2A                      POP  U
DEE5   65                         LIN  U
DEE6   0A                         STA  XL
DEE7   FD A8                      PSH  U
DEE9   48 78                      LDI  XH,$78

BCMD_TIME_16: ; $DEEB
DEEB   68 78                      LDI  UH,$78
DEED   6A 9C                      LDI  UL,$9C
DEEF   94                         LDA  YH
DEF0   41                         SIN  X
DEF1   14                         LDA  YL

BCMD_TIME_17: ; $DEF2
DEF2   41                         SIN  X

BCMD_TIME_15: ; $DEF3
DEF3   65                         LIN  U
DEF4   41                         SIN  X
DEF5   65                         LIN  U
DEF6   41                         SIN  X
DEF7   65                         LIN  U
DEF8   41                         SIN  X
DEF9   65                         LIN  U
DEFA   41                         SIN  X
DEFB   9A                         RTN

BCMD_TIME_5: ; $DEFC
DEFC   C8 00                      VEJ  (C8) \ ABRF(BCMD_TIME_6) ; $DEFE)

BCMD_TIME_6: ; $DEFE
DEFE   CD 18                      VMJ  ($18)
DF00   CC 81                      VEJ  (CC) \ ABYTL($7881)
DF02   48 7A                      LDI  XH,$7A
DF04   9E 1B                      BCH BCMD_TIME_16 ; $DEEB

BCMD_TIME_1: ; $DF06
DF06   68 78                      LDI  UH,$78
DF08   48 78                      LDI  XH,$78
DF0A   65                         LIN  U
DF0B   41                         SIN  X
DF0C   65                         LIN  U
DF0D   9E 1D                      BCH BCMD_TIME_17 ; $DEF2
DF0F   FD 98                      PSH  Y
DF11   C2 22 04                   VEJ  (C2) \ ACHR($22) \ ABRF(BCMD_TIME_18) ; $DF18
DF14   CD 0C                      VMJ  ($0C)
DF16   8E 04                      BCH BCMD_TIME_19 ; $DF1C

BCMD_TIME_18: ; $DF18
DF18   C6                         VEJ  (C6)
DF19   CE 40 03                   VEJ  (CE) \ ABYT($40) \ ABRF(BCMD_TIME_20) ; $DF1F

BCMD_TIME_19: ; $DF1C
DF1C   FB                         SEC
DF1D   8E 01                      BCH BCMD_TIME_21 ; $DF20

BCMD_TIME_20: ; $DF1F
DF1F   F9                         REC

BCMD_TIME_21: ; $DF20
DF20   FD 0A                      POP  X
DF22   9A                         RTN
DF23   FD 0A                      POP  X
DF25   FD A8                      PSH  U
DF27   28                         STA  UH
DF28   45                         LIN  X
DF29   2A                         STA  UL
DF2A   A4                         LDA  UH

BCMD_TIME_23: ; $DF2B
DF2B   F7                         CIN
DF2C   8B 05                      BZS BCMD_TIME_22 ; $DF33
DF2E   44                         INC  X
DF2F   88 06                      LOP  UL,BCMD_TIME_23 ; $DF2B
DF31   8E 03                      BCH BCMD_TIME_24 ; $DF36

BCMD_TIME_22: ; $DF33
DF33   45                         LIN  X
DF34   FD CA                      ADR  X

BCMD_TIME_24: ; $DF36
DF36   FD 2A                      POP  U
DF38   A4                         LDA  UH
DF39   FD 5E                      STX  P
DF3B   A5 78 9D                   LDA  (CURR_LINE_L)
DF3E   AB 78 9C                   ORA  (CURR_LINE_H)
DF41   9A                         RTN

BCMD_TIME_3: ; $DF42
DF42   6A 50                      LDI  UL,$50

BCMD_TIME_2: ; $DF44
DF44   68 00                      LDI  UH,$00
DF46   62                         DEC  UL

BCMD_TIME_29: ; $DF47
DF47   55                         LIN  Y
DF48   CD 34 03 2C 0C 22 0F 0D    VMJ  ($34) \ ABYT($03) \ ABYT($2C) \ 
                                       ABRF(BCMD_TIME_25) \ ABYT($22) \ ABRF(BCMD_TIME_26) \ 
                                       ABYT($0D) \ ABRF(BCMD_TIME_27) \ ABYT($3A) \ ABRF(BCMD_TIME_28)
DF53   9E 0E                      BCH BCMD_TIME_29 ; $DF47

BCMD_TIME_28: ; $DF55
DF55   99 10                      BZR BCMD_TIME_29 ; $DF47

BCMD_TIME_27: ; $DF57
DF57   56                         DEC  Y
DF58   9A                         RTN

BCMD_TIME_25: ; $DF59
DF59   99 14                      BZR BCMD_TIME_29 ; $DF47
DF5B   88 16                      LOP  UL,BCMD_TIME_29 ; $DF47
DF5D   9A                         RTN

BCMD_TIME_26: ; $DF5E
DF5E   BD 01                      EAI  $01
DF60   28                         STA  UH
DF61   9E 1C                      BCH BCMD_TIME_29 ; $DF47
DF63   C2 22 0A                   VEJ  (C2) \ ACHR($22) \ ABRF($DF70)
DF66   CD 0C                      VMJ  ($0C)
DF68   C2 0D 01                   VEJ  (C2) \ ACHR($0D) \ ABRF($DF6C)
DF6B   9A                         RTN
DF6C   C4 3A 01                   VEJ  (C4) \ ACHR($3A) \ ABRF($DF70)
DF6F   C0                         VEJ  (C0)
DF70   F9                         REC
DF71   9A                         RTN
DF72   B5 0D                      LDI  A,$0D
DF74   6A 4C                      LDI  UL,$4C
DF76   FD 18                      LDX  Y

BCMD_TIME_31: ; $DF78
DF78   F7                         CIN
DF79   8B 02                      BZS BCMD_TIME_30 ; $DF7D
DF7B   88 05                      LOP  UL,BCMD_TIME_31 ; $DF78

BCMD_TIME_30: ; $DF7D
DF7D   FD 5A                      STX  Y
DF7F   9A                         RTN
DF80   D4 A0                      VEJ  (D4) \ ABYT($A0)
DF82   83 0A                      BCS BCMD_TIME_32 ; $DF8E
DF84   55                         LIN  Y
DF85   AE 78 9C                   STA  (CURR_LINE_H)
DF88   55                         LIN  Y
DF89   AE 78 9D                   STA  (CURR_LINE_L)
DF8C   54                         INC  Y
DF8D   9A                         RTN

BCMD_TIME_32: ; $DF8E
DF8E   94                         LDA  YH
DF8F   BB 80                      ORI  A,$80
DF91   18                         STA  YH
DF92   9A                         RTN
DF93   CC 61                      VEJ  (CC) \ ABYTL(ROM_ST_L) ; $7861
DF95   DB                         ROL
DF96   81 02                      BCR BCMD_TIME_33 ; $DF9A
DF98   CC 65                      VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865

BCMD_TIME_33: ; $DF9A
DF9A   9A                         RTN
DF9B   B5 10                      LDI  A,$10
DF9D   AE 78 94                   STA  (STR_BUF_PTR_L)

BCMD_TIME_8: ; $DFA0
DFA0   DC                         VEJ  (DC)



XREG2STRBUF: ; $DFA1
DFA1   FD 98                      PSH  Y
DFA3   BE DF B4                   SJP  (XREG2STRBUF_1) ; $DFB4
DFA6   C3 4A                      VCS  ($4A)($25)
DFA8   24                         LDA  UL

XREG2STRBUF_3: ; $DFA9
DFA9   DF                         DEC  A
DFAA   81 03                      BCR XREG2STRBUF_2 ; $DFAF
DFAC   F5                         TIN
DFAD   9E 06                      BCH XREG2STRBUF_3 ; $DFA9

XREG2STRBUF_2: ; $DFAF
DFAF   BE DF C5                   SJP  (ARX2STRBUF_1) ; $DFC5
DFB2   CD 4E                      VMJ  ($4E)($27)

XREG2STRBUF_1: ; $DFB4
DFB4   2A                         STA  UL
DFB5   A5 78 94                   LDA  (STR_BUF_PTR_L)
DFB8   1A                         STA  YL
DFB9   F9                         REC
DFBA   22                         ADC  UL
DFBB   68 0F                      LDI  UH,$0F
DFBD   83 02                      BCS XREG2STRBUF_4 ; $DFC1
DFBF   B7 61                      CPI  A,$61

XREG2STRBUF_4: ; $DFC1
DFC1   58 7B                      LDI  YH,$7B
DFC3   9A                         RTN



ARX2STRBUF: ; $DFC4
DFC4   2A                         STA  UL

ARX2STRBUF_1: ; $DFC5
DFC5   A5 78 94                   LDA  (STR_BUF_PTR_L)
DFC8   0A                         STA  XL
DFC9   14                         LDA  YL
DFCA   AE 78 94                   STA  (STR_BUF_PTR_L)
DFCD   48 7B                      LDI  XH,$7B
DFCF   24                         LDA  UL
DFD0   8B 04                      BZS ARX2STRBUF_2 ; $DFD6
DFD2   E9 78 74 7F                ANI  (CURSOR_ENA),$7F

ARX2STRBUF_2: ; $DFD6
DFD6   BA DE AF                   JMP  BCMD_TIME_10 ; $DEAF
DFD9   CC 65                      VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865

ARX2STRBUF_3: ; $DFD8
DFDB   A5 78 64                   LDA  (RAM_END_H)
DFDE   28                         STA  UH
DFDF   6A 00                      LDI  UL,$00

ARX2STRBUF_4: ; $DFE1
DFE1   66                         DEC  U



U_MINUS_X: ; $DFE2
DFE2   FB                         SEC
DFE3   24                         LDA  UL
DFE4   00                         SBC  XL
DFE5   2A                         STA  UL
DFE6   A4                         LDA  UH
DFE7   80                         SBC  XH
DFE8   28                         STA  UH
DFE9   83 02                      BCS U_MINUS_X_1 ; $DFED
DFEB   68 16                      LDI  UH,$16

U_MINUS_X_1: ; $DFED
DFED   9A                         RTN



MEM_IN_UREG: ; $DFEE
DFEE   CC 67                      VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867
DFF0   44                         INC  X
DFF1   9E 18                      BCH ARX2STRBUF_3 ; $DFDB



PRGST2XREG: ; $DFF3
DFF3   CD 12                      VMJ  ($12)

PRGST2XREG_1: ; $DFF5
DFF5   F4 78 67                   VEJ  (F4) \ AWRD(BASPRG_END_H)
DFF8   9E 19                      BCH ARX2STRBUF_4 ; $DFE1
DFFA   CC 65                      VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865
DFFC   9E 09                      BCH PRGST2XREG_1 ; $DFF5
DFFE   E4                         VEJ  (E4)
DFFF   E4                         VEJ  (E4)



RESET: ; $E000
E000   FD BE                      RIE
E002   B5 00                      LDI  A,$00
E004   FD CE                      AM0
E006   FD C0                      RDP
E008   6A C0                      LDI  UL,$C0

RESET_1: ; $E00A
E00A   88 02                      LOP  UL,RESET_1 ; $E00A
E00C   FD C1                      SDP
E00E   6A C0                      LDI  UL,$C0

RESET_2: ; $E010
E010   88 02                      LOP  UL,RESET_2 ; $E010
E012   FD C0                      RDP
E014   68 96                      LDI  UH,$96
E016   6A FF                      LDI  UL,$FF

RESET_3: ; $E018
E018   88 02                      LOP  UL,RESET_3 ; $E018
E01A   FD 62                      DEC  UH
E01C   93 06                      BCS RESET_3 ; $E018
E01E   B5 00                      LDI  A,$00
E020   FD AE F0 0A                STA  #(PC1500_MSK_REG)
E024   FD AE B0 0A                STA  #($B00A)
E028   FD AE F0 0B                STA  #(PC1500_IF_REG)
E02C   FD AE DC 00                STA  #($DC00)
E030   FD AE B0 0B                STA  #($B00B)
E034   48 7A                      LDI  XH,$7A
E036   4A 10                      LDI  XL,$10
E038   6A 0F                      LDI  UL,$0F
E03A   B5 A0                      LDI  A,$A0
E03C   07                         CPA  (X)
E03D   8B 01                      BZS RESET_4 ; $E040
E03F   D5                         SHR

RESET_4: ; $E040
E040   07                         CPA  (X)
E041   44                         INC  X
E042   89 09                      BZR RESET_5 ; $E04D
E044   DD                         INC  A
E045   88 07                      LOP  UL,RESET_4 ; $E040
E047   D9                         SHL
E048   B5 00                      LDI  A,$00
E04A   DB                         ROL
E04B   8E 10                      BCH RESET_6 ; $E05D

RESET_5: ; $E04D
E04D   B5 41                      LDI  A,$41
E04F   AE 76 4E                   STA  (DISP_BUFF + $4E)
E052   B5 43                      LDI  A,$43
E054   AE 76 4F                   STA  (DISP_BUFF + $4F)
E057   E9 78 6B 00                ANI  (BEEP_PTR),$00
E05B   B5 02                      LDI  A,$02

RESET_6: ; $E05D
E05D   48 7A                      LDI  XH,$7A
E05F   4A 20                      LDI  XL,$20
E061   41                         SIN  X
E062   B5 00                      LDI  A,$00
E064   41                         SIN  X
E065   43                         SDE  X
E066   46                         DEC  X
E067   4D 01                      BII  (X),$01
E069   89 DC                      BZR RESET_7 ; $E147
E06B   AA 78 4F                   LDI  S,(CPU_STACK + $4F)
E06E   EB 78 5D FF                ORI  (KATAFLAGS),$FF
E072   E9 7B 0E 01                ANI  (CURS_CTRL),$01
E076   B5 60                      LDI  A,$60
E078   AE 79 D1                   STA  (OPN)
E07B   BE F5 B5                   SJP  (BCMD_PI)
E07E   CD 5C                      VMJ  ($5C)($2E)
E080   48 79                      LDI  XH,$79
E082   4A D2                      LDI  XL,$D2
E084   6A 0C                      LDI  UL,$0C
E086   CD BA                      VMJ  ($BA)($5D)

RESET_22: ; $E088
E088   BE E1 53                   SJP  (IO_INT)
E08B   58 7A                      LDI  YH,$7A
E08D   5A 14                      LDI  YL,$14
E08F   B5 FF                      LDI  A,$FF
E091   6A 04                      LDI  UL,$04

RESET_8: ; $E093
E093   53                         SDE  Y
E094   88 03                      LOP  UL,RESET_8 ; $E093
E096   48 00                      LDI  XH,$00

RESET_11: ; $E098
E098   4A 00                      LDI  XL,$00
E09A   05                         LDA  (X)
E09B   2A                         STA  UL
E09C   B5 5A                      LDI  A,$5A
E09E   0E                         STA  (X)
E09F   07                         CPA  (X)
E0A0   89 22                      BZR RESET_9 ; $E0C4
E0A2   B5 A5                      LDI  A,$A5
E0A4   0E                         STA  (X)
E0A5   07                         CPA  (X)
E0A6   89 1C                      BZR RESET_9 ; $E0C4
E0A8   24                         LDA  UL
E0A9   0E                         STA  (X)
E0AA   5A 13                      LDI  YL,$13
E0AC   15                         LDA  (Y)
E0AD   DD                         INC  A
E0AE   81 02                      BCR RESET_10 ; $E0B2
E0B0   84                         LDA  XH
E0B1   1E                         STA  (Y)

RESET_10: ; $E0B2
E0B2   FD 40                      INC  XH
E0B4   4C 70                      CPI  XH,$70
E0B6   91 20                      BCR RESET_11 ; $E098
E0B8   5A 14                      LDI  YL,$14

RESET_15: ; $E0BA
E0BA   84                         LDA  XH
E0BB   53                         SDE  Y
E0BC   15                         LDA  (Y)
E0BD   DD                         INC  A
E0BE   81 02                      BCR RESET_12 ; $E0C2
E0C0   84                         LDA  XH
E0C1   1E                         STA  (Y)

RESET_12: ; $E0C2
E0C2   8E 29                      BCH RESET_13 ; $E0ED

RESET_9: ; $E0C4
E0C4   5A 13                      LDI  YL,$13
E0C6   45                         LIN  X
E0C7   B7 55                      CPI  A,$55
E0C9   89 1C                      BZR RESET_14 ; $E0E7
E0CB   55                         LIN  Y
E0CC   DD                         INC  A
E0CD   91 15                      BCR RESET_15 ; $E0BA
E0CF   5A 10                      LDI  YL,$10
E0D1   15                         LDA  (Y)
E0D2   DD                         INC  A
E0D3   91 23                      BCR RESET_10 ; $E0B2
E0D5   45                         LIN  X
E0D6   DD                         INC  A
E0D7   83 02                      BCS RESET_16 ; $E0DB
E0D9   DF                         DEC  A
E0DA   08                         STA  XH

RESET_16: ; $E0DB
E0DB   84                         LDA  XH
E0DC   51                         SIN  Y
E0DD   05                         LDA  (X)
E0DE   D9                         SHL
E0DF   93 2F                      BCS RESET_10 ; $E0B2
E0E1   45                         LIN  X
E0E2   82                         ADC  XH
E0E3   51                         SIN  Y
E0E4   F5                         TIN
E0E5   9E 35                      BCH RESET_10 ; $E0B2

RESET_14: ; $E0E8
E0E7   55                         LIN  Y
E0E8   DD                         INC  A
E0E9   91 31                      BCR RESET_15 ; $E0BA
E0EB   9E 3B                      BCH RESET_10 ; $E0B2

RESET_13: ; $E0ED
E0ED   48 78                      LDI  XH,$78
E0EF   4A 64                      LDI  XL,$64
E0F1   54                         INC  Y
E0F2   6A 04                      LDI  UL,$04

RESET_18: ; $E0F4
E0F4   57                         LDE  Y
E0F5   07                         CPA  (X)
E0F6   8B 04                      BZS RESET_17 ; $E0FC
E0F8   EB 7A 20 04                ORI  (ARV),$04

RESET_17: ; $E0FC
E0FC   43                         SDE  X
E0FD   88 0B                      LOP  UL,RESET_18 ; $E0F4
E0FF   B5 00                      LDI  A,$00
E101   CD 5A                      VMJ  ($5A)($2D)
E103   EB 7B 0E 01                ORI  (CURS_CTRL),$01
E107   CD BE                      VMJ  ($BE)($5F)
E109   81 15                      BCR RESET_19 ; $E120

RESET_20: ; $E10B
E10B   FD C8                      PSH  A
E10D   FD 88                      PSH  X
E10F   4A 0A                      LDI  XL,$0A
E111   68 E1                      LDI  UH,$E1
E113   6A 18                      LDI  UL,$18
E115   BA E2 0E                   JMP  ISR_HANDLER_1 ; $E20E
E118   FD 0A                      POP  X
E11A   FD 8A                      POP  A
E11C   CD BC                      VMJ  ($BC)($5E)
E11E   93 15                      BCS RESET_20 ; $E10B

RESET_19: ; $E120
E120   FD EB F0 0A 01             ORI  #(PC1500_MSK_REG),$01
E125   FD EB B0 0A 01             ORI  #($B00A),$01
E12A   FD C1                      SDP
E12C   FD 81                      SIE
E12E   48 7A                      LDI  XH,$7A
E130   4A 20                      LDI  XL,$20
E132   45                         LIN  X
E133   BF 01                      BII  A,$01
E135   8B 0D                      BZS RESET_21 ; $E144
E137   45                         LIN  X
E138   89 0A                      BZR RESET_21 ; $E144
E13A   05                         LDA  (X)
E13B   89 07                      BZR RESET_21 ; $E144
E13D   FD 2A                      POP  U
E13F   FD 1A                      POP  Y
E141   BA E2 43                   JMP  WAIT4KB_1 ; $E243

RESET_21: ; $E144
E144   BA C9 E4                   JMP  COLD_START ; $C9E4

RESET_7: ; $E147
E147   A5 7A 30                   LDA  (ARS)
E14A   08                         STA  XH
E14B   A5 7A 31                   LDA  (ARS + $01)
E14E   0A                         STA  XL
E14F   FD 4E                      STX  S
E151   9E CB                      BCH RESET_22 ; $E088



IO_INT: ; $E153
E153   FD 98                      PSH  Y
E155   48 E1                      LDI  XH,$E1
E157   4A 68                      LDI  XL,$68
E159   58 F0                      LDI  YH,$F0
E15B   5A 07                      LDI  YL,$07
E15D   6A 08                      LDI  UL,$08

IO_INT_1: ; $E15F
E15F   45                         LIN  X
E160   FD 1E                      STA  #(Y)
E162   54                         INC  Y
E163   88 06                      LOP  UL,IO_INT_1 ; $E15F
E165   FD 1A                      POP  Y
E167   9A                         RTN



IO_TBL: ; $E168
E168   23                         ADC  (U)
E169   C0                         VEJ  (C0)
E16A   D7                         DRL  (X)
E16B   00                         SBC  XL
E16C   00                         SBC  XL
E16D   00                         SBC  XL
E16E   00                         SBC  XL
E16F   FF                         NOP
E170   00                         SBC  XL



ISR_HANDLER: ; $E171
E171   FD C8                      PSH  A
E173   FD 88                      PSH  X
E175   FD 98                      PSH  Y
E177   FD A8                      PSH  U
E179   A5 79 D0                   LDA  (PU_PV)
E17C   FD C8                      PSH  A
E17E   FD ED F0 0B 01             BII  #(PC1500_IF_REG),$01
E183   8B 65                      BZS $E1EA
E185   FD E9 F0 0A FE             ANI  #(PC1500_MSK_REG),$FE
E18A   FD E9 B0 0A FE             ANI  #($B00A),$FE
E18F   FD A5 DE 00                LDA  #($DE00)
E193   FD E9 B0 0B FE             ANI  #($B00B),$FE
E198   FD AE DC 00                STA  #($DC00)
E19C   BD FF                      EAI  $FF
E19E   8B 2E                      BZS ISR_HANDLER_2 ; $E1CE

ISR_HANDLER_8: $E1A0
E1A0   B8                         RPV

ISR_HANDLER_6: $E1A1
E1A1   48 B0                      LDI  XH,$B0
E1A3   4A 00                      LDI  XL,$00

ISR_HANDLER_5: ; $E1A5
E1A5   FD 88                      PSH  X
E1A7   D5                         SHR
E1A8   FD C8                      PSH  A
E1AA   81 0D                      BCR ISR_HANDLER_3 ; $E1B9
E1AC   B5 55                      LDI  A,$55
E1AE   07                         CPA  (X)
E1AF   89 08                      BZR ISR_HANDLER_3 ; $E1B9
E1B1   68 E1                      LDI  UH,$E1
E1B3   6A B9                      LDI  UL,$B9
E1B5   4A 13                      LDI  XL,$13
E1B7   8E 55                      BCH ISR_HANDLER_1 ; $E20E

ISR_HANDLER_3: ; $E189
E1B9   FD 8A                      POP  A
E1BB   FD 0A                      POP  X
E1BD   8B 0F                      BZS ISR_HANDLER_2 ; $E1CE
E1BF   4C 90                      CPI  XH,$90
E1C1   81 08                      BCR ISR_HANDLER_4 ; $E1CB
E1C3   1A                         STA  YL
E1C4   B5 EF                      LDI  A,$EF
E1C6   82                         ADC  XH
E1C7   08                         STA  XH
E1C8   14                         LDA  YL
E1C9   9E 26                      BCH ISR_HANDLER_5 ; $E1A5

ISR_HANDLER_4: ; $E1CB
E1CB   A8                         SPV
E1CC   9E 2D                      BCH ISR_HANDLER_6 ; $E1A1

ISR_HANDLER_2: ; $E1CE
E1CE   FD ED F0 0B 01             BII  #(PC1500_IF_REG),$01
E1D3   8B 15                      BZS ISR_HANDLER_7 ; $E1EA
E1D5   FD E9 F0 0B FE             ANI  #(PC1500_IF_REG),$FE
E1DA   FD A5 B0 0B                LDA  #($B00B)
E1DE   FD A9 B0 0A                AND  #($B00A)
E1E2   B9 0E                      ANI  A,$0E
E1E4   8B 04                      BZS ISR_HANDLER_7 ; $E1EA
E1E6   B5 01                      LDI  A,$01
E1E8   9E 4A                      BCH ISR_HANDLER_8 ; $E1A0

ISR_HANDLER_7: ; $E1EA
E1EA   A5 79 DA                   LDA  ($79DA)
E1ED   B7 55                      CPI  A,$55
E1EF   89 21                      BZR ISR_HANDLER_9 ; $E212
E1F1   FD A5 F0 0B                LDA  #(PC1500_IF_REG)
E1F5   FD A9 F0 0A                AND  #(PC1500_MSK_REG)
E1F9   B9 0E                      ANI  A,$0E
E1FB   8B 15                      BZS ISR_HANDLER_9 ; $E212
E1FD   68 E2                      LDI  UH,$E2
E1FF   6A 12                      LDI  UL,$12
E201   A5 79 DB                   LDA  ($79DB)
E204   08                         STA  XH
E205   A5 79 DC                   LDA  ($79DC)
E208   0A                         STA  XL
E209   D5                         SHR
E20A   B8                         RPV
E20B   81 01                      BCR ISR_HANDLER_1 ; $E20E
E20D   A8                         SPV

ISR_HANDLER_1: ; $E20E
E20E   FD A8                      PSH  U
E210   FD 5E                      STX  P

ISR_HANDLER_9: ; $E212
E212   FD EB B0 0A 01             ORI  #($B00A),$01
E217   FD EB F0 0A 01             ORI  #(PC1500_MSK_REG),$01
E21C   FD 8A                      POP  A
E21E   AE 79 D0                   STA  (PU_PV)
E221   CD A0                      VMJ  ($A0)($50)
E223   FD 2A                      POP  U
E225   FD 1A                      POP  Y
E227   FD 0A                      POP  X

ISR_HANDLER_10: ; $E229
E229   FD 8A                      POP  A



NMI_HANDLER: ; $E22B
E22B   8A                         RTI



TIMER_ISR:  ; $E22C
E22C   FD C8                      PSH  A
E22E   B5 00                      LDI  A,$00
E230   FD CE                      AM0
E232   9E 0B                      BCH ISR_HANDLER_10 ; $E229



PVBANK: ; $E234
E234   B8                         RPV
E235   ED 79 D0 01                BII  (PU_PV),$01
E239   8B 01                      BZS PVBANK_1 $E23C
E23B   A8                         SPV

PVBANK_1: ; $E23C
E23C   9A                         RTN


WAITNOKEYS: ; $E241
E23D   EB 7B 0E 03                ORI  (CURS_CTRL),$03
E241   8E 0B                      BCH WAIT4KB_2 ; $E24E



WAIT4KB: ; $E243
E243   A5 79 D4                   LDA  ($79D4)

WAIT4KB_1: ; $E246
E246   B7 55                      CPI  A,$55
E248   8B 6D                      BZS WAIT4KB_3 $E2B7
E24A   E9 7B 0E FD                ANI  (CURS_CTRL),$FD

WAIT4KB_2: ; $E24E
E24E   48 7B                      LDI  XH,$7B
E250   ED 7B 0E 40                BII  (CURS_CTRL),$40
E254   89 05                      BZR WAIT4KB_4 ; $E25B
E256   4A 09                      LDI  XL,$09
E258   B5 60                      LDI  A,$60
E25A   41                         SIN  X

WAIT4KB_4: ; $E25B
E25B   4A 0A                      LDI  XL,$0A
E25D   B5 FE                      LDI  A,$FE
E25F   41                         SIN  X
E260   B5 1D                      LDI  A,$1D
E262   41                         SIN  X
E263   41                         SIN  X
E264   B5 80                      LDI  A,$80
E266   41                         SIN  X
E267   68 F8                      LDI  UH,$F8

WAIT4KB_11: ; $E269
E269   CD A6                      VMJ  ($A6)($53)
E26B   89 CD                      BZR WAIT4KB_5 ; $E33A
E26D   BE E4 18                   SJP  (ISKEY_1)
E270   8B 52                      BZS WAIT4KB_6 ; $E2C4
E272   BE E4 2C                   SJP  (KEY2ASCII)
E275   83 4D                      BCS WAIT4KB_6 ; $E2C4
E277   38                         NOP
E278   ED 7B 0E 01                BII  (CURS_CTRL),$01
E27C   8B 2E                      BZS WAIT4KB_7 ; $E2AC
E27E   ED 7B 0E 40                BII  (CURS_CTRL),$40
E282   8B 7B                      BZS WAIT4KB_8 ; $E2FF
E284   04                         LDA  XL
E285   A7 7B 0F                   CPA  (KEY_LAST)
E288   89 6C                      BZR WAIT4KB_9 ; $E2F6
E28A   48 7B                      LDI  XH,$7B
E28C   4A 09                      LDI  XL,$09
E28E   05                         LDA  (X)
E28F   DD                         INC  A
E290   81 0B                      BCR WAIT4KB_10 ; $E29D
E292   B5 F2                      LDI  A,$F2
E294   0E                         STA  (X)
E295   48 FE                      LDI  XH,$FE
E297   A5 7B 0F                   LDA  (KEY_LAST)
E29A   0A                         STA  XL
E29B   8E C9                      BCH AUTO_OFF ; $E366

WAIT4KB_10: ; $E29D
E29D   0E                         STA  (X)

WAIT4KB_20: ; $E29E
E29E   E9 79 D9 00                ANI  ($79D9),$00
E2A2   B5 57                      LDI  A,$57
E2A4   FD CE                      AM0
E2A6   FD 81                      SIE
E2A8   FD B1                      HLT
E2AA   9E 43                      BCH WAIT4KB_11 ; $E269

WAIT4KB_7: ; $E2AC
E2AC   BE E4 2C                   SJP  (KEY2ASCII)
E2AF   83 13                      BCS WAIT4KB_6 ; $E2C4
E2B1   04                         LDA  XL
E2B2   AE 7B 0F                   STA  (KEY_LAST)
E2B5   8E AF                      BCH AUTO_OFF ; $E366

WAIT4KB_3: ; $E2B7
E2B7   CC 5B                      VEJ  (CC) \ ABYTL($785B)
E2B9   38                         NOP
E2BA   04                         LDA  XL
E2BB   D5                         SHR
E2BC   FD BE                      RIE
E2BE   B8                         RPV
E2BF   81 01                      BCR WAIT4KB_12 ; $E2C2
E2C1   A8                         SPV

WAIT4KB_12: ; $E2C2
E2C2   FD 5E                      STX  P

WAIT4KB_6: ; $E2C4
E2C4   ED 7B 0E 01                BII  (CURS_CTRL),$01
E2C8   8B 0E                      BZS WAIT4KB_13 ; $E2D8
E2CA   ED 7B 0E 40                BII  (CURS_CTRL),$40
E2CE   89 26                      BZR WAIT4KB_9 ; $E2F6
E2D0   FD 60                      INC  UH
E2D2   81 0A                      BCR WAIT4KB_14 ; $E2DE
E2D4   E9 7B 0E FE                ANI  (CURS_CTRL),$FE

WAIT4KB_13: ; $E2D8
E2D8   ED 7B 0E 02                BII  (CURS_CTRL),$02
E2DC   89 14                      BZR WAIT4KB_15 ; $E2F2

WAIT4KB_14: ; $E2DE
E2DE   6A 02                      LDI  UL,$02
E2E0   48 7B                      LDI  XH,$7B
E2E2   4A 0D                      LDI  XL,$0D

WAIT4KB_17: ; $E2E4
E2E4   46                         DEC  X
E2E5   4F 01                      ADI  (X),$01
E2E7   81 1A                      BCR WAIT4KB_16 ; $E303
E2E9   88 07                      LOP  UL,WAIT4KB_17 ; $E2E4
E2EB   B5 FF                      LDI  A,$FF
E2ED   41                         SIN  X
E2EE   41                         SIN  X
E2EF   0E                         STA  (X)
E2F0   8E 4D                      BCH AUTO_OFF

WAIT4KB_15: ; $E2F2
E2F2   B5 00                      LDI  A,$00
E2F4   F9                         REC
E2F5   9A                         RTN

WAIT4KB_9: ; $E2F6
E2F6   B5 60                      LDI  A,$60
E2F8   AE 7B 09                   STA  (KEY_REPEAT)
E2FB   E9 7B 0E 9F                ANI  (CURS_CTRL),$9F

WAIT4KB_8: ; $E2FF
E2FF   68 F8                      LDI  UH,$F8
E301   9E 25                      BCH WAIT4KB_14 ; $E2DE

WAIT4KB_16: ; $E303
E303   4A 0B                      LDI  XL,$0B
E305   45                         LIN  X
E306   BF 07                      BII  A,$07
E308   89 0B                      BZR WAIT4KB_18 ; $E315
E30A   05                         LDA  (X)
E30B   89 08                      BZR WAIT4KB_18 ; $E315
E30D   FD C0                      RDP
E30F   6A BC                      LDI  UL,$BC

WAIT4KB_19: ; $E311
E311   88 02                      LOP  UL,WAIT4KB_19 ; $E311
E313   FD C1                      SDP

WAIT4KB_18: ; $E315
E315   ED 78 7C 01                BII  (CURSOR_BLNK),$01
E319   9B 7D                      BZS WAIT4KB_20 ; $E29E
E31B   EF 7B 0D 01                ADI  (CURS_BLNK_CTR),$01
E31F   91 83                      BCR WAIT4KB_20 ; $E29E
E321   EB 7B 0D 80                ORI  (CURS_BLNK_CTR),$80
E325   FD A8                      PSH  U
E327   CC 7E                      VEJ  (CC) \ ABYTL(CURS_POS_NBUF_H) ; $787E
E329   EF 78 7C 80                ADI  (CURSOR_BLNK),$80
E32D   B5 7F                      LDI  A,$7F
E32F   81 03                      BCR WAIT4KB_21 ; $E334
E331   A5 78 7D                   LDA  (BLNKD_CHAR_CODE)

WAIT4KB_21: ; $E334
E334   CD 8A                      VMJ  ($8A)($45)
E336   FD 2A                      POP  U
E338   9E 9C                      BCH WAIT4KB_20 ; $E29E

WAIT4KB_5: ; $E33A
E33A   B5 0E                      LDI  A,$0E
E33C   FB                         SEC
E33D   9A                         RTN
E33E   38                         NOP



AUTO_OFF: ; $E33F
E33F   B5 A0                      LDI  A,$A0
E341   48 7A                      LDI  XH,$7A
E343   4A 10                      LDI  XL,$10
E345   6A 0F                      LDI  UL,$0F

AUTO_OFF_2: ; $E347
E347   41                         SIN  X
E348   DD                         INC  A
E349   88 04                      LOP  UL,AUTO_OFF_2 ; $E347
E34B   FD 98                      PSH  Y
E34D   FD A8                      PSH  U
E34F   FD 48                      LDX  S
E351   84                         LDA  XH
E352   AE 7A 30                   STA  (ARS)
E355   04                         LDA  XL
E356   AE 7A 31                   STA  (ARS + $01)
E359   FD 4C                      OFF
E35B   FD 4C                      OFF
E35D   FD 4C                      OFF
E35F   FD 2A                      POP  U
E361   FD 1A                      POP  Y
E363   BA E2 69                   JMP  WAIT4KB_11 ; $E269

AUTO_OFF_1: ; $E366
E366   68 76                      LDI  UH,$76
E368   6A 4E                      LDI  UL,$4E
E36A   EB 7B 0E 01                ORI  (CURS_CTRL),$01
E36E   05                         LDA  (X)
E36F   B7 3E                      CPI  A,$3E
E371   81 55                      BCR AUTO_OFF_3 ; $E3C8
E373   B7 41                      CPI  A,$41
E375   83 16                      BCS AUTO_OFF_4 ; $E38D
E377   6D 04                      BII  (U),$04
E379   8B 36                      BZS AUTO_OFF_5 ; $E3B1

AUTO_OFF_9: ; $E37B
E37B   FD BE                      RIE
E37D   A5 78 5D                   LDA  (KATAFLAGS)
E380   D9                         SHL
E381   B8                         RPV
E382   81 01                      BCR AUTO_OFF_6 ; $E385
E384   A8                         SPV

AUTO_OFF_6: ; $E385
E385   A5 78 5E                   LDA  (KATACHAR)
E388   DF                         DEC  A
E389   08                         STA  XH
E38A   05                         LDA  (X)
E38B   8E 26                      BCH AUTO_OFF_7 ; $E3B3

AUTO_OFF_4: ; $E38D
E38D   6D 80                      BII  (U),$80
E38F   89 16                      BZR AUTO_OFF_8 ; $E3A7
E391   6D 04                      BII  (U),$04
E393   99 1A                      BZR AUTO_OFF_9 ; $E37B
E395   6D 08                      BII  (U),$08
E397   89 08                      BZR AUTO_OFF_10 ; $E3A1
E399   6D 02                      BII  (U),$02
E39B   89 0F                      BZR AUTO_OFF_11 ; $E3AC

AUTO_OFF_12: ; $E39D
E39D   F9                         REC
E39E   69 7D                      ANI  (U),$7D
E3A0   9A                         RTN

AUTO_OFF_10: ; $E3A1
E3A1   6D 02                      BII  (U),$02
E3A3   8B 07                      BZS AUTO_OFF_11 ; $E3AC
E3A5   9E 0A                      BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_8: ; $E3A7
E3A7   F9                         REC
E3A8   B3 40                      ADI  A,$40
E3AA   9E 0F                      BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_11: ; $E3AC
E3AC   F9                         REC
E3AD   B3 20                      ADI  A,$20
E3AF   9E 14                      BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_5: ; $E3B1
E3B1   FD BE                      RIE

AUTO_OFF_7: ; $E3B3
E3B3   6D 02                      BII  (U),$02
E3B5   8B 05                      BZS AUTO_OFF_13 ; $E3BC
E3B7   B5 40                      LDI  A,$40
E3B9   FD CA                      ADR  X
E3BB   05                         LDA  (X)

AUTO_OFF_13: ; $E3BC
E3BC   CD A0                      VMJ  ($A0)($50)
E3BE   FD 81                      SIE
E3C0   9E 25                      BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_17: ; $E3C2
E3C2   6D 04                      BII  (U),$04
E3C4   99 4B                      BZR AUTO_OFF_9 ; $E37B
E3C6   9E 17                      BCH AUTO_OFF_5 ; $E3B1

AUTO_OFF_3: ; $E3C8
E3C8   B7 01                      CPI  A,$01
E3CA   8B 1C                      BZS AUTO_OFF_14 ; $E3E8
E3CC   B7 02                      CPI  A,$02
E3CE   8B 26                      BZS AUTO_OFF_15 ; $E3F6
E3D0   B7 1B                      CPI  A,$1B
E3D2   8B 1B                      BZS AUTO_OFF_16 ; $E3EF
E3D4   6D 80                      BII  (U),$80
E3D6   9B 16                      BZS AUTO_OFF_17 ; $E3C2
E3D8   B7 20                      CPI  A,$20
E3DA   8B 08                      BZS $E3E4
E3DC   B7 3D                      CPI  A,$3D
E3DE   99 1E                      BZR AUTO_OFF_17 ; $E3C2
E3E0   B5 9D                      LDI  A,$9D
E3E2   9E 47                      BCH AUTO_OFF_12 ; $E39D
E3E4   B5 80                      LDI  A,$80
E3E6   9E 4B                      BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_14: ; $E3E8
E3E8   25                         LDA  (U)
E3E9   BD 02                      EAI  $02
E3EB   B9 7F                      ANI  A,$7F
E3ED   8E 19                      BCH AUTO_OFF_18 ; $E408

AUTO_OFF_16: ; $E3EF
E3EF   25                         LDA  (U)
E3F0   BD 80                      EAI  $80
E3F2   B9 FD                      ANI  A,$FD
E3F4   8E 12                      BCH AUTO_OFF_18 ; $E408

AUTO_OFF_15: ; $E3F6
E3F6   FD ED F0 0F 08             BII  #(PC1500_PRT_B),$08
E3FB   89 0F                      BZR AUTO_OFF_19 ; $E40C
E3FD   A5 78 5D                   LDA  (KATAFLAGS)
E400   D9                         SHL
E401   89 10                      BZR AUTO_OFF_20 ; $E413
E403   25                         LDA  (U)
E404   BD 04                      EAI  $04
E406   B9 77                      ANI  A,$77

AUTO_OFF_18: ; $E408
E408   2E                         STA  (U)
E409   BA E2 43                   JMP  WAIT4KB_1 ; $E243

AUTO_OFF_19: ; $E40C
E40C   25                         LDA  (U)
E40D   BD 08                      EAI  $08
E40F   B9 7B                      ANI  A,$7B
E411   9E 0B                      BCH AUTO_OFF_18 ; $E408

AUTO_OFF_20: ; $E413
E413   25                         LDA  (U)
E414   B9 73                      ANI  A,$73
E416   9E 10                      BCH AUTO_OFF_18 ; $E408



ISKEY: ; $E418
E418   B5 FF                      LDI  A,$FF

ISKEY_1: ; $E41A
E41A   FD AE F0 0C                STA  #(PC1500_PRT_A_DIR)
E41E   FD E9 F0 0E 00             ANI  #(PC1500_PRT_A),$00
E423   6A 03                      LDI  UL,$03

ISKEY_2: ; $E425
E425   88 02                      LOP  UL,ISKEY_2 ; $E425
E427   FD BA                      ITA
E429   BD FF                      EAI  $FF
E42B   9A                         RTN



KEY2ASCII: ; $E42C
E42C   4A 80                      LDI  XL,$80
E42E   B5 01                      LDI  A,$01

KEY2ASCII_3: ; $E430
E430   08                         STA  XH
E431   BE E4 1A                   SJP  (ISKEY_1)
E434   89 0E                      BZR KEY2ASCII_1 ; $E444
E436   F9                         REC
E437   B5 08                      LDI  A,$08
E439   02                         ADC  XL
E43A   0A                         STA  XL
E43B   84                         LDA  XH
E43C   D9                         SHL
E43D   83 02                      BCS KEY2ASCII_2 ; $E441
E43F   99 11                      BZR KEY2ASCII_3 ; $E430

KEY2ASCII_2: ; $E441
E441   B5 00                      LDI  A,$00
E443   9A                         RTN

KEY2ASCII_1: ; $E444
E444   D9                         SHL
E445   83 05                      BCS KEY2ASCII_4 ; $E44C
E447   40                         INC  XL
E448   91 06                      BCR KEY2ASCII_1 ; $E444
E44A   9E 0B                      BCH KEY2ASCII_2 ; $E441

KEY2ASCII_4: ; $E44C
E44C   48 FE                      LDI  XH,$FE
E44E   05                         LDA  (X)
E44F   F9                         REC
E450   9A                         RTN



CHK_BRK: ; $E451
E451   FD ED F0 0B 02             BII  #(PC1500_IF_REG),$02
E456   9A                         RTN
E457   C8 0D                      VEJ  (C8) \ ABRF(CHK_BRK_1) ; $E466
E459   FD 98                      PSH  Y

CHK_BRK_2: ; $E45B
E45B   B5 60                      LDI  A,$60

CHK_BRK_6: ; $E45D
E45D   AE 79 D1                   STA  (OPN)
E460   FD 1A                      POP  Y
E462   FD 81                      SIE
E464   56                         DEC  Y
E465   E2                         VEJ  (E2)

CHK_BRK_1: ; $E466
E466   C6                         VEJ  (C6)
E467   CD 36                      VMJ  ($36)
E469   81 BF                      BCR BCMD_PRINT_1 ; $E52A
E46B   C8 BD                      VEJ  (C8) \ ABRF(BCMD_PRINT_1) ; $E52A
E46D   FD 98                      PSH  Y
E46F   48 7A                      LDI  XH,$7A
E471   58 7A                      LDI  YH,$7A
E473   CD 82                      VMJ  ($82)($41)
E475   58 E4                      LDI  YH,$E4
E477   5A E3                      LDI  YL,$E3
E479   CD 9E                      VMJ  ($9E)($4F)
E47B   99 22                      BZR CHK_BRK_2 ; $E45B
E47D   CD BE                      VMJ  ($BE)($5F)
E47F   81 14                      BCR CHK_BRK_3 ; $E495

CHK_BRK_5: ; $E481
E481   FD A8                      PSH  U
E483   FD 88                      PSH  X
E485   4A 02                      LDI  XL,$02
E487   FD 5A                      STX  Y
E489   CD 9E                      VMJ  ($9E)($4F)
E48B   FD 0A                      POP  X
E48D   FD 2A                      POP  U
E48F   89 09                      BZR CHK_BRK_4 ; $E49A
E491   CD BC                      VMJ  ($BC)($5E)
E493   93 14                      BCS CHK_BRK_5 ; $E481

CHK_BRK_3: ; $E495
E495   FD 1A                      POP  Y
E497   68 22                      LDI  UH,$22
E499   E0                         VEJ  (E0)

CHK_BRK_4: ; $E49A
E49A   A4                         LDA  UH
E49B   D5                         SHR
E49C   84                         LDA  XH
E49D   D1                         ROR
E49E   9E 43                      BCH CHK_BRK_6 ; $E45D



STR_COMP: ; $E4A0
E4A0   CD 0C                      VMJ  ($0C)
E4A2   B5 04                      LDI  A,$04
E4A4   BE D0 F9                   SJP  (DEL_DIM_VARS_15) ; $D0F9
E4A7   9A                         RTN



TOK_TABL_SRCH: ; $E4A8
E4A8   FD BE                      RIE
E4AA   B8                         RPV
E4AB   B5 02                      LDI  A,$02

TOK_TABL_SRCH_5: ; $E4AD
E4AD   48 B8                      LDI  XH,$B8
E4AF   28                         STA  UH

TOK_TABL_SRCH_3: ; $E4B0
E4B0   B5 55                      LDI  A,$55
E4B2   4A 00                      LDI  XL,$00
E4B4   07                         CPA  (X)
E4B5   8B 16                      BZS TOK_TABL_SRCH_1 ; $E4CD
E4B7   A4                         LDA  UH
E4B8   4C 88                      CPI  XH,$88
E4BA   81 06                      BCR TOK_TABL_SRCH_2 ; $E4C2
E4BC   84                         LDA  XH
E4BD   B3 F7                      ADI  A,$F7
E4BF   08                         STA  XH
E4C0   9E 12                      BCH TOK_TABL_SRCH_3 ; $E4B0

TOK_TABL_SRCH_2: ; $E4C2
E4C2   D5                         SHR
E4C3   83 03                      BCS TOK_TABL_SRCH_4 ; $E4C8
E4C5   A8                         SPV
E4C6   9E 1B                      BCH TOK_TABL_SRCH_5 ; $E4AD

TOK_TABL_SRCH_4: ; $E4C8
E4C8   CD A0                      VMJ  ($A0)($50)
E4CA   F9                         REC
E4CB   FD 81                      SIE

TOK_TABL_SRCH_1: ; $E4CD
E4CD   9A                         RTN
E4CE   CD BE                      VMJ  ($BE)($5F)
E4D0   81 09                      BCR TOK_TABL_SRCH_6 ; $E4DB

TOK_TABL_SRCH_8: ; $E4D2
E4D2   44                         INC  X
E4D3   24                         LDA  UL
E4D4   07                         CPA  (X)
E4D5   8B 05                      BZS TOK_TABL_SRCH_7 ; $E4DC
E4D7   CD BC                      VMJ  ($BC)($5E)
E4D9   93 09                      BCS TOK_TABL_SRCH_8 ; $E4D2

TOK_TABL_SRCH_6: ; $E4DB
E4DB   9A                         RTN

TOK_TABL_SRCH_7: ; $E4DC
E4DC   A4                         LDA  UH
E4DD   AE 79 D0                   STA  (PU_PV)
E4E0   FD 81                      SIE
E4E2   9A                         RTN
E4E3   4C 43                      CPI  XH,$43
E4E5   44                         INC  X
E4E6   0D                         EOR  (X)



BCMD_INPUTNUM: ; $E427
E4E7   B5 84                      LDI  A,$84
E4E9   8E 05                      BCH BCMD_PRINT_2 ; $E4F0



BCMD_PRINT: ; $E4EB
E4EB   C2 23 25                   VEJ  (C2) \ ACHR($23) \ ABRF(BCMD_PRINT_3) ; $E513
E4EE   B5 04                      LDI  A,$04

BCMD_PRINT_2: ; $E4F0
E4F0   AE 78 79                   STA  (CASS_FLAG)
E4F3   C2 2D 28                   VEJ  (C2) \ ACHR($2D) \ ABRF(BCMD_PRINT_4) ; $E51E
E4F6   DE 31                      VEJ  (DE) \ ABRF(BCMD_PRINT_5) ; $E529
E4F8   C2 2C 2F                   VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_PRINT_1) ; $E52A
E4FB   D0 08 2B                   VEJ  (D0) \ ABYT($08) \ ABRF(BCMD_PRINT_5) ; $E529
E4FE   B7 02                      CPI  A,$02
E500   81 15                      BCR BCMD_PRINT_6 ; $E517
E502   BE E4 CE                   SJP  ($E4CE)
E505   81 20                      BCR BCMD_PRINT_7: ; $E527
E507   4A 10                      LDI  XL,$10
E509   ED 78 79 80                BII  (CASS_FLAG),$80
E50D   8B 02                      BZS BCMD_PRINT_8 ; $E511
E50F   4A 0D                      LDI  XL,$0D

BCMD_PRINT_8: ; $E511
E511   FD 5E                      STX  P

BCMD_PRINT_3: ; $E513
E513   C6                         VEJ  (C6)
E514   BA E6 B6                   JMP  BCMD_PAUSE_1 ; $E6B6

BCMD_PRINT_6: ; $E517
E517   D5                         SHR
E518   81 04                      BCR BCMD_PRINT_4 ; $E51E
E51A   EB 78 79 10                ORI  (CASS_FLAG),$10

BCMD_PRINT_4: ; $E51E
E51E   B5 5C                      LDI  A,$5C
E520   CD 3C                      VMJ  ($3C)
E522   81 03                      BCR BCMD_PRINT_7: ; $E527
E524   BA B8 A3                   JMP  $B8A3 ; ***

BCMD_PRINT_7: ; $E527
E527   68 23                      LDI  UH,$23

BCMD_PRINT_5: ; $E529
E529   E0                         VEJ  (E0)

BCMD_PRINT_1: ; $E52A
E52A   E4                         VEJ  (E4)



WRITE2CLOCK: ; $E52B
E52B   FD AA                      TTA
E52D   FD C8                      PSH  A
E52F   FD BE                      RIE
E531   B5 08                      LDI  A,$08
E533   CD 5A                      VMJ  ($5A)($2D)
E535   B5 00                      LDI  A,$00
E537   FD AE F0 0D                STA  #(PC1500_PRT_B_DIR)
E53B   48 7A                      LDI  XH,$7A
E53D   4A 06                      LDI  XL,$06
E53F   68 04                      LDI  UH,$04

WRITE2CLOCK_3: ; $E541
E541   05                         LDA  (X)
E542   6A 07                      LDI  UL,$07
E544   FD ED F0 0F 40             BII  #(PC1500_PRT_B),$40
E549   F9                         REC
E54A   8B 01                      BZS WRITE2CLOCK_1 ; $E54D
E54C   FB                         SEC

WRITE2CLOCK_1: ; $E54D
E54D   D1                         ROR
E54E   83 1B                      BCS $E56B
E550   FD 59 FE                   ANI  #(Y),$FE
E553   FD 59 FE                   ANI  #(Y),$FE

WRITE2CLOCK_4: ; $E54D
E556   FD 5B 04                   ORI  #(Y),$04
E559   FD 5B 04                   ORI  #(Y),$04
E55C   FD 59 FB                   ANI  #(Y),$FB
E55F   88 1D                      LOP  UL,$E544
E561   43                         SDE  X
E562   FD 62                      DEC  UH
E564   93 25                      BCS WRITE2CLOCK_3 ; $E541
E566   FD 8A                      POP  A
E568   FD EC                      ATT
E56A   9A                         RTN

WRITE2CLOCK_2: ; $E56B
E56B   FD 5B 01                   ORI  #(Y),$01
E56E   FD 5B 01                   ORI  #(Y),$01
E571   9E 1D                      BCH WRITE2CLOCK_4 ; $E556



TIMEMODE: ; $E573
E573   58 F0                      LDI  YH,$F0
E575   5A 08                      LDI  YL,$08
E577   28                         STA  UH
E578   FD AA                      TTA
E57A   FD C8                      PSH  A
E57C   FD BE                      RIE
E57E   FD 15                      LDA  #(Y)
E580   B9 C0                      ANI  A,$C0
E582   F9                         REC
E583   A2                         ADC  UH
E584   FD 1E                      STA  #(Y)
E586   FD 1E                      STA  #(Y)
E588   B3 02                      ADI  A,$02
E58A   FD 1E                      STA  #(Y)
E58C   FD 1E                      STA  #(Y)
E58E   B3 FE                      ADI  A,$FE
E590   FD 1E                      STA  #(Y)
E592   FD 1E                      STA  #(Y)
E594   6A 02                      LDI  UL,$02

TIMEMODE_1: ; $E596
E596   88 02                      LOP  UL,TIMEMODE_1 ; $E596
E598   9E 34                      BCH $E566



ARX2TIME: ; $ E59A
E59A   FD 98                      PSH  Y
E59C   FD 88                      PSH  X
E59E   BE E5 2B                   SJP  (WRITE2CLOCK)
E5A1   B5 10                      LDI  A,$10
E5A3   CD 5A                      VMJ  ($5A)($2D)

ARX2TIME_1: ; $ E5A5
E5A5   B5 00                      LDI  A,$00
E5A7   CD 5A                      VMJ  ($5A)($2D)
E5A9   FD 59 C7                   ANI  #(Y),$C7
E5AC   FD 5B 08                   ORI  #(Y),$08

ARX2TIME_2: ; $ E5AF
E5AF   FD 0A                      POP  X
E5B1   FD 1A                      POP  Y
E5B3   9A                         RTN



TIME2ARX: ; $ E5B4
E5B4   FD 98                      PSH  Y
E5B6   FD 88                      PSH  X
E5B8   B5 18                      LDI  A,$18
E5BA   CD 5A                      VMJ  ($5A)($2D)
E5BC   BE E5 2B                   SJP  (WRITE2CLOCK)
E5BF   9E 1C                      BCH ARX2TIME_1 ; $E5A5
E5C1   C2 F1 9C 07                VEJ  (C2) \ AWRD($F19C) \ ABRF(TIME2ARX_1) ; $E5CC
E5C5   E9 78 6B FE                ANI  (BEEP_PTR),$FE

TIME2ARX_3: ; $ E5C9
E5C9   CD A2                      VMJ  ($A2)($51)
E5CB   E2                         VEJ  (E2)

TIME2ARX_1: ; $ E5CC
E5CC   C4 F1 9E 06                VEJ  (C4) \ AWRD($F19E) \ ABRF(TIME2ARX_2) ; $E5D6
E5D0   EB 78 6B 01                ORI  (BEEP_PTR),$01
E5D4   9E 0D                      BCH TIME2ARX_3 ; $E5C9

TIME2ARX_2: ; $ E5D6
E5D6   C6                         VEJ  (C6)
E5D7   ED 78 6B 01                BII  (BEEP_PTR),$01
E5DB   89 73                      BZR TIME2ARX_4 ; $E650
E5DD   DE 74                      VEJ  (DE) \ ABRF(TIME2ARX_12) $E653
E5DF   D2 72 80                   VEJ  (D2) \ ABRF(TIME2ARX_11) \ ABYT($80)
E5E2   ED 7A 01 80                BII  (ARX + $01),$80
E5E6   89 68                      BZR TIME2ARX_4 ; $E650
E5E8   ED 7A 02 F0                BII  (ARX + $02),$F0
E5EC   8B 62                      BZS TIME2ARX_4 ; $E650
E5EE   D0 00 62                   VEJ  (D0) \ ABYT($00) \ ABRF(TIME2ARX_12) ; $E653
E5F1   FD A8                      PSH  U
E5F3   C8 2D                      VEJ  (C8) \ ABRF(TIME2ARX_5) ; $E622
E5F5   B5 FF                      LDI  A,$FF

TIME2ARX_15: ; $ E5F7
E5F7   FD 2A                      POP  U
E5F9   FD 98                      PSH  Y
E5FB   1A                         STA  YL
E5FC   FD A8                      PSH  U

TIME2ARX_9: ; $ E5FE
E5FE   14                         LDA  YL
E5FF   8B 18                      BZS TIME2ARX_6 ; $E619
E601   BE E6 69                   SJP  (BCMD_BEEP_STD)

TIME2ARX_10: ; $ E604
E604   FD 2A                      POP  U
E606   89 42                      BZR TIME2ARX_7 ; $E64A
E608   66                         DEC  U
E609   24                         LDA  UL
E60A   89 03                      BZR TIME2ARX_8 ; $E60F
E60C   A4                         LDA  UH
E60D   8B 3B                      BZS TIME2ARX_7 ; $E64A

TIME2ARX_8: ; $ E60F
E60F   FD A8                      PSH  U
E611   68 00                      LDI  UH,$00
E613   6A 06                      LDI  UL,$06
E615   CD AC                      VMJ  ($AC)($56)
E617   9E 1B                      BCH TIME2ARX_9 ; $E5FE

TIME2ARX_6: ; $ E619
E619   A5 78 78                   LDA  (BEEP_FREQ)
E61C   2A                         STA  UL
E61D   BE E6 6F                   SJP  (BCMD_BEEP)
E620   9E 1E                      BCH TIME2ARX_10 ; $E604

TIME2ARX_5: ; $ E622
E622   C4 2C 2F                   VEJ  (C4) \ ACHR($2C) \ ABRF(TIME2ARX_11) ; $E654
E625   DE 2C                      VEJ  (DE) \ ABRF(TIME2ARX_12) ; $E653
E627   D0 08 29                   VEJ  (D0) \ ABYT($08) \ ABRF(TIME2ARX_12) ; $E653
E62A   24                         LDA  UL
E62B   AE 78 78                   STA  (BEEP_FREQ)
E62E   C8 06                      VEJ  (C8) \ ABRF(TIME2ARX_13) ; $E636
E630   48 01                      LDI  XH,$01
E632   4A A0                      LDI  XL,$A0
E634   8E 10                      BCH TIME2ARX_14 ; $E646

TIME2ARX_13: ; $ E636
E636   C4 2C 1B                   VEJ  (C4) \ ACHR($2C) \ ABRF(TIME2ARX_11) ; $E654
E639   DE 18                      VEJ  (DE) \ ABRF(TIME2ARX_12) ; $E653
E63B   D0 02 15                   VEJ  (D0) \ ABYT($02) \ ABRF(TIME2ARX_12) ; $E653
E63E   FD A8                      PSH  U
E640   C8 12                      VEJ  (C8) \ ABRF(TIME2ARX_11) ; $E654
E642   FD 0A                      POP  X
E644   FD 40                      INC  XH

TIME2ARX_14: ; $ E646
E646   B5 00                      LDI  A,$00
E648   9E 53                      BCH TIME2ARX_15 ; $E5F7

TIME2ARX_7: ; $ E64A
E64A   FD 1A                      POP  Y
E64C   CD A2                      VMJ  ($A2)($51)
E64E   56                         DEC  Y
E64F   E2                         VEJ  (E2)

TIME2ARX_4: ; $ E650
E650   BA C6 84                   JMP  BCMD_DATA ; $C684

TIME2ARX_12: ; $ E653
E653   E0                         VEJ  (E0)

TIME2ARX_11: ; $ E654
E654   E4                         VEJ  (E4)



BEEP_ON-OFF: ; $E655
E655   ED 78 6B 01                BII  (BEEP_PTR),$01
E659   8B 07                      BZS BEEP_ON-OFF_1 ; $E662
E65B   FD E9 F0 08 BF             ANI  #(PC1500_PRT_C),$BF
E660   FB                         SEC
E661   9A                         RTN

BEEP_ON-OFF_1: ; $E662
E662   FD EB F0 08 40             ORI  #(PC1500_PRT_C),$40
E667   F9                         REC
E668   9A                         RTN



BCMD_BEEP_STD: ; $E669
E669   6A 08                      LDI  UL,$08
E66B   48 01                      LDI  XH,$01
E66D   4A A0                      LDI  XL,$A0



BCMD_BEEP: ; $E66F
E66F   FD 98                      PSH  Y
E671   FD 88                      PSH  X
E673   FD A8                      PSH  U
E675   58 F0                      LDI  YH,$F0
E677   5A 08                      LDI  YL,$08
E679   24                         LDA  UL
E67A   28                         STA  UH

BCMD_BEEP_5: ; $E67B
E67B   B5 C8                      LDI  A,$C8
E67D   FD 1E                      STA  #(Y)
E67F   A4                         LDA  UH
E680   2A                         STA  UL

BCMD_BEEP_1: ; $E681
E681   88 02                      LOP  UL,BCMD_BEEP_1 ; $E681
E683   FD ED F0 0B 03             BII  #(PC1500_IF_REG),$03
E688   89 14                      BZR BCMD_BEEP_2 ; $E69E
E68A   46                         DEC  X
E68B   84                         LDA  XH
E68C   8B 10                      BZS BCMD_BEEP_2 ; $E69E
E68E   B5 88                      LDI  A,$88
E690   FD 1E                      STA  #(Y)
E692   A4                         LDA  UH
E693   2A                         STA  UL

BCMD_BEEP_3: ; $E694
E694   88 02                      LOP  UL,BCMD_BEEP_3 ; $E694
E696   6A 01                      LDI  UL,$01

BCMD_BEEP_4: ; $E698
E698   88 02                      LOP  UL,BCMD_BEEP_4 ; $E698
E69A   49 FF                      ANI  (X),$FF
E69C   9E 23                      BCH BCMD_BEEP_5 ; $E67B

BCMD_BEEP_2: ; $E69E
E69E   FD 2A                      POP  U
E6A0   9E F3                      BCH ARX2TIME_2 ; $E5AF
E6A2   E4                         VEJ  (E4)
E6A3   E4                         VEJ  (E4)
E6A4   E4                         VEJ  (E4)



BCMD_PAUSE: ; $E6A5
E6A5   B5 FF                      LDI  A,$FF
E6A7   8E 0F                      BCH BCMD_PAUSE_2 ; $E6B8

BCMD_PAUSE_25: ; $E6A9
E6A9   B5 AA                      LDI  A,$AA
E6AB   FD C8                      PSH  A
E6AD   B5 60                      LDI  A,$60
E6AF   AE 78 8F                   STA  ($788F)
E6B2   FD 98                      PSH  Y
E6B4   8E 57                      BCH BCMD_PAUSE_3 ; $E70D

BCMD_PAUSE_1: ; $E6B6
E6B6   B5 00                      LDI  A,$00

BCMD_PAUSE_2: ; $E6B8
E6B8   FD C8                      PSH  A
E6BA   B5 60                      LDI  A,$60
E6BC   AE 78 8F                   STA  ($788F)
E6BF   C8 3C                      VEJ  (C8) \ ABRF(BCMD_PAUSE_4); $E6FD

BCMD_PAUSE_16: ; $E6C1
E6C1   BE EC AE                   SJP  (INIT_CURS)

BCMD_PAUSE_21: ; $E6C4
E6C4   CD 84                      VMJ  ($84)($42)
E6C6   FD 8A                      POP  A
E6C8   D9                         SHL
E6C9   83 17                      BCS BCMD_PAUSE_5 ; $E6E2

BCMD_PAUSE_24: ; $E6CB
E6CB   D8                         VEJ  (D8)
E6CC   89 04                      BZR BCMD_PAUSE_6 ; $E6D2
E6CE   B5 20                      LDI  A,$20
E6D0   8E 24                      BCH BCMD_PAUSE_7 ; $E6F6

BCMD_PAUSE_6: ; $E6D2
E6D2   A5 78 71                   LDA  (WAIT_CFG)
E6D5   D5                         SHR
E6D6   83 08                      BCS BCMD_PAUSE_8 ; $E6E0
E6D8   D5                         SHR
E6D9   81 11                      BCR BCMD_PAUSE_9 ; $E6EC
E6DB   F4 78 72                   VEJ  (F4) \ AWRD(WAIT_CTR_H)

BCMD_PAUSE_10: ; $E6DE
E6DE   CD AC                      VMJ  ($AC)($56)

BCMD_PAUSE_8: ; $E6E0
E6E0   56                         DEC  Y
E6E1   E2                         VEJ  (E2)

BCMD_PAUSE_5: ; $E6E2
E6E2   D9                         SHL
E6E3   68 00                      LDI  UH,$00
E6E5   6A 36                      LDI  UL,$36
E6E7   93 0B                      BCSBCMD_PAUSE_10 ; $E6DE
E6E9   BA EE F7                   JMP  BCMD_POINT_1 ; $EEF7

BCMD_PAUSE_9: ; $E6EC
E6EC   EB 78 8A 20                ORI  (BREAKPARAM),$20
E6F0   D4 AC                      VEJ  (D4) \ ABYT($AC)
E6F2   D4 A0                      VEJ  (D4) \ ABYT($A0)
E6F4   B5 02                      LDI  A,$02

BCMD_PAUSE_7: ; $E6F6
E6F6   AE 78 80                   STA  (DISPARAM)
E6F9   CD 84                      VMJ  ($84)($42)
E6FB   CD 46                      VMJ  ($46)($23)

BCMD_PAUSE_4: ; $E6FD
E6FD   CD 9A                      VMJ  ($9A)($4D)
E6FF   C3 E0                      VCS  ($E0)
E701   DE A5                      VEJ  (DE) \ ABRF(BCMD_PAUSE_11) ; $E7A8
E703   C8 3F                      VEJ  (C8) \ ABRF(BCMD_PAUSE_12) ; $E744
E705   FD 98                      PSH  Y
E707   ED 78 74 01                BII  (CURSOR_ENA),$01
E70B   89 26                      BZR BCMD_PAUSE_13 ; $E733

BCMD_PAUSE_3: ; $E70D
E70D   BE EF 81                   SJP  (OUTBUFCLR)
E710   CD 98                      VMJ  ($98)($4C)
E712   83 10                      BCS BCMD_PAUSE_14 ; $E724
E714   B5 02                      LDI  A,$02
E716   CD 96                      VMJ  ($96)($4B)
E718   83 8A                      BCS BCMD_PAUSE_15 ; $E7A4
E71A   2A                         STA  UL
E71B   BD FF                      EAI  $FF
E71D   B3 7B                      ADI  A,$7B
E71F   AE 78 8F                   STA  ($788F)
E722   CD 94                      VMJ  ($94)($4A)

BCMD_PAUSE_14: ; $E724
E724   B5 1A                      LDI  A,$1A
E726   BE EC B2                   SJP  (INIT_MTRX)

BCMD_PAUSE_18: ; $E729
E729   68 7B                      LDI  UH,$7B
E72B   6A 60                      LDI  UL,$60
E72D   CD 92                      VMJ  ($92)($49)
E72F   FD 1A                      POP  Y
E731   9E 72                      BCH BCMD_PAUSE_16 ; $E6C1

BCMD_PAUSE_13: ; $E733
E733   CD 98                      VMJ  ($98)($4C)
E735   83 07                      BCS BCMD_PAUSE_17 ; $E73E
E737   B5 01                      LDI  A,$01
E739   BE EC D6                   SJP  (ARX2OUTBUF_F)
E73C   83 66                      BCS BCMD_PAUSE_15 ; $E7A4

BCMD_PAUSE_17: ; $E73E
E73E   FB                         SEC
E73F   14                         LDA  YL
E740   B1 60                      SBI  A,$60
E742   9E 1B                      BCH BCMD_PAUSE_18 ; $E729

BCMD_PAUSE_12: ; $E744
E744   C4 2C 3E                   VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_PAUSE_19) ; $E785
E747   FD 98                      PSH  Y
E749   CD 9C                      VMJ  ($9C)($4E)
E74B   83 57                      BCS BCMD_PAUSE_15 ; $E7A4
E74D   FD 1A                      POP  Y
E74F   C8 15                      VEJ  (C8) \ ABRF(BCMD_PAUSE_20) ; $E766
E751   E9 78 74 FE                ANI  (CURSOR_ENA),$FE
E755   BE EC 9C                   SJP  (CLRNOCURSOR)
E758   68 7B                      LDI  UH,$7B
E75A   6A 60                      LDI  UL,$60
E75C   CD 92                      VMJ  ($92)($49)
E75E   EB 78 74 01                ORI  (CURSOR_ENA),$01
E762   91 A0                      BCR BCMD_PAUSE_21 ; $E6C4
E764   9E A5                      BCH BCMD_PAUSE_16 ; $E6C1

BCMD_PAUSE_20: ; $E766
E766   CD 9A                      VMJ  ($9A)($4D)
E768   C3 E0                      VCS  ($E0)
E76A   DE 3C                      VEJ  (DE) \ ABRF(BCMD_PAUSE_11) ; $E7A8
E76C   C2 2C 01                   VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_PAUSE_22) ; $E770
E76F   E4                         VEJ  (E4)

BCMD_PAUSE_22: ; $E770
E770   CD 04 36                   VMJ  ($04) \ ABRF(BCMD_PAUSE_23) ; $E7A9
E773   FD 98                      PSH  Y
E775   CD 9C                      VMJ  ($9C)($4E)
E777   83 2B                      BCS BCMD_PAUSE_15 ; $E7A4
E779   BE EC B2                   SJP  (INIT_MTRX)
E77C   9E 40                      BCH BCMD_PAUSE_17 ; $E73E
E77E   CD 9A                      VMJ  ($9A)($4D)
E780   C3 E0                      VCS  ($E0)
E782   DE 24                      VEJ  (DE) \ ABRF(BCMD_PAUSE_11) ; $E7A8
E784   C0                         VEJ  (C0)

BCMD_PAUSE_19: ; $E785
E785   C4 3B 0D                   VEJ  (C4) \ ACHR($3B) \ ABRF($E795)
E788   FD 98                      PSH  Y
E78A   BE EC E3                   SJP  (ARXASCII2OUTBUF)
E78D   83 15                      BCS BCMD_PAUSE_15 ; $E7A4
E78F   FD 1A                      POP  Y
E791   C8 17                      VEJ  (C8) \ ABRF($E7AA)
E793   9E 40                      BCH $E755
E795   CD 04 11                   VMJ  ($04) \ ABRF(BCMD_PAUSE_23) ; $E7A9
E798   FD 98                      PSH  Y
E79A   BE EC E3                   SJP  (ARXASCII2OUTBUF)
E79D   83 05                      BCS BCMD_PAUSE_15 ; $E7A4
E79F   BE EC 9C                   SJP  (CLRNOCURSOR)
E7A2   9E 7B                      BCH BCMD_PAUSE_18 ; $E729

BCMD_PAUSE_15: ; $E7A4
E7A4   68 24                      LDI  UH,$24
E7A6   FD 1A                      POP  Y

BCMD_PAUSE_11: ; $E7A8
E7A8   E0                         VEJ  (E0)

BCMD_PAUSE_23: ; $E7A9
E7A9   E4                         VEJ  (E4)
E7AA   9E 2E                      BCH $E77E



BCMD_GPRINT: ; $E7AC
E7AC   C8 02                      VEJ  (C8) \ ABRF(BCMD_GPRINT_1) ; $E7B0
E7AE   8E 5B                      BCH $E80B

BCMD_GPRINT_1: ; $E7B0
E7B0   FD A8                      PSH  U
E7B2   BE EC 9C                   SJP  (CLRNOCURSOR)
E7B5   FD 2A                      POP  U

BCMD_GPRINT_19: ; $E7B7
E7B7   C6                         VEJ  (C6)
E7B8   DE 77                      VEJ  (DE) \ ABRF($E831)
E7BA   BE ED AB                   SJP  (MTRXNRANGE)($48)
E7BD   83 38                      BCS BCMD_GPRINT_2 ; $E7F7
E7BF   FD 98                      PSH  Y
E7C1   CD 8C                      VMJ  ($8C)($46)
E7C3   FD 88                      PSH  X
E7C5   A5 7A 04                   LDA  (ARX + $04)
E7C8   B7 C0                      CPI  A,$C0
E7CA   81 1C                      BCR BCMD_GPRINT_3 ; $E7E8
E7CC   DC                         VEJ  (DC)

BCMD_GPRINT_7: ; $E7CD
E7CD   6E 02                      CPI  UL,$02
E7CF   81 22                      BCR BCMD_GPRINT_4 ; $E7F3
E7D1   BE ED 95                   SJP  (ASCII2HEX)
E7D4   FD 5A                      STX  Y
E7D6   FD 0A                      POP  X
E7D8   81 58                      BCR BCMD_GPRINT_5 ; $E832
E7DA   CD 88                      VMJ  ($88)($44)
E7DC   62                         DEC  UL
E7DD   62                         DEC  UL
E7DE   CD 8E                      VMJ  ($8E)($47)
E7E0   83 13                      BCS BCMD_GPRINT_6 ; $E7F5
E7E2   FD 88                      PSH  X
E7E4   FD 18                      LDX  Y
E7E6   9E 1B                      BCH BCMD_GPRINT_7 ; $E7CD

BCMD_GPRINT_3: ; $E7E8
E7E8   D0 08 4B                   VEJ  (D0) \ ABYT($08) \ ABRF(BCMD_GPRINT_8) ; $E836
E7EB   FD 0A                      POP  X
E7ED   CD 88                      VMJ  ($88)($44)
E7EF   CD 8E                      VMJ  ($8E)($47)
E7F1   8E 02                      BCH BCMD_GPRINT_6 ; $E7F5

BCMD_GPRINT_4: ; $E7F3
E7F3   FD 0A                      POP  X

BCMD_GPRINT_6: ; $E7F5
E7F5   FD 1A                      POP  Y

BCMD_GPRINT_2: ; $E7F7
E7F7   C2 3B 0E                   VEJ  (C2) \ ACHR($3B) \ ABRF(BCMD_GPRINT_9) ; $E808
E7FA   C8 40                      VEJ  (C8) \ ABRF(BCMD_GPRINT_10) ; $E83C

BCMD_GPRINT_20: ; $E7FC
E7FC   EB 78 74 01                ORI  (CURSOR_ENA),$01
E800   BE ED AB                   SJP  (MTRXNRANGE)($48)
E803   83 0A                      BCS BCMD_GPRINT_11 ; $E80F

BCMD_GPRINT_13: ; $E805
E805   BA E6 CB                   JMP  BCMD_PAUSE_24 ; $E6CB

BCMD_GPRINT_9: ; $E808
E808   CD 04 09                   VMJ  ($04) \ ABRF(BCMD_GPRINT_12) ; $E814
E80B   E9 78 74 FE                ANI  (CURSOR_ENA),$FE

BCMD_GPRINT_11: ; $E80F
E80F   BE EC B2                   SJP  (INIT_MTRX)
E812   9E 0F                      BCH BCMD_GPRINT_13 ; $E805

BCMD_GPRINT_12: ; $E814
E814   C4 2C 10                   VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_GPRINT_14) ; $E827
E817   BE ED AB                   SJP  (MTRXNRANGE)($48)
E81A   83 07                      BCS BCMD_GPRINT_15 ; $E823
E81C   B5 00                      LDI  A,$00
E81E   BE ED EF                   SJP  (HEX2COL)
E821   CD 8E                      VMJ  ($8E)($47)

BCMD_GPRINT_15: ; $E823
E823   C8 17                      VEJ  (C8) \ ABRF(BCMD_GPRINT_10) ; $E83C
E825   9E 2B                      BCH BCMD_GPRINT_20 ; $E7FC

BCMD_GPRINT_14: ; $E827
E827   68 01                      LDI  UH,$01

BCMD_GPRINT_18: ; $E829
E829   BE ED AB                   SJP  (MTRXNRANGE)($48)
E82C   81 03                      BCR BCMD_GPRINT_16 ; $E831
E82E   BE EC B2                   SJP  (INIT_MTRX)

BCMD_GPRINT_16: ; $E831
E831   E0                         VEJ  (E0)

BCMD_GPRINT_5: ; $E932
E832   68 24                      LDI  UH,$24
E834   8E 02                      BCH BCMD_GPRINT_17 ; $E838

BCMD_GPRINT_8: ; $E836
E836   FD 0A                      POP  X

BCMD_GPRINT_17: ; $E838
E838   FD 1A                      POP  Y
E83A   9E 13                      BCH BCMD_GPRINT_18 ; $E829

BCMD_GPRINT_10: ; $E82C
E83C   9E 87                      BCH BCMD_GPRINT_19 ; $E7B7



BCMD_GCURSOR: ; $E83E
E83E   DE 4A                      VEJ  (DE) \ ABRF(BCMD_WAIT_1) ; $E88A
E840   D0 0A 47                   VEJ  (D0) \ ABYT($0A) \ ABRF(BCMD_WAIT_1) ; $E88A
E843   24                         LDA  UL
E844   8E 17                      BCH BCMD_CURSOR_2 ; $E85D

BCMD_CURSOR_1: ; $E846
E846   C8 0A                      VEJ  (C8) \ ABRF(BCMD_CURSOR_3) ; $E852
E848   E9 78 75 00                ANI  (CURSOR_PTR),$00
E84C   E9 78 74 FE                ANI  (CURSOR_ENA),$FE
E850   56                         DEC  Y
E851   E2                         VEJ  (E2)

BCMD_CURSOR_3: ; $E852
E852   C6                         VEJ  (C6)
E853   DE 35                      VEJ  (DE) \ ABRF(BCMD_WAIT_1) ; $E88A
E855   D0 10 32                   VEJ  (D0) \ ABYT($10) \ ABRF(BCMD_WAIT_1) ; $E88A
E858   24                         LDA  UL
E859   D9                         SHL
E85A   F9                         REC
E85B   22                         ADC  UL
E85C   D9                         SHL

BCMD_CURSOR_2: ; $E85D
E85D   AE 78 75                   STA  (CURSOR_PTR)
E860   EB 78 74 01                ORI  (CURSOR_ENA),$01
E864   E2                         VEJ  (E2)



BCMD_CLS: ; $E865
E865   F2                         VEJ  (F2)
E866   BE EC AE                   SJP  (INIT_CURS)
E869   E2                         VEJ  (E2)



BCMD_WAIT: ; $E86A
E86A   C8 05                      VEJ  (C8) \ ABRF(BCMD_WAIT_2) ; $E871
E86C   56                         DEC  Y
E86D   B5 00                      LDI  A,$00
E86F   8E 15                      BCH BCMD_WAIT_3 ; $E886

BCMD_WAIT_2: ; $E871
E871   C6                         VEJ  (C6)
E872   DE 16                      VEJ  (DE) \ ABRF(BCMD_WAIT_1) ; $E88A
E874   D0 00 13                   VEJ  (D0) \ ABYT($00) \ ABRF(BCMD_WAIT_1) ; $E88A
E877   F6 78 72                   VEJ  (F6) \ AWRD(WAIT_CTR_H)
E87A   B5 02                      LDI  A,$02
E87C   6C 00                      CPI  UH,$00
E87E   89 06                      BZR BCMD_WAIT_3 ; $E886
E880   6E 00                      CPI  UL,$00
E882   89 02                      BZR BCMD_WAIT_3 ; $E886
E884   B5 03                      LDI  A,$03

BCMD_WAIT_3: ; $E886
E886   AE 78 71                   STA  (WAIT_CFG)
E889   E2                         VEJ  (E2)

BCMD_WAIT_1: ; $E86A
E88A   E0                         VEJ  (E0)
E88B   E4                         VEJ  (E4)



TIMEDELAY: ; $E88C
E88C   FD 98                      PSH  Y
E88E   FD A8                      PSH  U
E890   B5 20                      LDI  A,$20
E892   CD 5A                      VMJ  ($5A)($2D)
E894   FD 2A                      POP  U
E896   B5 00                      LDI  A,$00
E898   FD AE F0 0D                STA  #(PC1500_PRT_B_DIR)

TIMEDELAY_2: ; $E89C
E89C   FD ED F0 0F 20             BII  #(PC1500_PRT_B),$20
E8A1   8B 06                      BZS TIMEDELAY_1 ; $E8A9
E8A3   CD A6                      VMJ  ($A6)($53)
E8A5   9B 0B                      BZS TIMEDELAY_2 ; $E89C
E8A7   8E 0B                      BCH TIMEDELAY_3 ; $E8B4

TIMEDELAY_1: ; $E8A9
E8A9   FD ED F0 0F 20             BII  #(PC1500_PRT_B),$20
E8AE   89 0C                      BZR TIMEDELAY_4 ; $E8BC
E8B0   CD A6                      VMJ  ($A6)($53)
E8B2   9B 0B                      BZS TIMEDELAY_1 ; $E8A9

TIMEDELAY_3: ; $E8B4
E8B4   B5 00                      LDI  A,$00
E8B6   CD 5A                      VMJ  ($5A)($2D)
E8B8   FB                         SEC

TIMEDELAY_5: ; $E8B9
E8B9   FD 1A                      POP  Y
E8BB   9A                         RTN

TIMEDELAY_4: ; $E8BC
E8BC   62                         DEC  UL
E8BD   93 23                      BCS TIMEDELAY_2 ; $E89C
E8BF   FD 62                      DEC  UH
E8C1   93 27                      BCS TIMEDELAY_2 ; $E89C
E8C3   B5 00                      LDI  A,$00
E8C5   CD 5A                      VMJ  ($5A)($2D)
E8C7   F9                         REC
E8C8   9E 11                      BCH TIMEDELAY_5 ; $E8B9



PRGMDISP: ; $E87A
E8CA   A5 78 80                   LDA  (DISPARAM)
E8CD   BF 31                      BII  A,$31
E8CF   89 96                      BZR PRGMDISP_1 ; $E967
E8D1   FD 98                      PSH  Y
E8D3   14                         LDA  YL
E8D4   FD C8                      PSH  A
E8D6   48 7A                      LDI  XH,$7A
E8D8   4A 08                      LDI  XL,$08
E8DA   ED 78 8A 10                BII  (BREAKPARAM),$10
E8DE   89 10                      BZR PRGMDISP_2 ; $E8F0
E8E0   ED 78 80 40                BII  (DISPARAM),$40
E8E4   8B 11                      BZS PRGMDISP_3 ; $E8F7
E8E6   FD 88                      PSH  X
E8E8   B5 E5                      LDI  A,$E5

PRGMDISP_5: ; $E8EA
E8EA   68 7B                      LDI  UH,$7B
E8EC   6A B0                      LDI  UL,$B0
E8EE   8E 28                      BCH PRGMDISP_4 ; $E918

PRGMDISP_2: ; $E8F0
E8F0   FD 88                      PSH  X
E8F2   A5 78 77                   LDA  ($7877)
E8F5   9E 0D                      BCH PRGMDISP_5 ; $E8EA

PRGMDISP_3: ; $E8F7
E8F7   58 7B                      LDI  YH,$7B
E8F9   5A B0                      LDI  YL,$B0
E8FB   8E 71                      BCH PRGMDISP_6 ; $E96E

PRGMDISP_31: ; $E8FF
E8FD   ED 78 80 40                BII  (DISPARAM),$40
E901   8B 6B                      BZS PRGMDISP_6 ; $E96E
E903   FD 8A                      POP  A
E905   FD C8                      PSH  A
E907   FD 88                      PSH  X
E909   FD 98                      PSH  Y
E90B   FD 2A                      POP  U
E90D   ED 78 7B FF                BII  ($787B),$FF
E911   89 01                      BZR PRGMDISP_7 ; $E914
E913   1A                         STA  YL

PRGMDISP_7: ; $E914
E914   F9                         REC
E915   04                         LDA  XL
E916   B3 DD                      ADI  A,$DD

PRGMDISP_4: ; $E918
E918   64                         INC  U
E919   FD C8                      PSH  A
E91B   FD A8                      PSH  U
E91D   C0                         VEJ  (C0)
E91E   81 16                      BCR PRGMDISP_8 ; $E936
E920   CD 1C 04                   VMJ  ($1C) \ ABYT($04)
E923   8B 11                      BZS PRGMDISP_8 ; $E936
E925   2A                         STA  UL
E926   FD 0A                      POP  X
E928   F9                         REC
E929   FD 8A                      POP  A
E92B   22                         ADC  UL
E92C   83 02                      BCS PRGMDISP_9 ; $E930
E92E   8E 11                      BCH PRGMDISP_10 ; $E941

PRGMDISP_9: ; $E930
E930   C6                         VEJ  (C6)
E931   8E 28                      BCH PRGMDISP_11 ; $E95B

PRGMDISP_15: ; $E933
E933   C0                         VEJ  (C0)
E934   83 29                      BCS PRGMDISP_12 ; $E95F

PRGMDISP_8: ; $E936
E936   B5 01                      LDI  A,$01

PRGMDISP_16: ; $E938
E938   2A                         STA  UL
E939   FD 0A                      POP  X
E93B   F9                         REC
E93C   FD 8A                      POP  A
E93E   22                         ADC  UL
E93F   83 1A                      BCS PRGMDISP_11 ; $E95B

PRGMDISP_10: ; $E941
E941   C6                         VEJ  (C6)
E942   FD C8                      PSH  A
E944   14                         LDA  YL
E945   06                         CPA  XL
E946   81 11                      BCR PRGMDISP_13 ; $E959
E948   FD 88                      PSH  X
E94A   8B 0A                      BZS PRGMDISP_14 ; $E956
E94C   56                         DEC  Y
E94D   56                         DEC  Y
E94E   15                         LDA  (Y)
E94F   B7 E0                      CPI  A,$E0
E951   93 20                      BCS PRGMDISP_15 ; $E933
E953   54                         INC  Y
E954   9E 23                      BCH PRGMDISP_15 ; $E933

PRGMDISP_14: ; $E956
E956   56                         DEC  Y
E957   9E 26                      BCH PRGMDISP_15 ;  $E933

PRGMDISP_13: ; $E959
E959   FD 8A                      POP  A

PRGMDISP_11: ; $E95B
E95B   FD 0A                      POP  X
E95D   8E 0F                      BCH PRGMDISP_6 ; $E96E

PRGMDISP_12: ; $E95F
E95F   CD 1C 04                   VMJ  ($1C) \ ABYT($04)
E962   9B 2E                      BZS PRGMDISP_8 ; $E936
E964   DD                         INC  A
E965   9E 2F                      BCH PRGMDISP_16 ; $E938

PRGMDISP_1: ; $E967
E967   F1                         AEX
E968   D5                         SHR
E969   83 BB                      BCS STATUSCHK_1 $EA26
E96B   BA EE EC                   JMP  BCMD_POINT_2 ; $EEEC

PRGMDISP_6: ; $E96E
E96E   FD 8A                      POP  A
E970   FD C8                      PSH  A
E972   16                         CPA  YL
E973   89 04                      BZR PRGMDISP_17 ; $E979
E975   04                         LDA  XL
E976   AE 78 7B                   STA  ($787B)

PRGMDISP_17: ; $E979
E979   C0                         VEJ  (C0)
E97A   83 1B                      BCS PRGMDISP_18 ; $E997
E97C   B7 0D                      CPI  A,$0D
E97E   8B 2C                      BZS PRGMDISP_19 ; $E9AC

PRGMDISP_23: ; $E980
E980   41                         SIN  X
E981   4E 22                      CPI  XL,$22
E983   91 17                      BCR PRGMDISP_6 ; $E96E
E985   BE E9 EB                   SJP  (STATUSCHK)
E988   83 2E                      BCS PRGMDISP_20 ; $E9B8
E98A   B5 1A                      LDI  A,$1A

PRGMDISP_30: ; $E98C
E98C   28                         STA  UH

PRGMDISP_29: ; $E98D
E98D   FD 8A                      POP  A
E98F   A5 78 75                   LDA  (CURSOR_PTR)
E992   FD C8                      PSH  A
E994   A4                         LDA  UH
E995   8E 2E                      BCH PRGMDISP_21 ; $E9C5

PRGMDISP_18: ; $E997
E997   FD 98                      PSH  Y
E999   FD 5A                      STX  Y
E99B   CD 1C 02                   VMJ  ($1C) \ ABYT($02)
E99E   8B 08                      BZS PRGMDISP_22 ; $E9A8
E9A0   B5 20                      LDI  A,$20

PRGMDISP_24: ; $E9A2
E9A2   FD 18                      LDX  Y
E9A4   FD 1A                      POP  Y
E9A6   9E 28                      BCH PRGMDISP_23 ; $E980

PRGMDISP_22: ; $E9A8
E9A8   B5 7E                      LDI  A,$7E
E9AA   9E 0A                      BCH PRGMDISP_24 ; $E9A2

PRGMDISP_19: ; $E9AC
E9AC   BE E9 EB                   SJP  (STATUSCHK)
E9AF   81 1C                      BCR PRGMDISP_25 ; $E9CD
E9B1   B5 00                      LDI  A,$00

PRGMDISP_26: ; $E9B3
E9B3   41                         SIN  X
E9B4   4E 22                      CPI  XL,$22
E9B6   91 05                      BCR PRGMDISP_26 ; $E9B3

PRGMDISP_20: ; $E9B8
E9B8   FD 8A                      POP  A
E9BA   A5 78 75                   LDA  (CURSOR_PTR)
E9BD   FD C8                      PSH  A
E9BF   E9 78 75 00                ANI  (CURSOR_PTR),$00
E9C3   B5 1A                      LDI  A,$1A

PRGMDISP_21: ; $E9C5
E9C5   68 7A                      LDI  UH,$7A
E9C7   6A 08                      LDI  UL,$08
E9C9   CD 92                      VMJ  ($92)($49)
E9CB   8E 2C                      BCH STATUSCHK_2 ; $E9F9

PRGMDISP_25: ; $E9CD
E9CD   49 00                      ANI  (X),$00
E9CF   04                         LDA  XL
E9D0   B1 06                      SBI  A,$06
E9D2   A7 78 76                   CPA  (CHARPOS_LCD)
E9D5   83 0F                      BCS PRGMDISP_27 ; $E9E6
E9D7   2A                         STA  UL
E9D8   A5 78 76                   LDA  (CHARPOS_LCD)
E9DB   28                         STA  UH
E9DC   DD                         INC  A
E9DD   20                         SBC  UL
E9DE   2A                         STA  UL
E9DF   B5 00                      LDI  A,$00

PRGMDISP_28: ; $E9E1
E9E1   41                         SIN  X
E9E2   88 03                      LOP  UL,PRGMDISP_28 ; $E9E1
E9E4   9E 59                      BCH PRGMDISP_29 ; $E98D

PRGMDISP_27: ; $E9E6
E9E6   AE 78 76                   STA  (CHARPOS_LCD)
E9E9   9E 5F                      BCH PRGMDISP_30 ; $E98C



STATUSCHK: ; $E9EB
E9EB   ED 78 80 10                BII  (DISPARAM),$10
E9EF   89 07                      BZR STATUSCHK_3 ; $E9F8
E9F1   ED 78 8A 10                BII  (BREAKPARAM),$10
E9F5   8B 01                      BZS STATUSCHK_3 ; $E9F8
E9F7   F9                         REC

STATUSCHK_3: ; $E9F8
E9F8   9A                         RTN

STATUSCHK_2: ; $E9F9
E9F9   ED 78 80 40                BII  (DISPARAM),$40
E9FD   8B 19                      BZS STATUSCHK_4 ; $EA18
E9FF   CC 7E                      VEJ  (CC) \ ABYTL(CURS_POS_NBUF_H) ; $787E
EA01   A5 78 7D                   LDA  (BLNKD_CHAR_CODE)
EA04   B7 20                      CPI  A,$20
EA06   81 16                      BCR STATUSCHK_5 ; $EA1E
EA08   B5 7F                      LDI  A,$7F
EA0A   EB 78 7C 81                ORI  (CURSOR_BLNK),$81

STATUSCHK_7: ; $EA0E
EA0E   CD 8A                      VMJ  ($8A)($45)

STATUSCHK_6: ; $EA10
EA10   FD 8A                      POP  A
EA12   AE 78 75                   STA  (CURSOR_PTR)
EA15   FD 1A                      POP  Y
EA17   9A                         RTN

STATUSCHK_4: ; $EA18
EA18   E9 78 7C 7E                ANI  (CURSOR_BLNK),$7E
EA1C   9E 0E                      BCH STATUSCHK_6 ; $EA10

STATUSCHK_5: ; $EA1E
EA1E   B5 5F                      LDI  A,$5F
EA20   E9 78 7C 7E                ANI  (CURSOR_BLNK),$7E
EA24   9E 18                      BCH STATUSCHK_7 ; $EA0E

STATUSCHK_1: ; $EA26
EA26   FD 98                      PSH  Y
EA28   E9 78 7B 00                ANI  ($787B),$00
EA2C   ED 78 80 40                BII  (DISPARAM),$40
EA30   89 02                      BZR STATUSCHK_8 ; $EA34
EA32   5A B0                      LDI  YL,$B0

STATUSCHK_8: ; $EA34
EA34   14                         LDA  YL
EA35   FD C8                      PSH  A
EA37   48 7A                      LDI  XH,$7A
EA39   4A 08                      LDI  XL,$08
EA3B   5A B0                      LDI  YL,$B0

STATUSCHK_11: ; $EA3D
EA3D   FD 8A                      POP  A
EA3F   FD C8                      PSH  A
EA41   16                         CPA  YL
EA42   8B 23                      BZS STATUSCHK_9 ; $EA67
EA44   C0                         VEJ  (C0)
EA45   B7 3A                      CPI  A,$3A
EA47   83 17                      BCS STATUSCHK_10 ; $EA60
EA49   B7 30                      CPI  A,$30
EA4B   81 13                      BCR STATUSCHK_10 ; $EA60
EA4D   41                         SIN  X
EA4E   4E 0E                      CPI  XL,$0E
EA50   91 15                      BCR STATUSCHK_11 ; $EA3D

STATUSCHK_14: ; $EA52
EA52   B5 20                      LDI  A,$20
EA54   ED 78 80 04                BII  (DISPARAM),$04
EA58   8B 02                      BZS STATUSCHK_12 ; $EA5C
EA5A   B5 3A                      LDI  A,$3A

STATUSCHK_12: ; $EA5C
EA5C   41                         SIN  X

STATUSCHK_13: ; $EA5D
EA5D   BA E8 FD                   JMP  PRGMDISP_31 ; $E8FD

STATUSCHK_10: ; $EA60
EA60   C6                         VEJ  (C6)
EA61   4E 09                      CPI  XL,$09
EA63   91 08                      BCR STATUSCHK_13 ; $EA5D
EA65   9E 15                      BCH STATUSCHK_14 ; $EA52

STATUSCHK_9: ; $EA67
EA67   C0                         VEJ  (C0)
EA68   B7 3A                      CPI  A,$3A
EA6A   93 0C                      BCS STATUSCHK_10 ; $EA60
EA6C   B7 30                      CPI  A,$30
EA6E   91 10                      BCR STATUSCHK_10 ; $EA60
EA70   0E                         STA  (X)
EA71   04                         LDA  XL
EA72   AE 78 7B                   STA  ($787B)
EA75   44                         INC  X
EA76   9E 2A                      BCH $EA4E



USING_FRMT: ; $EA78
EA78   FD C8                      PSH  A
EA7A   CD 54                      VMJ  ($54)($2A)
EA7C   4A 10                      LDI  XL,$10
EA7E   6A 0D                      LDI  UL,$0D
EA80   B5 20                      LDI  A,$20

USING_FRMT_1: ; $EA82
EA82   41                         SIN  X
EA83   88 03                      LOP  UL,USING_FRMT_1 ; $EA82
EA85   ED 78 96 FF                BII  (USINGM),$FF
EA89   8B 43                      BZS USING_FRMT_2 ; $EACE
EA8B   ED 78 95 80                BII  (USINGF),$80
EA8F   89 95                      BZR USING_FRMT_3 ; $EB26
EA91   A5 78 98                   LDA  (USINGMD)
EA94   CD 86                      VMJ  ($86)($43)
EA96   83 A4                      BCS USING_FRMT_4 ; $EB3C
EA98   A4                         LDA  UH
EA99   1A                         STA  YL

USING_FRMT_12: ; $EA9A
EA9A   FD 8A                      POP  A
EA9C   D5                         SHR
EA9D   81 06                      BCR USING_FRMT_5 ; $EAA5

USING_FRMT_7: ; $EA9F
EA9F   FB                         SEC
EAA0   14                         LDA  YL
EAA1   00                         SBC  XL
EAA2   DD                         INC  A
EAA3   F9                         REC
EAA4   9A                         RTN

USING_FRMT_5: ; $EAA5
EAA5   D5                         SHR
EAA6   81 09                      BCR USING_FRMT_6 ; $EAB1
EAA8   5E 2A                      CPI  YL,$2A
EAAA   91 0D                      BCR USING_FRMT_7 ; $EA9F
EAAC   14                         LDA  YL
EAAD   B3 E6                      ADI  A,$E6
EAAF   8E 03                      BCH USING_FRMT_8 ; $EAB4

USING_FRMT_6: ; $EAB1
EAB1   14                         LDA  YL
EAB2   B3 F4                      ADI  A,$F4

USING_FRMT_8: ; $EAB4
EAB4   0A                         STA  XL

USING_FRMT_10: ; $EAB5
EAB5   05                         LDA  (X)
EAB6   B7 20                      CPI  A,$20
EAB8   9B 1B                      BZS USING_FRMT_7 ; $EA9F
EABA   B7 2D                      CPI  A,$2D
EABC   9B 1F                      BZS USING_FRMT_7 ; $EA9F
EABE   B7 2B                      CPI  A,$2B
EAC0   9B 23                      BZS USING_FRMT_7 ; $EA9F
EAC2   8E 08                      BCH USING_FRMT_9: ; $EACC
EAC4   8B 06                      BZS USING_FRMT_9: ; $EACC
EAC6   46                         DEC  X
EAC7   52                         DEC  YL
EAC8   5E 1E                      CPI  YL,$1E
EACA   93 17                      BCS USING_FRMT_10 ; $EAB5

USING_FRMT_9: ; $EACC
EACC   FB                         SEC
EACD   9A                         RTN

USING_FRMT_2: ; $EACE
EACE   BE EC 3C                   SJP  (BCMD_DEC9)
EAD1   83 09                      BCS USING_FRMT_11 ; $EADC
EAD3   B5 0A                      LDI  A,$0A
EAD5   CD 86                      VMJ  ($86)($43)
EAD7   BE EC 2F                   SJP  (TRUNCDEC)
EADA   9E 42                      BCH USING_FRMT_12 ; $EA9A

USING_FRMT_11: ; $EADC
EADC   4A 00                      LDI  XL,$00
EADE   05                         LDA  (X)
EADF   49 00                      ANI  (X),$00
EAE1   FD C8                      PSH  A
EAE3   B5 0A                      LDI  A,$0A
EAE5   CD 86                      VMJ  ($86)($43)
EAE7   BE EC 2F                   SJP  (TRUNCDEC)

USING_FRMT_17: ; $EAEA
EAEA   54                         INC  Y
EAEB   FD 8A                      POP  A
EAED   AE 7A 00                   STA  (ARX)
EAF0   2A                         STA  UL
EAF1   FD 8A                      POP  A
EAF3   FD C8                      PSH  A
EAF5   8B 27                      BZS USING_FRMT_13 ; $EB1E

USING_FRMT_15: ; $EAF7
EAF7   B5 45                      LDI  A,$45
EAF9   51                         SIN  Y
EAFA   FD 88                      PSH  X
EAFC   FD 98                      PSH  Y
EAFE   24                         LDA  UL
EAFF   FD C8                      PSH  A
EB01   CD 80                      VMJ  ($80)($40)
EB03   FD 8A                      POP  A
EB05   2A                         STA  UL
EB06   68 00                      LDI  UH,$00
EB08   D9                         SHL
EB09   81 02                      BCR USING_FRMT_14 ; $EB0D
EB0B   68 FF                      LDI  UH,$FF

USING_FRMT_14: ; $EB0D
EB0D   FD 1A                      POP  Y
EB0F   CD 10 E0                   VMJ  ($10) \ ABYT($E0)
EB12   FD 98                      PSH  Y
EB14   BE F7 37                   SJP  (XFER_ARY2ARX)
EB17   FD 1A                      POP  Y
EB19   56                         DEC  Y
EB1A   FD 0A                      POP  X
EB1C   9E 84                      BCH USING_FRMT_12 ; $EA9A

USING_FRMT_13: ; $EB1E
EB1E   5E 27                      CPI  YL,$27
EB20   91 2B                      BCR USING_FRMT_15 ; $EAF7
EB22   5A 26                      LDI  YL,$26
EB24   9E 2F                      BCH USING_FRMT_15 ; $EAF7

USING_FRMT_3: ; $EB26
EB26   4A 00                      LDI  XL,$00
EB28   05                         LDA  (X)
EB29   49 00                      ANI  (X),$00
EB2B   FD C8                      PSH  A
EB2D   A5 78 98                   LDA  (USINGMD)
EB30   B7 0E                      CPI  A,$0E
EB32   81 02                      BCR USING_FRMT_16 ; $EB36
EB34   B5 0D                      LDI  A,$0D

USING_FRMT_16: ; $EB36
EB36   CD 86                      VMJ  ($86)($43)
EB38   A4                         LDA  UH
EB39   1A                         STA  YL
EB3A   9E 52                      BCH USING_FRMT_17 ; $EAEA

USING_FRMT_4: ; $EB3C
EB3C   FD 8A                      POP  A
EB3E   FB                         SEC
EB3F   9A                         RTN



ARX2ASCII: ; $EB40
EB40   F9                         REC
EB41   B3 1E                      ADI  A,$1E
EB43   28                         STA  UH
EB44   CD 80                      VMJ  ($80)($40)
EB46   4A 31                      LDI  XL,$31
EB48   05                         LDA  (X)
EB49   49 00                      ANI  (X),$00
EB4B   FD C8                      PSH  A
EB4D   46                         DEC  X
EB4E   05                         LDA  (X)
EB4F   BF 80                      BII  A,$80
EB51   89 79                      BZR ARX2ASCII_1 ; $EBCC
EB53   ED 78 95 10                BII  (USINGF),$10
EB57   89 32                      BZR ARX2ASCII_2 ; $EB8B
EB59   B7 0E                      CPI  A,$0E
EB5B   93 21                      BCS USING_FRMT_4 ; $EB3C

ARX2ASCII_9: ; $EB5D
EB5D   BD FF                      EAI  $FF
EB5F   B3 1E                      ADI  A,$1E
EB61   1A                         STA  YL
EB62   FD C8                      PSH  A
EB64   54                         INC  Y

ARX2ASCII_15: ; $EB65
EB65   B5 09                      LDI  A,$09

ARX2ASCII_5: ; $EB67
EB67   FD C8                      PSH  A
EB69   BE F7 8C                   SJP  (ARS_SHL_4BITS)
EB6C   F1                         AEX
EB6D   B9 0F                      ANI  A,$0F
EB6F   BB 30                      ORI  A,$30
EB71   51                         SIN  Y

ARX2ASCII_8: ; $EB72
EB72   A4                         LDA  UH
EB73   16                         CPA  YL
EB74   81 B5                      BCR ARX2ASCII_3 ; $EC2B
EB76   5E 1F                      CPI  YL,$1F
EB78   8B 0E                      BZS ARX2ASCII_4 ; $EB88
EB7A   FD 8A                      POP  A
EB7C   DF                         DEC  A
EB7D   93 18                      BCS ARX2ASCII_5 ; $EB67

ARX2ASCII_6: ; $EB7F
EB7F   B5 30                      LDI  A,$30
EB81   51                         SIN  Y
EB82   A4                         LDA  UH
EB83   16                         CPA  YL
EB84   93 07                      BCS ARX2ASCII_6 ; $EB7F
EB86   8E 64                      BCH ARX2ASCII_7 ; $EBEC

ARX2ASCII_4: ; $EB88
EB88   54                         INC  Y
EB89   9E 19                      BCH ARX2ASCII_8 ; $EB72

ARX2ASCII_2: ; $EB8B
EB8B   B7 0B                      CPI  A,$0B
EB8D   93 53                      BCS USING_FRMT_4 ; $EB3C
EB8F   B7 03                      CPI  A,$03
EB91   91 36                      BCR ARX2ASCII_9 ; $EB5D
EB93   B7 06                      CPI  A,$06
EB95   81 87                      BCR ARX2ASCII_10 ; $EC1E
EB97   B7 09                      CPI  A,$09
EB99   B3 02                      ADI  A,$02

ARX2ASCII_21: ; $EB9B
EB9B   F9                         REC
EB9C   BD FF                      EAI  $FF
EB9E   B3 1E                      ADI  A,$1E
EBA0   1A                         STA  YL
EBA1   FD C8                      PSH  A
EBA3   54                         INC  Y
EBA4   B5 09                      LDI  A,$09

ARX2ASCII_12: ; $EBA6
EBA6   FD C8                      PSH  A
EBA8   BE F7 8C                   SJP  (ARS_SHL_4BITS)
EBAB   F1                         AEX
EBAC   B9 0F                      ANI  A,$0F
EBAE   BB 30                      ORI  A,$30
EBB0   51                         SIN  Y

ARX2ASCII_13: ; $EBB1
EBB1   A4                         LDA  UH
EBB2   16                         CPA  YL
EBB3   81 76                      BCR ARX2ASCII_3 ; $EC2B
EBB5   5E 1F                      CPI  YL,$1F
EBB7   9B 31                      BZS ARX2ASCII_4 ; $EB88
EBB9   14                         LDA  YL
EBBA   BD FF                      EAI  $FF
EBBC   BF 03                      BII  A,$03
EBBE   8B 07                      BZS ARX2ASCII_11 ; $EBC7
EBC0   FD 8A                      POP  A
EBC2   DF                         DEC  A
EBC3   93 1F                      BCS ARX2ASCII_12 ; $EBA6
EBC5   9E 48                      BCH ARX2ASCII_6 ; $EB7F

ARX2ASCII_11: ; $EBC7
EBC7   B5 2C                      LDI  A,$2C
EBC9   51                         SIN  Y
EBCA   9E 1B                      BCH ARX2ASCII_13 ; $EBB1

ARX2ASCII_1: ; $EBCC
EBCC   2A                         STA  UL
EBCD   5A 1E                      LDI  YL,$1E
EBCF   A5 78 96                   LDA  (USINGM)
EBD2   B7 01                      CPI  A,$01
EBD4   8B 03                      BZS ARX2ASCII_14 ; $EBD9
EBD6   B5 30                      LDI  A,$30
EBD8   53                         SDE  Y

ARX2ASCII_14: ; $EBD9
EBD9   14                         LDA  YL
EBDA   FD C8                      PSH  A
EBDC   24                         LDA  UL
EBDD   BD FF                      EAI  $FF
EBDF   2A                         STA  UL
EBE0   5A 20                      LDI  YL,$20

ARX2ASCII_16: ; $EBE2
EBE2   62                         DEC  UL
EBE3   91 80                      BCR ARX2ASCII_15 ; $EB65
EBE5   B5 30                      LDI  A,$30
EBE7   51                         SIN  Y
EBE8   A4                         LDA  UH
EBE9   16                         CPA  YL
EBEA   93 0A                      BCS ARX2ASCII_16 ; $EBE2

ARX2ASCII_7: ; $EBEC
EBEC   B5 2E                      LDI  A,$2E
EBEE   AE 7A 1F                   STA  (ARU + $07)
EBF1   FD 8A                      POP  A
EBF3   1A                         STA  YL
EBF4   A5 78 96                   LDA  (USINGM)
EBF7   8B 19                      BZS ARX2ASCII_17 ; $EC12
EBF9   BD FF                      EAI  $FF
EBFB   B3 20                      ADI  A,$20
EBFD   0A                         STA  XL
EBFE   05                         LDA  (X)
EBFF   B7 20                      CPI  A,$20
EC01   99 C7                      BZR USING_FRMT_4 ; $EB3C
EC03   ED 78 95 40                BII  (USINGF),$40
EC07   8B 0B                      BZS ARX2ASCII_18 ; $EC14

ARX2ASCII_19: ; $EC09
EC09   04                         LDA  XL
EC0A   16                         CPA  YL
EC0B   8B 07                      BZS ARX2ASCII_18 ; $EC14
EC0D   B5 2A                      LDI  A,$2A
EC0F   53                         SDE  Y
EC10   9E 09                      BCH ARX2ASCII_19 ; $EC09

ARX2ASCII_17: ; $EC12
EC12   FD 18                      LDX  Y

ARX2ASCII_18: ; $EC14
EC14   FD 8A                      POP  A
EC16   D9                         SHL
EC17   81 08                      BCR ARX2ASCII_20 ; $EC21
EC19   B5 2D                      LDI  A,$2D

ARX2ASCII_23: ; $EC1B
EC1B   1E                         STA  (Y)

ARX2ASCII_22: ; $EC1C
EC1C   F9                         REC
EC1D   9A                         RTN

ARX2ASCII_10: ; $EC1E
EC1E   DD                         INC  A
EC1F   9E 86                      BCH ARX2ASCII_21 ; $EB9B

ARX2ASCII_20: ; $EC21
EC21   ED 78 95 20                BII  (USINGF),$20
EC25   9B 0B                      BZS ARX2ASCII_22 ; $EC1C
EC27   B5 2B                      LDI  A,$2B
EC29   9E 10                      BCH ARX2ASCII_23 ; $EC1B

ARX2ASCII_3: ; $EC2B
EC2B   FD 8A                      POP  A
EC2D   9E 43                      BCH ARX2ASCII_7 ; $EBEC



TRUNCDEC: ; $EC2F
EC2F   5A 28                      LDI  YL,$28

TRUNCDEC_1: ; $EC31
EC31   57                         LDE  Y
EC32   B7 30                      CPI  A,$30
EC34   9B 05                      BZS TRUNCDEC_1 ; $EC31
EC36   B7 2E                      CPI  A,$2E
EC38   8B 01                      BZS TRUNCDEC_2 ; $EC3B
EC3A   54                         INC  Y

TRUNCDEC_2: ;$EC3B
EC3B   9A                         RTN



BCMD_DEC9: ; $DEC9
EC3C   A5 7A 00                   LDA  (ARX)
EC3F   BF 80                      BII  A,$80
EC41   89 03                      BZR BCMD_DEC9_1 ; $EC46
EC43   B7 0A                      CPI  A,$0A
EC45   9A                         RTN

BCMD_DEC9_1: ; $EC46
EC46   B7 F7                      CPI  A,$F7
EC48   81 4B                      BCR XP_STROUT_1 ; $EC95
EC4A   B3 0C                      ADI  A,$0C
EC4C   D5                         SHR
EC4D   1A                         STA  YL
EC4E   55                         LIN  Y
EC4F   83 08                      BCS BCMD_DEC9_2 ; $EC59
EC51   BF 0F                      BII  A,$0F

BCMD_DEC9_3: ; $EC53
EC53   89 40                      BZR XP_STROUT_1 ; $EC95
EC55   5E 07                      CPI  YL,$07
EC57   93 3D                      BCS ARX2ASCII_22 ; $EC1C

BCMD_DEC9_2: ; $EC59
EC59   55                         LIN  Y
EC5A   9E 09                      BCH BCMD_DEC9_3 ; $EC53



X_STROUT: ; $EC5C
EC5C   A5 78 8F                   LDA  ($788F)
EC5F   1A                         STA  YL
EC60   58 7B                      LDI  YH,$7B
EC62   8E 05                      BCH X_STROUT_1 ; $EC69

X_STROUT_3: ; $EC64
EC64   5E B0                      CPI  YL,$B0
EC66   83 03                      BCS X_STROUT_2 ; $EC6B
EC68   F5                         TIN

X_STROUT_1: ; $EC69
EC69   88 07                      LOP  UL,X_STROUT_3 ; $EC64

X_STROUT_2: ; $EC6B
EC6B   9A                         RTN



ARX2BCD: ; $EC6C
EC6C   D2 03 80                   VEJ  (D2) \ ABRF(ARX2BCD_1) \ ABYT($80)
EC6F   F9                         REC
EC70   9A                         RTN
EC71   DC                         VEJ  (DC)

ARX2BCD_1: ; $EC72
EC72   FB                         SEC
EC73   9A                         RTN



ARXBCD2ASCII: ; $EC74
EC74   BE EC 6C                   SJP  (ARX2BCD)
EC77   81 1D                      BCR $EC96
EC79   2A                         STA  UL
EC7A   A5 78 97                   LDA  (USING_CHR)
EC7D   8B 19                      BZS $EC98
EC7F   26                         CPA  UL
EC80   81 15                      BCR $EC97



XP_STROUT: ; $EC82
EC82   20                         SBC  UL
EC83   FD C8                      PSH  A
EC85   CD 94                      VMJ  ($94)($4A)
EC87   FD 8A                      POP  A
EC89   2A                         STA  UL
EC8A   B5 20                      LDI  A,$20
EC8C   8E 05                      BCH XP_STROUT_3 ; $EC93
EC8E   5E B0                      CPI  YL,$B0
EC90   83 04                      BCS XP_STROUT_2 ; $EC96
EC92   51                         SIN  Y

XP_STROUT_3: ; $EC93
EC93   88 07                      LOP  UL,$EC8E


XP_STROUT_1: ; $EC82
EC95   FB                         SEC

XP_STROUT_2: ; $EC96
EC96   9A                         RTN
EC97   2A                         STA  UL
EC98   CD 94                      VMJ  ($94)($4A)
EC9A   9E 07                      BCH XP_STROUT_1 ; $EC95



CLRNOCURSOR: ; $EC9C
EC9C   ED 78 74 01                BII  (CURSOR_ENA),$01
ECA0   89 05                      BZR $ECA7
ECA2   F2                         VEJ  (F2)
ECA3   E9 78 75 00                ANI  (CURSOR_PTR),$00
ECA7   A5 78 8F                   LDA  ($788F)
ECAA   FB                         SEC
ECAB   B1 60                      SBI  A,$60
ECAD   9A                         RTN



INIT_CURS: ; $ECAE
ECAE   E9 78 74 FE                ANI  (CURSOR_ENA),$FE



INIT_MTRX: ; $ECB2
ECB2   E9 78 75 00                ANI  (CURSOR_PTR),$00
ECB6   9A                         RTN



ARX2OUTBUF: ; $ECB7
ECB7   BE EC 6C                   SJP  (ARX2BCD)
ECBA   81 18                      BCR ARX2OUTBUF_1 ; $ECD4
ECBC   2A                         STA  UL
ECBD   A5 78 97                   LDA  (USING_CHR)
ECC0   8B 04                      BZS ARX2OUTBUF_2 ; $ECC6
ECC2   B7 0E                      CPI  A,$0E
ECC4   81 02                      BCR ARX2OUTBUF_3 ; $ECC8

ARX2OUTBUF_2: ; $ECC6
ECC6   B5 0D                      LDI  A,$0D

ARX2OUTBUF_3: ; $ECC8
ECC8   26                         CPA  UL
ECC9   83 01                      BCS ARX2OUTBUF_4 ; $ECCC
ECCB   2A                         STA  UL

ARX2OUTBUF_4: ; $ECCC
ECCC   B5 0D                      LDI  A,$0D
ECCE   FB                         SEC
ECCF   BE EC 82                   SJP  (XP_STROUT)
ECD2   8E 09                      BCH ARX2OUTBUF_F_1 ; $ECDD

ARX2OUTBUF_1: ; $ECD4
ECD4   B5 00                      LDI  A,$00



ARX2OUTBUF_F: ; $ECD6
ECD6   CD 96                      VMJ  ($96)($4B)
ECD8   83 08                      BCS ARX2OUTBUF_F_2 ; $ECE2
ECDA   2A                         STA  UL
ECDB   CD 94                      VMJ  ($94)($4A)

ARX2OUTBUF_F_1: ; $ECDD
ECDD   14                         LDA  YL
ECDE   AE 78 8F                   STA  ($788F)
ECE1   F9                         REC

ARX2OUTBUF_F_2: ; $ECE2
ECE2   9A                         RTN



ARXASCII2OUTBUF: ; $ECE3
ECE3   CD 98                      VMJ  ($98)($4C)
ECE5   93 0A                      BCS ARX2OUTBUF_F_1 ; $ECDD
ECE7   B5 01                      LDI  A,$01
ECE9   9E 15                      BCH ARX2OUTBUF_F



USING_PARAM: ; $ECEB
ECEB   C4 F0 85 06                VEJ  (C4) \ AWRD($F085) \ ABRF($ECF5)
ECEF   BE DA B2                   SJP  (EVAL_USING)
ECF2   05                         LDA  (X)
ECF3   F9                         REC
ECF4   9A                         RTN
ECF5   C6                         VEJ  (C6)
ECF6   F9                         REC
ECF7   9A                         RTN
ECF8   FB                         SEC
ECF9   9A                         RTN



OUTBUF2LCD: ; $ECFA
ECFA   B5 1A                      LDI  A,$1A
ECFC   68 7B                      LDI  UH,$7B
ECFE   6A 60                      LDI  UL,$60



TEXTUREG_A: ; $ED00
ED00   FD C8                      PSH  A
ED02   CD 8C                      VMJ  ($8C)($46)
ED04   FD 8A                      POP  A
ED06   FD 98                      PSH  Y
ED08   FD C8                      PSH  A
ED0A   66                         DEC  U

TEXTUREG_A4: ; $ED0B
ED0B   64                         INC  U
ED0C   A5 78 7B                   LDA  ($787B)
ED0F   26                         CPA  UL
ED10   8B 16                      BZS TEXTUREG_A1 ; $ED28
ED12   FD 8A                      POP  A
ED14   DF                         DEC  A
ED15   81 21                      BCR TEXTUREG_A2 ; $ED38
ED17   FD C8                      PSH  A
ED19   FD A8                      PSH  U
ED1B   25                         LDA  (U)
ED1C   CD 8A                      VMJ  ($8A)($45)
ED1E   FD 2A                      POP  U
ED20   83 14                      BCS TEXTUREG_A3 ; $ED36
ED22   EF 78 75 06                ADI  (CURSOR_PTR),$06
ED26   9E 1D                      BCH TEXTUREG_A4 ; $ED0B

TEXTUREG_A1: ; $ED28
ED28   84                         LDA  XH
ED29   AE 78 7E                   STA  (CURS_POS_NBUF_H)
ED2C   04                         LDA  XL
ED2D   AE 78 7F                   STA  (CURS_POS_NBUF_L)
ED30   25                         LDA  (U)
ED31   AE 78 7D                   STA  (BLNKD_CHAR_CODE)
ED34   9E 24                      BCH $ED12

TEXTUREG_A3: ; $ED36
ED36   FD 8A                      POP  A

TEXTUREG_A2: ; $ED38
ED38   FD 1A                      POP  Y
ED3A   9A                         RTN



TEXTUREG_XL: ; $
ED3B   A5 78 75                   LDA  (CURSOR_PTR)
ED3E   E9 78 75 00                ANI  (CURSOR_PTR),$00
ED42   FD C8                      PSH  A
ED44   04                         LDA  XL
ED45   CD 92                      VMJ  ($92)($49)
ED47   FD 8A                      POP  A
ED49   AE 78 75                   STA  (CURSOR_PTR)
ED4C   9A                         RTN



CHAR2COL: ; $ED4D
ED4D   BE ED 57                   SJP  (CHARA2COL)
ED50   93 A0                      BCS INIT_MTRX
ED52   EF 78 75 06                ADI  (CURSOR_PTR),$06
ED56   9A                         RTN



CHARA2COL: ; $ED57
ED57   28                         STA  UH
ED58   CD 8C                      VMJ  ($8C)($46)
ED5A   A4                         LDA  UH



CHARA2COLX: ; $ED5B
ED5B   FD 98                      PSH  Y
ED5D   BE EE 48                   SJP  (CHAR2ADDR)
ED60   6A 04                      LDI  UL,$04

CHARA2COLX_2: ; $ED62
ED62   55                         LIN  Y
ED63   CD 88                      VMJ  ($88)($44)
ED65   4C 78                      CPI  XH,$78
ED67   83 08                      BCS CHARA2COLX_1 ; $ED71
ED69   88 09                      LOP  UL,CHARA2COLX_2 ; $ED62
ED6B   B5 00                      LDI  A,$00
ED6D   CD 88                      VMJ  ($88)($44)
ED6F   4C 78                      CPI  XH,$78

CHARA2COLX_1: ; $ED71
ED71   B8                         RPV
ED72   ED 79 D0 01                BII  (PU_PV),$01
ED76   8B 01                      BZS $ED79 ; CHARA2COLX_3
ED78   A8                         SPV

CHARA2COLX_3: ; $ED79
ED79   FD 81                      SIE
ED7B   9E 45                      BCH TEXTUREG_A2 ; $ED38



A2HEX: ; $ED7D
ED7D   B7 47                      CPI  A,$47
ED7F   83 0C                      BCS A2HEX_1 ; $ED8D
ED81   B7 41                      CPI  A,$41
ED83   83 0D                      BCS A2HEX_2 ; $ED92
ED85   B7 3A                      CPI  A,$3A
ED87   83 04                      BCS A2HEX_1 ; $ED8D
ED89   B7 30                      CPI  A,$30
ED8B   83 02                      BCS A2HEX_3 ; $ED8F

A2HEX_1: ; $ED8D
ED8D   F9                         REC
ED8E   9A                         RTN

A2HEX_3: ; $ED8F
ED8F   B1 30                      SBI  A,$30
ED91   9A                         RTN

A2HEX_2: ; $ED92
ED92   B1 37                      SBI  A,$37
ED94   9A                         RTN



ASCII2HEX: ; $ED95
ED95   FD A8                      PSH  U
ED97   45                         LIN  X
ED98   BE ED 7D                   SJP  (A2HEX)
ED9B   81 0B                      BCR ASCII2HEX_1 ; $EDA8
ED9D   F1                         AEX
ED9E   28                         STA  UH
ED9F   45                         LIN  X
EDA0   BE ED 7D                   SJP  (A2HEX)
EDA3   81 03                      BCR ASCII2HEX_1 ; $EDA8
EDA5   F9                         REC
EDA6   A2                         ADC  UH
EDA7   FB                         SEC

ASCII2HEX_1: ; $EDA8
EDA8   FD 2A                      POP  U
EDAA   9A                         RTN



MTRXNRANGE: ; $EDAB
EDAB   A5 78 75                   LDA  (CURSOR_PTR)
EDAE   B7 9C                      CPI  A,$9C
EDB0   9A                         RTN



MTRXINC: ; $EDB1
EDB1   A5 78 75                   LDA  (CURSOR_PTR)
EDB4   DD                         INC  A
EDB5   83 02                      BCS MTRXINC_1 ; $EDB9
EDB7   B7 9C                      CPI  A,$9C

MTRXINC_1: ; $EDB9
EDB9   81 02                      BCR $EDBD
EDBB   B5 9C                      LDI  A,$9C

MTRXINC_2: ; $EDBD
EDBD   AE 78 75                   STA  (CURSOR_PTR)
EDC0   9A                         RTN



LCDCACHE: ; $EDC1
EDC1   FD 98                      PSH  Y

LCDCACHE_3: ; $EDC3
EDC3   FB                         SEC
EDC4   58 7B                      LDI  YH,$7B
EDC6   5A 10                      LDI  YL,$10
EDC8   48 76                      LDI  XH,$76

LCDCACHE_2: ; $EDCA
EDCA   4A 00                      LDI  XL,$00
EDCC   6A 4D                      LDI  UL,$4D

LCDCACHE_1: ; $EDCE
EDCE   F5                         TIN
EDCF   88 03                      LOP  UL,LCDCACHE_1 ; $EDCE
EDD1   91 9B                      BCR TEXTUREG_A2 ; $ED38
EDD3   F9                         REC
EDD4   48 77                      LDI  XH,$77
EDD6   9E 0E                      BCH LCDCACHE_2 ; $EDCA



BCMD_BFF: ; $EDD8
EDD8   FD 98                      PSH  Y

BCMD_BFF_3: ; $EDDA
EDDA   FB                         SEC
EDDB   48 7B                      LDI  XH,$7B
EDDD   4A 10                      LDI  XL,$10
EDDF   58 76                      LDI  YH,$76

BCMD_BFF_2: ; $EDE1
EDE1   5A 00                      LDI  YL,$00
EDE3   6A 4D                      LDI  UL,$4D

BCMD_BFF_1: ; $EDD8
EDE5   F5                         TIN
EDE6   88 03                      LOP  UL,BCMD_BFF_1 ; $EDE5
EDE8   91 B2                      BCR TEXTUREG_A2 ; $ED38
EDEA   F9                         REC
EDEB   58 77                      LDI  YH,$77
EDED   9E 0E                      BCH BCMD_BFF_2 ; $EDE1



HEX2COL: ; $EDEF
EDEF   28                         STA  UH
EDF0   CD 8C                      VMJ  ($8C)($46)
EDF2   A4                         LDA  UH
EDF3   8E 01                      BCH GPRNT_A_2LCD
EDF5   55                         LIN  Y



GPRNT_A_2LCD: ; $EDF6
EDF6   28                         STA  UH
EDF7   B9 0F                      ANI  A,$0F
EDF9   4C 76                      CPI  XH,$76
EDFB   83 16                      BCS GPRNT_A_2LCD_1 ; $EE13
EDFD   49 F0                      ANI  (X),$F0
EDFF   0B                         ORA  (X)
EE00   41                         SIN  X
EE01   A4                         LDA  UH
EE02   F1                         AEX
EE03   B9 0F                      ANI  A,$0F
EE05   49 F0                      ANI  (X),$F0

GPRNT_A_2LCD_3: ; $EE07
EE07   0B                         ORA  (X)
EE08   41                         SIN  X
EE09   4E 4E                      CPI  XL,$4E
EE0B   83 01                      BCS GPRNT_A_2LCD_2 ; $EE0E
EE0D   9A                         RTN

GPRNT_A_2LCD_2: ; $EE0E
EE0E   4A 00                      LDI  XL,$00
EE10   FD 40                      INC  XH
EE12   9A                         RTN

GPRNT_A_2LCD_1: ; $EE13
EE13   F1                         AEX
EE14   49 0F                      ANI  (X),$0F
EE16   0B                         ORA  (X)
EE17   41                         SIN  X
EE18   A4                         LDA  UH
EE19   B9 F0                      ANI  A,$F0
EE1B   49 0F                      ANI  (X),$0F
EE1D   9E 18                      BCH GPRNT_A_2LCD_3 ; $EE07



MATRIX_PTR2XREG: ; $EE1F
EE1F   A5 78 75                   LDA  (CURSOR_PTR)



MATRIX_A2XREG: ; $EE22
EE22   B7 4E                      CPI  A,$4E
EE24   83 10                      BCS MATRIX_A2XREG_1 ; $EE36
EE26   B7 27                      CPI  A,$27
EE28   83 05                      BCS MATRIX_A2XREG_2 ; $EE2F
EE2A   48 74                      LDI  XH,$74
EE2C   D9                         SHL
EE2D   0A                         STA  XL
EE2E   9A                         RTN

MATRIX_A2XREG_2: ; $EE2F
EE2F   B1 27                      SBI  A,$27
EE31   48 75                      LDI  XH,$75
EE33   D9                         SHL
EE34   0A                         STA  XL
EE35   9A                         RTN

MATRIX_A2XREG_1: ; $EE36
EE36   B7 75                      CPI  A,$75
EE38   83 07                      BCS MATRIX_A2XREG_3 ; $EE41
EE3A   B1 4D                      SBI  A,$4D
EE3C   48 76                      LDI  XH,$76
EE3E   D9                         SHL
EE3F   0A                         STA  XL
EE40   9A                         RTN

MATRIX_A2XREG_3: ; $EE41
EE41   B1 75                      SBI  A,$75
EE43   48 77                      LDI  XH,$77
EE45   D9                         SHL
EE46   0A                         STA  XL
EE47   9A                         RTN



CHAR2ADDR: ; $EE48
EE48   D9                         SHL
EE49   83 0F                      BCS CHAR2ADDR_1 ; $EE5A

CHAR2ADDR_6: ; $EE4B
EE4B   58 FC                      LDI  YH,$FC
EE4D   B7 40                      CPI  A,$40
EE4F   83 02                      BCS CHAR2ADDR_2 ; $EE53
EE51   B5 40                      LDI  A,$40

CHAR2ADDR_2: ; $EE53
EE53   1A                         STA  YL

CHAR2ADDR_5: ; $EE54
EE54   FD DA                      ADR  Y
EE56   D5                         SHR
EE57   FD DA                      ADR  Y
EE59   9A                         RTN

CHAR2ADDR_1: ; $EE5A
EE5A   1A                         STA  YL
EE5B   A5 78 5D                   LDA  (KATAFLAGS)
EE5E   D9                         SHL
EE5F   89 0D                      BZR CHAR2ADDR_3 ; $EE6E
EE61   FD BE                      RIE
EE63   B8                         RPV
EE64   81 01                      BCR CHAR2ADDR_4 ; $EE67
EE66   A8                         SPV

CHAR2ADDR_4: ; $EE67
EE67   A5 78 5E                   LDA  (KATACHAR)
EE6A   18                         STA  YH
EE6B   14                         LDA  YL
EE6C   9E 1A                      BCH CHAR2ADDR_5 ; $EE54

CHAR2ADDR_3: ; $EE6E
EE6E   14                         LDA  YL
EE6F   9E 26                      BCH CHAR2ADDR_6 ; $EE4B



LCDCLR: ; $EE71
EE71   68 76                      LDI  UH,$76
EE73   BE EE 78                   SJP  (LCDCLRRNG)
EE76   68 77                      LDI  UH,$77



LCDCLRRNG: ; $EE78
EE78   6A 4D                      LDI  UL,$4D
EE7A   B5 00                      LDI  A,$00

LCDCLRRNG_1: ; $EE7C
EE7C   2E                         STA  (U)
EE7D   88 03                      LOP  UL,LCDCLRRNG_1 ; $EE7C
EE7F   9A                         RTN



SAVELCD2BUF: ; $EE80
EE80   E9 7A 07 00                ANI  (ARX + $07),$00
EE84   EB 78 74 80                ORI  (CURSOR_ENA),$80
EE88   FD 98                      PSH  Y
EE8A   48 78                      LDI  XH,$78
EE8C   4A 7C                      LDI  XL,$7C
EE8E   58 78                      LDI  YH,$78
EE90   5A 6C                      LDI  YL,$6C
EE92   6A 03                      LDI  UL,$03

SAVELCD2BUF_1: ; $EE94
EE94   F5                         TIN
EE95   88 03                      LOP  UL,SAVELCD2BUF_1 ; $EE94
EE97   9E D6                      BCH LCDCACHE_3 ; $EDC3



BUF2LCD: ; $EE99
EE99   ED 78 74 80                BII  (CURSOR_ENA),$80
EE9D   8B 21                      BZS LCDCHRLEFT_1 ; $EEC0
EE9F   FD 98                      PSH  Y
EEA1   48 78                      LDI  XH,$78
EEA3   4A 6C                      LDI  XL,$6C
EEA5   58 78                      LDI  YH,$78
EEA7   5A 7C                      LDI  YL,$7C
EEA9   6A 03                      LDI  UL,$03

BUF2LCD_1: ; $EEAB
EEAB   F5                         TIN
EEAC   88 03                      LOP  UL,BUF2LCD_1 ; $EEAB
EEAE   9E D6                      BCH BCMD_BFF_3 ; $EDDA



LCDCHRLEFT: ; $EEB0
EEB0   6A 19                      LDI  UL,$19
EEB2   A5 78 75                   LDA  (CURSOR_PTR)
EEB5   8B 0E                      BZS LCDCHRLEFT_2 ; $EEC5
EEB7   DF                         DEC  A
EEB8   68 06                      LDI  UH,$06
EEBA   FB                         SEC

LCDCHRLEFT_4: ; $EEBB
EEBB   A0                         SBC  UH
EEBC   81 04                      BCR LCDCHRLEFT_3 ; $EEC2
EEBE   88 05                      LOP  UL,LCDCHRLEFT_4 ; $EEBB

LCDCHRLEFT_1: ; $EEC0
EEC0   FB                         SEC
EEC1   9A                         RTN

LCDCHRLEFT_3: ; $EEC2
EEC2   A2                         ADC  UH
EEC3   89 01                      BZR LCDCHRLEFT_5 ; $EEC6

LCDCHRLEFT_2: ; $EEC5
EEC5   60                         INC  UL

LCDCHRLEFT_5: ; $EEC6
EEC6   24                         LDA  UL
EEC7   9B 09                      BZS LCDCHRLEFT_1 ; $EEC0
EEC9   F9                         REC
EECA   9A                         RTN



BCMD_POINT: ; $EECB
EECB   D0 0A 4B                   VEJ  (D0) \ ABYT($0A) \ ABRF($EF19) ; ***
EECE   BE EE 22                   SJP  (MATRIX_A2XREG)
EED1   4C 76                      CPI  XH,$76
EED3   83 0D                      BCS BCMD_POINT_1 ; $EEE2
EED5   45                         LIN  X
EED6   B9 0F                      ANI  A,$0F
EED8   2A                         STA  UL
EED9   45                         LIN  X
EEDA   B9 0F                      ANI  A,$0F
EEDC   F1                         AEX

BCMD_POINT_3: ; $EEE2
EEDD   F9                         REC
EEDE   22                         ADC  UL
EEDF   BA D9 E4                   JMP  BCMD_LEN_1 ; $D9E4

BCMD_POINT_1: ; $EEE2
EEE2   45                         LIN  X
EEE3   B9 F0                      ANI  A,$F0
EEE5   F1                         AEX
EEE6   2A                         STA  UL
EEE7   45                         LIN  X
EEE8   B9 F0                      ANI  A,$F0
EEEA   9E 0F                      BCH BCMD_POINT_3 ; $EEDD

BCMD_POINT_2: ; $EEEC
EEEC   D5                         SHR
EEED   81 15                      BCR CURSOR_OFF_1 ; $EF04
EEEF   FD 98                      PSH  Y
EEF1   BE EF 05                   SJP  (USING2STK)
EEF4   BA E6 A9                   JMP  BCMD_PAUSE_25 ; $E6A9

BCMD_POINT_1: ; $EEF7
EEF7   E9 78 74 7F                ANI  (CURSOR_ENA),$7F
EEFB   BE EF 35                   SJP  (STK2USING)
EEFE   FD 1A                      POP  Y



CURSOR_OFF: ; $EF00
EF00   E9 78 7C FC                ANI  (CURSOR_BLNK),$FC

CURSOR_OFF_1: ; $EF04
EF04   9A                         RTN



USING2STK: ; $EF05
EF05   48 78                      LDI  XH,$78
EF07   4A 95                      LDI  XL,$95
EF09   FD 1A                      POP  Y
EF0B   6A 02                      LDI  UL,$02

USING2STK_1: ; $EF0D
EF0D   45                         LIN  X
EF0E   FD C8                      PSH  A
EF10   88 05                      LOP  UL,USING2STK_1 ; $EF0D
EF12   46                         DEC  X
EF13   B5 00                      LDI  A,$00
EF15   43                         SDE  X
EF16   43                         SDE  X
EF17   0E                         STA  (X)

USING2STK_2: ; $EF18
EF18   FD 98                      PSH  Y
EF1A   9A                         RTN



ARX2STRNG: ; $EF1B
EF1B   BE EF 05                   SJP  (USING2STK)
EF1E   B5 01                      LDI  A,$01
EF20   CD 96                      VMJ  ($96)($4B)
EF22   2A                         STA  UL
EF23   05                         LDA  (X)
EF24   B7 20                      CPI  A,$20
EF26   89 02                      BZR ARX2STRNG_1 ; $EF2A
EF28   62                         DEC  UL
EF29   44                         INC  X

ARX2STRNG_1: ; $EF2A
EF2A   24                         LDA  UL
EF2B   CD 24                      VMJ  ($24)
EF2D   E9 78 74 7F                ANI  (CURSOR_ENA),$7F
EF31   BE EF 35                   SJP  (STK2USING)
EF34   9A                         RTN



STK2USING: ; $EF35
EF35   48 78                      LDI  XH,$78
EF37   4A 97                      LDI  XL,$97
EF39   FD 1A                      POP  Y
EF3B   6A 02                      LDI  UL,$02

STK2USING_1: ; $EF3D
EF3D   FD 8A                      POP  A
EF3F   43                         SDE  X
EF40   88 05                      LOP  UL,STK2USING_1 ; $EF3D
EF42   9E 2C                      BCH USING2STK_2 ; $EF18



TXT2LCD: ; $EF44
EF44   FD 88                      PSH  X
EF46   B5 00                      LDI  A,$00
EF48   6A 19                      LDI  UL,$19
EF4A   4D FF                      BII  (X),$FF
EF4C   8B 04                      BZS TXT2LCD_1 ; $EF52
EF4E   DD                         INC  A
EF4F   44                         INC  X
EF50   88 08                      LOP  UL,$EF4A

TXT2LCD_1: ; $EF52
EF52   0A                         STA  XL
EF53   F2                         VEJ  (F2)
EF54   FD 2A                      POP  U
EF56   BE ED 3B                   SJP  (TEXTUREG_XL)
EF59   9E 5B                      BCH CURSOR_OFF



TXT2LCD_ARY: ; $EF5B
EF5B   F9                         REC
EF5C   B5 F0                      LDI  A,$F0
EF5E   02                         ADC  XL
EF5F   68 7A                      LDI  UH,$7A
EF61   6A 10                      LDI  UL,$10
EF63   FD A8                      PSH  U
EF65   9E 15                      BCH TXT2LCD_1 ; $EF52



PREPLCDOUT: ; $EF67
EF67   EB 78 8A 10                ORI  (BREAKPARAM),$10
EF6B   ED 78 74 01                BII  (CURSOR_ENA),$01
EF6F   89 01                      BZR PREPLCDOUT_1 ; $EF72
EF71   F2                         VEJ  (F2)

PREPLCDOUT_1: ; $EF72
EF72   E9 78 76 00                ANI  (CHARPOS_LCD),$00
EF76   BE EE B0                   SJP  (LCDCHRLEFT)
EF79   83 05                      BCS PREPLCDOUT_2 ; $EF80
EF7B   BD FF                      EAI  $FF
EF7D   AE 78 77                   STA  ($7877)

PREPLCDOUT_2: ; $EF80
EF80   9A                         RTN



OUTBUFCLR: ; $EF81
EF81   48 7B                      LDI  XH,$7B
EF83   4A 60                      LDI  XL,$60
EF85   6A 4F                      LDI  UL,$4F
EF87   CD BA                      VMJ  ($BA)($5D)
EF89   9A                         RTN

OUTBUFCLR_8: ; $EF8A
EF8A   5A 07                      LDI  YL,$07
EF8C   B5 06                      LDI  A,$06
EF8E   BA F3 BA                   JMP  BCMD_SIN_1 ; $F3BA

OUTBUFCLR_7: ; $EF91
EF91   BA F6 5D                   JMP  ARX2BCD_ABS ; $F65D

OUTBUFCLR_1: ; $EF94
EF94   5E 2B                      CPI  YL,$2B
EF96   8B 04                      BZS OUTBUFCLR_4 ; $EF9C
EF98   EF 7A 11 80                ADI  (ARY + $01),$80

OUTBUFCLR_4: ; $EF9C
EF9C   F0                         VEJ  (F0)

OUTBUFCLR_6: ; $EF9D
EF9D   83 03                      BCS $EFA2
EF9F   BA D8 F0                   JMP  DEC2HEX_113 ; $D8F0
EFA2   BA D8 F2                   JMP  DEC2HEX_91 ; $D8F2

OUTBUFCLR_2: ; $EFA5
EFA5   5E 2A                      CPI  YL,$2A
EFA7   89 04                      BZR OUTBUFCLR_5 ; $EFAD
EFA9   CD 7E                      VMJ  ($7E)($3F)
EFAB   9E 10                      BCH OUTBUFCLR_6 ; $EF9D

OUTBUFCLR_5: ; $EFAD
EFAD   CD 58                      VMJ  ($58)($2C)
EFAF   9E 14                      BCH OUTBUFCLR_6 ; $EF9D

OUTBUFCLR_3: ; $EFB1
EFB1   BE F8 9C                   SJP  ($F89C)
EFB4   9E 19                      BCH OUTBUFCLR_6 ; $EF9D



SUBTR: ; $EFB6
EFB6   EF 7A 11 80                ADI  (ARY + $01),$80



ADDIT: ; $EFBA
EFBA   CD 54                      VMJ  ($54)($2A)
EFBC   4A 02                      LDI  XL,$02
EFBE   5A 12                      LDI  YL,$12
EFC0   47                         LDE  X
EFC1   8B 33                      BZS ADDIT_1 ; $EFF6
EFC3   57                         LDE  Y
EFC4   8B 9F                      BZS MULTIPLY_1 ; $F065
EFC6   CD 7C                      VMJ  ($7C)($3E)
EFC8   05                         LDA  (X)
EFC9   FB                         SEC
EFCA   11                         SBC  (Y)
EFCB   8B 18                      BZS ADDIT_2 ; $EFE5
EFCD   8F 2B                      BVS ADDIT_3 ; $EFFA
EFCF   DB                         ROL

ADDIT_6: ; $EFD0
EFD0   81 2C                      BCR ADDIT_4 ; $EFFE
EFD2   D1                         ROR
EFD3   BD FF                      EAI  $FF
EFD5   DD                         INC  A
EFD6   FD C8                      PSH  A
EFD8   15                         LDA  (Y)
EFD9   0E                         STA  (X)
EFDA   FD 8A                      POP  A
EFDC   4A 07                      LDI  XL,$07

ADDIT_7: ; $EFDE
EFDE   B7 0C                      CPI  A,$0C
EFE0   83 21                      BCS ADDIT_5 ; $F003
EFE2   BE F7 F7                   SJP  (ADD_ARU_ARX_2) ; $F7F7

ADDIT_2: ; $EFE5
EFE5   FD 8A                      POP  A
EFE7   FD C8                      PSH  A
EFE9   D9                         SHL
EFEA   83 20                      BCS PC1500_PRT_A_DIR
EFEC   EE                         VEJ  (EE)

ADDIT_8: ; $EFED
EFED   FD 8A                      POP  A

ADDIT_9: ; $EFEF
EFEF   28                         STA  UH
EFF0   FD 8A                      POP  A
EFF2   F9                         REC
EFF3   A2                         ADC  UH
EFF4   8E 61                      BCH MULTIPLY_2 ; $F057

ADDIT_1: ; $EFF6
EFF6   CD 56                      VMJ  ($56)($2B)
EFF8   9E 69                      BCH OUTBUFCLR_7 ; $EF91

ADDIT_3: ; $EFFA
EFFA   B5 1F                      LDI  A,$1F
EFFC   9E 2E                      BCH ADDIT_6 ; $EFD0

ADDIT_4: ; $EFFE
EFFE   D1                         ROR
EFFF   4A 17                      LDI  XL,$17
F001   9E 25                      BCH ADDIT_7 ; $EFDE

ADDIT_5: ; $F003
F003   04                         LDA  XL
F004   B9 F9                      ANI  A,$F9
F006   0A                         STA  XL
F007   BE F7 61                   SJP  (CLR_7_XREG)
F00A   9E 27                      BCH ADDIT_2 ; $EFE5
F00C   CD 7A                      VMJ  ($7A)($3D)
F00E   93 23                      BCS ADDIT_8 ; $EFED
F010   BE F7 EB                   SJP  (ADD_ARU_ARX_3) ; $F7EB
F013   FD 8A                      POP  A
F015   BD 80                      EAI  $80
F017   9E 2A                      BCH ADDIT_9 ; $EFEF



SQUARE: ; $7174
F019   E6                         VEJ  (E6)



MULTIPLY: ; $F01A
F01A   CD 54                      VMJ  ($54)($2A)
F01C   4A 01                      LDI  XL,$01
F01E   5A 11                      LDI  YL,$11
F020   CD 7C                      VMJ  ($7C)($3E)
F022   15                         LDA  (Y)
F023   F9                         REC
F024   03                         ADC  (X)
F025   8F 33                      BVS MULTIPLY_3 ; $F05A
F027   0E                         STA  (X)
F028   CD 78                      VMJ  ($78)($3C)
F02A   CD 76                      VMJ  ($76)($3B)
F02C   BE F8 20                   SJP  (ADD_ARU_ARX_4) ; $F820
F02F   5A 0F                      LDI  YL,$0F

MULTIPLY_5: ; $F031
F031   FD 98                      PSH  Y
F033   15                         LDA  (Y)
F034   FD C8                      PSH  A
F036   B9 0F                      ANI  A,$0F
F038   F1                         AEX
F039   BE F0 67                   SJP  (ADDMANY)
F03C   CD 74                      VMJ  ($74)($3A)
F03E   FD 8A                      POP  A
F040   B9 F0                      ANI  A,$F0
F042   BE F0 67                   SJP  (ADDMANY)
F045   FD 1A                      POP  Y
F047   56                         DEC  Y
F048   5E 0A                      CPI  YL,$0A
F04A   81 04                      BCR MULTIPLY_4 ; $F050
F04C   CD 74                      VMJ  ($74)($3A)
F04E   9E 1F                      BCH MULTIPLY_5 ; $F031

DIVISION_11: ; $F050
F050   FD 2A                      POP  U
F052   24                         LDA  UL
F053   AE 7A 11                   STA  (ARY + $01)
F056   A4                         LDA  UH

MULTIPLY_2: ; $F057
F057   CD 52                      VMJ  ($52)($29)
F059   9A                         RTN

MULTIPLY_3: ; $F05A
F05A   FD 2A                      POP  U
F05C   83 04                      BCS MULTIPLY_6 ; $F062
F05E   68 25                      LDI  UH,$25
F060   FB                         SEC
F061   9A                         RTN

MULTIPLY_6: ; $F062
F062   EC                         VEJ  (EC)

MULTIPLY_7: ; $F063
F063   68 00                      LDI  UH,$00

MULTIPLY_1: ; $F065
F065   F9                         REC
F066   9A                         RTN



ADDMANY: ; $F067
F067   28                         STA  UH
F068   B5 2F                      LDI  A,$2F

ADDMANY_2: ; $F06A
F06A   FD C8                      PSH  A
F06C   1A                         STA  YL
F06D   A4                         LDA  UH
F06E   D9                         SHL
F06F   28                         STA  UH
F070   81 09                      BCR ADDMANY_1 ; $F07B
F072   CD 72                      VMJ  ($72)($39)

ADDMANY_3: ; $F074
F074   F9                         REC
F075   FD 8A                      POP  A
F077   B3 F8                      ADI  A,$F8
F079   9E 11                      BCH ADDMANY_2 ; $F06A

ADDMANY_1: ; $F07B
F07B   99 09                      BZR ADDMANY_3 ; $F074
F07D   FD 8A                      POP  A
F07F   9A                         RTN



RECIPRICAL: ; $F080
F080   CD 6A                      VMJ  ($6A)($35)
F082   CD 66                      VMJ  ($66)($33)



DIVISION: ; $F084
F084   CD 54                      VMJ  ($54)($2A)
F086   4A 01                      LDI  XL,$01
F088   5A 11                      LDI  YL,$11
F08A   CD 7C                      VMJ  ($7C)($3E)
F08C   ED 7A 12 F0                BII  (ARY + $02),$F0
F090   8B 51                      BZS DIVISION_1 ; $F0E3
F092   F9                         REC
F093   05                         LDA  (X)
F094   11                         SBC  (Y)
F095   9F 3D                      BVS MULTIPLY_3 ; $F05A
F097   0E                         STA  (X)
F098   BE F7 4B                   SJP  (CLR_SM_ARZ)
F09B   BE F8 1C                   SJP  (ADD_ARU_ARX_5) ; $F81C
F09E   B5 0C                      LDI  A,$0C
F0A0   FD C8                      PSH  A

DIVISION_6: ; $F0A2
F0A2   BE F7 D9                   SJP  (ADD_ARU_ARX_6) ; $F7D9
F0A5   83 16                      BCS DIVISION_2 ; $F0BD

DIVISION_8: ; $F0A7
F0A7   BE F7 C8                   SJP  (ADD_ARU_ARX)
F0AA   83 22                      BCS DIVISION_3 ; $F0CE
F0AC   EE                         VEJ  (EE)
F0AD   83 29                      BCS DIVISION_4 ; $F0D8

DIVISION_10: ; $F0AF
F0AF   EE                         VEJ  (EE)

DIVISION_11: ; $F0B0
F0B0   FD 8A                      POP  A
F0B2   DF                         DEC  A
F0B3   81 29                      BCR DIVISION_5 ; $F0DE
F0B5   FD C8                      PSH  A
F0B7   EA                         VEJ  (EA)
F0B8   BE F7 98                   SJP  (ARZ_SHL_4BITS)
F0BB   9E 1B                      BCH DIVISION_6 ; $F0A2

DIVISION_2: ; $F0BD
F0BD   BE F7 D9                   SJP  (ADD_ARU_ARX_6) ; $F7D9
F0C0   83 06                      BCS DIVISION_7 ; $F0C8
F0C2   EB 7A 0F 04                ORI  (ARZ + $07),$04
F0C6   9E 21                      BCH DIVISION_8 ; $F0A7

DIVISION_7: ; $F0C8
F0C8   EB 7A 0F 08                ORI  (ARZ + $07),$08
F0CC   8E 04                      BCH DIVISION_9 ; $F0D2

DIVISION_3: ; $F0CE
F0CE   EB 7A 0F 02                ORI  (ARZ + $07),$02

DIVISION_9: ; $F0D2
F0D2   CD 7A                      VMJ  ($7A)($3D)
F0D4   83 02                      BCS DIVISION_4 ; $F0D8
F0D6   9E 29                      BCH DIVISION_10 ; $F0AF

DIVISION_4: ; $F0D8
F0D8   EB 7A 0F 01                ORI  (ARZ + $07),$01
F0DC   9E 2E                      BCH DIVISION_11 ; $F0B0

DIVISION_5: ; $F0DE
F0DE   BE F7 1F                   SJP  (XFER_SM_ARZ2ARX)
F0E1   9E 93                      BCH DIVISION_11 ; $F050

DIVISION_1: ; $F0E3
F0E3   FD 0A                      POP  X
F0E5   68 26                      LDI  UH,$26
F0E7   FB                         SEC
F0E8   9A                         RTN



SQR_ROOT: ; $F0E9
F0E9   CD 54                      VMJ  ($54)($2A)
F0EB   4A 01                      LDI  XL,$01
F0ED   47                         LDE  X
F0EE   D9                         SHL
F0EF   83 6C                      BCS SQR_ROOT_1 ; $F15D
F0F1   05                         LDA  (X)
F0F2   BF 80                      BII  A,$80
F0F4   8B 01                      BZS SQR_ROOT_2 ; $F0F7
F0F6   FB                         SEC

SQR_ROOT_2: ; $F0F7
F0F7   D1                         ROR
F0F8   0E                         STA  (X)
F0F9   81 01                      BCR SQR_ROOT_3 ; $F0FC
F0FB   EA                         VEJ  (EA)

SQR_ROOT_3: ; $F0FC
F0FC   CD 70                      VMJ  ($70)($38)
F0FE   BE F7 4B                   SJP  (CLR_SM_ARZ)
F101   B5 24                      LDI  A,$24
F103   EB 7A 12 10                ORI  (ARY + $02),$10
F107   8E 26                      BCH SQR_ROOT_4 ; $F12F

SQR_ROOT_9: ; $F109
F109   EE                         VEJ  (EE)
F10A   FD 1A                      POP  Y
F10C   FD 18                      LDX  Y
F10E   04                         LDA  XL
F10F   F9                         REC
F110   B3 F8                      ADI  A,$F8
F112   0A                         STA  XL
F113   FD 8A                      POP  A
F115   B7 0F                      CPI  A,$0F
F117   A4                         LDA  UH
F118   81 06                      BCR SQR_ROOT_5 ; $F120
F11A   F1                         AEX
F11B   0E                         STA  (X)
F11C   5F F1                      ADI  (Y),$F1
F11E   8E 0B                      BCH SQR_ROOT_6 ; $F12B

SQR_ROOT_5: ; $F120
F120   0B                         ORA  (X)
F121   0E                         STA  (X)
F122   5E 17                      CPI  YL,$17
F124   83 30                      BCS SQR_ROOT_7 ; $F156
F126   5F FF                      ADI  (Y),$FF
F128   54                         INC  Y
F129   5B 10                      ORI  (Y),$10

SQR_ROOT_6: ; $F12B
F12B   EA                         VEJ  (EA)
F12C   FD 8A                      POP  A
F12E   DD                         INC  A

SQR_ROOT_4: ; $F12F
F12F   FD C8                      PSH  A
F131   D5                         SHR
F132   1A                         STA  YL
F133   B5 20                      LDI  A,$20
F135   81 02                      BCR SQR_ROOT_8 ; $F139
F137   B5 02                      LDI  A,$02

SQR_ROOT_8: ; $F139
F139   68 00                      LDI  UH,$00
F13B   FD C8                      PSH  A
F13D   FD 98                      PSH  Y

SQR_ROOT_11: ; $F13F
F13F   CD 7A                      VMJ  ($7A)($3D)
F141   91 3A                      BCR SQR_ROOT_9 ; $F109
F143   FD 1A                      POP  Y
F145   FD 8A                      POP  A
F147   FD C8                      PSH  A
F149   FD 98                      PSH  Y
F14B   F9                         REC

SQR_ROOT_10: ; $F14C
F14C   9C                         DCA  (Y)
F14D   53                         SDE  Y
F14E   B5 00                      LDI  A,$00
F150   93 06                      BCS SQR_ROOT_10 ; $F14C
F152   FD 60                      INC  UH
F154   9E 17                      BCH SQR_ROOT_11 ; $F13F

SQR_ROOT_7: ; $F156
F156   BE F7 1F                   SJP  (XFER_SM_ARZ2ARX)
F159   FD 8A                      POP  A
F15B   E8                         VEJ  (E8)
F15C   9A                         RTN

SQR_ROOT_1: ; $F15D
F15D   68 27                      LDI  UH,$27
F15F   8E 5F                      BCH BCMD_LOG_2 ; $F1C0



BCMD_LN: ; $F161
F161   B5 02                      LDI  A,$02
F163   8E 02                      BCH BCMD_LOG_3 ; $F167



BCMD_LOG: ; $F165
F165   B5 00                      LDI  A,$00

BCMD_LOG_3: ; $F167
F167   CD 54                      VMJ  ($54)($2A)
F169   4A 02                      LDI  XL,$02
F16B   4A 02                      LDI  XL,$02
F16D   4D F0                      BII  (X),$F0
F16F   9B 14                      BZS SQR_ROOT_1 ; $F15D
F171   46                         DEC  X
F172   4D FF                      BII  (X),$FF
F174   99 19                      BZR SQR_ROOT_1 ; $F15D
F176   46                         DEC  X
F177   4D 80                      BII  (X),$80
F179   89 47                      BZR BCMD_LOG_4 ; $F1C2
F17B   FD C8                      PSH  A

BCMD_LOG_8: ; $F17D
F17D   05                         LDA  (X)
F17E   FD C8                      PSH  A

BCMD_LOG_1: ; $F180
F180   49 00                      ANI  (X),$00
F182   EF 7A 02 F0                ADI  (ARX + $02),$F0
F186   E8                         VEJ  (E8)
F187   A5 7A 00                   LDA  (ARX)
F18A   BD FF                      EAI  $FF
F18C   DD                         INC  A
F18D   28                         STA  UH
F18E   B5 01                      LDI  A,$01
F190   AE 7A 18                   STA  (ARU)
F193   BA F2 EC                   JMP  EXPONENT_1 ; $F2EC

BCMD_LOG_9: ; $F196
F196   EF 7A 00 FF                ADI  (ARX),$FF
F19A   E8                         VEJ  (E8)
F19B   E6                         VEJ  (E6)
F19C   FD 8A                      POP  A
F19E   2A                         STA  UL
F19F   B5 00                      LDI  A,$00
F1A1   28                         STA  UH
F1A2   83 04                      BCS BCMD_LOG_5 ; $F1A8
F1A4   CD 10 00                   VMJ  ($10) \ ABYT($00)
F1A7   F0                         VEJ  (F0)

BCMD_LOG_5: ; $F1A8
F1A8   FD 8A                      POP  A
F1AA   83 12                      BCS BCMD_LOG_6 ; $F1BE
F1AC   D5                         SHR
F1AD   81 04                      BCR BCMD_LOG_7 ; $F1B3
F1AF   EB 7A 01 80                ORI  (ARX + $01),$80

BCMD_LOG_7: ; $F1B3
F1B3   D5                         SHR
F1B4   81 7A                      BCR EXPONENT_2 ; $F230
F1B6   BE F8 7B                   SJP  (ADD_ARU_ARX_7) ; $F87B
F1B9   CD 58                      VMJ  ($58)($2C)
F1BB   83 01                      BCS BCMD_LOG_6 ; $F1BE
F1BD   9A                         RTN

BCMD_LOG_6: ; $F1BE
F1BE   68 25                      LDI  UH,$25

BCMD_LOG_2: ; $F1C0
F1C0   FB                         SEC
F1C1   9A                         RTN

BCMD_LOG_4: ; $F1C2
F1C2   DD                         INC  A
F1C3   FD C8                      PSH  A
F1C5   CD 6E                      VMJ  ($6E)($37)
F1C7   4A 00                      LDI  XL,$00
F1C9   9E 4E                      BCH BCMD_LOG_8 ; $F17D



BCMD_EXP: ; $F1CB
F1CB   CD 54                      VMJ  ($54)($2A)
F1CD   BE F8 7B                   SJP  (ADD_ARU_ARX_7) ; $F87B
F1D0   CD 7E                      VMJ  ($7E)($3F)
F1D2   93 16                      BCS BCMD_LOG_6 ; $F1BE



EXPONENT: ; $F1D4
F1D4   CD 54                      VMJ  ($54)($2A)
F1D6   CD 6C                      VMJ  ($6C)($36)
F1D8   FD C8                      PSH  A
F1DA   46                         DEC  X
F1DB   05                         LDA  (X)
F1DC   8B 48                      BZS EXPONENT_3 ; $F226
F1DE   BF 80                      BII  A,$80
F1E0   89 40                      BZR EXPONENT_4 ; $F222
F1E2   B7 01                      CPI  A,$01
F1E4   89 43                      BZR EXPONENT_5 ; $F229
F1E6   4A 01                      LDI  XL,$01
F1E8   6A 05                      LDI  UL,$05

EXPONENT_6: ; $F1EA
F1EA   44                         INC  X
F1EB   47                         LDE  X
F1EC   41                         SIN  X
F1ED   88 05                      LOP  UL,EXPONENT_6 ; $F1EA
F1EF   49 00                      ANI  (X),$00

EXPONENT_11: ; $F1F1
F1F1   B5 00                      LDI  A,$00

EXPONENT_10: ; $F1F3
F1F3   28                         STA  UH
F1F4   CD 6C                      VMJ  ($6C)($36)
F1F6   FD C8                      PSH  A
F1F8   B5 01                      LDI  A,$01
F1FA   AE 7A 18                   STA  (ARU)
F1FD   8E 34                      BCH EXPONENT_7 ; $F233

EXPONENT_26: ; $F1FF
F1FF   FD 8A                      POP  A
F201   4A 02                      LDI  XL,$02
F203   43                         SDE  X
F204   04                         LDA  XL
F205   46                         DEC  X
F206   0E                         STA  (X)
F207   E8                         VEJ  (E8)
F208   D0 08 15                   VEJ  (D0) \ ABYT($08) \ ABRF(EXPONENT_8) ; $F220
F20B   48 7A                      LDI  XH,$7A
F20D   24                         LDA  UL
F20E   AE 7A 00                   STA  (ARX)
F211   BE F7 1B                   SJP  (XFER_SM_ARY2ARX)
F214   CD 74                      VMJ  ($74)($3A)
F216   FD 8A                      POP  A

EXPONENT_12: ; $F218
F218   D9                         SHL
F219   81 04                      BCR EXPONENT_9 ; $F21F
F21B   CD 6E                      VMJ  ($6E)($37)
F21D   93 61                      BCS BCMD_LOG_6 ; $F1BE

EXPONENT_9: ; $F21F
F21F   9A                         RTN

EXPONENT_8: ; $F220
F220   9E 64                      BCH BCMD_LOG_6 ; $F1BE

EXPONENT_4: ; $F222
F222   BD FF                      EAI  $FF
F224   9E 33                      BCH EXPONENT_10 ; $F1F3

EXPONENT_3: ; $F226
F226   EA                         VEJ  (EA)
F227   9E 38                      BCH EXPONENT_11 ; $F1F1

EXPONENT_5: ; $F229
F229   EC                         VEJ  (EC)
F22A   FD 8A                      POP  A
F22C   BD 80                      EAI  $80
F22E   9E 18                      BCH EXPONENT_12 ; $F218

EXPONENT_2: ; $F230
F230   BA F0 63                   JMP  MULTIPLY_7 ; $F063

EXPONENT_7: ; $F233
F233   BE F7 4F                   SJP  (CLR_SM_ARW)
F236   CD 70                      VMJ  ($70)($38)
F238   B5 00                      LDI  A,$00
F23A   FD C8                      PSH  A

EXPONENT_18: ; $F23C
F23C   A4                         LDA  UH
F23D   ED 7A 18 01                BII  (ARU),$01
F241   8B 08                      BZS EXPONENT_13 ; $F24B
F243   B7 0D                      CPI  A,$0D
F245   81 0D                      BCR EXPONENT_14 ; $F254
F247   B5 0C                      LDI  A,$0C
F249   8E 09                      BCH EXPONENT_14 ; $F254

EXPONENT_13: ; $F24B
F24B   F9                         REC
F24C   B3 0D                      ADI  A,$0D
F24E   B7 14                      CPI  A,$14
F250   81 02                      BCR EXPONENT_14 ; $F254
F252   B5 13                      LDI  A,$13

EXPONENT_14: ; $F254
F254   D9                         SHL
F255   D9                         SHL
F256   D9                         SHL
F257   BB 07                      ORI  A,$07
F259   FD C8                      PSH  A
F25B   58 FC                      LDI  YH,$FC

EXPONENT_16: ; $F25D
F25D   FD 8A                      POP  A
F25F   FD C8                      PSH  A
F261   1A                         STA  YL
F262   BE F7 DF                   SJP  (ADD_ARU_ARX_8) ; $F7DF
F265   81 06                      BCR EXPONENT_15 ; $F26D
F267   EF 7A 2F 01                ADI  (ARW + $07),$01
F26B   9E 10                      BCH EXPONENT_16 ; $F25D

EXPONENT_15: ; $F26D
F26D   FD 8A                      POP  A
F26F   1A                         STA  YL
F270   CD 72                      VMJ  ($72)($39)
F272   FD 8A                      POP  A
F274   B7 0C                      CPI  A,$0C
F276   83 0B                      BCS EXPONENT_17 ; $F283
F278   DD                         INC  A
F279   FD C8                      PSH  A
F27B   FD 60                      INC  UH
F27D   BE F7 94                   SJP  (ARW_SHL_4BITS)
F280   EA                         VEJ  (EA)
F281   9E 47                      BCH EXPONENT_18 ; $F23C

EXPONENT_17: ; $F283
F283   58 7A                      LDI  YH,$7A
F285   FD C8                      PSH  A
F287   CD 76                      VMJ  ($76)($3B)
F289   CD 70                      VMJ  ($70)($38)
F28B   EB 7A 11 01                ORI  (ARY + $01),$01

EXPONENT_25: ; $F28F
F28F   A4                         LDA  UH
F290   B7 07                      CPI  A,$07
F292   ED 7A 18 01                BII  (ARU),$01
F296   8B 02                      BZS EXPONENT_19 ; $F29A
F298   B7 0D                      CPI  A,$0D

EXPONENT_19: ; $F29A
F29A   81 02                      BCR EXPONENT_20 ; $F29E
F29C   B5 FF                      LDI  A,$FF

EXPONENT_20: ; $F29E
F29E   DD                         INC  A
F29F   AE 7A 08                   STA  (ARZ)

EXPONENT_23: ; $F2A2
F2A2   4A 2F                      LDI  XL,$2F
F2A4   4D 0F                      BII  (X),$0F
F2A6   8B 27                      BZS EXPONENT_21 ; $F2CF
F2A8   4F FF                      ADI  (X),$FF
F2AA   ED 7A 18 01                BII  (ARU),$01
F2AE   8B 08                      BZS EXPONENT_22 ; $F2B8
F2B0   BE F7 25                   SJP  (XFER_SM_ARY2ARZ)
F2B3   BE F8 3C                   SJP  (ADD_ARU_ARX_9) ; $F83C
F2B6   9E 16                      BCH EXPONENT_23 ; $F2A2

EXPONENT_22: ; $F2B8
F2B8   CD 78                      VMJ  ($78)($3C)
F2BA   EE                         VEJ  (EE)
F2BB   A5 7A 08                   LDA  (ARZ)
F2BE   9B 1E                      BZS EXPONENT_23 ; $F2A2
F2C0   DF                         DEC  A
F2C1   4A 0F                      LDI  XL,$0F
F2C3   BE F8 05                   SJP  (ADD_ARU_ARX_10) ; $F805
F2C6   4A 17                      LDI  XL,$17
F2C8   5A 0F                      LDI  YL,$0F
F2CA   BE F7 E1                   SJP  (ADD_ARU_ARX_11) ; $F7E1
F2CD   9E 2D                      BCH EXPONENT_23 ; $F2A2

EXPONENT_21: ; $F2CF
F2CF   FD 8A                      POP  A
F2D1   DF                         DEC  A
F2D2   81 0F                      BCR EXPONENT_24 ; $F2E3
F2D4   FD 62                      DEC  UH
F2D6   FD C8                      PSH  A
F2D8   BE F7 69                   SJP  (ARW_SHR_4BITS)
F2DB   ED 7A 18 01                BII  (ARU),$01
F2DF   CB 74                      VZS  ($74)($3A)
F2E1   9E 54                      BCH EXPONENT_25 ; $F28F

EXPONENT_24: ; $F2E3
F2E3   ED 7A 18 01                BII  (ARU),$01
F2E7   99 EA                      BZR EXPONENT_26 ; $F1FF
F2E9   BA F4 32                   JMP  BCMD_SIN_2 ; $F432

EXPONENT_1: ; $F2EC
F2EC   BE F7 4F                   SJP  (CLR_SM_ARW)
F2EF   CD 6A                      VMJ  ($6A)($35)
F2F1   B5 00                      LDI  A,$00
F2F3   FD C8                      PSH  A

EXPONENT_35: ; $F2F5
F2F5   A4                         LDA  UH
F2F6   B7 07                      CPI  A,$07
F2F8   ED 7A 18 01                BII  (ARU),$01
F2FC   8B 02                      BZS EXPONENT_27 ; $F300
F2FE   B7 0D                      CPI  A,$0D

EXPONENT_27: ; $F300
F300   81 02                      BCR EXPONENT_28 ; $F304
F302   B5 FF                      LDI  A,$FF

EXPONENT_28: ; $F304
F304   DD                         INC  A
F305   AE 7A 08                   STA  (ARZ)
F308   ED 7A 18 01                BII  (ARU),$01
F30C   8B 05                      BZS EXPONENT_29 ; $F313
F30E   8E 16                      BCH EXPONENT_30 ; $F326

EXPONENT_32: ; $F310
F310   BE F8 4D                   SJP  (ADD_ARU_ARX_12) ; $F84D

EXPONENT_29: ; $F313
F313   CD 78                      VMJ  ($78)($3C)

EXPONENT_33: ; $F315
F315   CD 7A                      VMJ  ($7A)($3D)
F317   81 12                      BCR EXPONENT_31 ; $F32B
F319   EF 7A 2F 01                ADI  (ARW + $07),$01
F31D   ED 7A 18 01                BII  (ARU),$01
F321   9B 13                      BZS EXPONENT_32 ; $F310
F323   BE F8 3C                   SJP  (ADD_ARU_ARX_9) ; $F83C

EXPONENT_30: ; $F326
F326   BE F7 25                   SJP  (XFER_SM_ARY2ARZ)
F329   9E 16                      BCH EXPONENT_33 ; $F315

EXPONENT_31: ; $F32B
F32B   EE                         VEJ  (EE)
F32C   FD 8A                      POP  A
F32E   B7 0C                      CPI  A,$0C
F330   83 0B                      BCS EXPONENT_34 ; $F33D
F332   DD                         INC  A
F333   FD C8                      PSH  A
F335   FD 60                      INC  UH
F337   BE F7 94                   SJP  (ARW_SHL_4BITS)
F33A   EA                         VEJ  (EA)
F33B   9E 48                      BCH EXPONENT_35 ; $F2F5

EXPONENT_34: ; $F33D
F33D   FD C8                      PSH  A
F33F   CD 76                      VMJ  ($76)($3B)

EXPONENT_41: ; $F341
F341   A4                         LDA  UH
F342   ED 7A 18 01                BII  (ARU),$01
F346   8B 08                      BZS EXPONENT_36 ; $F350
F348   B7 0D                      CPI  A,$0D
F34A   81 0D                      BCR EXPONENT_37 ; $F359
F34C   B5 0C                      LDI  A,$0C
F34E   8E 09                      BCH EXPONENT_37 ; $F359

EXPONENT_36: ; $F350
F350   F9                         REC
F351   B3 0D                      ADI  A,$0D
F353   B7 14                      CPI  A,$14
F355   81 02                      BCR EXPONENT_37 ; $F359
F357   B5 13                      LDI  A,$13

EXPONENT_37: ; $F359
F359   D9                         SHL
F35A   D9                         SHL
F35B   D9                         SHL
F35C   BB 07                      ORI  A,$07
F35E   FD C8                      PSH  A
F360   58 FC                      LDI  YH,$FC

EXPONENT_39: ; $F362
F362   4A 2F                      LDI  XL,$2F
F364   FD 8A                      POP  A
F366   4D 0F                      BII  (X),$0F
F368   8B 09                      BZS EXPONENT_38 ; $F373
F36A   4F FF                      ADI  (X),$FF
F36C   FD C8                      PSH  A
F36E   1A                         STA  YL
F36F   CD 72                      VMJ  ($72)($39)
F371   9E 11                      BCH EXPONENT_39 ; $F362

EXPONENT_38: ; $F373
F373   FD 8A                      POP  A
F375   DF                         DEC  A
F376   81 0B                      BCR EXPONENT_40 ; $F383
F378   FD C8                      PSH  A
F37A   FD 62                      DEC  UH
F37C   BE F7 69                   SJP  (ARW_SHR_4BITS)
F37F   CD 74                      VMJ  ($74)($3A)
F381   9E 42                      BCH EXPONENT_41 ; $F341

EXPONENT_40: ; $F383
F383   58 7A                      LDI  YH,$7A
F385   ED 7A 18 01                BII  (ARU),$01
F389   8B 03                      BZS EXPONENT_42 ; $F38E
F38B   BA F1 96                   JMP  BCMD_LOG_9 ; $F196

EXPONENT_42: ; $F38E
F38E   BA F4 F7                   JMP  BCMD_ASN_1 ; $F4F7



BCMD_COS: ; $F391
F391   E9 7A 01 00                ANI  (ARX + $01),$00
F395   B5 00                      LDI  A,$00
F397   AE 7A 18                   STA  (ARU)
F39A   B5 01                      LDI  A,$01
F39C   8E 0B                      BCH BCMD_SIN_3 ; $F3A9



BCMD_TAN: ; $F39E
F39E   B5 40                      LDI  A,$40
F3A0   8E 02                      BCH BCMD_SIN_4 ; $F3A4



BCMD_SIN: ; $F3A2
F3A2   B5 00                      LDI  A,$00

BCMD_SIN_4: ; $F3A4
F3A4   AE 7A 18                   STA  (ARU)
F3A7   B5 00                      LDI  A,$00

BCMD_SIN_3: ; $F3A9
F3A9   AE 7A 20                   STA  (ARV)
F3AC   CD 54                      VMJ  ($54)($2A)
F3AE   BE F8 5A                   SJP  (ADD_ARU_ARX_13) ; $F85A
F3B1   81 16                      BCR BCMD_SIN_5 ; $F3C9
F3B3   CD 7E                      VMJ  ($7E)($3F)
F3B5   83 D7                      BCS BCMD_SIN_6 ; $F48E
F3B7   BA EF 8A                   JMP  OUTBUFCLR_8 ; $EF8A

BCMD_SIN_1: ; $F3BA
F3BA   9C                         DCA  (Y)
F3BB   53                         SDE  Y
F3BC   B5 00                      LDI  A,$00
F3BE   93 06                      BCS BCMD_SIN_1 ; $F3BA
F3C0   E9 7A 07 F0                ANI  (ARX + $07),$F0
F3C4   BE F6 5D                   SJP  (ARX2BCD_ABS)
F3C7   83 C5                      BCS BCMD_SIN_6 ; $F48E

BCMD_SIN_5: ; $F3C9
F3C9   CD 6C                      VMJ  ($6C)($36)
F3CB   FD C8                      PSH  A
F3CD   46                         DEC  X
F3CE   05                         LDA  (X)
F3CF   BF 80                      BII  A,$80
F3D1   89 56                      BZR BCMD_SIN_7 ; $F429
F3D3   B7 0A                      CPI  A,$0A
F3D5   83 B5                      BCS BCMD_SIN_8 ; $F48C
F3D7   CD 70                      VMJ  ($70)($38)
F3D9   EB 7A 11 36                ORI  (ARY + $01),$36
F3DD   CD 74                      VMJ  ($74)($3A)
F3DF   BE F7 71                   SJP  (ARY_SHR_4BITS)

BCMD_SIN_9: ; $F3E2
F3E2   FD 60                      INC  UH

BCMD_SIN_12: ; $F3E4
F3E4   CD 7A                      VMJ  ($7A)($3D)
F3E6   93 06                      BCS BCMD_SIN_9 ; $F3E2
F3E8   EE                         VEJ  (EE)
F3E9   ED 7A 11 0F                BII  (ARY + $01),$0F
F3ED   8B 13                      BZS BCMD_SIN_10 ; $F402
F3EF   EF 7A 00 FF                ADI  (ARX),$FF
F3F3   81 03                      BCR BCMD_SIN_11 ; $F3F8
F3F5   EA                         VEJ  (EA)
F3F6   9E 16                      BCH BCMD_SIN_9 ; $F3E2

BCMD_SIN_11: ; $F3F8
F3F8   CD 70                      VMJ  ($70)($38)
F3FA   EB 7A 12 90                ORI  (ARY + $02),$90
F3FE   68 00                      LDI  UH,$00
F400   9E 1E                      BCH BCMD_SIN_12 ; $F3E4

BCMD_SIN_10: ; $F402
F402   EA                         VEJ  (EA)
F403   E9 7A 00 00                ANI  (ARX),$00
F407   A4                         LDA  UH
F408   4A 20                      LDI  XL,$20
F40A   F9                         REC
F40B   03                         ADC  (X)
F40C   0E                         STA  (X)
F40D   F1                         AEX
F40E   0B                         ORA  (X)
F40F   0E                         STA  (X)
F410   CD 70                      VMJ  ($70)($38)
F412   4A 11                      LDI  XL,$11
F414   B5 04                      LDI  A,$04
F416   41                         SIN  X
F417   4B 50                      ORI  (X),$50
F419   CD 7A                      VMJ  ($7A)($3D)
F41B   81 07                      BCR BCMD_SIN_13 ; $F424
F41D   BE F7 EB                   SJP  (ADD_ARU_ARX_3) ; $F7EB
F420   EF 7A 20 01                ADI  (ARV),$01

BCMD_SIN_13: ; $F424
F424   EE                         VEJ  (EE)
F425   E8                         VEJ  (E8)
F426   4A 00                      LDI  XL,$00
F428   05                         LDA  (X)

BCMD_SIN_7: ; $F429
F429   DF                         DEC  A
F42A   0E                         STA  (X)
F42B   BD FF                      EAI  $FF
F42D   DD                         INC  A
F42E   28                         STA  UH
F42F   BA F2 33                   JMP  EXPONENT_7 ; $F233

BCMD_SIN_2: ; $F432
F432   E9 7A 10 00                ANI  (ARY),$00
F436   E8                         VEJ  (E8)
F437   CD 66                      VMJ  ($66)($33)
F439   E8                         VEJ  (E8)
F43A   CD 66                      VMJ  ($66)($33)
F43C   CD 58                      VMJ  ($58)($2C)
F43E   FD 8A                      POP  A
F440   AE 7A 01                   STA  (ARX + $01)
F443   ED 7A 18 40                BII  (ARU),$40
F447   89 37                      BZR BCMD_SIN_14 ; $F480
F449   CD 80                      VMJ  ($80)($40)
F44B   BE F0 19                   SJP  (SQUARE)
F44E   83 DE                      BCS BCMD_ASN_2 ; $F52E
F450   CD 6A                      VMJ  ($6A)($35)
F452   F0                         VEJ  (F0)
F453   83 D9                      BCS BCMD_ASN_2 ; $F52E
F455   BE F0 E9                   SJP  (SQR_ROOT)
F458   83 D4                      BCS BCMD_ASN_2 ; $F52E
F45A   CD 68                      VMJ  ($68)($34)
F45C   CD 7C                      VMJ  ($7C)($3E)
F45E   ED 7A 20 01                BII  (ARV),$01
F462   8B 02                      BZS $F466
F464   CD 6A                      VMJ  ($6A)($35)
F466   CD 66                      VMJ  ($66)($33)
F468   CD 58                      VMJ  ($58)($2C)
F46A   FD 8A                      POP  A
F46C   AE 7A 01                   STA  (ARX + $01)
F46F   FD 8A                      POP  A
F471   ED 7A 20 20                BII  (ARV),$20

BCMD_SIN_16: ; $F475
F475   83 B7                      BCS BCMD_ASN_2 ; $F52E
F477   8B 04                      BZS BCMD_SIN_15 ; $F47D
F479   EF 7A 01 80                ADI  (ARX + $01),$80

BCMD_SIN_15: ; $F47D
F47D   BA F6 5D                   JMP  ARX2BCD_ABS ; $F65D

BCMD_SIN_14: ; $F480
F480   ED 7A 20 01                BII  (ARV),$01
F484   C9 6E                      VZR  ($6E)($37)
F486   ED 7A 20 10                BII  (ARV),$10
F48A   9E 17                      BCH BCMD_SIN_16 ; $F475

BCMD_SIN_8: ; $F48C
F48C   FD 8A                      POP  A

BCMD_SIN_6: ; $F48E
F48E   68 27                      LDI  UH,$27
F490   FB                         SEC
F491   9A                         RTN



BCMD_ACS: ; $F492
F492   B5 20                      LDI  A,$20
F494   8E 06                      BCH BCMD_ASN_3 ; $F49C



BCMD_ATN: ; $F496
F496   B5 40                      LDI  A,$40
F498   8E 02                      BCH BCMD_ASN_3 ; $F49C



BCMD_ASN: ; $F49A
F49A   B5 00                      LDI  A,$00

BCMD_ASN_3: ; $F49C
F49C   AE 7A 18                   STA  (ARU)
F49F   CD 54                      VMJ  ($54)($2A)
F4A1   CD 6C                      VMJ  ($6C)($36)
F4A3   FD C8                      PSH  A
F4A5   ED 7A 18 40                BII  (ARU),$40
F4A9   89 27                      BZR BCMD_ASN_4 ; $F4D2
F4AB   CD 80                      VMJ  ($80)($40)
F4AD   BE F0 19                   SJP  (SQUARE)
F4B0   93 26                      BCS BCMD_SIN_8 ; $F48C
F4B2   CD 6A                      VMJ  ($6A)($35)
F4B4   EF 7A 01 80                ADI  (ARX + $01),$80
F4B8   F0                         VEJ  (F0)
F4B9   93 2F                      BCS BCMD_SIN_8 ; $F48C
F4BB   BE F0 E9                   SJP  (SQR_ROOT)
F4BE   93 34                      BCS BCMD_SIN_8 ; $F48C
F4C0   CD 68                      VMJ  ($68)($34)
F4C2   ED 7A 18 20                BII  (ARU),$20
F4C6   89 02                      BZR BCMD_ASN_5 ; $F4CA
F4C8   CD 66                      VMJ  ($66)($33)

BCMD_ASN_5: ; $F4CA
F4CA   ED 7A 12 F0                BII  (ARY + $02),$F0
F4CE   8B 20                      BZS BCMD_ASN_6 ; $F4F0
F4D0   CD 58                      VMJ  ($58)($2C)

BCMD_ASN_4: ; $F4D2
F4D2   ED 7A 02 F0                BII  (ARX + $02),$F0
F4D6   8B 36                      BZS BCMD_ASN_7 ; $F50E
F4D8   ED 7A 00 80                BII  (ARX),$80
F4DC   89 06                      BZR BCMD_ASN_8 ; $F4E4
F4DE   CD 6E                      VMJ  ($6E)($37)
F4E0   EF 7A 18 80                ADI  (ARU),$80

BCMD_ASN_8: ; $F4E4
F4E4   93 5A                      BCS BCMD_SIN_8 ; $F48C
F4E6   A5 7A 00                   LDA  (ARX)
F4E9   BD FF                      EAI  $FF
F4EB   DD                         INC  A
F4EC   28                         STA  UH
F4ED   BA F2 EC                   JMP EXPONENT_1 ; $F2EC

BCMD_ASN_6: ; $F4F0
F4F0   BE F8 83                   SJP  (ADD_ARU_ARX_14) ; $F883
F4F3   CD 56                      VMJ  ($56)($2B)
F4F5   8E 17                      BCH BCMD_ASN_7 ; $F50E

BCMD_ASN_1: ; $F4F7
F4F7   EF 7A 00 01                ADI  (ARX),$01
F4FB   E8                         VEJ  (E8)
F4FC   83 2E                      BCS BCMD_ASN_9 ; $F52C
F4FE   ED 7A 18 80                BII  (ARU),$80
F502   8B 0A                      BZS BCMD_ASN_7 ; $F50E
F504   BE F8 83                   SJP  (ADD_ARU_ARX_14) ; $F883
F507   EF 7A 01 80                ADI  (ARX + $01),$80
F50B   F0                         VEJ  (F0)
F50C   83 1E                      BCS BCMD_ASN_9 ; $F52C

BCMD_ASN_7: ; $F50E
F50E   FD 8A                      POP  A
F510   AE 7A 01                   STA  (ARX + $01)
F513   D9                         SHL
F514   81 0C                      BCR BCMD_ASN_10 ; $F522
F516   ED 7A 18 20                BII  (ARU),$20
F51A   8B 06                      BZS BCMD_ASN_10 ; $F522
F51C   BE F8 87                   SJP  (ADD_ARU_ARX_15) ; $F887
F51F   F0                         VEJ  (F0)
F520   83 0C                      BCS BCMD_ASN_2 ; $F52E

BCMD_ASN_10: ; $F522
F522   BE F8 5A                   SJP  (ADD_ARU_ARX_13) ; $F85A
F525   81 95                      BCR BCMD_PI_1 ; $F5BC
F527   CD 58                      VMJ  ($58)($2C)
F529   83 03                      BCS BCMD_ASN_2 ; $F52E
F52B   9A                         RTN

BCMD_ASN_9: ; $F52C
F52C   FD 8A                      POP  A

BCMD_ASN_2: ; $F52E
F52E   BA F6 98                   JMP  ARX2BCD2_1 ; $F698



BCMD_DEG: ; $F531
F531   CD 54                      VMJ  ($54)($2A)
F533   CD 6C                      VMJ  ($6C)($36)
F535   FD C8                      PSH  A
F537   BE F6 A9                   SJP  (ARX2BCD2_2) ; $F6A9
F53A   CD 64                      VMJ  ($64)($32)
F53C   CD 56                      VMJ  ($56)($2B)
F53E   E8                         VEJ  (E8)
F53F   CD 62                      VMJ  ($62)($31)
F541   CD 58                      VMJ  ($58)($2C)
F543   93 19                      BCS BCMD_ASN_9 ; $F52C
F545   CD 64                      VMJ  ($64)($32)
F547   E8                         VEJ  (E8)
F548   CD 60                      VMJ  ($60)($30)
F54A   CD 64                      VMJ  ($64)($32)
F54C   CD 66                      VMJ  ($66)($33)
F54E   E8                         VEJ  (E8)
F54F   F0                         VEJ  (F0)
F550   93 26                      BCS BCMD_ASN_9 ; $F52C
F552   CD 62                      VMJ  ($62)($31)
F554   CD 58                      VMJ  ($58)($2C)
F556   93 2C                      BCS BCMD_ASN_9 ; $F52C
F558   E6                         VEJ  (E6)
F559   CD 64                      VMJ  ($64)($32)
F55B   E8                         VEJ  (E8)
F55C   F0                         VEJ  (F0)
F55D   93 33                      BCS BCMD_ASN_9 ; $F52C
F55F   FD 8A                      POP  A
F561   BA F6 63                   JMP  ARX2BCD2 ; $F663



BCMD_DMS: ; $F564
F564   CD 54                      VMJ  ($54)($2A)
F566   CD 6C                      VMJ  ($6C)($36)
F568   FD C8                      PSH  A
F56A   CD 60                      VMJ  ($60)($30)
F56C   CD 64                      VMJ  ($64)($32)
F56E   CD 56                      VMJ  ($56)($2B)
F570   E8                         VEJ  (E8)
F571   CD 62                      VMJ  ($62)($31)
F573   CD 7E                      VMJ  ($7E)($3F)
F575   E6                         VEJ  (E6)
F576   CD 64                      VMJ  ($64)($32)
F578   E8                         VEJ  (E8)
F579   F0                         VEJ  (F0)
F57A   BE F6 A9                   SJP  (ARX2BCD2_2) ; $F6A9
F57D   CD 80                      VMJ  ($80)($40)
F57F   CD 56                      VMJ  ($56)($2B)
F581   E8                         VEJ  (E8)
F582   CD 62                      VMJ  ($62)($31)
F584   CD 7E                      VMJ  ($7E)($3F)
F586   BE F6 3C                   SJP  (ARXX)
F589   E6                         VEJ  (E6)
F58A   CD 64                      VMJ  ($64)($32)
F58C   E8                         VEJ  (E8)
F58D   F0                         VEJ  (F0)
F58E   93 64                      BCS BCMD_ASN_9 ; $F52C



BCMD_SGN: ; $F590
F590   FD 8A                      POP  A
F592   CD 52                      VMJ  ($52)($29)
F594   BA F6 3C                   JMP  ARX ; $F63C



BCMD_ABS: ; $F597
F597   E9 7A 01 00                ANI  (ARX + $01),$00
F59B   8E 1F                      BCH BCMD_PI_1 ; $F5BC
F59D   48 7A                      LDI  XH,$7A
F59F   4A 01                      LDI  XL,$01
F5A1   45                         LIN  X
F5A2   28                         STA  UH
F5A3   05                         LDA  (X)
F5A4   FD C8                      PSH  A
F5A6   EC                         VEJ  (EC)
F5A7   FD 8A                      POP  A
F5A9   BF F0                      BII  A,$F0
F5AB   9B 12                      BZS $F59B
F5AD   A4                         LDA  UH
F5AE   4A 01                      LDI  XL,$01
F5B0   41                         SIN  X
F5B1   4B 10                      ORI  (X),$10
F5B3   9E 1A                      BCH $F59B



BCMD_PI: ; $F585
F5B5   CD 54                      VMJ  ($54)($2A)
F5B7   BE F8 75                   SJP  ($F875)
F5BA   CD 56                      VMJ  ($56)($2B)

BCMD_PI_1: ; $F5BC
F5BC   8E E7                      BCH ARX2BCD2_9 ; $F6A5



BCMD_INT: ; $F5BE
F5BE   CD 54                      VMJ  ($54)($2A)
F5C0   CD 6C                      VMJ  ($6C)($36)
F5C2   FD C8                      PSH  A
F5C4   CD 60                      VMJ  ($60)($30)
F5C6   FD 8A                      POP  A
F5C8   8B 0B                      BZS BCMD_INT_1 ; $F5D5
F5CA   4A 11                      LDI  XL,$11
F5CC   6A 06                      LDI  UL,$06

BCMD_INT_3: ; $F5CE
F5CE   45                         LIN  X
F5CF   89 07                      BZR BCMD_INT_2 ; $F5D8
F5D1   88 05                      LOP  UL,BCMD_INT_3 ; $F5CE

BCMD_INT_4: ; $F5D3
F5D3   B5 80                      LDI  A,$80

BCMD_INT_1: ; $F5D5
F5D5   CD 52                      VMJ  ($52)($29)
F5D7   9A                         RTN

BCMD_INT_2: ; $F5D8
F5D8   CD 6A                      VMJ  ($6A)($35)
F5DA   F0                         VEJ  (F0)
F5DB   9E 0A                      BCH BCMD_INT_4 ; $F5D3
F5DD   CD 54                      VMJ  ($54)($2A)
F5DF   ED 7A 01 80                BII  (ARX + $01),$80
F5E3   89 10                      BZR RANDGEN_1 ; $F5F5
F5E5   ED 7A 00 80                BII  (ARX),$80
F5E9   8B 10                      BZS RANDGEN_2 ; $F5FB



RANDGEN: ; $F5EB
F5EB   CD 5E                      VMJ  ($5E)($2F)

RANDGEN_3: ; $F5ED
F5ED   CD 5C                      VMJ  ($5C)($2E)
F5EF   EB 7A 00 FF                ORI  (ARX),$FF
F5F3   E8                         VEJ  (E8)
F5F4   9A                         RTN

RANDGEN_1: ; $F5F5
F5F5   E9 7A 01 00                ANI  (ARX + $01),$00
F5F9   9E 0E                      BCH RANDGEN_3 ; $F5ED

RANDGEN_2: ; $F5FB
F5FB   ED 7A 02 F0                BII  (ARX + $02),$F0
F5FF   9B 16                      BZS RANDGEN
F601   CD 80                      VMJ  ($80)($40)
F603   BE F5 EB                   SJP  (RANDGEN)
F606   CD 68                      VMJ  ($68)($34)
F608   A5 7A 10                   LDA  (ARY)
F60B   B7 0A                      CPI  A,$0A
F60D   83 09                      BCS RANDGEN_4 ; $F618
F60F   CD 7E                      VMJ  ($7E)($3F)
F611   CD 60                      VMJ  ($60)($30)
F613   E8                         VEJ  (E8)
F614   CD 6A                      VMJ  ($6A)($35)
F616   F0                         VEJ  (F0)
F617   9A                         RTN

RANDGEN_4: ; $F518
F618   BA F1 5D                   JMP  SQR_ROOT_1 ; $F15D
F61B   CD 82                      VMJ  ($82)($41)
F61D   EE                         VEJ  (EE)
F61E   EA                         VEJ  (EA)
F61F   EE                         VEJ  (EE)
F620   EE                         VEJ  (EE)
F621   4A 07                      LDI  XL,$07
F623   5A 17                      LDI  YL,$17
F625   6A 05                      LDI  UL,$05
F627   FB                         SEC

RANDGEN_5: ; $F528
F628   57                         LDE  Y
F629   8C                         DCA  (X)
F62A   43                         SDE  X
F62B   88 05                      LOP  UL,RANDGEN_5 ; $F628
F62D   E9 7A 01 00                ANI  (ARX + $01),$00
F631   58 7B                      LDI  YH,$7B
F633   5A 01                      LDI  YL,$01
F635   4A 01                      LDI  XL,$01
F637   BE F7 33                   SJP  (XREG2YREG)
F63A   58 7A                      LDI  YH,$7A



ARX: ; $F63C
F63C   E9 7A 07 00                ANI  (ARX + $07),$00
F640   9A                         RTN



BCMD_RANDOM: ; $F641
F641   FD 98                      PSH  Y
F643   CD 54                      VMJ  ($54)($2A)
F645   BE F7 53                   SJP  (CLR_ARZ)
F648   BE E5 B4                   SJP  (TIME2ARX)
F64B   A5 7A 06                   LDA  (ARX + $06)
F64E   B9 77                      ANI  A,$77
F650   BB 20                      ORI  A,$20
F652   AE 7A 12                   STA  (ARY + $02)
F655   CD 5E                      VMJ  ($5E)($2F)
F657   EE                         VEJ  (EE)
F658   CD 5C                      VMJ  ($5C)($2E)
F65A   FD 1A                      POP  Y
F65C   E2                         VEJ  (E2)



ARX2BCD_ABS: ; $F65D
F65D   CD 6C                      VMJ  ($6C)($36)
F65F   8E 02                      BCH ARX2BCD_ABS
F661   B5 00                      LDI  A,$00



ARX2BCD2: ; $F663
F663   FD C8                      PSH  A
F665   4A 01                      LDI  XL,$01
F667   6A 06                      LDI  UL,$06

ARX2BCD2_4: ; $F669
F669   45                         LIN  X
F66A   89 04                      BZR ARX2BCD2_3 ; $F670
F66C   88 05                      LOP  UL,$ARX2BCD2_4 ; F669
F66E   8E 32                      BCH ARX2BCD2_5 ; $F6A2

ARX2BCD2_3: ; $F670
F670   4A 01                      LDI  XL,$01
F672   47                         LDE  X
F673   8B 06                      BZS ARX2BCD2_6 ; $F67B
F675   4F 01                      ADI  (X),$01
F677   CD 74                      VMJ  ($74)($3A)
F679   9E 0B                      BCH ARX2BCD2_3 ; $F670

ARX2BCD2_6: ; $F67B
F67B   ED 7A 02 F0                BII  (ARX + $02),$F0
F67F   89 07                      BZR ARX2BCD2_7 ; $F688
F681   EF 7A 00 FF                ADI  (ARX),$FF
F685   EA                         VEJ  (EA)
F686   9E 0D                      BCH ARX2BCD2_6 ; $F67B

ARX2BCD2_7: ; $F688
F688   A5 7A 00                   LDA  (ARX)
F68B   BF 80                      BII  A,$80
F68D   89 0D                      BZR ARX2BCD2_8 ; $F69C
F68F   B7 64                      CPI  A,$64

ARX2BCD2_10: ; $F691
F691   FD 8A                      POP  A
F693   AE 7A 01                   STA  (ARX + $01)
F696   81 0D                      BCR ARX2BCD2_9 ; $F6A5

ARX2BCD2_1: ; $F698
F698   68 25                      LDI  UH,$25
F69A   FB                         SEC
F69B   9A                         RTN

ARX2BCD2_8: ; $F69C
F69C   BD FF                      EAI  $FF
F69E   B7 63                      CPI  A,$63
F6A0   91 11                      BCR ARX2BCD2_10 ; $F691

ARX2BCD2_5: ; $F698
F6A2   EC                         VEJ  (EC)
F6A3   FD 8A                      POP  A

ARX2BCD2_9: ; $F6A5
F6A5   68 00                      LDI  UH,$00
F6A7   F9                         REC
F6A8   9A                         RTN

ARX2BCD2_2: ; $F6A9
F6A9   BE F7 53                   SJP  (CLR_ARZ)
F6AC   4A 00                      LDI  XL,$00
F6AE   05                         LDA  (X)
F6AF   F9                         REC
F6B0   B3 02                      ADI  A,$02
F6B2   8E 06                      BCH XFER_DEC_ARX2ARY_1 ; $F6BA



XFER_DEC_ARX2ARY: ; $F6B4
F6B4   BE F7 53                   SJP  (CLR_ARZ)
F6B7   4A 00                      LDI  XL,$00
F6B9   05                         LDA  (X)

XFER_DEC_ARX2ARY_1: ; $F6BA
F6BA   BF 80                      BII  A,$80
F6BC   89 1D                      BZR XFER_DEC_ARX2ARY_2 ; $F6DB
F6BE   B7 0B                      CPI  A,$0B
F6C0   83 18                      BCS XFER_DEC_ARX2ARY_3 ; $F6DA
F6C2   B3 05                      ADI  A,$05

XFER_DEC_ARX2ARY_6: ; $F6C4
F6C4   D5                         SHR
F6C5   0A                         STA  XL
F6C6   BB 10                      ORI  A,$10
F6C8   1A                         STA  YL
F6C9   83 14                      BCS XFER_DEC_ARX2ARY_4 ; $F6DF

XFER_DEC_ARX2ARY_5: ; $F6CB
F6CB   05                         LDA  (X)
F6CC   49 00                      ANI  (X),$00

XFER_DEC_ARX2ARY_7: ; $F6CE
F6CE   51                         SIN  Y
F6CF   40                         INC  XL
F6D0   4E 08                      CPI  XL,$08
F6D2   91 09                      BCR XFER_DEC_ARX2ARY_5 ; $F6CB
F6D4   A5 7A 00                   LDA  (ARX)
F6D7   AE 7A 10                   STA  (ARY)

XFER_DEC_ARX2ARY_3: ; $F6DA
F6DA   9A                         RTN

XFER_DEC_ARX2ARY_2: ; $F6DB
F6DB   B5 04                      LDI  A,$04
F6DD   9E 1B                      BCH XFER_DEC_ARX2ARY_6 ; $F6C4

XFER_DEC_ARX2ARY_4: ; $F6DF
F6DF   05                         LDA  (X)
F6E0   49 F0                      ANI  (X),$F0
F6E2   B9 0F                      ANI  A,$0F
F6E4   9E 18                      BCH XFER_DEC_ARX2ARY_7 ; $F6CE



SIGN_TEST: ; $F6E6
F6E6   FD 2A                      POP  U
F6E8   4A 01                      LDI  XL,$01
F6EA   5A 11                      LDI  YL,$11
F6EC   15                         LDA  (Y)
F6ED   59 00                      ANI  (Y),$00
F6EF   FD C8                      PSH  A
F6F1   0D                         EOR  (X)
F6F2   49 00                      ANI  (X),$00
F6F4   FD C8                      PSH  A
F6F6   46                         DEC  X
F6F7   56                         DEC  Y
F6F8   FD A8                      PSH  U
F6FA   9A                         RTN



LDA_SGN_ARX: ; $F6FB
F6FB   4A 01                      LDI  XL,$01
F6FD   05                         LDA  (X)
F6FE   49 00                      ANI  (X),$00
F700   9A                         RTN



XFER_ARY2ARS:  ; $F701
F701   4A 10                      LDI  XL,$10
F703   5A 30                      LDI  YL,$30
F705   8E 3A                      BCH XFER_ARY2ARX2_1 ; $F741



XFER_ARX2ARS:  ; $F707
F707   CD 54                      VMJ  ($54)($2A)
F709   5A 30                      LDI  YL,$30
F70B   8E 04                      BCH XFER_ARX2ARY_1 ; $F711



XFER_ARX2ARY: ; $F70D
F70D   CD 54                      VMJ  ($54)($2A)
F70F   5A 10                      LDI  YL,$10

XFER_ARX2ARY_1: ; $F711
F711   4A 00                      LDI  XL,$00
F713   8E 2C                      BCH XFER_ARY2ARX2_1 ; $F741



XFER_ARS2ARY: ; $F715
F715   4A 30                      LDI  XL,$30
F717   5A 10                      LDI  YL,$10
F719   8E 26                      BCH XFER_ARY2ARX2_1 ; $F741



XFER_SM_ARY2ARX: ; $F71B
F71B   4A 11                      LDI  XL,$11
F71D   8E 02                      BCH XFER_SM_ARZ2ARX_1 ; $F721



XFER_SM_ARZ2ARX: ; $F71F
F71F   4A 09                      LDI  XL,$09

XFER_SM_ARZ2ARX_1: ; $F721
F721   5A 01                      LDI  YL,$01
F723   8E 0E                      BCH XFER_SM_ARX2ARZ: ; $F733


XFER_SM_ARY2ARZ: ; $F725
F725   4A 11                      LDI  XL,$11
F727   8E 08                      BCH XFER_SM_ARX2ARZ_1 ; $F731



XFER_SM_ARX2ARY: ; $F729
F729   4A 01                      LDI  XL,$01
F72B   5A 11                      LDI  YL,$11
F72D   8E 04                      BCH XREG2YREG2 ; F733



XFER_SM_ARX2ARZ: ; $F725
F72F   4A 01                      LDI  XL,$01

XFER_SM_ARX2ARZ_1: ; $F731
F731   5A 09                      LDI  YL,$09



XREG2YREG2: ; F733
F733   6A 06                      LDI  UL,$06
F735   8E 0C                      BCH XFER_ARY2ARX2_2 ; $F743

XFER_ARY2ARX:
F737   CD 54                      VMJ  ($54)($2A)
F739   4A 30                      LDI  XL,$30
F73B   8E 02                      BCH XFER_ARY2ARX2_3 ; $F73F



XFER_ARY2ARX2: ; $F73D
F73D   4A 10                      LDI  XL,$10

XFER_ARY2ARX2_3: ; $F73F
F73F   5A 00                      LDI  YL,$00

XFER_ARY2ARX2_1: ; $F741
F741   6A 07                      LDI  UL,$07

XFER_ARY2ARX2_2: ; $F743
F743   F5                         TIN
F744   88 03                      LOP  UL,XFER_ARY2ARX2_2 ; $F743
F746   9A                         RTN



CLR_SM_ARY: ; $F747
F747   4A 11                      LDI  XL,$11
F749   8E 16                      BCH CLR_7_XREG



CLR_SM_ARZ: ; $F74B
F74B   4A 09                      LDI  XL,$09
F74D   8E 12                      BCH CLR_7_XREG



CLR_SM_ARW: ; $F74F
F74F   4A 29                      LDI  XL,$29
F751   8E 0E                      BCH CLR_7_XREG



CLR_ARZ: ; $F753
F753   4A 10                      LDI  XL,$10
F755   8E 04                      BCH CLR_ARZ



CLR_ARZ2: ; $F757
F757   48 7A                      LDI  XH,$7A
F759   4A 00                      LDI  XL,$00



CLR_ARZ3: ; $F75B
F75B   6A 07                      LDI  UL,$07
F75D   8E 04                      BCH CLR_N_XREG



CLR_SM_XREG: ; $F75F
F75F   4A 01                      LDI  XL,$01



CLR_7_XREG: ; $F761
F761   6A 06                      LDI  UL,$06



CLR_N_XREG: ; $F763
F763   B5 00                      LDI  A,$00

CLR_N_XREG_1: ; $F765
F765   41                         SIN  X
F766   88 03                      LOP  UL,$F765
F768   9A                         RTN



ARW_SHR_4BITS: ; $F769
F769   4A 28                      LDI  XL,$28
F76B   8E 0A                      BCH X_REG_SHR_4BITS



ARZ_SHR_4BITS: ; $F76D
F76D   4A 08                      LDI  XL,$08
F76F   8E 06                      BCH X_REG_SHR_4BITS



ARY_SHR_4BITS: ; $F771
F771   4A 10                      LDI  XL,$10
F773   8E 02                      BCH X_REG_SHR_4BITS



ARX_SHR_4BITS: ; $F775
F775   4A 00                      LDI  XL,$00



X_REG_SHR_4BITS: ; $F777
F777   6A 06                      LDI  UL,$06
F779   B5 00                      LDI  A,$00

X_REG_SHR_4BITS_1: ; $F77B
F77B   44                         INC  X
F77C   D3                         DDR  (X)
F77D   88 04                      LOP  UL,X_REG_SHR_4BITS_1 ; $F77B
F77F   9A                         RTN
F780   4A 0F                      LDI  XL,$0F
F782   6A 05                      LDI  UL,$05

X_REG_SHR_4BITS_2: ; $F784
F784   46                         DEC  X
F785   45                         LIN  X
F786   43                         SDE  X
F787   88 05                      LOP  UL,X_REG_SHR_4BITS_2 ; $F784
F789   49 00                      ANI  (X),$00
F78B   9A                         RTN



ARS_SHL_4BITS: ; $F78C
F78C   48 7A                      LDI  XH,$7A
F78E   4A 37                      LDI  XL,$37
F790   6A 04                      LDI  UL,$04
F792   8E 0C                      BCH ARX_SHL_4BITS_1 ; $F7A0



ARW_SHL_4BITS: ; $F794
F794   4A 30                      LDI  XL,$30
F796   8E 06                      BCH ARX_SHL_4BITS_2 ; $F79E



ARZ_SHL_4BITS: ; $F798
F798   4A 10                      LDI  XL,$10
F79A   8E 02                      BCH ARX_SHL_4BITS_2 ; $F79E



ARX_SHL_4BITS: ; $F79C
F79C   4A 08                      LDI  XL,$08

ARX_SHL_4BITS_2: ; $F79E
F79E   6A 06                      LDI  UL,$06

ARX_SHL_4BITS_1: ; $F7A0
F7A0   B5 00                      LDI  A,$00

ARX_SHL_4BITS_3: ; $F7A2
F7A2   46                         DEC  X
F7A3   D7                         DRL  (X)
F7A4   88 04                      LOP  UL,ARX_SHL_4BITS_3 ; $F7A2
F7A6   9A                         RTN



RND2ARX: ; $F7A7
F7A7   5A 01                      LDI  YL,$01
F7A9   48 7B                      LDI  XH,$7B
F7AB   4A 01                      LDI  XL,$01
F7AD   BE F7 33                   SJP  (XREG2YREG)



SET_HB_XYREGS: ; $F7B0
F7B0   48 7A                      LDI  XH,$7A
F7B2   58 7A                      LDI  YH,$7A
F7B4   9A                         RTN



SWAP_AARX_ARY: ; $F7B5
F7B5   5A 30                      LDI  YL,$30
F7B7   8E 02                      BCH SWAP_ARX_ARY_1 ; $F7BB



SWAP_ARX_ARY: ; $F7B9
F7B9   5A 10                      LDI  YL,$10

SWAP_ARX_ARY_1: ; $F7BB
F7BB   4A 00                      LDI  XL,$00
F7BD   6A 07                      LDI  UL,$07



SWAP_BYTES: ; $F7BF
F7BF   05                         LDA  (X)
F7C0   28                         STA  UH
F7C1   15                         LDA  (Y)
F7C2   41                         SIN  X
F7C3   A4                         LDA  UH
F7C4   51                         SIN  Y
F7C5   88 08                      LOP  UL,SWAP_BYTES
F7C7   9A                         RTN



ADD_ARU_ARX: ; $F7C8
F7C8   5A 1F                      LDI  YL,$1F
F7CA   8E 02                      BCH ADD_ARU_ARX_16 ; $F7CE
F7CC   5A 17                      LDI  YL,$17

ADD_ARU_ARX_16: ; $F7CE
F7CE   4A 07                      LDI  XL,$07

ADD_ARU_ARX_26: ; $F7D0
F7D0   F9                         REC
F7D1   6A 06                      LDI  UL,$06

ADD_ARU_ARX_17: ; $F7D3
F7D3   57                         LDE  Y
F7D4   8C                         DCA  (X)
F7D5   43                         SDE  X
F7D6   88 05                      LOP  UL,ADD_ARU_ARX_17 ; $F7D3
F7D8   9A                         RTN

ADD_ARU_ARX_6: ; $F7D9
F7D9   5A 27                      LDI  YL,$27
F7DB   8E 02                      BCH ADD_ARU_ARX_8 ; $F7DF
F7DD   5A 17                      LDI  YL,$17

ADD_ARU_ARX_8: ; $F7DF
F7DF   4A 07                      LDI  XL,$07

ADD_ARU_ARX_11: ; $F7E1
F7E1   FB                         SEC
F7E2   6A 06                      LDI  UL,$06

ADD_ARU_ARX_18: ; $F7E4
F7E4   05                         LDA  (X)
F7E5   1C                         DCS  (Y)
F7E6   43                         SDE  X
F7E7   56                         DEC  Y
F7E8   88 06                      LOP  UL,ADD_ARU_ARX_18 ; $F7E4
F7EA   9A                         RTN

ADD_ARU_ARX_3: ; $F7EB
F7EB   4A 07                      LDI  XL,$07
F7ED   FB                         SEC
F7EE   6A 06                      LDI  UL,$06

ADD_ARU_ARX_19: ; $F7F0
F7F0   B5 00                      LDI  A,$00
F7F2   0C                         DCS  (X)
F7F3   43                         SDE  X
F7F4   88 06                      LOP  UL,ADD_ARU_ARX_19 ; $F7F0
F7F6   9A                         RTN

ADD_ARU_ARX_2: ; $F7F7
F7F7   D5                         SHR
F7F8   81 0B                      BCR ADD_ARU_ARX_10 ; $F805
F7FA   FD C8                      PSH  A
F7FC   04                         LDA  XL
F7FD   B9 F8                      ANI  A,$F8
F7FF   0A                         STA  XL
F800   BE F7 77                   SJP  (X_REG_SHR_4BITS)
F803   FD 8A                      POP  A

ADD_ARU_ARX_10: ; $F805
F805   BF FF                      BII  A,$FF
F807   8B 32                      BZS ADD_ARU_ARX_20 ; $F83B
F809   FD 5A                      STX  Y
F80B   BD FF                      EAI  $FF
F80D   FB                         SEC
F80E   12                         ADC  YL
F80F   1A                         STA  YL
F810   6A 06                      LDI  UL,$06

ADD_ARU_ARX_22: ; $F812
F812   14                         LDA  YL
F813   B9 07                      ANI  A,$07
F815   8B 01                      BZS ADD_ARU_ARX_21 ; $F818
F817   57                         LDE  Y

ADD_ARU_ARX_21: ; $F818
F818   43                         SDE  X
F819   88 09                      LOP  UL,ADD_ARU_ARX_22 ; $F812
F81B   9A                         RTN

ADD_ARU_ARX_5: ; $F81C
F81C   68 01                      LDI  UH,$01
F81E   8E 02                      BCH ADD_ARU_ARX_23 ; $F822

ADD_ARU_ARX_4: ; $F820
F820   68 02                      LDI  UH,$02

ADD_ARU_ARX_23: ; $F822
F822   4A 17                      LDI  XL,$17
F824   5A 1F                      LDI  YL,$1F

ADD_ARU_ARX_25: ; $F826
F826   6A 06                      LDI  UL,$06
F828   F9                         REC

ADD_ARU_ARX_24: ; $F829
F829   05                         LDA  (X)
F82A   8C                         DCA  (X)
F82B   53                         SDE  Y
F82C   46                         DEC  X
F82D   88 06                      LOP  UL,ADD_ARU_ARX_24 ; $F829
F82F   FD 62                      DEC  UH
F831   81 08                      BCR ADD_ARU_ARX_20 ; $F83B
F833   B5 0F                      LDI  A,$0F
F835   FD CA                      ADR  X
F837   FD DA                      ADR  Y
F839   9E 15                      BCH ADD_ARU_ARX_25 ; $F826

ADD_ARU_ARX_20: ; $F83B
F83B   9A                         RTN

ADD_ARU_ARX_9: ; $F83C
F83C   A5 7A 08                   LDA  (ARZ)
F83F   9B 06                      BZS ADD_ARU_ARX_20 ; $F83B
F841   DF                         DEC  A
F842   4A 0F                      LDI  XL,$0F
F844   BE F7 F7                   SJP  (ADD_ARU_ARX_2) ; $F7F7

ADD_ARU_ARX_27: ; $F847
F847   4A 17                      LDI  XL,$17
F849   5A 0F                      LDI  YL,$0F
F84B   9E 7D                      BCH ADD_ARU_ARX_26 ; $F7D0

ADD_ARU_ARX_12: ; $F84D
F84D   A5 7A 08                   LDA  (ARZ)
F850   9B 17                      BZS ADD_ARU_ARX_20 ; $F83B
F852   DF                         DEC  A
F853   4A 0F                      LDI  XL,$0F
F855   BE F8 05                   SJP  (ADD_ARU_ARX_10) ; $F805
F858   9E 13                      BCH ADD_ARU_ARX_27 ; $F847

ADD_ARU_ARX_13: ; $F85A
F85A   A5 76 4F                   LDA  (DISP_BUFF + $4F)
F85D   BF 04                      BII  A,$04
F85F   F9                         REC
F860   9B 27                      BZS ADD_ARU_ARX_20 ; $F83B
F862   BF 02                      BII  A,$02
F864   89 19                      BZR ADD_ARU_ARX_28 ; $F87F
F866   4A 98                      LDI  XL,$98

ADD_ARU_ARX_31: ; $F868
F868   6A 07                      LDI  UL,$07
F86A   48 FC                      LDI  XH,$FC

ADD_ARU_ARX_33: ; $F86C
F86C   5A 10                      LDI  YL,$10

ADD_ARU_ARX_29: ; $F86E
F86E   F5                         TIN
F86F   88 03                      LOP  UL,ADD_ARU_ARX_29 ; $F86E
F871   48 7A                      LDI  XH,$7A
F873   FB                         SEC

ADD_ARU_ARX_42: ; $F874
F874   9A                         RTN
F875   4A F8                      LDI  XL,$F8
F877   6A 07                      LDI  UL,$07
F879   8E 1D                      BCH ADD_ARU_ARX_30 ; $F898

ADD_ARU_ARX_7: ; $F87B
F87B   4A 60                      LDI  XL,$60
F87D   9E 17                      BCH ADD_ARU_ARX_31 ; $F868

ADD_ARU_ARX_28: ; $F87F
F87F   B5 E9                      LDI  A,$E9
F881   8E 0E                      BCH ADD_ARU_ARX_32 ; $F891

ADD_ARU_ARX_14: ; $F883
F883   B5 EF                      LDI  A,$EF
F885   8E 0A                      BCH ADD_ARU_ARX_32 ; $F891

ADD_ARU_ARX_15: ; $F887
F887   B5 F2                      LDI  A,$F2
F889   8E 06                      BCH ADD_ARU_ARX_32 ; $F891
F88B   B5 F5                      LDI  A,$F5
F88D   8E 02                      BCH ADD_ARU_ARX_32 ; $F891
F88F   B5 EC                      LDI  A,$EC

ADD_ARU_ARX_32: ; $F891
F891   1A                         STA  YL
F892   CD 70                      VMJ  ($70)($38)
F894   14                         LDA  YL
F895   0A                         STA  XL
F896   6A 02                      LDI  UL,$02

ADD_ARU_ARX_30: ; $F898
F898   48 FB                      LDI  XH,$FB
F89A   9E 30                      BCH ADD_ARU_ARX_33 ; $F86C
F89C   CD 54                      VMJ  ($54)($2A)
F89E   4A 02                      LDI  XL,$02
F8A0   47                         LDE  X
F8A1   8B 7D                      BZS ADD_ARU_ARX_34 ; $F920
F8A3   4D 80                      BII  (X),$80
F8A5   89 39                      BZR ADD_ARU_ARX_35 ; $F8E0
F8A7   ED 7A 12 FF                BII  (ARY + $02),$FF
F8AB   8B 2D                      BZS ADD_ARU_ARX_35 ; $F8DA
F8AD   B5 00                      LDI  A,$00
F8AF   FD C8                      PSH  A

ADD_ARU_ARX_41: ; $F8B1
F8B1   BE F7 01                   SJP  (XFER_ARY2ARS)
F8B4   BE F1 65                   SJP  (BCMD_LOG)
F8B7   83 09                      BCS ADD_ARU_ARX_36 ; $F8C2
F8B9   CD 68                      VMJ  ($68)($34)
F8BB   CD 7E                      VMJ  ($7E)($3F)
F8BD   83 03                      BCS ADD_ARU_ARX_36 ; $F8C2
F8BF   BE F1 D4                   SJP  (EXPONENT)

ADD_ARU_ARX_36: ; $F8C2
F8C2   FD 8A                      POP  A
F8C4   83 0A                      BCS ADD_ARU_ARX_37 ; $F8D0
F8C6   BF F0                      BII  A,$F0
F8C8   8B 0D                      BZS ADD_ARU_ARX_38 ; $F8D7
F8CA   D5                         SHR
F8CB   83 06                      BCS $F8D3
F8CD   D9                         SHL
F8CE   81 07                      BCR ADD_ARU_ARX_38 ; $F8D7

ADD_ARU_ARX_37: ; $F8D0
F8D0   BA F1 5D                   JMP  SQR_ROOT_1 ; $F15D
F8D3   EB 7A 01 80                ORI  (ARX + $01),$80

ADD_ARU_ARX_38: ; $F8D7
F8D7   BA F0 63                   JMP  MULTIPLY_7 ; $F063

ADD_ARU_ARX_35: ; $F8DA
F8DA   CD 6A                      VMJ  ($6A)($35)
F8DC   CD 56                      VMJ  ($56)($2B)
F8DE   9E 09                      BCH ADD_ARU_ARX_38 ; $F8D7

ADD_ARU_ARX_35: ; $F8E0
F8E0   49 00                      ANI  (X),$00
F8E2   CD 80                      VMJ  ($80)($40)
F8E4   CD 56                      VMJ  ($56)($2B)
F8E6   A5 7A 00                   LDA  (ARX)
F8E9   BF 80                      BII  A,$80
F8EB   99 1D                      BZR ADD_ARU_ARX_41 ; $F8D0
F8ED   B7 0B                      CPI  A,$0B
F8EF   B5 00                      LDI  A,$00
F8F1   83 20                      BCS ADD_ARU_ARX_39 ; $F913
F8F3   CD 6C                      VMJ  ($6C)($36)
F8F5   FD C8                      PSH  A
F8F7   CD 60                      VMJ  ($60)($30)
F8F9   FB                         SEC
F8FA   5A 11                      LDI  YL,$11
F8FC   6A 06                      LDI  UL,$06
F8FE   55                         LIN  Y
F8FF   99 3F                      BZR ADD_ARU_ARX_36 ; $F8C2
F901   88 05                      LOP  UL,$F8FE
F903   FD 8A                      POP  A
F905   AE 7A 01                   STA  (ARX + $01)
F908   A5 7A 00                   LDA  (ARX)
F90B   B3 04                      ADI  A,$04
F90D   D5                         SHR
F90E   0A                         STA  XL
F90F   83 0B                      BCS ADD_ARU_ARX_40 ; $F91C
F911   42                         DEC  XL
F912   05                         LDA  (X)

ADD_ARU_ARX_39: ; $F913
F913   BB F0                      ORI  A,$F0
F915   FD C8                      PSH  A
F917   E6                         VEJ  (E6)
F918   CD 64                      VMJ  ($64)($32)
F91A   9E 6B                      BCH ADD_ARU_ARX_41 ; $F8B1

ADD_ARU_ARX_40: ; $F91C
F91C   05                         LDA  (X)
F91D   F1                         AEX
F91E   9E 0D                      BCH ADD_ARU_ARX_39 ; $F913

ADD_ARU_ARX_34: ; $F920
F920   4A 12                      LDI  XL,$12
F922   47                         LDE  X
F923   9B 55                      BZS ADD_ARU_ARX_41 ; $F8D0
F925   4D 80                      BII  (X),$80
F927   9B 52                      BZS ADD_ARU_ARX_38 ; $F8D7
F929   9E 5B                      BCH ADD_ARU_ARX_41 ; $F8D0

ADD_ARU_ARX_1: ; $F92B
F92B   B5 A0                      LDI  A,$A0
F92D   A7 7A 04                   CPA  (ARX + $04)
F930   91 BE                      BCR ADD_ARU_ARX_42 ; $F874
F932   48 7A                      LDI  XH,$7A
F934   A5 7A 07                   LDA  (ARX + $07)
F937   F9                         REC
F938   B3 B0                      ADI  A,$B0
F93A   81 12                      BCR ADD_ARU_ARX_43 ; $F94E
F93C   CD 6C                      VMJ  ($6C)($36)
F93E   FD C8                      PSH  A
F940   4A 06                      LDI  XL,$06
F942   6A 05                      LDI  UL,$05

ADD_ARU_ARX_44: ; $F944
F944   B5 00                      LDI  A,$00
F946   8C                         DCA  (X)
F947   43                         SDE  X
F948   88 06                      LOP  UL,ADD_ARU_ARX_44 ; $F944
F94A   FD 8A                      POP  A
F94C   CD 52                      VMJ  ($52)($29)

ADD_ARU_ARX_43: ; $F94E
F94E   BA F6 3C                   JMP  ARX ; $F63C
F951   E4                         VEJ  (E4)
F952   E4                         VEJ  (E4)
F953   E4                         VEJ  (E4)
F954   E4                         VEJ  (E4)
F955   E4                         VEJ  (E4)
F956   E4                         VEJ  (E4)



TOKENIZE_INBUF: ; $F957
F957   68 00                      LDI  UH,$00

TOKENIZE_INBUF_4: ; $F959
F959   A5 78 8B                   LDA  (INBUFPTR_L)
F95C   1A                         STA  YL
F95D   58 7B                      LDI  YH,$7B
F95F   FD 18                      LDX  Y

TOKENIZE_INBUF_1: ; $F961
F961   55                         LIN  Y
F962   B7 27                      CPI  A,$27
F964   9B 05                      BZS TOKENIZE_INBUF_1 ; $F961
F966   B7 0D                      CPI  A,$0D
F968   89 04                      BZR TOKENIZE_INBUF_2 ; $F96E
F96A   68 00                      LDI  UH,$00
F96C   8E AA                      BCH VAR_TYPE_1 ; $FA18

TOKENIZE_INBUF_2: ; $F96E
F96E   B7 22                      CPI  A,$22
F970   89 2F                      BZR VAR_TYPE_2 ; $F9A1
F972   FD 62                      DEC  UH
F974   8B 02                      BZS TOKENIZE_INBUF_3 ; $F978
F976   68 01                      LDI  UH,$01

TOKENIZE_INBUF_3: ; $F978
F978   41                         SIN  X
F979   9E 1A                      BCH TOKENIZE_INBUF_1 ; $F961



VAR_TYPE: ; $F97B
F97B   68 00                      LDI  UH,$00
F97D   ED 78 85 80                BII  (CURVARTYPE),$80 ; $7885
F981   89 02                      BZR VAR_TYPE_3 ; $F985
F983   68 01                      LDI  UH,$01

VAR_TYPE_3: ; $F985
F985   BE F9 59                   SJP  (TOKENIZE_INBUF_4) ; $F959
F988   8B 15                      BZS VAR_TYPE_4 ; $F99F
F98A   06                         CPA  XL
F98B   83 0B                      BCS VAR_TYPE_5 ; $F998
F98D   A5 78 85                   LDA  (CURVARTYPE); $7885
F990   DB                         ROL
F991   83 06                      BCS VAR_TYPE_6 ; $F999
F993   CD 0C                      VMJ  ($0C)

VAR_TYPE_8: ; $F995
F995   C8 06                      VEJ  (C8) \ ABRF(VAR_TYPE_7) ; $F99D
F997   62                         DEC  UL

VAR_TYPE_5: ; $F998
F998   9A                         RTN

VAR_TYPE_6: ; $F999
F999   DE 04                      VEJ  (DE) \ ABRF(VAR_TYPE_4) ; $F99F
F99B   9E 08                      BCH VAR_TYPE_8 ; $F995

VAR_TYPE_7: ; $F99D
F99D   68 01                      LDI  UH,$01

VAR_TYPE_4: ; $F99F
F99F   F9                         REC
F9A0   9A                         RTN

VAR_TYPE_2: ; $F9A1
F9A1   6C 00                      CPI  UH,$00
F9A3   8B 06                      BZS VAR_TYPE_9 ; $F9AB
F9A5   B7 E0                      CPI  A,$E0
F9A7   91 31                      BCR TOKENIZE_INBUF_3 ; $F978
F9A9   8E 6D                      BCH VAR_TYPE_1 ; $FA18

VAR_TYPE_9: ; $F9AB
F9AB   B7 20                      CPI  A,$20
F9AD   9B 4E                      BZS TOKENIZE_INBUF_1 ; $F961
F9AF   B7 41                      CPI  A,$41
F9B1   91 3B                      BCR TOKENIZE_INBUF_3 ; $F978
F9B3   B7 5B                      CPI  A,$5B
F9B5   81 09                      BCR $F9C0
F9B7   B7 E0                      CPI  A,$E0
F9B9   91 43                      BCR TOKENIZE_INBUF_3 ; $F978
F9BB   28                         STA  UH
F9BC   55                         LIN  Y
F9BD   2A                         STA  UL
F9BE   8E 49                      BCH VAR_TYPE_10 ; $FA09
F9C0   FD 88                      PSH  X
F9C2   28                         STA  UH
F9C3   6A 60                      LDI  UL,$60
F9C5   48 C0                      LDI  XH,$C0
F9C7   A5 79 D0                   LDA  (PU_PV)

VAR_TYPE_22: ; $F9CA
F9CA   FD C8                      PSH  A
F9CC   4A 1E                      LDI  XL,$1E
F9CE   A4                         LDA  UH
F9CF   B9 1F                      ANI  A,$1F
F9D1   D9                         SHL
F9D2   FD CA                      ADR  X
F9D4   45                         LIN  X
F9D5   8B 69                      BZS VAR_TYPE_11 ; $FA40
F9D7   FD C8                      PSH  A
F9D9   05                         LDA  (X)
F9DA   0A                         STA  XL
F9DB   FD 8A                      POP  A
F9DD   08                         STA  XH

VAR_TYPE_20: ; $F9DE
F9DE   FD 98                      PSH  Y

VAR_TYPE_12: ; $F9E0
F9E0   55                         LIN  Y
F9E1   B7 20                      CPI  A,$20
F9E3   9B 05                      BZS VAR_TYPE_12 ; $F9E0
F9E5   B7 27                      CPI  A,$27
F9E7   9B 09                      BZS VAR_TYPE_12 ; $F9E0
F9E9   B7 2E                      CPI  A,$2E
F9EB   89 08                      BZR VAR_TYPE_13 ; $F9F5

VAR_TYPE_14: ; $F9ED
F9ED   B5 E0                      LDI  A,$E0
F9EF   F7                         CIN
F9F0   93 05                      BCS VAR_TYPE_14 ; $F9ED
F9F2   46                         DEC  X
F9F3   8E 08                      BCH VAR_TYPE_15 ; $F9FD

VAR_TYPE_13: ; $F9F5
F9F5   F7                         CIN
F9F6   89 38                      BZR VAR_TYPE_16 ; $FA30
F9F8   05                         LDA  (X)
F9F9   B7 E0                      CPI  A,$E0
F9FB   91 1D                      BCR VAR_TYPE_12 ; $F9E0

VAR_TYPE_15: ; $F9FD
F9FD   45                         LIN  X
F9FE   28                         STA  UH
F9FF   05                         LDA  (X)
FA00   2A                         STA  UL
FA01   FD 0A                      POP  X
FA03   FD 8A                      POP  A
FA05   CD 1E                      VMJ  ($1E)
FA07   FD 0A                      POP  X

VAR_TYPE_10: ; $FA09
FA09   A4                         LDA  UH
FA0A   41                         SIN  X
FA0B   24                         LDA  UL
FA0C   41                         SIN  X
FA0D   6C F1                      CPI  UH,$F1
FA0F   68 00                      LDI  UH,$00
FA11   99 B2                      BZR TOKENIZE_INBUF_1 ; $F961
FA13   6E AB                      CPI  UL,$AB
FA15   99 B6                      BZR TOKENIZE_INBUF_1 ; $F961

VAR_TYPE_17: ; $FA17
FA17   55                         LIN  Y

VAR_TYPE_1: ; $FA18
FA18   41                         SIN  X
FA19   B7 0D                      CPI  A,$0D
FA1B   99 06                      BZR VAR_TYPE_17 ; $FA17
FA1D   56                         DEC  Y
FA1E   46                         DEC  X
FA1F   FD 88                      PSH  X

VAR_TYPE_18: ; $FA21
FA21   0E                         STA  (X)
FA22   40                         INC  XL
FA23   91 04                      BCR VAR_TYPE_18 ; $FA21
FA25   FD 0A                      POP  X
FA27   A5 78 8B                   LDA  (INBUFPTR_L)
FA2A   1A                         STA  YL
FA2B   FD 62                      DEC  UH
FA2D   68 1C                      LDI  UH,$1C
FA2F   9A                         RTN

VAR_TYPE_16: ; $FA30
FA30   B5 E0                      LDI  A,$E0

VAR_TYPE_19: ; $FA32
FA32   F7                         CIN
FA33   93 03                      BCS VAR_TYPE_19 ; $FA32
FA35   44                         INC  X
FA36   44                         INC  X
FA37   44                         INC  X
FA38   45                         LIN  X
FA39   44                         INC  X
FA3A   B9 10                      ANI  A,$10
FA3C   FD 1A                      POP  Y
FA3E   9B 62                      BZS VAR_TYPE_20 ; $F9DE

VAR_TYPE_11: ; $FA40
FA40   FD 8A                      POP  A
FA42   CD 1E                      VMJ  ($1E)

VAR_TYPE_23: ; $FA44
FA44   24                         LDA  UL
FA45   BE FA 58                   SJP  (DEC_OPN)
FA48   2A                         STA  UL
FA49   83 06                      BCS VAR_TYPE_21 ; $FA51
FA4B   CD 3C                      VMJ  ($3C)
FA4D   9B 85                      BZS VAR_TYPE_22 ; $F9CA
FA4F   9E 0D                      BCH VAR_TYPE_23 ; $FA44

VAR_TYPE_21: ; $FA51
FA51   FD 0A                      POP  X
FA53   A4                         LDA  UH
FA54   68 00                      LDI  UH,$00
FA56   9E E0                      BCH TOKENIZE_INBUF_3 ; $F978



DEC_OPN: ; $FA58
FA58   BF 3C                      BII  A,$3C
FA5A   8B 05                      BZS $FA61
FA5C   FB                         SEC
FA5D   B1 04                      SBI  A,$04
FA5F   F9                         REC
FA60   9A                         RTN

DEC_OPN: ; $FA61
FA61   DB                         ROL
FA62   B5 DC                      LDI  A,$DC
FA64   9A                         RTN



SET_PV: ; $FA65
FA65   B9 FE                      ANI  A,$FE
FA67   FD BE                      RIE
FA69   B8                         RPV
FA6A   81 02                      BCR SET_PV_1 ; $FA6E
FA6C   A8                         SPV
FA6D   DD                         INC  A

SET_PV_1: ; $FA6E
FA6E   AE 79 D0                   STA  (PU_PV)
FA71   FD 81                      SIE
FA73   9A                         RTN




TOKEN_CHECK: ; $FA74
FA74   D9                         SHL

TOKEN_CHECK_1: ; $FA75
FA75   08                         STA  XH
FA76   A5 79 D0                   LDA  (PU_PV)
FA79   FD C8                      PSH  A
FA7B   BE FA 65                   SJP  (SET_PV)
FA7E   4A 00                      LDI  XL,$00
FA80   05                         LDA  (X)
FA81   0A                         STA  XL
FA82   FD 8A                      POP  A
FA84   4E 55                      CPI  XL,$55
FA86   89 A2                      BZR PVBANK2
FA88   9A                         RTN



TOKEN_PROCESS: ; $FA89
FA89   FD 0A                      POP  X
FA8B   45                         LIN  X
FA8C   FD 88                      PSH  X
FA8E   6C F2                      CPI  UH,$F2
FA90   83 50                      BCS TOKEN_PROCESS_1 ; $FAE2
FA92   FD C8                      PSH  A
FA94   E9 79 D1 FC                ANI  (OPN),$FC
FA98   A5 79 D1                   LDA  (OPN)
FA9B   6C F0                      CPI  UH,$F0
FA9D   89 05                      BZR TOKEN_PROCESS_2 ; $FAA4

TOKEN_PROCESS_9: ; $FA9F
FA9F   FD C8                      PSH  A

TOKEN_PROCESS_4: ; $FAA1
FAA1   D9                         SHL
FAA2   8E 0C                      BCH TOKEN_PROCESS_3 ; $FAB0

TOKEN_PROCESS_2: ; $FAA4
FAA4   B5 60                      LDI  A,$60
FAA6   93 07                      BCS TOKEN_PROCESS_4 ; $FAA1
FAA8   FB                         SEC
FAA9   A4                         LDA  UH
FAAA   B9 07                      ANI  A,$07
FAAC   F1                         AEX
FAAD   D1                         ROR
FAAE   6C E8                      CPI  UH,$E8

TOKEN_PROCESS_3: ; $FAB0
FAB0   BE FA 75                   SJP  (TOKEN_CHECK_1) ; $FA75
FAB3   81 10                      BCR TOKEN_PROCESS_5 ; $FAC5
FAB5   FD C8                      PSH  A
FAB7   4A 51                      LDI  XL,$51

TOKEN_PROCESS_10: ; $FAB9
FAB9   44                         INC  X

TOKEN_PROCESS_11: ; $FABA
FABA   44                         INC  X
FABB   44                         INC  X
FABC   45                         LIN  X
FABD   B9 0F                      ANI  A,$0F
FABF   89 26                      BZR TOKEN_PROCESS_6 ; $FAE7
FAC1   FD 8A                      POP  A
FAC3   CD 1E                      VMJ  ($1E)

TOKEN_PROCESS_5: ; $FAC5
FAC5   FD 8A                      POP  A
FAC7   6C F0                      CPI  UH,$F0
FAC9   89 17                      BZR TOKEN_PROCESS_1 ; $FAE2
FACB   A7 79 D1                   CPA  (OPN)
FACE   89 04                      BZR TOKEN_PROCESS_7 ; $FAD4
FAD0   B5 60                      LDI  A,$60
FAD2   8E 05                      BCH TOKEN_PROCESS_8 ; $FAD9

TOKEN_PROCESS_7: ; $FAD4
FAD4   BE FA 58                   SJP  (DEC_OPN)
FAD7   83 07                      BCS $FAE0

TOKEN_PROCESS_8: ; $FAD9
FAD9   A7 79 D1                   CPA  (OPN)
FADC   9B 0A                      BZS TOKEN_PROCESS_7 ; $FAD4
FADE   9E 41                      BCH TOKEN_PROCESS_9 ; $FA9F
FAE0   FD 8A                      POP  A

TOKEN_PROCESS_1: ; $FAE2
FAE2   B5 00                      LDI  A,$00
FAE4   68 1B                      LDI  UH,$1B
FAE6   9A                         RTN

TOKEN_PROCESS_6: ; $FAE7
FAE7   FD CA                      ADR  X
FAE9   45                         LIN  X
FAEA   A6                         CPA  UH
FAEB   99 34                      BZR TOKEN_PROCESS_10 ; $FAB9
FAED   45                         LIN  X
FAEE   26                         CPA  UL
FAEF   99 37                      BZR TOKEN_PROCESS_11 ; $FABA
FAF1   6C F0                      CPI  UH,$F0
FAF3   89 06                      BZR TOKEN_PROCESS_12 ; $FAFB
FAF5   FD 8A                      POP  A
FAF7   FD 2A                      POP  U
FAF9   8E 03                      BCH TOKEN_PROCESS_13 ; $FAFE

TOKEN_PROCESS_12: ; $FAFB
FAFB   FD 2A                      POP  U
FAFD   A4                         LDA  UH

TOKEN_PROCESS_13: ; $FAFE
FAFE   FD C8                      PSH  A
FB00   24                         LDA  UL
FB01   8B 77                      BZS PVBANK2_1 ; $FB7A
FB03   D5                         SHR
FB04   83 34                      BCS PVBANK2_2 ; $FB3A
FB06   FD C8                      PSH  A
FB08   46                         DEC  X
FB09   47                         LDE  X
FB0A   2A                         STA  UL
FB0B   47                         LDE  X
FB0C   28                         STA  UH

TOKEN_PROCESS_14: ; $FB0D
FB0D   46                         DEC  X
FB0E   05                         LDA  (X)
FB0F   B7 80                      CPI  A,$80
FB11   91 06                      BCR TOKEN_PROCESS_14 ; $FB0D
FB13   FD 8A                      POP  A
FB15   D1                         ROR
FB16   83 08                      BCS TOKEN_PROCESS_15 ; $FB20
FB18   FD 8A                      POP  A
FB1A   D5                         SHR
FB1B   05                         LDA  (X)
FB1C   B9 0F                      ANI  A,$0F
FB1E   8E 0D                      BCH PVBANK2_3 ; $FB2D

TOKEN_PROCESS_15: ; $FB20
FB20   45                         LIN  X
FB21   B9 0F                      ANI  A,$0F
FB23   DF                         DEC  A
FB24   2A                         STA  UL

TOKEN_PROCESS_16: ; $FB25
FB25   F5                         TIN
FB26   88 03                      LOP  UL,TOKEN_PROCESS_16 ; $FB25
FB28   FD 8A                      POP  A



PVBANK2: ; $FB2A
FB2A   D1                         ROR
FB2B   B5 EF                      LDI  A,$EF

PVBANK2_3: ; $FB2D
FB2D   FD C8                      PSH  A
FB2F   A5 79 D0                   LDA  (PU_PV)
FB32   BE FA 65                   SJP  (SET_PV)
FB35   FD 8A                      POP  A
FB37   9A                         RTN

PVBANK2_10: ; $FB38
FB38   FD C8                      PSH  A

PVBANK2_2: ; $FB3A
FB3A   6A 28                      LDI  UL,$28
FB3C   68 FB                      LDI  UH,$FB
FB3E   FD A8                      PSH  U
FB40   FD 6A                      STX  U
FB42   65                         LIN  U
FB43   08                         STA  XH
FB44   65                         LIN  U
FB45   0A                         STA  XL
FB46   65                         LIN  U
FB47   D9                         SHL
FB48   D9                         SHL
FB49   83 2A                      BCS PVBANK2_4 ; $FB75
FB4B   2A                         STA  UL
FB4C   68 12                      LDI  UH,$12
FB4E   A5 78 8C                   LDA  (NUMARGS)
FB51   DF                         DEC  A
FB52   89 25                      BZR PVBANK2_5 ; $FB79
FB54   B5 B2                      LDI  A,$B2
FB56   A7 7A 04                   CPA  (ARX + $04)
FB59   B5 00                      LDI  A,$00
FB5B   D1                         ROR
FB5C   68 11                      LDI  UH,$11
FB5E   22                         ADC  UL
FB5F   D9                         SHL
FB60   83 17                      BCS PVBANK2_5 ; $FB79
FB62   6E 80                      CPI  UL,$80
FB64   81 0F                      BCR PVBANK2_4 ; $FB75
FB66   84                         LDA  XH
FB67   B7 80                      CPI  A,$80
FB69   BB 80                      ORI  A,$80
FB6B   08                         STA  XH
FB6C   81 07                      BCR PVBANK2_4 ; $FB75
FB6E   FD 88                      PSH  X
FB70   D2 05 80                   VEJ  (D2) \ ABRF($FB78) \ ABYT($80)
FB73   FD 0A                      POP  X

PVBANK2_4: ; $FB75
FB75   FD 5E                      STX  P
FB77   FD 0A                      POP  X

PVBANK2_5: ; $FB79
FB79   9A                         RTN

PVBANK2_1: ; $FB7A
FB7A   FD 6A                      STX  U
FB7C   65                         LIN  U
FB7D   08                         STA  XH
FB7E   65                         LIN  U
FB7F   0A                         STA  XL
FB80   D8                         VEJ  (D8)
FB81   89 10                      BZR PVBANK2_6 ; $FB93
FB83   B5 20                      LDI  A,$20
FB85   6D 60                      BII  (U),$60
FB87   89 0C                      BZR PVBANK2_7 ; $FB95
FB89   68 1A                      LDI  UH,$1A
FB8B   45                         LIN  X
FB8C   A9 76 4F                   AND  (DISP_BUFF + $4F)
FB8F   8B 0B                      BZS PVBANK2_8 ; $FB9C

PVBANK2_9: ; $FB91
FB91   FD 5E                      STX  P

PVBANK2_6: ; $FB93
FB93   B5 00                      LDI  A,$00

PVBANK2_7: ; $FB95
FB95   2D                         EOR  (U)
FB96   B9 60                      ANI  A,$60
FB98   99 09                      BZR PVBANK2_9 ; $FB91
FB9A   68 01                      LDI  UH,$01

PVBANK2_8: ; $FB9C
FB9C   E0                         VEJ  (E0)



TRACE2: ; $FB9D
FB9D   AE 78 8E                   STA  (TRACE)
FBA0   B7 02                      CPI  A,$02
FBA2   A5 78 8D                   LDA  (TRACE_ON)
FBA5   8B 21                      BZS TRACE2_1 ; $FBC8
FBA7   81 12                      BCR TRACE2_2 ; $FBBB
FBA9   B7 58                      CPI  A,$58
FBAB   8B 0E                      BZS TRACE2_2 ; $FBBB
FBAD   CD 3C                      VMJ  ($3C)
FBAF   89 08                      BZR TRACE2_3 ; $FBB9
FBB1   4A 1D                      LDI  XL,$1D
FBB3   BE FB 38                   SJP  (PVBANK2_10) ; $FB38
FBB6   A4                         LDA  UH
FBB7   89 0E                      BZR TRACE2_4 ; $FBC7

TRACE2_3: ; $FBB9
FBB9   B5 58                      LDI  A,$58

TRACE2_2: ; $FBBB
FBBB   68 00                      LDI  UH,$00
FBBD   CD 3C                      VMJ  ($3C)
FBBF   4A 1D                      LDI  XL,$1D
FBC1   89 03                      BZR TRACE2_5 ; $FBC6
FBC3   BE FB 38                   SJP  (PVBANK2_10) ; $FB38

TRACE2_5: ; $FBC6
FBC6   A4                         LDA  UH

TRACE2_4: ; $FBC7
FBC7   9A                         RTN

TRACE2_1: ; $FBC8
FBC8   93 11                      BCS TRACE2_3 ; $FBB9
FBCA   9A                         RTN



STRXFR: ; $FBCB
FBCB   FD 98                      PSH  Y
FBCD   48 7B                      LDI  XH,$7B
FBCF   58 7B                      LDI  YH,$7B
FBD1   4A 10                      LDI  XL,$10
FBD3   5A 60                      LDI  YL,$60
FBD5   81 04                      BCR STRXFR_1 ; $FBDB
FBD7   4A 60                      LDI  XL,$60
FBD9   5A 10                      LDI  YL,$10

STRXFR_1: ; $FBDB
FBDB   6A 4F                      LDI  UL,$4F
FBDD   BA DC 28                   JMP  ISARXBCD_13 ; $DC28
FBE0   E4                         VEJ  (E4)
FBE1   E4                         VEJ  (E4)
FBE2   E4                         VEJ  (E4)
FBE3   E4                         VEJ  (E4)
FBE4   E4                         VEJ  (E4)
FBE5   E4                         VEJ  (E4)
FBE6   E4                         VEJ  (E4)
FBE7   E4                         VEJ  (E4)
FBE8   E4                         VEJ  (E4)


AUX_CONST:
FBE9   FF 00 90 00 00 10 01 00    .BYTE  $FF,$00,$90,$00,$00,$10,$01,$00
FBF1   90 02 00 18 FF 00 60 00    .BYTE  $90,$02,$00,$18,$FF,$00,$60,$00
FBF9   00 31 41 59 26 53 59 00    .BYTE  $00,$31,$41,$59,$26,$53,$59,$00
FC01   00 30 10 29 99 56 64 00    .BYTE  $00,$30,$10,$29,$99,$56,$64,$00
FC09   00 41 39 26 85 15 82 00    .BYTE  $00,$41,$39,$26,$85,$15,$82,$00
FC11   00 43 21 37 37 82 64 00    .BYTE  $00,$43,$21,$37,$37,$82,$64,$00
FC19   00 43 40 77 47 93 19 00    .BYTE  $00,$43,$40,$77,$47,$93,$19,$00
FC21   00 43 42 72 76 86 27 00    .BYTE  $00,$43,$42,$72,$76,$86,$27,$00
FC29   00 43 42 92 31 04 45 00    .BYTE  $00,$43,$42,$92,$31,$04,$45,$00
FC31   00 43 42 94 26 47 56 00    .BYTE  $00,$43,$42,$94,$26,$47,$56,$00
FC39   00 43 42 94 46 01 89 00    .BYTE  $00,$43,$42,$94,$46,$01,$89,$00
FC41   00 43 42 94 47 97 32 00    .BYTE  $00,$43,$42,$94,$47,$97,$32,$00
FC49   00 43 42 94 48 16 86 00    .BYTE  $00,$43,$42,$94,$48,$16,$86,$00
FC51   00 43 42 94 48 18 82 00    .BYTE  $00,$43,$42,$94,$48,$18,$82,$00
FC59   00 43 42 94 48 19 01 FF    .BYTE  $00,$43,$42,$94,$48,$19,$01,$FF
FC61   00 43 42 94 48 19 03 00    .BYTE  $00,$43,$42,$94,$48,$19,$03,$00
FC69   00 45 00 00 00 00 00 00    .BYTE  $00,$45,$00,$00,$00,$00,$00,$00
FC71   00 57 10 59 31 37 50 00    .BYTE  $00,$57,$10,$59,$31,$37,$50,$00
FC79   00 57 29 38 69 76 83 00    .BYTE  $00,$57,$29,$38,$69,$76,$83,$00
FC81   00 57 29 57 60 41 45 00    .BYTE  $00,$57,$29,$57,$60,$41,$45,$00
FC89   00 57 29 57 79 32 21 00    .BYTE  $00,$57,$29,$57,$79,$32,$21,$00
FC91   00 57 29 57 79 51 11 01    .BYTE  $00,$57,$29,$57,$79,$51,$11,$01
FC99   00 57 29 57 79 51 31       .BYTE  $00,$57,$29,$57,$79,$51,$31


CHARSET:
FCA0   00 00 00 00 00 00 00 5F    .BYTE  $00,$00,$00,$00,$00,$00,$00,$5F
FCA8   00 00 00 03 04 03 00 22    .BYTE  $00,$00,$00,$03,$04,$03,$00,$22
FCB0   7F 22 7F 22 24 2A 7F 2A    .BYTE  $7F,$22,$7F,$22,$24,$2A,$7F,$2A
FCB8   12 23 13 08 64 62 36 49    .BYTE  $12,$23,$13,$08,$64,$62,$36,$49
FCC0   55 22 50 63 41 41 41 63    .BYTE  $55,$22,$50,$63,$41,$41,$41,$63
FCC8   00 1C 22 41 00 00 41 22    .BYTE  $00,$1C,$22,$41,$00,$00,$41,$22
FCD0   1C 00 14 08 3E 08 14 08    .BYTE  $1C,$00,$14,$08,$3E,$08,$14,$08
FCD8   08 3E 08 08 00 58 38 00    .BYTE  $08,$3E,$08,$08,$00,$58,$38,$00
FCE0   00 08 08 08 08 08 00 60    .BYTE  $00,$08,$08,$08,$08,$08,$00,$60
FCE8   60 00 00 20 10 08 04 02    .BYTE  $60,$00,$00,$20,$10,$08,$04,$02
FCF0   3E 51 49 45 3E 00 42 7F    .BYTE  $3E,$51,$49,$45,$3E,$00,$42,$7F
FCF8   40 00 42 61 51 49 46 41    .BYTE  $40,$00,$42,$61,$51,$49,$46,$41
FD00   49 4D 4B 31 18 14 12 7F    .BYTE  $49,$4D,$4B,$31,$18,$14,$12,$7F
FD08   10 27 45 45 45 39 3C 4A    .BYTE  $10,$27,$45,$45,$45,$39,$3C,$4A
FD10   49 49 30 01 01 79 05 03    .BYTE  $49,$49,$30,$01,$01,$79,$05,$03
FD18   36 49 49 49 36 06 49 49    .BYTE  $36,$49,$49,$49,$36,$06,$49,$49
FD20   29 1E 00 36 36 00 00 00    .BYTE  $29,$1E,$00,$36,$36,$00,$00,$00
FD28   5B 3B 00 00 08 14 22 41    .BYTE  $5B,$3B,$00,$00,$08,$14,$22,$41
FD30   00 14 14 14 14 14 00 41    .BYTE  $00,$14,$14,$14,$14,$14,$00,$41
FD38   22 14 08 02 01 51 09 06    .BYTE  $22,$14,$08,$02,$01,$51,$09,$06
FD40   32 49 79 41 3E 7C 12 11    .BYTE  $32,$49,$79,$41,$3E,$7C,$12,$11
FD48   12 7C 41 7F 49 49 36 3E    .BYTE  $12,$7C,$41,$7F,$49,$49,$36,$3E
FD50   41 41 41 22 41 7F 41 41    .BYTE  $41,$41,$41,$22,$41,$7F,$41,$41
FD58   3E 7F 49 49 49 41 7F 09    .BYTE  $3E,$7F,$49,$49,$49,$41,$7F,$09
FD60   09 09 01 3E 41 41 49 39    .BYTE  $09,$09,$01,$3E,$41,$41,$49,$39
FD68   7F 08 08 08 7F 00 41 7F    .BYTE  $7F,$08,$08,$08,$7F,$00,$41,$7F
FD70   41 00 20 40 41 3F 01 7F    .BYTE  $41,$00,$20,$40,$41,$3F,$01,$7F
FD78   08 14 22 41 7F 40 40 40    .BYTE  $08,$14,$22,$41,$7F,$40,$40,$40
FD80   40 7F 02 0C 02 7F 7F 04    .BYTE  $40,$7F,$02,$0C,$02,$7F,$7F,$04
FD88   08 10 7F 3E 41 41 41 3E    .BYTE  $08,$10,$7F,$3E,$41,$41,$41,$3E
FD90   7F 09 09 09 06 3E 41 51    .BYTE  $7F,$09,$09,$09,$06,$3E,$41,$51
FD98   21 5E 7F 09 19 29 46 26    .BYTE  $21,$5E,$7F,$09,$19,$29,$46,$26
FDA0   49 49 49 32 01 01 7F 01    .BYTE  $49,$49,$49,$32,$01,$01,$7F,$01
FDA8   01 3F 40 40 40 3F 07 18    .BYTE  $01,$3F,$40,$40,$40,$3F,$07,$18
FDB0   60 18 07 7F 20 18 20 7F    .BYTE  $60,$18,$07,$7F,$20,$18,$20,$7F
FDB8   63 14 08 14 63 03 04 78    .BYTE  $63,$14,$08,$14,$63,$03,$04,$78
FDC0   04 03 61 51 49 45 43 10    .BYTE  $04,$03,$61,$51,$49,$45,$43,$10
FDC8   20 7F 01 01 15 16 7C 16    .BYTE  $20,$7F,$01,$01,$15,$16,$7C,$16
FDD0   15 41 3F 01 3F 41 18 04    .BYTE  $15,$41,$3F,$01,$3F,$41,$18,$04
FDD8   02 04 18 40 40 40 40 40    .BYTE  $02,$04,$18,$40,$40,$40,$40,$40
FDE0   00 00 00 00 00 38 44 44    .BYTE  $00,$00,$00,$00,$00,$38,$44,$44
FDE8   3C 40 7F 48 44 44 38 38    .BYTE  $3C,$40,$7F,$48,$44,$44,$38,$38
FDF0   44 44 44 20 38 44 44 48    .BYTE  $44,$44,$44,$20,$38,$44,$44,$48
FDF8   7F 38 54 54 54 18 00 08    .BYTE  $7F,$38,$54,$54,$54,$18,$00,$08
FE00   7E 09 02 08 54 54 3C 00    .BYTE  $7E,$09,$02,$08,$54,$54,$3C,$00
FE08   7F 04 04 78 00 00 00 7D    .BYTE  $7F,$04,$04,$78,$00,$00,$00,$7D
FE10   00 00 20 40 44 3D 00 7F    .BYTE  $00,$00,$20,$40,$44,$3D,$00,$7F
FE18   10 28 44 00 00 00 7F 00    .BYTE  $10,$28,$44,$00,$00,$00,$7F,$00
FE20   00 78 04 78 04 78 7C 08    .BYTE  $00,$78,$04,$78,$04,$78,$7C,$08
FE28   04 04 78 38 44 44 44 38    .BYTE  $04,$04,$78,$38,$44,$44,$44,$38
FE30   7C 14 14 14 08 18 24 14    .BYTE  $7C,$14,$14,$14,$08,$18,$24,$14
FE38   7C 40 7C 08 04 04 00 48    .BYTE  $7C,$40,$7C,$08,$04,$04,$00,$48
FE40   54 54 54 20 04 3E 44 20    .BYTE  $54,$54,$54,$20,$04,$3E,$44,$20
FE48   00 3C 40 40 20 7C 1C 20    .BYTE  $00,$3C,$40,$40,$20,$7C,$1C,$20
FE50   40 20 1C 3C 40 30 40 3C    .BYTE  $40,$20,$1C,$3C,$40,$30,$40,$3C
FE58   44 24 7C 48 44 0C 50 50    .BYTE  $44,$24,$7C,$48,$44,$0C,$50,$50
FE60   3C 00 44 64 54 4C 44 00    .BYTE  $3C,$00,$44,$64,$54,$4C,$44,$00
FE68   08 77 41 00 00 00 77 00    .BYTE  $08,$77,$41,$00,$00,$00,$77,$00
FE70   00 00 41 77 08 00 08 04    .BYTE  $00,$00,$41,$77,$08,$00,$08,$04
FE78   08 10 08 FF FF FF FF FF    .BYTE  $08,$10,$08,$FF,$FF,$FF,$FF,$FF


KB_LAYOUT_NORM:
FE80   0B 4E 59 01 48 38 35 32    .BYTE  $0B,$4E,$59,$01,$48,$38,$35,$32
FE88   09 58 57 11 53 0F 2D 2E    .BYTE  $09,$58,$57,$11,$53,$0F,$2D,$2E
FE90   30 4D 55 15 4A 37 34 31    .BYTE  $30,$4D,$55,$15,$4A,$37,$34,$31
FE98   0D 28 49 16 4B 4F 4C 29    .BYTE  $0D,$28,$49,$16,$4B,$4F,$4C,$29
FEA0   19 43 45 12 44 2F 2A 2B    .BYTE  $19,$43,$45,$12,$44,$2F,$2A,$2B
FEA8   20 56 52 13 46 50 08 3D    .BYTE  $20,$56,$52,$13,$46,$50,$08,$3D
FEB0   02 5A 51 1B 41 18 1F 0C    .BYTE  $02,$5A,$51,$1B,$41,$18,$1F,$0C
FEB8   0A 42 54 14 47 39 36 33    .BYTE  $0A,$42,$54,$14,$47,$39,$36,$33


KB_LAYOUT_SH:
FEC0   5B 6E 79 01 68 38 35 32    .BYTE  $5B,$6E,$79,$01,$68,$38,$35,$32
FEC8   09 78 77 21 73 0F 2C 2E    .BYTE  $09,$78,$77,$21,$73,$0F,$2C,$2E
FED0   30 6D 75 25 6A 37 34 31    .BYTE  $30,$6D,$75,$25,$6A,$37,$34,$31
FED8   0D 3C 69 26 6B 6F 6C 3E    .BYTE  $0D,$3C,$69,$26,$6B,$6F,$6C,$3E
FEE0   19 63 65 22 64 3F 3A 3B    .BYTE  $19,$63,$65,$22,$64,$3F,$3A,$3B
FEE8   5E 76 72 23 66 70 1D 40    .BYTE  $5E,$76,$72,$23,$66,$70,$1D,$40
FEF0   02 7A 71 1B 61 1A 1E 1C    .BYTE  $02,$7A,$71,$1B,$61,$1A,$1E,$1C
FEF8   5D 62 74 24 67 39 36 33    .BYTE  $5D,$62,$74,$24,$67,$39,$36,$33


CALL_VECTORS:
FF00   DC B7 DC B6 DC C6 D0 65    .BYTE  $DC,$B7,$DC,$B6,$DC,$C6,$D0,$65
FF08   DD D9 DE 5E DE 97 D4 61    .BYTE  $DD,$D9,$DE,$5E,$DE,$97,$D4,$61
FF10   DD 2D DF 93 DF FA DF F5    .BYTE  $DD,$2D,$DF,$93,$DF,$FA,$DF,$F5
FF18   DF 80 D2 E6 FA 89 FB 2A    .BYTE  $DF,$80,$D2,$E6,$FA,$89,$FB,$2A
FF20   DF 72 DF 63 DE AF DB 87    .BYTE  $DF,$72,$DF,$63,$DE,$AF,$DB,$87
FF28   DB B1 D0 3E DC A6 D6 C0    .BYTE  $DB,$B1,$D0,$3E,$DC,$A6,$D6,$C0
FF30   DC 16 D0 71 DF 23 DF 0F    .BYTE  $DC,$16,$D0,$71,$DF,$23,$DF,$0F
FF38   CE 9F CF FB FA 74 FB 9D    .BYTE  $CE,$9F,$CF,$FB,$FA,$74,$FB,$9D
FF40   C4 01 CA 58 CA 7A CA 80    .BYTE  $C4,$01,$CA,$58,$CA,$7A,$CA,$80
FF48   DC F9 DC FD DC E9 DC ED    .BYTE  $DC,$F9,$DC,$FD,$DC,$E9,$DC,$ED
FF50   DA 71 F6 63 F7 B0 F7 3D    .BYTE  $DA,$71,$F6,$63,$F7,$B0,$F7,$3D
FF58   F0 84 E5 73 F6 1B F7 A7    .BYTE  $F0,$84,$E5,$73,$F6,$1B,$F7,$A7
FF60   F6 B4 F8 8B F7 B5 F7 B9    .BYTE  $F6,$B4,$F8,$8B,$F7,$B5,$F7,$B9
FF68   F7 15 F8 8F F6 FB F0 80    .BYTE  $F7,$15,$F8,$8F,$F6,$FB,$F0,$80
FF70   F7 47 F7 CE F7 75 F7 5F    .BYTE  $F7,$47,$F7,$CE,$F7,$75,$F7,$5F
FF78   F7 2F F7 DD F6 E6 F0 1A    .BYTE  $F7,$2F,$F7,$DD,$F6,$E6,$F0,$1A
FF80   F7 07 F7 29 EF 00 EB 40    .BYTE  $F7,$07,$F7,$29,$EF,$00,$EB,$40
FF88   ED F6 ED 5B EE 1F ED B1    .BYTE  $ED,$F6,$ED,$5B,$EE,$1F,$ED,$B1
FF90   ED AB ED 00 EC 5C EA 78    .BYTE  $ED,$AB,$ED,$00,$EC,$5C,$EA,$78
FF98   EC 74 EC EB EC B7 E4 A0    .BYTE  $EC,$74,$EC,$EB,$EC,$B7,$E4,$A0
FFA0   E2 34 E6 55 B8 88 E4 51    .BYTE  $E2,$34,$E6,$55,$B8,$88,$E4,$51
FFA8   B8 8B B8 8E E8 8C B8 91    .BYTE  $B8,$8B,$B8,$8E,$E8,$8C,$B8,$91
FFB0   B8 94 B8 97 B8 9A B8 9D    .BYTE  $B8,$94,$B8,$97,$B8,$9A,$B8,$9D
FFB8   B8 A0 F7 63 E4 B7 E4 A8    .BYTE  $B8,$A0,$F7,$63,$E4,$B7,$E4,$A8
FFC0   DD 08 DC D4 DC D5 DD 13    .BYTE  $DD,$08,$DC,$D4,$DC,$D5,$DD,$13
FFC8   DC C5 C0 01 DD C8 D4 5D    .BYTE  $DC,$C5,$C0,$01,$DD,$C8,$D4,$5D
FFD0   D5 F9 DD 1A DE E3 DE D1    .BYTE  $D5,$F9,$DD,$1A,$DE,$E3,$DE,$D1
FFD8   DF 3B C0 0E DE BC D6 DF    .BYTE  $DF,$3B,$C0,$0E,$DE,$BC,$D6,$DF
FFE0   CD 8B C4 00 CD 89 F7 0D    .BYTE  $CD,$8B,$C4,$00,$CD,$89,$F7,$0D
FFE8   F6 61 F7 9C F7 57 F7 CC    .BYTE  $F6,$61,$F7,$9C,$F7,$57,$F7,$CC
FFF0   EF BA EE 71 DB BC DD B5    .BYTE  $EF,$BA,$EE,$71,$DB,$BC,$DD,$B5
FFF8   E1 71 E2 2C E2 2B E0 00    .BYTE  $E1,$71,$E2,$2C,$E2,$2B,$E0,$00
