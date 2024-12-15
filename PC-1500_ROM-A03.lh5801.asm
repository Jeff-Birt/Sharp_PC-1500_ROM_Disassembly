; PC-1500_ROM-A03.lh5801.asm
; PEEK &C443=59 (&3B). PEEK &C5BD=129 (&81). 
; Disassembly of ROM version 
; To fold: Hightlight Ctrl+K Ctrl+,
;

; PC-1500 versions via CGH
; Checksum  Peeks     : Version    - Notes
; &B1D9     {56, 129} : A01 = ROM0 - PC1500 (early-mid 1982) -> PEEK &E2B9 <> 56, which makes the keyboard driver unusable.
; &NNNN     {xx, yy}  : A02 = ROM? - No information or to be specified.
; &AE48     {59, 129} : A03 = ROM1 - PC1500 (12/1982) = PC2
; &AA1E     {59, 74}  : A04 = ROM2 - PC1500 = PC1500A = PC2
; &7CCD     {xx, yy}  : A0x = ROM(3) ? PC1600 (A priori the ROM1500 in the PC1600 is different)
; (NB: the values in curly brackets are the results of PEEK &C443 and PEEK &C5BD respectively).

; The code to calculate the ROM checksum:
; POKE &78C0,&34,&08,&0A,&2A,&68,&C0,&65,&FD,&CA,&6C,&00,&99,&07,&FB,&9A
; Then do CALL &78C0,X as an output, the checksum is in X. If X is negative, press 65536-X

#INCLUDE    "lib/PC-1500.lib"
; #INCLUDE    "lib/CE-150.lib"
; #INCLUDE    "lib/CE-158.lib"
; #INCLUDE    "lib/CE-158N.lib"
#INCLUDE    "lib/PC-1500_Macros.lib"

; Modifications enabled by uncommenting #DEFINEs.
; DEFINE  - Description
; DEFINE  - Description

.org $C000

; Marking for token table from C020
ST_MAIN_ROM: ; $C000
    .BYTE  $55



;------------------------------------------------------------------------------
; (CA) Transfer 16-bit value from X-Reg to memory page 7BXX
;            Address: C001 (CA)
;                     D1: sets low byte in memory page 78XX
;   Entry parameters: None
;
; Modified registers: X-Reg was saved after (7801 f.). U-Reg points to the 
;                     next address of 7801. Accumulator= XL
;   Error conditions: None
;------------------------------------------------------------------------------
SA_XREG_2RAM: ; $C001
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


; (DA) Variable address from U-Reg, length from AR-X to variable pointer
SAVEVARPTR_ARX_SRC: ; $C00E
    LDA  (ARX + $07)

; Store address from U-Reg and Accumulator.
SAVEVARPTR_A: ; $C011
    STA  (CURVARTYPE)   ; CURVARTYPE = $7885
    LDA  UL
    STA  (CURVARADD_L)
    LDA  UH
    STA  (CURVARADD_H)
    RTN


; Trace vector of this token table
TRACE_VEC: ; $C01D
    .BYTE  $C4,$AF
    .BYTE  $FF



; Auxiliary table for detecting Basic commands. The following addresses point to the 2nd letter of the Basic command, where the 1st letter of the commands in the token table has changed.
ST_BAS_TBL: ; $C020
    .BYTE  $C0,$56,$C0,$99,$C0,$A2,$C0,$E2
    .BYTE  $C1,$0E,$C1,$28,$C1,$30,$00,$00
    .BYTE  $C1,$63,$00,$00,$00,$00,$C1,$87
    .BYTE  $C1,$C2,$C1,$D3,$C1,$EC,$C2,$0A
    .BYTE  $00,$00,$C2,$5F,$C2,$B8,$C2,$F6
    .BYTE  $C3,$2A,$C3,$3F,$C3,$47,$00,$00
    .BYTE  $00,$00,$00,$00



; TOKEN TABLE
TOKEN_TBL: ; $C054
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



; Messages
SM_NEW0: ; $C34F 
    .BYTE  $4E,$45,$57,$30,$3F,$20,$3A,$43
    .BYTE  $48,$45,$43,$4B,$20              ; NEW0? :CHECK

SM_BREAK: ; $C35C
    .BYTE  $42,$52,$45,$41,$4B,$20          ; BREAK

SM_IN: ; $C362
    .BYTE  $49,$4E,$20                      ; IN

SM_ERROR: ; $C36B
    .BYTE  $45,$52,$52,$4F,$52,$20          ; Error



; Table for occupied DEF keys
DEFKEY_TBL: ; $C36B
    .BYTE  $20,$41,$42,$43,$44,$F0,$46,$47
    .BYTE  $48,$F0,$4A,$4B,$4C,$4D,$4E,$F0
    .BYTE  $F0,$F0,$F1,$53,$F1,$F0,$56,$F0
    .BYTE  $58,$F1,$5A,$20,$20,$3D,$20,$20



; Address table for editor control characters
EDCTRL_TBL: ; $C38B
    .BYTE  $CA,$64,$CB,$61,$CA,$55,$CA,$80
    .BYTE  $CB,$C7,$CB,$CF,$CB,$9C,$CB,$A0
    .BYTE  $CC,$22,$CB,$69,$CC,$48,$CC,$38
    .BYTE  $CB,$E4,$CC,$C1,$C4



; Operator table for formula evaluation of the subroutines (DE), (D6DF)
FVAL_TBLE: ; $C3A8
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


; (E2) - BASIC interpreter: Y-Reg points to command or line end
BASIC_INT: ; $ C400
    VEJ  (C0)

; (40) - Process command in U-Reg  
    VEJ  (D8)
    BZR  BASIC_INT_1 ; $C409
    CPI  UL,$0D
    VZS  ($42) ; *** orig VZS  ($42)($21) second argument wrong?
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
    CPI  A,$C0       ; B7 C0
    BCR  BCMD_LET_4  ; 81 82 $C4A5
    SJP  (KEY2ASCII)
    CPI  A,$0A
    BZR BCMD_LET_4  ; $C4A5

BASIC_INT_2: ; $C42A
    VMJ  ($A6) ; *** orig VMJ  ($A6) ; ($A6)($53) second argument is bogus
    BZR  BCMD_STOP_2 ; $C4BA

BASIC_INT_11: ; $C42E
    LDA  (CURR_LINE_H)
    INC  A
    BZS  BCMD_END_1  ; $C510
    LDA  YH
    SHL
    BCS  BASIC_INT_3 ; $C444 $83 0A $C442

BASIC_INT_10: ; $C438
    LDI  A,$01
    VMJ  ($3E)
    VZR  ($00) \ ABYT($CD) \ ABYT($22) \ ABRF(BCMD_STOP_3) ; $C4C2
    LDA  (X)
    BCH  BASIC_INT_1; $C409 

BASIC_INT_3: ; $C442
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



; BASIC command LET
BCMD_LET: ; $C458
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
    VZR  ($40) ; orig ($40)($20) $20 is bogus
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
    BZS BCMD_LET_9 ; BCMD_STOP_6 ; $C4AD
    LDI  UL,$00

BCMD_LET_9: ; $????
    BCH BCMD_STOP_5 ; $C4BC



; Trace routine
TRCROUTINE: ; $C4AF
    VEJ  (CC) \ ABYTL($788E)
    BZS $C4AB
    LDI  UH,$00
    RTN



; BASIC command STOP
BCMD_STOP: ; $C4B6
    VEJ  (C8) \ ABRF(BCMD_STOP_1) ; $C4C5
    VMJ  ($18)

BCMD_STOP_2: ; $C4BA
    LDI  UL,$02 

BCMD_STOP_5: ; $C4BC
    PSH  U
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
    VZS  ($42) ; orig ($42)($21) ; 21 is bogus
    BII  (BREAKPARAM),$60
    VZS  ($42) ; orig ($42)($21) ; 21 is bogus
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
    VZS  ($46) ; orig ($46)($23) 23 is bogus
    LDI  YL,$10 
    LDI  YH,$7A
    PSH  Y
    LDI  A,$3A
    BCR BCMD_STOP_8 ; $C505
    VMJ  ($2A) \ ABYT($5B) \ ABYT($09) ; C504
    LDI  A,$20

BCMD_STOP_8: ; $C505
    PSH  A
    VEJ  (CC) \ ABYTL(PREV_LINE_H) ; $78A2
    JMP  ERRN_5 ; $CDD4

BCMD_STOP_6: ; $C4AD
    NOP



; Basic Command END
BCMD_END: ; $C50D
    VEJ  (C2) \ ACHR($0D) \ ABRF(BCMD_ON_1) ; $C5F9

BCMD_END_1:; $C510
    SJP  (PRGLINE_TDI_1) ; $CFF7
    VMJ  ($42) ; orig ($42)($21) 21 is bogus



; Basic Command GOTO
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



; Evaluation of def keys (label addressing)
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



; Basic Command IF
BCMD_IF: ; $C5B4
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



; Basic-Command ON
BCMD_ON: ; $C5E0
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



; Basic Command GOSUB
BCMD_GOSUB: ; $C64E
    VMJ  ($2E) \ ABRF(BCMD_GOSUB_1) ; $C675
    VEJ  (D0) \ ABYT($83) \ ABRF(BCMD_GOSUB_1) ; $C675
    VMJ  ($1A) \ ABRF(BCMD_GOSUB_1) ; $C675
    VEJ  (C8) \ ABRF(BCMD_NEXT_3) ; $C710
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



; Basic Command REM
BCMD_REM: ; $C676
    VMJ  ($20)
    REC
    JMP  BASIC_INT_7 ; $C40C



; Basic Command USING
BCMD_USING: ; $C67C
    LDI  A,$01
    SJP  (EVAL_USING_1) ; $DAB4
    VEJ  (DE) \ ABYT($56) ; $C760 ***wrong original calc c6da
    VEJ  (E2)



; Basic Command DATA / ARUN / AREAD
BCMD_DATA: ; $C684
    DEC  Y
    LDI  S,(CPU_STACK + $4F)
    SJP  (BCMD_TIME_3) ; $DF42
    VEJ  (E2)



; Basic Command TRON
BCMD_TRON: ; $C68C
    LDA  (OPN)

BCMD_TRON_1: ; $C68F
    STA  (TRACE_ON)
    VEJ  (E2)



; Basic Command TROFF
BCMD_TROFF: ; $C693
    LDI  A,$00
    BCH BCMD_TRON_1 ; $C68F



; Basic Command DEGREE
BCMD_DEGREE: ; $C697
    LDI  UL,$03

BCMD_DEGREE_1: ; $C699
    LDA  (DISP_BUFF + $4F)
    ANI  A,$F8
    REC
    ADC  UL
    STA  (DISP_BUFF + $4F)
    VEJ  (E2)



; Basic Command RADIAN
BCMD_RADIAN: ; $C6A4
    LDI  UL,$04
    BCH BCMD_DEGREE_1 ; $C699



; Basic Command GRAD
BCMD_GRAD: ; $C6A8
    LDI  UL,$06
    BCH BCMD_DEGREE_1 ; $C699



; Basic Command RETURN
BCMD_RETURN: ; $C6AC
    VEJ  (C2) \ ACHR($0D) \ ABRF($10) ; $C710
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
    VEJ  (C8) \ ABRF(BCMD_NEXT_3) ; $C710
    BCH BCMD_RETURN_5 ; $C6BC

BCMD_RETURN_3: ; $C6FD
    POP  Y
    ADI  (FORNXT_STK_PTR),$F4
    VEJ  (E2)



; Basic Command NEXT
BCMD_NEXT: ; $C704
    VEJ  (C6)
    VEJ  (CE) \ ABYT($68) \ ABRF($C70F)
    SJP  (VARONBSTK)
    BCS BCMD_RETURN_6 ; $C6C2

BCMD_NEXT_2: ; $C70D
    LDI  UH,$02

BCMD_NEXT_1: ; $C710
    VEJ  (E0)

BCMD_NEXT_3: ; $C710
    VEJ  (E4)



; Basic Command FOR
BCMD_FOR: ; $C711
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



; Basic Command POKE
BCMD_POKE: ; $C777
    REC

; Basic Command POKE# $C778
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


; Basic Command RESTORE
BCMD_RESTORE: ; $C7A2
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



; Basic Command READ
BCMD_READ: ; $C7B8
    VEJ  (CE) \ ABYT($58) \ ABRF(BCMD_READ_2) ; $C7F1
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
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_READ_5) ; $C7E6

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
    BCH BCMD_READ ; $C7B8

BCMD_READ_7: ; $C7E4
    VMJ  ($40) ; orig ($40)($20) 20 bogus

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

; Basic Command NEW
    SBC  VL ; $C80A
    SHR
    BHR BCMD_READ_12 ; $C81B
    VEJ  (C8) \ ABRF(BCMD_CONT_1) ; $C8F0
    VMJ  ($38)
    VCR  ($E0)
    LDI  UL,$BC
    SJP  (DEL_DIM_VARS_18) ; $D0AE
    VMJ  ($42) ; orig ($42)($21) 21 bogus

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

; Basic Command CLEAR  
    SJP  (DELSVARS) ; $C85F
    VEJ (E2)

; Basic Command CALL ; C863
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

; Basic Command RUN
    INC  XL ; $C8B4
    SJP  (BTN_DOWN_1) ; $CC86
    NOP
    VCR  ($42) ; orig ($42)($21) 21 bogus
    SJP  (DELDVARS)
    SJP  (PRGLINE_TDI_2) ; $D00D

BCMD_READ_23: ; $C8C1
    VEJ  (F2)

BCMD_READ_1: ; $C8C2
    VEJ  (D6) \ ABYT($A6)
    JMP  BASIC_INT_10 ; $C438



; Basic Command CONT
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
    BCR BCMD_CONT_4 ; BCMD_CLEAR_1 ; BCMD_READ_20 ; $C8F7
    DEC  Y
    VEJ  (E2)

BCMD_CONT_4: ; $C42E
    JMP  BASIC_INT_11 ; 



; Basic Command INPUT
BCMD_INPUT: ; $C8FA
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



; Basic Command LOCK
BCMD_LOCK: ; $C968
    LDI  A,$00



; Basic Command UNLOCK
BCMD_UNLOCK: ; $C96A
    STA  (UNDEF_REG_79FF)
    VEJ  (E2)



; Basic Command LIST
BCMD_LIST: ; $C96E
    SBC  UL
    SJP  (BTN_DOWN_1); $CC86
    LDA  XL
    BCS BCMD_LIST_1 ; $C97D
    VMJ  ($42) ; orig ($42)($21) 21 bogus
    VCR  ($E0)
    CPI  UH,$0B
    VZR  ($E0)

BCMD_LIST_1: ; $C97D
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    DEC  X
    DEC  X
    SJP  (BCD_Y2ARX_1) ; $D2D0
    LDI  A,$14
    VMJ  ($44) ;orig ($44)($22) 22 bogus



; Basic Command DIM
BCMD_DIM: ; $C988
    VEJ  (CE) \ ABYT($14) \ ABRF(BCMD_DIM_1) ; $C9D4
    VEJ  (DA)
    VMJ  ($2C) \ ABRF(BCMD_DIM_1) ; $C9D4
    PSH  U
    LDI  A,$88
    BII  (CURVARADD_L),$20
    BZS BCMD_DIM_2 ; $C9A1
    VEJ  (C2) \ ACHR($2A) \ ABRF(BCMD_DIM_9) ; $C9D5
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
    VMJ  ($50) ; orig ($50)($28) 28 us bogus
    BCS BCMD_DIM_8 ; $C9CE
    LDA  (CURVARTYPE) ; $7885
    ANI  A,$7F
    STA  UL
    VMJ  ($50) ; orig ($50)($28) 28 us bogus
    BCS BCMD_DIM_8 ; $C9CE
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

BCMD_DIM_9: ; $C9D5  
    VEJ  (C6)
    LDI  A,$10
    BCH BCMD_DIM_2 ; $C9A1

BCMD_DIM_7: ; $C9DA
    VEJ  (C8) \ ABRF(BCMD_DIM_5) ; $C9DE
    
BCMD_DIM_4: ; $C9DC   
    VMJ  ($40) ; orig ($40)($20) 20 bogus

BCMD_DIM_5: ; $C9DE
    VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_DIM_6) ; $C9E3
    BCH BCMD_INPUT_9 ; $C907

BCMD_DIM_6: ; $C9E3
    VEJ  (E4)



; Editor Cold Start
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

COLD_START_8: ; $    
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
    BHS COLD_START_8 ; $CA32
    LDI  A,$80
    VMJ  ($44) ; orig ($44)($22) 22 bogus

COLD_START_3: ; $CA4A
    POP  A
    DEC  A
    BCS BTN_SHCL
    VMJ  ($14)
    LDI  A,$FF
    BCH COLD_START_7 ; $CA0C



; SHIFT CL button (Clear All)
BTN_SHCL: ; $CA55
    SJP  (PRGLINE_TDI_3) ; $CFCC



; (42) Editor Warm Boot
WARM_START: ; $CA58
    SJP  (INBUF_CLRRST_1) ; $D02B
    LDI  A,$3E
    STA  (Y)
    ANI  (BREAKPARAM),$EF
    BCH BUTTON_CL_3 ; $CA78



; CL Button
BUTTON_CL: ; CA64
    BCR BUTTON_CL_1 ; $CA67
    VEJ  (F2)

BUTTON_CL_1: ; $CA67
    SJP  (PRGLINE_TDI_4) ; $D011
    BCR WARM_START
    SJP  (INBUF_CLRRST)
    LDI  A,$40
    CPI  YL,$B0
    BZR BUTTON_CL_5 ; $CA7A

BUTTON_CL_2: ; $CA75
    LDI  A,$3F
    STA  (Y)

BUTTON_CL_3: ; $CA78
    LDI  A,$00

; (44) Editor (display is retained)
BUTTON_CL_5: ; $CA7A
    STA  (DISPARAM)

; (46) Editor Jump
BUTTON_CL_4: ; $CA7D
    SJP  (PRGMDISP)
    ANI  (CURR_LINE_L),$00
    ANI  (CURR_LINE_H),$00
    ANI  (DISP_BUFF + $4E),$FE
    LDI  S,(CPU_STACK + $4F)
    SJP  (WAIT4KB)
    STA  UL
    VEJ  (CC) \ ABYTL(DISPARAM) ; $7880
    CPI  UL,$19
    BZS BTN_RCL
    CPI  UL,$09
    BZS RSV_CHNG
    STA  UH
    ROR
    BCR BUTTON_CL_7 ; $CAAE
    DEC  UH
    PSH  U
    SJP  (BUF2LCD)
    POP  U
    ANI  (DISPARAM),$FE

BUTTON_CL_7: ; $CAAE
    LDA  UL
    CPI  A,$20
    BCR BUTTON_CL_6 ; $CADF
    CPI  UH,$80
    VCS  ($46) ; orig ($46)($23) 23 bogus
    BII  A,$60
    LDI  UH,$00
    BZR BUTTON_CL_16 ; $CADA
    LDI  XL,$EB
    LDI  XH,$C2
    ADR  X
    LDA  (X)
    CPI  A,$E0
    BCS $CAD9
    STA  UL
    BII  (DISP_BUFF + $4F),$40
    BZS BUTTON_CL_16 ; $CADA
    ORI  (DISP_BUFF + $4E),$01
    STA  UH
    VMJ  ($3A)
    JMP  DEFKEY_EVAL ; $C529
    STA  UH

BUTTON_CL_16: ; $CADA
    SJP  (DEFEVAL)
    BCH BUTTON_CL_4 ; $CA7D

BUTTON_CL_6: ; $CADF
    SHL
    BHR BUTTON_CL_8 ; $CAF8
    BII  A,$20
    BZS BUTTON_CL_9 ; $CAE8
    ANI  A,$0E

BUTTON_CL_9: ; $CAE8
    LDI  UL,$8B
    LDI  UH,$C3
    ADR  U
    LIN  U
    STA  XH
    LDA  (U)
    STA  XL
    LDA  (DISPARAM)
    SHL
    STX  P

BUTTON_CL_8: ; $CAF8
    CPI  UH,$80
    VCS  ($46) ; orig ($46)($23) 23 bogus

BUTTON_CL_15: ; $CAFC
    SJP  (DEFEVAL_1) ; $CE87
    BII  (DISP_BUFF + $4F),$10
    BZS BUTTON_CL_10 ; $CB2D
    SJP  (INBUF_INIT)
    LDI  A,$46
    SIN  Y
    LDA  UH
    ORI  A,$30
    SIN  Y
    LDI  A,$3A
    SIN  Y
    LDA  YL
    STA  (INBUFPTR_L)
    VMJ  ($38)
    SJP  (RESKEY_SRCH)
    LDI  A,$48
    BCR BUTTON_CL_11 ; $CB2B
    LIN  X
    BII  A,$E0
    BZS BUTTON_CL_12 ; $CB27
    SIN  Y
    BCH $CB1F

BUTTON_CL_12: ; $CB27
    LDI  YL,$B3
    LDI  A,$08

BUTTON_CL_11: ; $CB2B
    VMJ  ($44) ; orig ($44)($22) 22 bogus

BUTTON_CL_10: ; $CB2D
    VMJ  ($38)
    LDI  UH,$00
    SJP  (RESKEY_SRCH)
    BCR BUTTON_CL_16 ; $CADA
    LIN  X
    CPI  A,$40
    BZS PRG_ENTER
    STA  UL

BUTTON_CL_14: ; $CB3C
    LDA  UL
    LDI  UH,$00
    CPI  A,$E0
    BCR BUTTON_CL_13 ; $CB46
    STA  UH
    LIN  X
    STA  UL

BUTTON_CL_13: ; $CB46
    SJP  (DEFEVAL)
    LIN  X
    STA  UL
    CPI  A,$20
    BCR BUTTON_CL_4 ; $CA7D
    CPI  A,$40
    BZS PRG_ENTER
    LDA  (Y)
    CPI  A,$0D
    BZS BUTTON_CL_14 ; $CB3C
    CPI  A,$27
    BZS BUTTON_CL_14 ; $CB3C
    SJP  (INS2INBUF)
    BCH BUTTON_CL_14 ; $CB3C



; RCL button
BTN_RCL: ; $CB61
    ROR
    BCS RSV_CHNG_1 ; $CB93

BTN_RCL_1: ; $CB64
    SJP  (SAVELCD2BUF)
    BCH RSV_CHNG_2 ; $CB87



; Switching the RESERVE layers
RSV_CHNG: ; $CB69
    LDI  XL,$4E
    LDI  XH,$76
    LDA  (X)
    ANI  (X),$8F
    ANI  A,$70
    SHR
    BHR RSV_CHNG_3 ; $CB77
    LDI  A,$40

RSV_CHNG_3: ; $CB77
    ORA  (X)
    STA  (X)
    LDA  (DISPARAM)
    BII  A,$09
    BZS BTN_RCL_1 ; $CB64
    ROR
    LDA  (CURVARADD_L)
    BCR BUTTON_CL_15 ; $CAFC
    NOP

RSV_CHNG_2: ; $CB87
    ORI  (DISPARAM),$01
    SJP  (DEFEVAL_2) ; $CEAF
    SJP  (TXT2LCD)
    VMJ  ($46) ; orig ($46)($23) 23 bogus

RSV_CHNG_1: ; $CB93
    ANI  (DISPARAM),$FE
    SJP  (BUF2LCD)
    VMJ  ($46) ; orig ($46)($23) 23 bogus



; SHIFT MODE button
BTN_SHMODE: ; $CB9C
    LDI  UL,$10
    BCH $CBA2



; MODE button
BTN_MODE: ; $CBA0
    LDI  UL,$40
    VCS  ($46) ; orig ($46)($23) 23 bogus
    LDI  XL,$4F
    LDI  XH,$76
    LDA  (UNDEF_REG_79FF)
    VZS  ($46) ; orig ($46)($23) 23 bogus
    LDA  UL
    AND  (X)
    BZS BTN_MODE_1 ; $CBB7
    SHR
    BHR BTN_MODE_2 ; $CBB6
    LDI  A,$40

BTN_MODE_2: ; $CBB6
    STA  UL

BTN_MODE_1: ; CBB7
    ANI  (X),$0F
    LDA  UL
    ORA  (X)
    STA  (X)
    SJP  ($D017)
    BCR BTN_MODE_3 ; $CBC5
    ORI  (BREAKPARAM),$80

BTN_MODE_3: ; $CBC5
    VMJ  ($42) ; orig ($42)($21) 21 bogus



; INS Button
BTN_INS: ; $CBC7
    SHL
    VCR  ($46) ; orig ($46)($23) 23 bogus
    SJP  (INS2INBUF)
    BCH BTN_DEL_2 ; $CBE1



; DEL Button
BTN_DEL: ; $CBCF
    SHL
    VCR  ($46) ; orig ($46)($23) 23 bogus
    LDA  (Y)
    CPI  A,$0D
    VZS  ($46) ; orig ($46)($23) 23 bogus
    CPI  A,$E0
    BCR BTN_DEL_1 ; $CBDE
    SJP  (DELFRMINBUF)

BTN_DEL_1: ; $CBDE
    SJP  (DELFRMINBUF)

BTN_DEL_2: ; $CBE1
    JMP  BUTTON_CL_4 ; $CA7D



; Cursor Right Button
BTN_RIGHT: ; $CBE4
    ROL
    BCS BTN_RIGHT_1 ; $CBFF
    ROL
    BCR BTN_RIGHT_2 ; $CC15
    ROR
    ROR
    BCS BTN_LEFT_1 ; $CC28
    DEC  Y
    LDI  YL,$B0

BTN_RIGHT_3: ; $CBF1
    ANI  (DISPARAM),$5B
    ORI  (DISPARAM),$40
    ORI  (CURS_CTRL),$40
    BCH BTN_DEL_2 ; $CBE1

BTN_RIGHT_1: ; $CBFF
    LDA  (Y)
    CPI  A,$0D
    BZS BTN_RIGHT_3 ; $CBF1
    CPI  A,$E0
    BCR  BTN_RIGHT_4 ; $CC10
    INC  YL
    INC  YL
    BCR BTN_RIGHT_3 ; $CBF1
    DEC  YL

BTN_RIGHT_5: ; $CC0D
    DEC  YL
    BCH BTN_RIGHT_3 ; $CBF1

BTN_RIGHT_4: ; $CC10
    INC  YL

BTN_RIGHT_6: ; $CC11
    BCR BTN_RIGHT_3 ; $CBF1
    BCH BTN_RIGHT_5 ; $CC0D

BTN_RIGHT_2: ; $CC15
    ROL
    BCS BTN_RIGHT_3 ; $CBF1
    ROL
    VCR  ($46) ; orig ($46)($23) 23 bogus
    BCH BTN_RIGHT_3 ; $CBF1



; Programmatic "ENTER" by "@"
PRG_ENTER: ; $CC1D
    VEJ  (CC) \ ABYTL(DISPARAM) ; $7880
    ROL
    BCH BTN_ENTER_2 ; $CCC3



; Cursor Left Button
BTN_LEFT: ; CC22
    ROL
    BCS BTN_LEFT_2 ; $CC29
    ROL
    BCR BTN_RIGHT_2 ; $CC15

BTN_LEFT_1: ; $CC28
    VEJ  (F2)

BTN_LEFT_2: ; $CC29
    LDA  YL
    SJP  (ISARXBCD_3) ; $DCAE
    BCR BTN_RIGHT_3 ; $CBF1
    DEC  Y
    BZS BTN_RIGHT_3 ; $CBF1
    DEC  Y
    LIN  Y
    CPI  A,$E0
    BCH BTN_RIGHT_6 ; $CC11



; Cursor Up Button
BTN_UP: ; $CC38
    ORI  (CURS_CTRL),$40
    LDA  (DISP_BUFF + $4F)
    ROL
    ANI  A,$C0
    VZS  ($46) ; ($46)($23)
    SHL
    STA  UL
    BCH BTN_DOWN_3 ; $CC7C



 ; Cursor Down Button
BTN_DOWN: ; $CC48
    VCS  ($46) ; ($46)($23)
    LDA  (DISP_BUFF + $4F)
    ROL
    ROL
    BCR BTN_DOWN_4 ; $CC73
    BII  (BREAKPARAM),$E0
    VZS  ($46) ; ($46)($23)
    SJP  (PRGLINE_TDI_4) ; $D011
    BCR BTN_DOWN_5 ; $CC62
    ORI  (CURS_CTRL),$C0
    BCH PRG_ENTER

BTN_DOWN_5: ; $CC62
    LDA  (CURS_CTRL)
    BII  A,$40
    BZS BTN_DOWN_6 ; $CC6B
    ORI  A,$20

BTN_DOWN_6: ; $CC6B
    ORI  A,$C0
    STA  (CURS_CTRL)
    JMP  BCMD_CONT_3 ; $C8D5

BTN_DOWN_4: ; $CC73
    ORI  (CURS_CTRL),$40
    ROL
    VCR  ($46) ; ($46)($23)
    LDI  UL,$01

BTN_DOWN_3: ; $CC7C
    PSH  U
    SJP  (PRGST2XREG)
    VCR  ($46) ; ($46)($23)
    JMP  ISARXBCD_4 ; $DC32



;------------------------------------------------------------------------------
; Finds address of the 1st program byte of a line number
;            Address: CC86
;                     D1
;         Parameters: Y-Reg points to parameters in input buffer or main memory
;                     from which the searched line number or a label is located.
; Modified Registers: It is continued after D1 (Carry=1) if the line is found. 
;                     If no program in memory: carry flag=0. A branch is made to
;                     offset address D1 if the line was not found (Carry=0)
;   Error conditions: None
;------------------------------------------------------------------------------
BTN_DOWN_1: ; $CC86
    SJP  (PRGST2XREG)
    VCR  ($4C) ; ($4C)($26)

; Searches for line number.
BTN_DOWN_2: ; $CC8B
    VEJ  (C8) \ ABRF(BTN_DOWN_7) ; $CC96

BTN_DOWN_12: ; $CC8D
    VMJ  ($12)
    SJP  (DEL_DIM_VARS_2) ; $D0B4
    LDI  UL,$00
    BCH BTN_DOWN_8 ; $CCBA

BTN_DOWN_7: ; $CC96
    VEJ  (C6)
    VMJ  ($2E) \ ABRF(BTN_DOWN_9) ; $CCBF
    VEJ  (C8) \ ABRF(BTN_DOWN_10) ; $CCBD
    VEJ  (D0) \ ABYT($82) \ ABRF(BTN_DOWN_9) ; $CCBF
    LDA  UL
    BZR BTN_DOWN_11 ; $CCA5
    LDA  UH
    BZS BTN_DOWN_12 ; $CC8D

BTN_DOWN_11: ; $CCA5
    VEJ  (D8)
    BZR BTN_DOWN_13 ; $CCB5
    VMJ  ($12)
    LDA  YH
    BZR BTN_DOWN_14 ; $CCAF
    VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865

BTN_DOWN_14: ; $CCAF
    SJP  (SRCHPRGLINE) \ ABRF(BTN_DOWN_9) ; $CCBF
    BCH BTN_DOWN_15 ; $CCB8

BTN_DOWN_13: ; $CCB5
    VMJ  ($1A) \ ABRF(BTN_DOWN_9) ; $CCBF

BTN_DOWN_15: ; $CCB8
    LDI  UL,$01

BTN_DOWN_8: ; $CCBA
    SEC
    VMJ  ($4C) ; ($4C)($26)

BTN_DOWN_10: ; $CCBD
    LDI  UH,$01

BTN_DOWN_9: ; $CCBF
    VMJ  ($48) ; ($48)($24)



; Enter Button
BTN_ENTER: ; $CCC1
    VCS  ($46) ; ($46)($23)

BTN_ENTER_2: ; $CCC3
    ORI  (DISP_BUFF + $4E),$01
    ROL
    BCS BTN_ENTER_3 ; $CCEC
    BII  (DISP_BUFF + $4F),$40
    VZS  ($42) ; ($42)($21)
    VEJ  (CC) \ ABYTL(BREAKPARAM) ; $788A
    SHL
    VCS  ($42) ; ($42)($21)
    SHL
    BCS BTN_ENTER_4 ; $CD10
    SHL
    VCR  ($42) ; ($42)($21) 
    JMP  BCMD_CONT_3 ; $C8D5



;------------------------------------------------------------------------------
; Initializes "right boundary" of the input buffer with CR (0D) 
;            Address: CCDE
;         Parameters: None
; 
; Modified Registers: X-Reg points to 7BFF. Accumulator contains 00. If last 
;                     entry in input buffer was a token, (7BFE and 7BFF) are 
;                     deleted, with a character only (7BFF).
;   Error conditions: None
;------------------------------------------------------------------------------
BTN_ENTER_1: ; $CCDE
    LDI  XL,$FE
    LDI  XH,$7B
    LDA  (X)
    CPI  A,$E0
    LDI  A,$0D
    BCS BTN_ENTER_5 ; $CCEA
    INC  X

BTN_ENTER_5: ; $CCEA
    STA  (X)
    RTN

BTN_ENTER_3: ; $CCEC
    SJP  (BTN_ENTER_1) ; $CCDE
    SJP  (PRGLINE_TDI_4) ; $D011
    BCR BTN_ENTER_6 ; $CD19
    VEJ  (F4) \ AWRD(LASTVARADD_H)
    VEJ  (CC) \ ABYTL($7888)
    SJP  (SAVEVARPTR_A)
    SJP  (VAR_TYPE)
    BCR ERRN
    CPA  XL
    BZS BTN_ENTER_4 ; $CD10
    VMJ  ($08) \ ABRF(ERRN)
    ANI  (BREAKPARAM),$0F
    VEJ  (D6) \ ABYT($AC)
    JMP  BCMD_DIM_7 ; $C9DA

BTN_ENTER_4: ; $CD10
    ANI  (BREAKPARAM),$0F
    VEJ  (D6) \ ABYT($AC)
    JMP  BCMD_REM ; $C676

BTN_ENTER_6: ; $CD19
    SJP  (TOKENIZE_INBUF)
    BZS ERRN
    CPI  XL,$B0
    VZS  ($42) ; ($42)($21)
    LDA  (DISP_BUFF + $4F)
    SHL
    ROL
    BCS BTN_ENTER_7 ; $CD65
    BVR BTN_ENTER_8 ; $CD3E
    SJP  (PRGLINE_TDI)
    EOR  (X)
    ORI  (Y),$34
    SBC  XL
    LDA  UH
    STA  YL
    LDI  A,$14

BTN_ENTER_10: ; $CD36
    LDI  YH,$7B
    VCS  ($E0)
    VMJ  ($44) ; ($44)($22)
    VMJ  ($42) ; ($42)($21)

BTN_ENTER_8: ; $CD3E
    BII  (DISPARAM),$08
    BZS BTN_ENTER_9 ; $CD55
    LDA  YL
    SBC  XL
    EAI  $FF
    LDX  Y
    VMJ  ($24)
    SJP  (TXFR_RSV_KEY)
    LDI  YL,$B3
    LDI  A,$08
    BCH BTN_ENTER_10 ; $CD36

BTN_ENTER_9: ; $CD55
    VEJ  (C2) \ ACHR($22) \ ABRF(BTN_ENTER_7) ; $CD65
    VMJ  ($0C)
    VEJ  (C8) \ ABRF(ERR1)
    SJP  (TXFR_RSV_KEY_1) ; $CF0B
    LDI  YL,$B0
    LDI  A,$20
    BCH BTN_ENTER_10 ; $CD36

BTN_ENTER_7: ; $CD65
    LDI  YL,$B0
    JMP  BASIC_INT_12 ; $C446



;------------------------------------------------------------------------------
; Unlock, cancles LOCK
;            Address: CD6A
;         Parameters: None
; 
; Modified Registers: (79FF) is overwritten with FF.
;                     Accumulator, XH
;   Error conditions: None
;------------------------------------------------------------------------------
UNLOCK: ; $CD6A
    STA  XH
    LDI  A,$FF
    STA  (UNDEF_REG_79FF)
    RTN



;------------------------------------------------------------------------------
; Switch off the computer with the OFF button
;            Address: CD71
;         Parameters: None
;
; Modified Registers: For the RESET routine recognizes switching off by OFF, 
;                     the bytes: 50, 51, 52,...,5F are stored at 7A10 ff. 
;                     When switched on again, the computer performs an editor 
;                     cold start after running through the RESET routine.
;   Error conditions: None
;------------------------------------------------------------------------------
BTN_OFF: ; $CD71
    LDI  XL,$10
    LDI  XH,$7A
    LDI  A,$50
    LDI  UL,$0F

BTN_OFF_1: ; $CD79
    SIN  X
    INC  A
    LOP  UL,BTN_OFF_1 ; $CD79
    VMJ  ($A6) ; ($A6)($53)
    BZR BTN_OFF_2 ; $CD83
    .BYTE $FD, $4C ;    OFF ; *** add OFF opcode to syntax highlighting

BTN_OFF_2: ; $CD83
    VEJ  (D8)
    VZS  ($46) ; ($46)($23)
    JMP  BCMD_STOP_9 ; $C4C6



; (E4) Output Error 1 and return to the editor
ERR1: ; $CD89
    LDI  UH,$01



; (E0) Output error from UH
ERRN: ; $CD8B
    LDA  UH
    STA  (ERL)
    LDI  S,(CPU_STACK + $4F)
    VEJ  (D8)
    BZS ERRN_1 ; $CDA9
    VEJ  (D4) \ ABYT($B2)
    VEJ  (CC) \ ABYTL(ERL) ; $789B
    DEC  A
    BZS ERRN_2 ; $CDAF
    BII  (ON_ERR_ADD_H),$80
    BZR ERRN_2 ; $CDAF
    VEJ  (D4) \ ABYT($A0)
    VEJ  (D6) \ ABYT($B8)
    JMP  BASIC_INT_8 ; $C413

ERRN_1: ; $CD8B
    LDI  A,$A0
    CPI  YH,$00
    BZR ERRN_3 ; $CDB1

ERRN_2: ; $CDAF
    LDI  A,$80

ERRN_3: ; $CDB1
    STA  (DISPARAM)
    PSH  Y
    LDI  YL,$10
    LDI  YH,$7A
    VMJ  ($2A) \ ABYT($64) \ ABYT($06)
    LDA  (ERL)
    STA  UL
    LDI  UH,$00
    VMJ  ($10) \ ABYT($40)
    VEJ  (D8)
    BZS ERRN_4 ; $CDDB
    VMJ  ($2A) \ ABYT($61) \ ABYT($03)
    LDI  A,$20
    PSH  A
    VEJ  (CC) \ ABYTL(ERR_LINE_H) ; $78B4

ERRN_5: ; $CDD4
    SJP  (LOAD_NEXT_1) ; $DD2F
    INC  XL
    POP  A
    SIN  Y

ERRN_4: ; $CDDB
    ANI  (Y),$00
    LDX  Y
    POP  Y
    SJP  (TXT2LCD_ARY)
    VMJ  ($46) ; ($46)($23)



;------------------------------------------------------------------------------
; INSERT - Pass characters/tokens from U-Reg to input buffer
;            Address: CDE6
;         Parameters: U-Reg contains tokens or characters (UH must contain 00). 
;                     Y-Reg must contain address being edited.
;
; Modified Registers: Y-Reg points to next cursor position.
;   Error conditions: None
;------------------------------------------------------------------------------
INS2INBUF: ; $CDE6
    LDA  (Y)
    CPI  A,$0D
    BZS INS2INBUF_1 ; $CE0F
    REC
    LDI  A,$FF
    SBC  YL
    BCR INS2INBUF_2 ; $CE0C
    PSH  U
    PSH  X
    STA  UL
    LDI  YL,$FF
    LDX  Y
    DEC  X
    LDA  (X)
    CPI  A,$E0
    BCR INS2INBUF_3 ; $CE02
    LDI  A,$0D

INS2INBUF_3: ; $CE02
    STA  (X)

INS2INBUF_4: ; $CE03
    LDE  X
    SDE  Y
    LOP  UL,INS2INBUF_4 ; $CE03
    SEC
    POP  X
    POP  U

INS2INBUF_2: ; $CE0C
    LDI  A,$27
    STA  (Y)

INS2INBUF_1: ; $CE0F
    RTN

;

; Character input in Input Buffer
CHAR2INBUF: ; $CE10
    LDA  UH
    BZS CHAR2INBUF_1 ; $CE2D
    CPI  YL,$FF
    BCS CHAR2INBUF_2 ; $CE2C
    LDA  (Y)
    CPI  A,$0D
    BZS CHAR2INBUF_3 ; $CE23
    CPI  A,$E0
    BCS CHAR2INBUF_3 ; $CE23
    SJP  (INS2INBUF)

CHAR2INBUF_3: ; $CE23
    LDA  UH
    SIN  Y
    LDA  UL
    SIN  Y
    LDA  YL
    BZR CHAR2INBUF_2 ; $CE2C
    DEC  Y

CHAR2INBUF_4: ; $CE2B
    DEC  Y

CHAR2INBUF_2: ; $CE2C
    RTN

CHAR2INBUF_1: ; $CE2D
    LDA  (Y)
    CPI  A,$E0
    LDA  UL
    SIN  Y
    BCS DELFRMINBUF
    LDA  YL
    BZS CHAR2INBUF_4 ; $CE2B
    RTN



;------------------------------------------------------------------------------
; DELETE (a character in the input buffer)
;            Address: CE38
;         Parameters: Y-Reg must point to memory cell to be erased
; 
; Modified Registers: Contents from next address pointed to by Y-Reg
;                     shifted one byte to left to end of the memory page. 
;                     (Y-Reg) will be deleted. The last address in memory page 
;                     is written with 0D.
;                     X Reg, U Reg, Accumulator=0D
;   Error conditions:	None
;------------------------------------------------------------------------------
DELFRMINBUF: ; $CE38
    PSH  Y
    LDX  Y
    LDA  YL
    EAI  $FF
    STA  UL
    INC  X
    SJP  (XREG2YREG)
    LDI  A,$0D
    STA  (Y)
    POP  Y
    RTN



; Evaluate programmed button; Clears input buffer.
DEFEVAL: ; $CE4A
    PSH  X
    BII  (DISPARAM),$40
    BZR DEFEVAL_3 ; $CE81
    PSH  U
    SJP  (INBUF_CLRRST_1) ; $D02B
    BII  (DISPARAM),$20
    BZS DEFEVAL_4 ; $CE7A
    POP  U
    PSH  U
    LDA  UH
    BZR DEFEVAL_4 ; $CE7A
    LDA  UL
    LDI  UL,$07
    SJP  (MULT16B_1) ; $DA98
    BZR DEFEVAL_4 ; $CE7A
    VEJ  (D2) \ ABRF($CE7A) \ ABYT($80)
    SJP  (ARX2STRNG)
    VEJ  (DC)
    LDI  YL,$B0
    LDI  YH,$7B
    SJP  (XREG2YREG)

DEFEVAL_4: ; $CE7A
    POP  U
    LDI  A,$40
    STA  (DISPARAM)

DEFEVAL_3: ; $CE81
    SJP  (CHAR2INBUF)
    POP  X
    RTN



;------------------------------------------------------------------------------
; Determines the associated reserve key code for the function key
;            Address: CE87
;   Entry parameters: UL must contain the ASCII code of the spare key sought. 
;                     The symbol for the corresponding reserve level must be 
;                     visible in the display, otherwise level I is preset.
;
; Modified registers: (7884) & accumulator contain reserve key code. 
;                     U reg changed.
;   Error conditions: none
;--------------------------------------------------------------------------------------------------
DEFEVAL_1: ; $CE87
    LDI  A,$10
    ADC  UL
    STA  UL
    ANI  A,$07
    STA  UH
    LDA  (DISP_BUFF + $4E)
    ANI  A,$30
    CPI  A,$30
    BCR DEFEVAL_5 ; $CE99
    LDI  A,$20

DEFEVAL_5: ; $CE99
    SHR
    ADC  UH
    STA  (CURVARADD_L)
    RTN



;------------------------------------------------------------------------------
; (38) Determines reserve memory start address +8
; If there is a module in the memory, the reserve memory start for module is 
; entered in (7860). This value is then recognized as high byte of the address.
;            Address: CE9F (38) 
;   Entry parameters: none
;
; Modified registers: X-Reg shows reserve level I (e.g. 3808) at the beginning 
;                     of the text. Accumulator contains the value from (7860) 
;                     or (7863). UH contains error code 24 if module was 
;                     recognized. Carry flag=0 if in (7860) the default value 
;                     FF is not found, i.e., no module was found in the memory.
;   Error conditions: none
;------------------------------------------------------------------------------
RSRV_MEM_START: ; $CE9F
    LDA  (ST_ROM_MOD) ; $7860
    STA  XH
    ROL
    LDI  UH,$18
    BCR DEFEVAL_6 ; $CEAC
    LDA  (RAM_ST_H)
    STA  XH

DEFEVAL_6: ; $CEAC
    LDI  XL,$08
    RTN


;------------------------------------------------------------------------------
; Determines the start address of the text that explains the reserve assignment 
; for the set reserve key level I, II, or III.
;            Address: CEAF
;   Entry parameters: none
; 
; Modified registers: X-Reg contains the address of the beginning of the text of the visible (activated) reserve level in the display. U-Reg, accumulator, Carry=0 if ROM module is used.
;   Error conditions: none
;------------------------------------------------------------------------------
DEFEVAL_2: ; $CEAF
    LDA  (DISP_BUFF + $4E)
    LDI  UL,$08
    ROL
    ROL
    BCS DEFEVAL_7 ; $CEBF
    LDI  UL,$22
    ROL
    BCS DEFEVAL_7 ; $CEBF
    LDI  UL,$3C

DEFEVAL_7: ; $CEBF
    VMJ  ($38)
    LDA  UL
    STA  XL
    RTN


;------------------------------------------------------------------------------
; Searches reserve key code in reserve memory (from XH56)
;           Address: CEC4
;  Entry parameters: XH must point to reserve memory start. (7884) must contain 
;                    the required reserve key code (01H-16H). If this code was 
;                    not found from (XH56), carry and zero flag are 0, else 1.
; 
; Reserve-Key-Codes:
;                        I II III
;                    F1 01 11 09
;                    F2 02 12 0A
;                    F3 03 13 0B
;                    F4 04 14 0C
;                    F5 05 15 0D
;                    F6 06 16 0E
;
; Modified registers: X-Reg points to the address of the instruction assigned to the key. Accumulator contains found key or 00.
;   Error conditions: none
;------------------------------------------------------------------------------
RESKEY_SRCH: ; $CEC4
    LDI  XL,$56

RESKEY_SRCH_2: ; $CEC6
    REC
    LIN  X
    BZS RESKEY_SRCH_1 ; $CECF
    CPA  (CURVARADD_L)
    BZR RESKEY_SRCH_2 $CEC6

RESKEY_SRCH_1: ; $CECF
    RTN



;------------------------------------------------------------------------------
; Change reserve key assignment
; Address:	CED0
;   Entry parameters: (7884) must contain key code of the key to be redefined. 
;                     AR-X must contain CSI of the new text.
; 
; Modified registers: The original key assignment is deleted, and the assignment 
;                     of the remaining keys is moved to bottom. New allocation
;                     is appended to first free address of reserve memory.
;                     X-Reg points to address behind transferred text.
;                     Y-Reg points to the next free address of reserve memory. 
;                     Accumulator contains reserve key code. U reg.
;   Error conditions: If there is not enough free space in the reserve memory, 
;                     Carry=1 and UH contains error code 13. The original 
;                     assignment is deleted. If (7860) is not assigned FF, 
;                     carry is also set, and error code 24 is placed after UH.
;------------------------------------------------------------------------------
TXFR_RSV_KEY: ; $CED0
    VMJ  ($38)
    BCR TXFR_RSV_KEY_2 ; $CF25
    SJP  (RESKEY_SRCH)
    STX  Y
    BCR TXFR_RSV_KEY_3 ; $CEF2
    LDI  A,$1F

TXFR_RSV_KEY_4: ; $CEDD
    CIN
    BCR TXFR_RSV_KEY_4 ; $CEDD
    DEC  X
    DEC  Y
    LDI  A,$C5
    SBC  XL
    STA  UL

TXFR_RSV_KEY_5: ; $CEE6
    TIN
    LOP  UL,TXFR_RSV_KEY_5 ; $CEE6
    LDI  UL,$6F
    LDI  YL,$56

TXFR_RSV_KEY_6: ; $CEED
    LIN  Y
    BZS TXFR_RSV_KEY_3 ; $CEF2
    LOP  UL,TXFR_RSV_KEY_6 ; $CEED

TXFR_RSV_KEY_3: ; $CEF2
    DEC  YL
    VEJ  (DC)
    LDI  UH,$0D
    DEC  UL
    BCR TXFR_RSV_KEY_7 ; $CF0A
    LDA  YL
    ADC  UL
    BCS TXFR_RSV_KEY_7 ; $CF0A
    CPI  A,$C4
    BCS TXFR_RSV_KEY_7 ; $CF0A
    LDA  (CURVARADD_L)
    SIN  Y

TXFR_RSV_KEY_8: ; $CF05
    TIN
    LOP  UL,TXFR_RSV_KEY_8 ; $CF05
    ANI  (Y),$00

TXFR_RSV_KEY_7: ; $CF0A
    RTN



;------------------------------------------------------------------------------
; Transfers text declaring reserve button level to reserve memory area
;            Address: CF0B
;   Entry parameters: AR-X must contain CSI for text to be transmitted. The 
;                     symbol of the level to be changed must be visible in the 
;                     display. If (7860) does not contain FF, the assignment is 
;                     protected from being overwritten.
; 
; Modified registers: All registers changed.
;   Error conditions: If text was transferred, Carry=0. If the value in (7860) was not FF, Carry=1
;------------------------------------------------------------------------------
TXFR_RSV_KEY_1: ; $CF0B
    SJP  (DEFEVAL_2) ; $CEAF
    BCR $TXFR_RSV_KEY_2 ; CF25
    STX  Y
    VEJ  (DC)
    LDI  UH,$00
    CPI  A,$1A
    BCR TXFR_RSV_KEY_9 ; $CF1C
    LDI  UL,$1A
    STA  UH

TXFR_RSV_KEY_9: ; $CF1C
    SJP  (XREG2YREG)
    LDA  UH
    BZR TXFR_RSV_KEY_10 ; $CF23
    STA  (Y)

TXFR_RSV_KEY_10: ; $CF23
     REC
     RTN

TXFR_RSV_KEY_2: ; $CF25
    SEC
    RTN



;------------------------------------------------------------------------------
; Transfer, delete, insert line from Input buffer
;            Address: CF27
;                     4 data bytes
;                     D1= if line number not found
;                     D2= if line number not allowed
;                     D3= if n beginning of buffer does not contain line number
;                     D4=if line was transferred correctly
;         Parameters: Y-Reg must point to arbitrary buffer ranges (XXBO-XXFF). 
;                     The character that X-Reg then points to must be a "0D". 
;                     YH must also point to this memory page.
; 
; Modified Registers: All CPU registers. The program pointers in the memory map 
;                     are also changed and adapted to new scope of the program.
;   Error conditions: UH may contain Error message. Error 13, if program line 
;                     no longer fits in memory; Error 1 if line number not 
;                     allowed. If variables and program memory overlap, an 
;                     error code is also stored in UH.
;------------------------------------------------------------------------------
PRGLINE_TDI: ; $CF27
    PSH  X
    LDI  YL,$B0
    SJP  (DEC2HEX)
    BZR PRGLINE_TDI_5 ; $CF34
    LDI  A,$02
    BCH PRGLINE_TDI_6 ; $CFC8

PRGLINE_TDI_5: ; $CF34
    LDI  A,$01
    BCS PRGLINE_TDI_6 ; $CFC8
    POP  X
    LDA  XL
    SBC  YL
    PSH  Y
    PSH  A
    PSH  U
    SJP  (PRGLINE_TDI_7) ; $CFD0
    POP  U
    PSH  U
    SJP  (BCD_Y2ARX_2) ; $D2E0
    STA  (Y)
    POP  X
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    DEC  X
    STX  Y
    LIN  X
    ADR  X
    DEC  Y
    DEC  Y
    DEC  X
    VMJ  ($16)
    INC  X

PRGLINE_TDI_8: ; $CF5D
    TIN
    LOP  UL,PRGLINE_TDI_8 ; $CF5D
    DEC  UH
    BCS PRGLINE_TDI_8 ; $CF5D
    LDX  Y
    DEC  X
    VEJ  (CA) \ ABYTL(BASPRG_END_H) ; $7867
    BCH $CF71
    POP  X
    VEJ  (CA) \ ABYTL(SRCH_LINE_H) ; $78A8
    VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867
    POP  A
    INC  A
    BZS PRGLINE_TDI_6 ; $CFC8
    PSH  A
    ADI  A,$04
    STX  Y
    ADR  Y
    LDA  YH
    CPA  (RAM_END_H)
    BCS PRGLINE_TDI_9 ; $CFC2
    PSH  Y
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    DEC  X
    DEC  X
    DEC  X
    VEJ  (CA) \ ABYTL(SRCH_ADD_H) ; $78A6
    DEC  X
    VMJ  ($16)
    INC  X
    VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867

PRGLINE_TDI_10: ; $CF93
    LDE  X
    SDE  Y
    LOP  UL,PRGLINE_TDI_10 ; $CF93
    DEC  UH
    BCS PRGLINE_TDI_10 ; $CF93
    POP  X
    VEJ  (CA) \ ABYTL(BASPRG_END_H) ; $7867
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    STX  Y
    VEJ  (CC) \ ABYTL(SRCH_LINE_H) ; $78A8
    SIN  Y
    LDA  XL
    SIN  Y
    POP  A
    STA  UL
    INC  A
    SIN  Y
    POP  X
    LDA  XL
    STA  UH

PRGLINE_TDI_11: ; $CFB1
    TIN
    LOP  UL,PRGLINE_TDI_11 ; $CFB1
    SJP  (DEL_DIM_VARS)
    LDI  A,$03

PRGLINE_TDI_12: ; $CFB9
    POP  X
    ADR  X
    LIN  X
    ADR  X
    STX  P

PRGLINE_TDI_9: ; $CFC2
    POP  A
    LDI  UH,$0D
    LDI  A,$01

PRGLINE_TDI_6: ; $CFC8
    POP  Y
    BCH PRGLINE_TDI_12 ; $CFB9


; Initializes system addresses??
PRGLINE_TDI_3: ; $CFCC
    ANI  (TRACE_ON),$00

; Initialization of system addresses.
PRGLINE_TDI_7: ; $CFD0
    VMJ  ($12)

PRGLINE_TDI_14: ; $CFD2
    INC  X
    INC  X
    INC  X
    LDA  XH
    ORI  A,$80
    STA  XH
    VEJ  (CA) \ ABYTL(DATA_PTR_H) ; $78BE
    LDI  A,$00
    LDI  UL,$A2
    SIN  U
    SIN  U
    LDI  UL,$B4
    SIN  U
    SIN  U
    STA  (ERL)
    LDI  XH,$78
    LDI  XL,$71
    LDI  UL,$0D

PRGLINE_TDI_13: ; $CFEE
    SIN  X
    LOP  UL,PRGLINE_TDI_13 ; $CFEE
    LDI  XL,$95
    SIN  X
    SIN  X
    SIN  X
    SIN  X

; Initializes FOR / GOSUB pointers. Sets the error flag.
PRGLINE_TDI_1: ; $CFF7
    ORI  (ON_ERR_ADD_H),$80

; (3A) basic-stack keyboard and input status    
    ANI  (CURS_CTRL),$1F
    ANI  (BREAKPARAM),$00
    ORI  (GOSB_STK_PTR_L),$FF
    LDI  A,$38
    STA  (FORNXT_STK_PTR)
    RTN

; Initialization of the program pointers.
PRGLINE_TDI_2: ; $D00D
    VEJ  (CC) \ ABYTL(SRCH_TOP_H) ; $78AA
    BCH PRGLINE_TDI_14 ; $CFD2



;------------------------------------------------------------------------------
; Checks whether the inputs for an INPUT command are edited
;            Address: D011
;         Parameters: None
;
; Modified Registers: Accumulator, carry flag=1 when editing with INPUT command
;   Error conditions: None
;------------------------------------------------------------------------------
PRGLINE_TDI_4: ; $D011
    BII  (DISP_BUFF + $4F),$40
    BZS PRGLINE_TDI_15 ; $D01F
    
; Tests input status. If input is required C=1. $D017   
    LDA  (BREAKPARAM)
    SHL
    BCS PRGLINE_TDI_15 ; $D01F
    ROL
    RTN

PRGLINE_TDI_15: ; $D01F
    REC
    RTN



; 	Clears the rest of the input buffer with "0D"
INBUF_CLRRST: ; $D021
    LDA  (INBUFPTR_L)
    STA  XL
    STA  YL
    EAI  $FF
    STA  UL
    BCH INBUF_CLR_1 ; $D038



;------------------------------------------------------------------------------
; Clear input buffers with "0D" and initializes Input buffer pointers
;            Address:	D02B
;          Parameter:	None
;
; Modified Registers:	Input buffer is filled with "0D"
;   Error conditions:	None
;------------------------------------------------------------------------------
INBUF_CLRRST_1: ; $D02B
    LDI  A,$B0
    STA  (INBUFPTR_L)


; Clears the input buffer and sets V-Reg to the beginning of the input buffer.
INBUF_INIT: ; $D030
    LDI  YL,$B0
    LDI  YH,$7B


; Clears input buffer.
INBUF_CLR: ; $D034
    LDI  XL,$B0
    LDI  UL,$50

INBUF_CLR_1: ; $D038
    LDI  XH,$7B
    LDI  A,$0D
    BCH DEL_DIM_VARS_3 ; $D0B0



;------------------------------------------------------------------------------
; (2A) Transfer system messages from memory page C3xx
;            Address: D03E (2A)
;          Parameter: D1 defines low byte of memory page C3xx from which 
;                     message transfer begins. D2 = length of system message.
;                     (5B 09) BREAK IN
;                     (64 06) ERROR
;                     (61 03) IN
;                     Y-Reg points to target address of system message
;
; Modified Registers: X-Reg, Y-Reg, U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------ 
    POP  U
    LIN  U
    STA  XL
    LIN  U
    PSH  U
    STA  UL


; Transfers system messages.
SYSMSG: ; $D046
    LDI  XH,$C3

SYSMSG_1: ; $D048
    TIN


; Transfers UL bytes from X-Reg to Y-Reg
XREG2YREG: ; $D049
    LOP  UL,SYSMSG_1 ; $D048
    RTN


; Searches for variable on Basic stack, if not found C=0.
VARONBSTK: ; $D04C
    LDA  (FORNXT_STK_PTR)
    LDI  XH,$7A
    CPI  A,$39
    BCR PSHBSTK_3 ; $D07C
    SBI  A,$0C
    STA  XL
    LIN  X
    CPA  UH
    BZR VARONBSTK_1 ; $D061
    LIN  X
    CPA  UL
    BZS PSHBSTK_2 ; $D07B
    DEC  X

VARONBSTK_1: ; $D061
    DEC  X
    LDA  XL
    BCH $D051



;------------------------------------------------------------------------------
; (06) Gets address from Basic-Stack to U-Reg
;            Address: D065 (06)
;          Parameter: None
; 
; Modified Registers: X-Reg points to the next free address on the stack
;                     Accumulator holds new basic stack pointer. 
;                     ($7882) is updated
;   Error conditions: None
;------------------------------------------------------------------------------
POPBSTK: ; $D065
    LDA  (STK_PTR_GSB_FOR)
    STA  XL
    LDI  XH,$7A
    LIN  X
    STA  UH
    LIN  X
    STA  UL
    BCH PSHBSTK_2 ; $D07B


; (32) Save U-Reg on Basic Stack
PSHBSTK: ; $D071
    LDA  (STK_PTR_GSB_FOR)
    STA  XL
    LDI  XH,$7A
    LDA  UH
    SIN  X
    LDA  UL
    SIN  X

PSHBSTK_2: ; $D07B
    LDA  XL

PSHBSTK_3: ; $D07C
    STA  (STK_PTR_GSB_FOR)
    RTN



;------------------------------------------------------------------------------
; Delete variable (standard and dimensioned variable)
;            Address: D080
;          Parameter: None
; 
; Modified Registers: X-Reg, U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
DELSVARS: ; $D080
    LDI  XH,$76
    SJP  (DEL_DIM_VARS_1) ; $D0AA
    SJP  (DEL_DIM_VARS_1) ; $D0AA
    LDI  XL,$C0
    LDI  UL,$0F
    LDI  UH,$01
    SJP  (DELU_FROMX_1) ; $D3C7



;------------------------------------------------------------------------------
; Delete dimensioned variables
;            Address: D091
;          Parameter: None
; 
; Modified Registers: Variable pointer
;   Error conditions: None
;------------------------------------------------------------------------------
DELDVARS: ; $D091
    LDA  (RAM_END_H)
    STA  (VAR_START_H)
    ANI  (VAR_START_L),$00
    RTN


;------------------------------------------------------------------------------
; Delete dimensioned variable if program and variable memory overlap
;            Address: D09C
;          Parameter: None
;
; Modified Registers: X-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
DEL_DIM_VARS: ; $D09C
    VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867
    SEC
    LDA  XL
    SBC  (VAR_START_L)
    LDA  XH
    SBC  (VAR_START_H)
    BCS DELDVARS
    RTN

; Delete standard variables (176 bytes) from XH 50.
DEL_DIM_VARS_1: ; $D0AA
    LDI  XL,$50
    LDI  UL,$AF


;------------------------------------------------------------------------------
; Delete UL+1 bytes from X-Reg
;            Address: D0AE
;          Parameter: X-Reg points to the start address of the area to be deleted. 
;                     UL contains the number of bytes to be deleted +1
;
; Modified Registers: X-Reg, Y-Reg
;   Error conditions: None
;------------------------------------------------------------------------------
DEL_DIM_VARS_18: ; $D0AE
    LDI  A,$00

DEL_DIM_VARS_3: ; $D0B0
    SIN  X
    LOP  UL,DEL_DIM_VARS_3 ; $D0B0
    RTN

; Initializes pointer for search program
DEL_DIM_VARS_2: ; $D0B4
    LDA  XH
    STA  (SRCH_TOP_H)
    LDA  XL
    STA  (SRCH_TOP_L)

; Loads address pointed to by X-Reg 2-bytes (line number) after search pointer 
; & start address from 78A6 f ..
DEL_DIM_VARS_14: ; $D0BC
    LIN  X
    STA  (SRCH_LINE_H)
    LIN  X
    STA  (SRCH_LINE_L)
    INC  X
    LDA  XH
    STA  (SRCH_ADD_H)
    LDA  XL
    STA  (SRCH_ADD_L)
    RTN
    STA  XH
    JMP  BCMD_READ_17 ; $C853

; Compare BCD numbers in AR-X & AR-Y according to operand in Accumulator Set 
; AR-X according to result 0 or 1.
DEL_DIM_VARS_16: ; $D0D2
    PSH  A
    LDA  (ARX + $01)
    EOR  (ARY + $01)
    BZR DEL_DIM_VARS_4 ; $D0E4
    SJP  (SUBTR)
    LDA  (ARX + $02)
    BZS $D142

DEL_DIM_VARS_4: ; $D0E4
    LDA  (ARX + $01)
    SHL

DEL_DIM_VARS_13: ; $D0E8
    POP  A
    BZS DEL_DIM_VARS_5 ; $D138
    EAI  $04
    BZS DEL_DIM_VARS_6 ; $D0F7
    BCS DEL_DIM_VARS_7 ; $D0F4
    EAI  $03

DEL_DIM_VARS_7: ; $D0F4
    SHR
    BCS DEL_DIM_VARS_5 ; $D138

DEL_DIM_VARS_6: ; $D0F7
    VEJ  (EC)
    RTN

; Comparison of two strings according to operator in the accumulator
; Comparison of two strings according to the operand in the accumulator whose 
; CSI is in AR-X and AR-Y. AR-X is set to 1=true or 0=false, depending on the result.
DEL_DIM_VARS_15: ; $D0F9
    PSH  A
    LDI  UL,$15
    SJP  (BCMD_TIME_7) ; $DEBE
    STX  Y
    PSH  A
    VEJ  (DC)
    POP  A
    LDI  UH,$01
    CPA  UL
    BZS DEL_DIM_VARS_8 ; $D11B
    LDI  UH,$02
    BCS DEL_DIM_VARS_9 ; $D113
    LDI  UH,$00
    STA  UL

DEL_DIM_VARS_9: ; $D113
    POP  A
    CPI  A,$04
    BZS DEL_DIM_VARS_6 ; $D0F7
    PSH  A

DEL_DIM_VARS_8: ; $D11B
    DEC  UL
    BCR DEL_DIM_VARS_10 ; $D13E
    LIN  Y
    CIN
    BZS DEL_DIM_VARS_8 ; $D11B
    POP  A
    BZS DEL_DIM_VARS_5 ; $D138
    PSH  A
    BII  A,$03
    BZS DEL_DIM_VARS_11 ; $D148
    BCR DEL_DIM_VARS_12 ; $D130
    EAI  $03

DEL_DIM_VARS_12: ; $D130
    SHR
    BCS DEL_DIM_VARS_11 ; $D148
    NOP
    NOP
    NOP
    POP  A

DEL_DIM_VARS_5: ; $D138
    VEJ  (EC)
    ORI  (ARX + $02),$10
    RTN

DEL_DIM_VARS_10: ; $D13E
    CPI  UH,$01
    BZR DEL_DIM_VARS_13 ; $D0E8
    POP  A
    SHR
    SHR
    BCH DEL_DIM_VARS_7 ; $D0F4

DEL_DIM_VARS_11: ; $D148
    POP  A
    BCH DEL_DIM_VARS_6 ; $D0F7

; Passes number pointed to by Y-Reg to AR-X.
DEL_DIM_VARS_17: ; $D14C
    VEJ  (DC)
    STX  Y


; BCD value pointed to by Y-Reg points passed to AR-X
; Decimal number pointed to by Y-Reg, passed to AR-X. Jump if there is an error.
BCD_Y2ARX: ; $D14F
    PSH  U
    VEJ  (EC)
    DEC  X
    LDA  UL
    STA  (X)
    POP  U
    LDI  UH,$00
    LDI  XL,$02

BCD_Y2ARX_13: ; $D15B
    DEC  UL
    BCR BCD_Y2ARX_3 ; $D1BC
    LDA  (Y)
    CPI  A,$30
    BZR BCD_Y2ARX_4 ; $D173
    LDA  UH
    SHR
    BCS BCD_Y2ARX_5 ; $D19E
    SHR
    BCS BCD_Y2ARX_6 ; $D17E
    SHR
    BCR BCD_Y2ARX_7 ; $D1A4
    ADI  (ARX + $07),$FF
    BCH BCD_Y2ARX_7 ; $D1A4

BCD_Y2ARX_4: ; $D173
    BCR BCD_Y2ARX_8 ; $D1AB
    CPI  A,$3A
    BCS BCD_Y2ARX_8 ; $D1AB
    LDA  UH
    SHR
    BCS BCD_Y2ARX_5 ; $D19E
    SHR

BCD_Y2ARX_6: ; $D17E
    SHR
    BCS BCD_Y2ARX_9 ; $D185
    ADI  (ARX + $07),$01

BCD_Y2ARX_9: ; $D185
    CPI  XL,$07
    BCS BCD_Y2ARX_10 ; $D199
    CPI  XH,$7A
    LDI  XH,$7A
    LDA  (Y)
    ANI  A,$0F
    BCR BCD_Y2ARX_11 ; $D197
    DRR  (X) 
    LDI  XH,$00
    BCH BCD_Y2ARX_10 ; $D199

BCD_Y2ARX_11: ; $D197
    ADC  (X)
    SIN  X

BCD_Y2ARX_10: ; $D199
    LDA  UH
    ORI  A,$02
    BCH BCD_Y2ARX_12 ; $D1A5

BCD_Y2ARX_5: ; $D19E
    LDI  XL,$00
    LDI  XH,$7A
    LDA  (Y)
    DRR  (X)

BCD_Y2ARX_7: ; $D1A4
    LDA  UH

BCD_Y2ARX_12: ; $D1A5
    ORI  A,$80
    STA  UH

BCD_Y2ARX_27: ; $D1A8
    INC  Y
    BCH BCD_Y2ARX_13 ; $D15B

BCD_Y2ARX_8: ; $D1AB
    PSH  X
    VMJ  ($34) \ ABYT($04) \ ABYT($20) \ 
         ABRF(BCD_Y2ARX_14) \ ABYT($2E) \ ABRF(BCD_Y2ARX_15) \ 
         ABYT($2D) \ ABRF(BCD_Y2ARX_16) \ ABYT($2B) \ 
         ABRF(BCD_Y2ARX_17) \ ABYT($45) \ ABRF(BCD_Y2ARX_18)

BCD_Y2ARX_25: ; $D1BA
    POP  X

BCD_Y2ARX_3: ; $D1BC
    LDI  XL,$02
    LDI  XH,$7A
    LDE  X
    BZS BCD_Y2ARX_19 ; $D1E8
    DEC  X
    LDI  A,$00
    DRR  (X)
    ANI  A,$0F
    STA  UL
    LDA  (X)

BCD_Y2ARX_21: ; $D1CB
    DEC  UL
    BCR BCD_Y2ARX_20
    ADI  A,$09
    BCH BCD_Y2ARX_21 ; $D1CB

BCD_Y2ARX_20: ; $D1D2
    SIN  X
    LDA  (X)
    SHL
    SDE  X
    LDA  (ARX + $07)
    ANI  (ARX + $07),$00
    BCR BCD_Y2ARX_22 ; $D1EB
    SBC  (X)
    CPI  A,$64
    BCR BCD_Y2ARX_23 ; $D1F8
    CPI  A,$9D
    BCS BCD_Y2ARX_23 ; $D1F8

BCD_Y2ARX_19: ; $D1E8
    VEJ  (EC)
    VMJ  ($4C) ; ($4C)($26)

BCD_Y2ARX_22: ; $D1EB
    ADC  (X)
    CPI  A,$9D
    BCS BCD_Y2ARX_23 ; $D1F8
    CPI  A,$64
    BCR BCD_Y2ARX_23 ; $D1F8
    LDI  UH,$10
    VMJ  ($48) ; ($48)($24)

BCD_Y2ARX_23: ; $D1F8
    STA  (X)
    VMJ  ($4C) ; ($4C)($26)

BCD_Y2ARX_15: ; $D1FB
    SHR
    BCS BCD_Y2ARX_24 ; $D200
    ORI  A,$02

BCD_Y2ARX_24: ; $D200
    ROL
    POP  X
    BCH BCD_Y2ARX_12 ; $D1A5

BCD_Y2ARX_16: ; $D205
    SHL
    BCS BCD_Y2ARX_25 ; $D1BA
    ROR
    ROR
    LDI  A,$40
    BCR BCD_Y2ARX_26 ; $D20F
    SHL

BCD_Y2ARX_26: ; $D20F
    EOR  (ARX + $01)
    STA  (ARX + $01)

BCD_Y2ARX_14: ; $D215
    POP  X
    BCH BCD_Y2ARX_27 ; $D1A8

BCD_Y2ARX_17: ; $D219
    SHL
    BCS BCD_Y2ARX_25 ; $D1BA
    BCH BCD_Y2ARX_14 ; $D215

BCD_Y2ARX_18: ; $D21E
    SHR
    BCS BCD_Y2ARX_14 ; $D215
    LDI  UH,$01
    BCH BCD_Y2ARX_14 ; $D215



;------------------------------------------------------------------------------
; Finds address ofline number which contains address to which X-Reg points and 
; transfers this value to search pointers (78A6 f.).
;            Address: D225
;         Parameters: X-Reg contains an address from the program memory for 
;                     which the line start address is to be determined.
; 
; Modified Registers: X-Reg, Y-Reg and search pointers (78A6 f.) contain the 
;                     start address found. U-Reg=78A7. Accumulator contains the 
;                     low byte of the address found.
;   Error conditions: Basically, the search starts from the start of the 
;                     program memory. An error check as to whether the address 
;                     sought is outside of the program memory is not carried 
;                     out and is also not indicated by the flags when exiting.
;------------------------------------------------------------------------------
BCD_Y2ARX_33: ; $D225
    STX  Y
    VMJ  ($12)



;------------------------------------------------------------------------------
; Finds the address of the program line pointed to by Y-Reg from the address 
; pointed to by X-Reg. (like D225)
;            Address: D229
;         Parameters: X-Reg must point to the high byte of a line number in 
;                     program memory from which to search.
; 
; Modified Registers: like D225
;   Error conditions: like D225
;------------------------------------------------------------------------------
BCD_Y2ARX_31: ; $D229
    STX  U
    DEC  Y
    INC  U

BCD_Y2ARX_30: ; $D22D
    INC  U
    LIN  U
    ADR  U
    SEC
    LDA  UL
    SBC  YL
    LDA  UH
    SBC  YH
    BCS BCD_Y2ARX_28 ; $D241

BCD_Y2ARX_29: ; $D238
    LIN  U
    INC  A
    BCS BCD_Y2ARX_29 ; $D238
    LDX  U
    DEC  X
    BCH BCD_Y2ARX_30 ; $D22D

BCD_Y2ARX_28: ; $D241
    STX  Y
    VEJ  (CA) \ ABYTL(SRCH_ADD_H) ; $78A6
    RTN



;------------------------------------------------------------------------------
; Transfer program line to input buffer
;            Address: D246: Line where error occurred
;                     D24E: Program line that was processed last
;                     D26F: 1st program line
;                     D277: transfer last program line
;         Parameters: Corresponding search pointers must be set in memory map.
; 
; Modified Registers: X-Reg points to the high byte of the next line number. 
;                     Y-Reg points to the cursor position within input buffer. 
;                     U-Reg and Accumulator overwritten.
;   Error conditions: None
;------------------------------------------------------------------------------
; Transfer line where error occurred to input buffer
BCD_Y2ARX_45: ; $D246
    VEJ  (CC) \ ABYTL(ERR_ADD_H) ; $78B2
    STX  Y
    VEJ  (CC) \ ABYTL(ERR_TOP_H) ; $78B6
    BCH BCD_Y2ARX_48 ; $D254


; Transfer line of the instruction to be processed to input buffer
BCD_Y2ARX_44: ; $D24E
    VEJ  (CC) \ ABYTL(PREV_ADD_H) ; $78A0
    STX  Y
    VEJ  (CC) \ ABYTL(PREV_TOP_H) ; $78A4
    
BCD_Y2ARX_48: ; $D254
    PSH  Y
    SJP  (BCD_Y2ARX_31) ; $D229
    POP  X
    REC
    LDA  XL
    SBC  YL
    DEC  A
    DEC  A
    DEC  A
    BZS BCD_Y2ARX_32 ; $D27E
    STA  UL
    DEC  X
    DEC  X
    LDA  (X)
    CPI  A,$E0
    LDA  UL
    BCR BCD_Y2ARX_32 ; $D27E
    DEC  A
    BCH BCD_Y2ARX_32 ; $D27E


; Transfers 1st line of program to input buffer
BCD_Y2ARX_47: ; $D26F
    VMJ  ($12)

BCD_Y2ARX_38: ; $D271
    VEJ  (CA) \ ABYTL(SRCH_ADD_H) ; $78A6
    STX  Y
    BCH $D27C


; Transfers last line of program to input buffer
; Lists line in which BREAK occurred on the LCD.
BCD_Y2ARX_46: ; $D277
    VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867

BCD_Y2ARX_42: ; $D279
    SJP  (BCD_Y2ARX_33) ; $D225
    LDI  A,$00

BCD_Y2ARX_32: ; $D27E
    PSH  A
    VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865
    LDA  YH
    CPA  XH
    BCS BCD_Y2ARX_34 ; $D28E
    VEJ  (CC) \ ABYTL(ST_ROM_MOD) ; $7860
    LDI  XL,$07
    LDA  (X)
    ROL
    BCR BCD_Y2ARX_35 ; $D2AF

BCD_Y2ARX_34: ; $D28E
    SJP  (INBUF_INIT)
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    LIN  X
    STA  UH
    LIN  X
    STA  UL
    PSH  X
    VMJ  ($10) \ ABYT($40)
    POP  X
    LIN  X
    DEC  A
    ANI  A,$7F
    STA  UL
    PSH  Y

BCD_Y2ARX_36: ; $D2A5
    TIN
    LOP  UL,BCD_Y2ARX_36 ; $D2A5
    POP  Y

BCD_Y2ARX_37: ; $D2AA
    POP  A
    ADR  Y
    RTN

BCD_Y2ARX_35: ; $D2AF
    LDI  UH,$1F
    BCH BCD_Y2ARX_37 ; $D2AA

; Transfers next line to Input buffer
; Finds the last line number $D2B3
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    INC  X
    INC  X
    LIN  X
    ADR  X
    LDA  (X)
    INC  A
    BCR  BCD_Y2ARX_38 ; $D271
    VMJ  ($16)
    LDI  A,$FF
    BCH BCD_Y2ARX_39 ; $D2CB

BCD_Y2ARX_40: ; $D2C4
    CIN
    BZR BCD_Y2ARX_1 ; $D2D0
    LOP  UL,BCD_Y2ARX_40 ; $D2C4
    DEC  UH

BCD_Y2ARX_39: ; $D2CB
    BCS BCD_Y2ARX_40 ; $D2C4

BCD_Y2ARX_41: ; $D2CD
    LDI  UH,$00
    RTN

; Transmits output line to which X-Reg points to Input buffer
; Lists program line on LCD.
BCD_Y2ARX_1: ; $D2D0
    DEC  X
    BCH BCD_Y2ARX_38 ; $D271

; Searches for line address according to search pointer
BCD_Y2ARX_43: ; $D2D3
    VMJ  ($12)
    STX  U
    VEJ  (CC) \ ABYTL(SRCH_ADD_H) ; $78A6
    SJP  (U_MINUS_X)
    BCS BCD_Y2ARX_41 ; $D2CD
    BCH BCD_Y2ARX_42 ; $D279

; Searches for line number according to U-Reg from merge start
; Searches for the line number from the start of the merge.
BCD_Y2ARX_2: ; $D2E0
    VEJ  (CC) \ ABYTL($7869)
    PSH  Y
    BCH SRCHPRGLINE_2 ; $D2FF



;------------------------------------------------------------------------------
; (1A) Searches according to U-Reg ; D2E6
; Searches for line numbers according to U-Reg. Jump if an error occurs.
;------------------------------------------------------------------------------
    CPI  UH,$FF
    BZR SRCHPRGLINE_3 ; $D327


; Searches line number according to U-Reg from beginning of program memory
; Searches for line number corresponding to U-Reg; updated program pointer. 
; If not found, jump to Distance Address.
LINESEARCH: ; $D2EA
    VMJ  ($12)

; Searches for program line from U-Reg from X-Reg
SRCHPRGLINE: ; $D2EC
    PSH  Y
    PSH  U
    VEJ  (CA) \ ABYTL(SRCH_TOP_H) ; $78AA

SRCHPRGLINE_10: ; $D2F2
    POP  U
    CPI  UH,$FF
    BZR SRCHPRGLINE_2 ; $D2FF
    PSH  X
    VEJ  (E6)
    POP  X

SRCHPRGLINE_8: ; $D2FD
    LDI  UH,$FF

SRCHPRGLINE_2: ; $D2FF
    SJP  (DEL_DIM_VARS_14) ; $D0BC
    LDA  (SRCH_LINE_H)
    CPI  A,$FF
    BCR SRCHPRGLINE_4 ; $D341
    CPI  UH,$FF
    BCR SRCHPRGLINE_5 ; $D31E
    VMJ  ($16)
    BCR SRCHPRGLINE_5 ; $D31E
    DEC  X
    DEC  X
    LDI  A,$FF

SRCHPRGLINE_7: ; $D315
    CIN
    BZR SRCHPRGLINE_6 ; $D322
    LOP  UL,SRCHPRGLINE_7 ; $D315
    DEC  UH
    BCS SRCHPRGLINE_7 ; $D315

SRCHPRGLINE_5: ; $D31E
    LDI  UH,$0B
    VMJ  ($4A) ; ($4A)($25)

SRCHPRGLINE_6: ; $D322
    DEC  X
    VEJ  (CA) \ ABYTL(SRCH_TOP_H) ; $78AA
    BCH SRCHPRGLINE_8 ; $D2FD

SRCHPRGLINE_3: ; $D327
    VEJ  (CC) \ ABYTL(CURR_LINE_H) ; $789C
    LDA  UL
    SBC  XL
    LDA  UH
    SBC  XH
    BCS SRCHPRGLINE_9 ; $D333
    VEJ  (CC) \ ABYTL(SRCH_TOP_H) ; $78AA
    BCH SRCHPRGLINE

SRCHPRGLINE_9: ; $D333
    PSH  Y
    PSH  U
    VEJ  (CC) \ ABYTL(CURR_TOP_H) ; $789E
    VEJ  (CA) \ ABYTL(SRCH_TOP_H) ; $78AA
    DEC  Y
    VMJ  ($20)
    NOP
    BCH SRCHPRGLINE_10 ; $D2F2

SRCHPRGLINE_4: ; $D341
    CPI  UH,$FF
    BZR SRCHPRGLINE_11 ; $D362
    LIN  X
    CPI  A,$22
    BZR SRCHPRGLINE_12 ; $D35B
    PSH  X
    STX  Y
    VMJ  ($0C)
    LDI  A,$04
    SJP  (DEL_DIM_VARS_15) ; $D0F9
    POP  X
    LDI  UH,$FF
    BZR SRCHPRGLINE_13 ; $D36F

SRCHPRGLINE_12: ; $D35B
    DEC  X

SRCHPRGLINE_14: ; $D35C
    DEC  X
    LIN  X
    ADR  X
    BCH SRCHPRGLINE_2 ; $D2FF

SRCHPRGLINE_11: ; $D362
    CPA  UH
    BCR  SRCHPRGLINE_14 ; $D35C
    BZR  SRCHPRGLINE_5 ; $D31E
    LDA  (SRCH_LINE_L)
    CPA  UL
    BCR  SRCHPRGLINE_14 ; $D35C
    BZR  SRCHPRGLINE_5 ; $D31E

SRCHPRGLINE_13: ; $D36F
    VMJ  ($4E) ; ($4E)($27)



; Reserves space for simple variables
; Reserves space for simple variables and corrects variable pointers.
SRCHPRGLINE_16: ; $D371
    LDA  (CURVARADD_L)
    ANI  A,$20
    SHR
    STA  YL
    BZR SRCHPRGLINE_15 ; $D37E
    LDI  YL,$08
    LDI  A,$88

SRCHPRGLINE_15: ; $D37E
    STA  (CURVARTYPE) ; $7885
    LDI  A,$00
    STA  YH
    STA  UL
    STA  UH

; Reserves space for variables
SRCHPRGLINE_1 ; $D386
    PSH  U
    VEJ  (F4) \ AWRD(VAR_START_H)
    LDI  A,$07
    REC
    ADC  YL
    STA  XL
    LDI  A,$00
    ADC  YH
    STA  XH
    BCS DELU_FROMX_2 ; $D3CF
    SJP  (U_MINUS_X)
    BCR DELU_FROMX_2 ; $D3CF
    LDX  U
    DEC  X
    VMJ  ($16)
    BCS DELU_FROMX_2 ; $D3CF
    INC  X
    VEJ  (CA) \ ABYTL($7899)
    VEJ  (F4) \ AWRD(CURVARADD_H)
    ANI  A,$7F
    SIN  X
    LDA  UL
    SIN  X
    LDA  YL
    STA  UL
    LDA  YH
    STA  UH
    INC  Y
    INC  Y
    INC  Y
    LDA  YH
    SIN  X
    LDA  YL
    SIN  X
    POP  Y
    LDA  YL
    SIN  X
    LDA  YH
    SIN  X
    LDA  (CURVARTYPE) ; $7885
    SIN  X
    STX  Y


;------------------------------------------------------------------------------
; Delete U bytes from X-Reg
;            Address: DC34
;          Parameter: X-Reg points to the start address of the area to be deleted
; 
; Modified Registers: X-Reg, U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
; Deletes U-bytes from X-Reg
DELU_FROMX: ; $D3C4
    DEC  U
    LDI  A,$00

DELU_FROMX_1: ; $D3C7
    SIN  X
    LOP  UL,DELU_FROMX_1 ; $D3C7
    DEC  UH
    BCS DELU_FROMX_1 ; $D3C7
    RTN

DELU_FROMX_2: ; $D3CF
    LDI  UH,$0A
    SEC
    POP  X
    RTN



;------------------------------------------------------------------------------
; Conversion decimal to hexadecimal
; Address:	D335
;   Entry parameters: Y-Reg points to 1st ASCII character of decimal number. 
;                     Leading zeros are skipped.
; 
; Modified registers: U-Reg contains hex result. (0000-FEFF).
;                     Y-Reg points to address after last decimal number.
;   Error conditions: If the value range is not complied with, 
;                     error code 1E UH is loaded and the carry flag is set.
;------------------------------------------------------------------------------
DEC2HEX: ; $D335
    LDI  XL,$00
    LDI  XH,$00

DEC2HEX_4: ; $D3D9
    PSH  X
    VMJ  ($02) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_2) ; $D3FE
    POP  X
    PSH  Y
    PSH  A
    STX  Y
    LDI  UL,$0A
    VMJ  ($50) ; ($50)($28)
    POP  A
    LDI  UH,$1E
    POP  Y
    BCS DEC2HEX_3 ; $D406
    CPI  XH,$FF
    BZS DEC2HEX_3 ; $D406
    ANI  A,$0F
    ADR  X
    BCH DEC2HEX_4 ; $D3D9

DEC2HEX_2: ; $D3FE
    VEJ  (C6)
    POP  U
    LDA  UL
    REC
    BZR DEC2HEX_3 ; $D406
    LDA  UH

DEC2HEX_3: ; $D406
    RTN



;------------------------------------------------------------------------------
; Retrieves the encoded name of variable pointed to by Y-Reg
;            Address: D407
;                     1 Data byte
;   Entry parameters: Y-Reg points to 1st byte of variable name in main memory
; 
; Modified registers: X-Reg contains return address
;                     Y-Reg points to the index or byte after variable name.
;                     U-Reg contains encoded variable names.
;   Error conditions: If variable name is not allowed, branch to offset (D1).
;------------------------------------------------------------------------------
DEC2HEX_13: ; $D407
    VEJ  (C0)
    VMJ  ($00) \ ABYT($40) \ ABYT($5B) \ ABRF(DEC2HEX_128) ; $D42F



;------------------------------------------------------------------------------
; Find encoded variable name whose 1st letter is in UL and 2nd letter in Y-Reg.
;            Address: D40D
;                     1 Data byte
;   Entry parameters: Y-Reg points to 2nd letters of variable. UL=1st letter
; 
; Modified registers: Like D407
;   Error conditions: Like D407
;------------------------------------------------------------------------------
DEC2HEX_70: ; $D40D
    LDA  UL
    STA  XH
    LDI  XL,$00

DEC2HEX_9: ; $D411
    PSH  X
    VMJ  ($02) \ ABYT($41) \ ABYT($5B) \ ABRF(DEC2HEX_5) ; $D41A
    BCH DEC2HEX_7 ; $D422

DEC2HEX_5: ; $D41A
    VMJ  ($00) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_6) ; $D43B
    ANI  A,$DF
    STA  UL

DEC2HEX_7: ; $D422
    POP  X
    CPI  XH,$40
    BZS DEC2HEX_8 ; $D459
    LDA  XL
    BZR DEC2HEX_9 ; $D411
    LDA  UL
    STA  XL
    BCH DEC2HEX_9 ; $D411

DEC2HEX_128: ; $D42F
    VEJ  (C4) \ AWRD($F15B) \ ABRF(DEC2HEX_10) ; $D435
    VMJ  ($4C) ; ($4C)($26)

DEC2HEX_10: ; $D435
    LDA  UH
    STA  UL
    LDI  UH,$15
    VMJ  ($48) ; ($48)($24)

DEC2HEX_6: ; $D43B
    VEJ  (C4) \ ACHR($24) \ ABRF(DEC2HEX_11) ; $D447
    POP  U
    LDI  A,$20
    ADR  U
    PSH  U
    VEJ  (C0)

DEC2HEX_11: ; $D447
    VEJ  (C4) \ ACHR($28) \ ABRF(DEC2HEX_12) ; $D452
    POP  U
    LDI  A,$80
    ADR  U
    VMJ  ($4C) ; ($4C)($26)

DEC2HEX_12: ; $D452
    VEJ  (C6)
    POP  U
    CPI  UH,$40
    VZR  ($4C) ; ($4C)($26)

DEC2HEX_8: ; $D459
    LDI  UH,$14
    VMJ  ($48) ; ($48)($24)



;------------------------------------------------------------------------------
; (CE) Gets the address of the variable whose name is pointed to by Y-Reg
;            Address: D45D (CE)
;                     2 Data bytes
;                     D1 = selection of permitted variable types
;                     14: Array variable must not yet be dimensioned
;                     58: all variable types allowed
;                     48: only string variables allowed
;                     68: only numeric variables allowed.
;   Entry parameters: X-Reg contains return address
; 
; Modified registers: Y-Reg points to next byte in main memory
;                     U-Reg contains the start address of the variable.
;                     AR-X may contain CSI or BCD value of searched var.
;   Error conditions: This subroutine can produce a variety of error
;                     conditions depending on the preselected data byte 1 and 
;                     the variable type. If an error is detected, then a
;                     branch is made to the offset address defined by D2.
;------------------------------------------------------------------------------
GET_VAR_ADDR: ; $D45D
    SJP  (DEC2HEX_13) ; $D407
    .BYTE $58

;------------------------------------------------------------------------------
; (0E) Find address of the variable whose name is stored in U-Reg
; Line above and below different in PC-1500 Intern ***
;            Address: D461 (0E)
;                     2 Data bytes (see (CE))
;   Entry parameters: U-Reg contains variable name
;
; Modified registers: Like (CE)
;   Error conditions: Like (CE)
;------------------------------------------------------------------------------
GET_VAR_NAME: ; $D461
    POP X
    LIN  X
    PSH  X
    DEC  X
    PSH  A
    LDA  UL
    ANI  A,$A0
    EOR  (X)
    BII  A,$C0
    BZS DEC2HEX_14 ; $D50C
    BII  A,$30
    BZS DEC2HEX_14 ; $D50C
    CPI  UH,$40
    BZS DEC2HEX_15 ; $D510
    CPI  UH,$5B
    BCR DEC2HEX_16 ; $D480
    JMP  DEC2HEX_29 ; $D5D8

DEC2HEX_16: ; $D480
    LDA  UL
    ANI  A,$DF
    BZR DEC2HEX_17 ; $D4B5

DEC2HEX_37: ; $D485
    LDA  UH
    ANI  A,$1F
    LDI  XL,$F8
    LDI  XH,$78
    CPI  UL,$20
    BCR DEC2HEX_18 ; $D4A3
    LDI  XL,$B0
    CPI  A,$05
    BCR DEC2HEX_19 ; $D4A2
    LDI  XL,$00
    LDI  XH,$76
    CPI  A,$10
    BCR DEC2HEX_19 ; $D4A2
    LDI  XL,$50
    LDI  XH,$77

DEC2HEX_19: ; $D4A2
    SHL

DEC2HEX_18: ; $D4A3
    SHL
    SHL
    SHL
    ADR  X
    LDI  UH,$00
    POP  A
    PSH  A
    ROR
    LDA  UL
    BCS DEC2HEX_20 ; $D500
    JMP  DEC2HEX_21 ; $D5E6

DEC2HEX_17: ; $D4B5
    VEJ  (CC) \ ABYTL(VAR_START_H) ; $7899
    BCH DEC2HEX_30 ; $D4CA
    POP  X
    JMP  LOAD_NEXT_2 ; $DCF6

DEC2HEX_23: ; $D4BE
    INC  X

DEC2HEX_24: ; $D4BF
    LIN  X
    PSH  A
    LIN  X
    REC
    ADC  XL
    STA  XL
    POP  A
    ADC  XH
    STA  XH

DEC2HEX_30: ; $D4CA
    CPA  (RAM_END_H)
    BCS DEC2HEX_22 ; $D5A9
    LIN  X
    CPA  UH
    BZR  DEC2HEX_23 ; $D4BE
    LIN  X
    CPA  UL
    BZR  DEC2HEX_24 ; $D4BF
    POP  A
    PSH  A
    SHR
    BCS DEC2HEX_25 ; $D4EE
    INC  X
    INC  X
    SHR
    BCS DEC2HEX_26 ; $D55B
    SHR
    BCR DEC2HEX_27 ; $D546
    LDI  UH,$05
    BCH DEC2HEX_28 ; $D5A5

DEC2HEX_31: ; $D4EA
    LDI  UH,$01
    BCH DEC2HEX_28 ; $D5A5

DEC2HEX_25: ; $D4EE
    CPI  UL,$80

DEC2HEX_49: ; $D4F0
    LDI  UH,$01
    BCR DEC2HEX_20 ; $D500
    LDI  UH,$21

DEC2HEX_33: ; $D4F6
    LIN  Y
    CPI  A,$2A
    BZR DEC2HEX_31 ; $D4EA
    LIN  Y
    CPI  A,$29
    BZR DEC2HEX_31 ; $D4EA

DEC2HEX_20: ; $D500
    POP  A
    LDA  UL
    ANI  A,$20
    SHR
    SHR
    ADC  UH
    STX  U

DEC2HEX_45: ; $D50A
    VMJ  ($4C) ; ($4C)($26)

DEC2HEX_14: ; $D50C
    LDI  UH,$07
    BCH DEC2HEX_28 ; $D5A5

DEC2HEX_15: ; $D510
    POP  A
    PSH  A
    ANI  A,$07
    BZS DEC2HEX_32 ; $D533
    SHR
    BCR DEC2HEX_14 ; $D50C
    LDI  XL,$C0
    LDI  XH,$78
    LDI  UH,$10
    CPI  UL,$A0
    BCS DEC2HEX_33 ; $D4F6
    STA  XL
    LDI  XH,$79
    BCH DEC2HEX_33 ; $D4F6

; Determines indexed default variable
DEC2HEX_78: ; $D52A
    PSH  A
    PSH  U
    VMJ  ($28) \ ABRF(DEC2HEX_34) ; $D5F5
    BCH DEC2HEX_35 ; $D53A

DEC2HEX_32: ; $D533
    PSH  U
    VEJ  (DE) \ ABRF(DEC2HEX_34) ; $D5F5
    VEJ  (C2) \ ACHR($29) \ ABRF(DEC2HEX_36) ; $D5F3

DEC2HEX_35: ; $D53A
    VEJ  (D0) \ ABYT($0F) \ ABRF(DEC2HEX_34) ; $D5F5
    POP  U
    STA  UH
    LDA  UL
    SHL
    SHR
    STA  UL
    BCH DEC2HEX_37 ; $D485

DEC2HEX_27: ; $D546
    CPI  UL,$80
    BCS DEC2HEX_38 ; $D563
    INC  X
    INC  X
    LIN  X

DEC2HEX_42: ; $D54D
    VMJ  ($24)
    STX  U
    POP  A
    BII  A,$08
    BZR DEC2HEX_39 ; $D559
    VMJ  ($0A)

DEC2HEX_39: ; $D559
    VMJ  ($4C) ; ($4C)($26)

DEC2HEX_26: ; $D55B
    PSH  X
    SJP  (DEC2HEX_40) ; $D7CA
    LDA  YH
    BCH DEC2HEX_43 ; $D568

DEC2HEX_38: ; $D563
    PSH  X
    VMJ  ($2C) \ ABRF(DEC2HEX_34) ; $D5F5

DEC2HEX_43: ; $D568
    POP  X
    PSH  Y
    LIN  X
    STA  YL
    CPA  UL
    BCR DEC2HEX_41 ; $D5A1
    LIN  X
    CPA  UH
    BCR DEC2HEX_41 ; $D5A1
    LIN  X
    PSH  A
    PSH  X
    PSH  A
    LDA  UL
    PSH  A
    LDA  UH
    STA  UL
    LDI  YH,$00
    LDI  UH,$00
    INC  Y
    VMJ  ($50) ; ($50)($28)
    POP  A
    ADR  Y
    POP  A
    ANI  A,$7F
    STA  UL
    VMJ  ($50) ; ($50)($28)
    POP  X
    LDA  YL
    ADC  XL
    STA  XL
    LDA  YH
    ADC  XH
    STA  XH
    POP  A
    POP  Y
    BCH DEC2HEX_42 ; $D54D

DEC2HEX_41: ; $D5A1
    LDI  UH,$09

DEC2HEX_48: ; $D5A3
    POP  Y

DEC2HEX_28: ; $D5A5
    POP  A
    VMJ  ($48) ; ($48)($24)

DEC2HEX_22: ; $D5A9
    CPI  UL,$80
    POP  A
    BCR DEC2HEX_44 ; $D5B7
    BII  A,$04
    BZR DEC2HEX_45 ; $D50A
    LDI  UH,$06
    VMJ  ($48) ; ($48)($24)

DEC2HEX_44: ; $D5B7
    PSH  A
    ANI  A,$07
    BZS DEC2HEX_46 ; $D5E0
    BII  (CASS_FLAG),$80
    BZS DEC2HEX_47 ; $D5EF
    VEJ  (DA)
    PSH  Y
    SJP  (SRCHPRGLINE_16) ; $D371
    BCS DEC2HEX_48 ; $D5A3
    LDX  Y
    POP  Y
    LDA  (CURVARADD_L)
    STA  UL
    DEC  X
    DEC  X
    DEC  X
    BCH DEC2HEX_49 ; $D4F0

DEC2HEX_29: ; $D5D8
    POP  A
    PSH  A
    ANI  A,$07
    BZR DEC2HEX_14 ; $D50C

DEC2HEX_46: ; $D5E0
    LDA  UH
    ORI  A,$80
    STA  XH
    LDA  UL
    STA  XL

DEC2HEX_21: ; $D5E6
    ANI  A,$20
    SHR
    BZR DEC2HEX_42 ; $D54D
    LDI  A,$88
    BCH DEC2HEX_42 ; $D54D

DEC2HEX_47: ; $D5EF
    LDI  UH,$15
    BCH DEC2HEX_28 ; $D5A5

DEC2HEX_36: ; $D5F3
    LDI  UH,$01

DEC2HEX_34: ; $D5F5
    POP  X
    BCH DEC2HEX_28 ; $D5A5


;------------------------------------------------------------------------------
; (D0) Convert AR-X to integer and load to U-Reg. D1 specifies the area. 
; If exceeded, jump
;------------------------------------------------------------------------------
    POP  X ; D5F9
    LIN  X
    PSH  X
    PSH  Y
    PSH  A
    LDI  YL,$00
    LDI  YH,$00
    LDA  (ARX + $04)
    CPI  A,$B2
    BCR DEC2HEX_50 ; $D640
    BZR DEC2HEX_51 ; $D620
    VEJ  (DC)
    STX  Y
    CPI  YH,$80
    BCR DEC2HEX_52 ; $D647
    POP  A
    ANI  A,$1F
    CPI  A,$04
    VZS  ($4E) ; ($4E)($27)
    BCH DEC2HEX_53 ; $D64B

DEC2HEX_51: ; $D620
    STA  UL
    POP  A
    ROL
    LDI  UH,$11
    BCR DEC2HEX_54 ; $D6AB
    CPI  UL,$C1
    LDI  UH,$FF
    BZR DEC2HEX_55 ; $D66A
    ROL
    BCR DEC2HEX_55 ; $D66A
    ROR
    SHR
    PSH  A
    VEJ  (DC)
    BZS DEC2HEX_52 ; $D647
    LDA  (X)
    STA  YL
    LDA  XL
    STA  (STR_BUF_PTR_L)
    BCH DEC2HEX_52 ; $D647

DEC2HEX_50: ; $D640
    LDA  (ARX)
    STA  UL
    SHL
    BCR DEC2HEX_56 ; $D676

DEC2HEX_52: ; $D647
    POP  A
    ANI  A,$1F

DEC2HEX_53: ; $D64B
    SHR
    BCR DEC2HEX_57 ; $D656
    CPI  YL,$00
    BZR DEC2HEX_57 ; $D656
    CPI  YH,$00
    BZS DEC2HEX_58 ; $D6A9

DEC2HEX_57: ; $D656
    SHL
    LDI  XL,$AD
    LDI  XH,$D6
    ADR  X
    LIN  X
    ADC  YL
    LDA  (X)
    ADC  YH
    BCS DEC2HEX_58 ; $D6A9
    LDA  YL
    STA  UL
    LDA  YH
    STA  UH

DEC2HEX_61: ; $D667
    SJP  (ARUINT2ARX)

DEC2HEX_55: ; $D66A
    VMJ  ($4E) ; ($4E)($27)

DEC2HEX_60: ; $D66C
    PSH  U
    LDI  UL,$0A
    VMJ  ($50) ; ($50)($28)
    POP  U
    BCS DEC2HEX_59 ; $D6A7

DEC2HEX_56: ; $D676
    LDI  XL,$04
    LDI  XH,$7A
    DRL  (X)
    DEC  X
    DRL  (X)
    DEC  X
    DRL  (X)
    ANI  A,$F0
    AEX
    ADC  YL
    STA  YL
    LDI  A,$00
    STA  UH
    ADC  YH
    STA  YH
    BCS DEC2HEX_59 ; $D6A7
    LOP  UL,DEC2HEX_60 ; $D66C
    STA  UH
    LDA  YL
    STA  UL
    BII  (ARX + $01),$80
    BZS DEC2HEX_52 ; $D647
    SJP  (TWOSCOMP)
    CPI  UH,$80
    BCR DEC2HEX_59 ; $D6A7
    POP  A
    ANI  A,$1F
    CPI  A,$04
    BZS DEC2HEX_61 ; $D667
    BCH DEC2HEX_58 ; $D6A9

DEC2HEX_59: ; $D6A7
    POP  A

DEC2HEX_58: ; $D6A9
    LDI  UH,$13

DEC2HEX_54: ; $D6AB
    VMJ  ($4A) ; ($4A)($25)

; Parameters for subroutine (D0) ; D6AD 
    .BYTE $00,$00,$00,$01,$00,$80,$00,$80
    .BYTE $00,$FF,$64,$FF,$AF,$FF,$E5,$FF
    .BYTE $E6,$FF,$38


;------------------------------------------------------------------------------
; (2E) Calculates formula expression and transfers result to AR-X.
;------------------------------------------------------------------------------
    PSH  Y ; $DC60
    SJP  (DEC2HEX)
    BCS DEC2HEX_62 ; $D6DD
    BZS DEC2HEX_62 ; $D6DD
    SJP  (ARUINT2ARX)
    VEJ  (C2) \ ACHR($2E) \ ABRF($D6D1)
    BCH DEC2HEX_62 ; $D6DD
    VEJ  (C4) \ ACHR($45) \ ABRF($D6D6)
    BCH DEC2HEX_62 ; $D6DD
    POP  X
    VEJ  (C6)

DEC2HEX_1:  ; $D6D9
    LDI  A,$02
    BCH DEC2HEX_63 ; $D6E1

DEC2HEX_62:  ; $D6DD
    POP  Y


;------------------------------------------------------------------------------
; (DE) Calculates formula pointed to by Y-Reg and transfers the result to AR-X. 
; Jump if an error occurs.
;------------------------------------------------------------------------------
    LDI  A,$01 ; $D6DF

DEC2HEX_63:  ; $D6E1
    ANI  ($7889),$FE

DEC2HEX_127:  ; $D6E5
    STA  ($7881)
    VEJ  (CC) \ ABYTL($7890)
    REC
    ADI  A,$04
    STA  XH
    VEJ  (CA) \ ABYTL($7892)
    INC  U
    LDI  A,$10
    STA  (U)
    JMP  DEC2HEX_64 ; $D826

DEC2HEX_66:  ; $D6F7
    JMP  BCMD_RLM_STR_1 ; $DA25

DEC2HEX_87:  ; $D6FA
    VMJ  ($00) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_65) ; $D70E
    BII  ($7881),$1D
    BZS DEC2HEX_66 ; $D6F7

DEC2HEX_105:  ; $D705
    DEC  Y
    LDI  UL,$4F
    SJP  (BCD_Y2ARX) \ ABRF(DEC2HEX_67) ; $D7F3
    BCH DEC2HEX_68 ; $D736

DEC2HEX_65:  ; $D70E
    VMJ  ($00) \ ABYT($40) \ ABYT($5B) \ ABRF(DEC2HEX_69) ; $D738
    BII  ($7881),$1D
    BZS DEC2HEX_66 ; $D6F7
    SJP  (DEC2HEX_70) ; $D40D
    VEJ  (D6) \ ABYT($6E)
    SBC  XH
    BCR DEC2HEX_71 ; $D732
    SJP  (ISARXBCD_5) ; $DBE0
    VCS  ($48) ; ($48)($24)
    LDI  A,$01
    STA  ($7881)
    LDI  A,$01
    STA  (NUMARGS)
    BCH DEC2HEX_72 ; $D767

DEC2HEX_71:  ; $D732
    VMJ  ($0E) \ ABYT($50) \ ABRF(DEC2HEX_67) ; $D7F3

DEC2HEX_68:  ; $D736
    BCH DEC2HEX_73 ; $D821

DEC2HEX_69:  ; $D738
    LDA  UL
    LDI  UL,$10
    SJP  (MULT16B_1) ; $DA98
    STA  UL
    LIN  X
    STA  UH
    LIN  X
    AND  ($7881)
    BZS DEC2HEX_66 ; $D6F7
    LIN  X
    PSH  A
    LIN  X
    LDI  XH,$D7
    LDI  XL,$55
    ADR  X
    POP  A
    STX  P
    BII  ($7881),$1D
    BZS DEC2HEX_74 ; $D837
    LDI  UH,$83
    LDI  A,$04

DEC2HEX_107:  ; $D75F
    STA  ($7881)
    SJP  (ISARXBCD_5) ; $DBE0
    VCS  ($48) ; ($48)($24)

DEC2HEX_72:  ; $D767
    JMP  DEC2HEX_75 ; $D89D
    LDI  UL,$01
    CPA  (Y)
    BZR DEC2HEX_101 ; $D773
    LDI  UL,$05
    BCH DEC2HEX_100 ; $D779

DEC2HEX_101:  ; $D773
    INC  A
    CPA  (Y)
    BZR DEC2HEX_99 ; $D77A
    LDI  UL,$00

DEC2HEX_100:  ; $D779
    INC  Y

DEC2HEX_99:  ; $D77A
    LDI  A,$08
    BCH DEC2HEX_74 ; $D837
    LDI  UL,$02
    CPA  (Y)
    BZR DEC2HEX_99 ; $D77A
    LDI  UL,$06
    BCH DEC2HEX_100 ; $D779
    STA  UL
    BCH DEC2HEX_99 ; $D77A
    VMJ  ($0C)
    BCH DEC2HEX_73 ; $D821
    VEJ  (EC)

DEC2HEX_104:  ; $D78F
    VMJ  ($02) \ ABYT($30) \ ABYT($3A) \ ABRF(DEC2HEX_102) ; $D796
    BCH $D79D

DEC2HEX_102:  ; $D796
    VMJ  ($00) \ ABYT($41) \ ABYT($47) \ ABRF(DEC2HEX_103) ; $D7B1
    ADI  A,$09
    LDI  XL,$06
    LDI  XH,$7A
    AEX
    DRL  (X)
    DEC  X
    DRL  (X)
    ANI  A,$F0
    LDI  UH,$10
    VZR  ($48) ; ($48)($24)
    BCH DEC2HEX_104 ; $D78F
    BCH DEC2HEX_105 ; $D705
    BCH DEC2HEX_106 ; $D8A0

DEC2HEX_103:  ; $D7B1
    VEJ  (C6)
    VEJ  (DC)
    SJP  (LOAD_NEXT_1) ; $DD2F
    SBC  XL
    BCH DEC2HEX_73 ; $D821
    LDI  UL,$6B
    BCH DEC2HEX_107 ; $D75F

DEC2HEX_89:  ; $D7BD
    VEJ  (CC) \ ABYTL($7893)

DEC2HEX_80:  ; $D7BF
    CPA  (GOSB_STK_PTR_L)
    BZR DEC2HEX_108 ; $D7F8
    BII  ($7889),$01
    BZS DEC2HEX_109 ; $D858


; UH = 1st index, UL = 2nd index of a variable. Jump if error.
DEC2HEX_40:  ; $D7CA
    ADI  (NUMARGS),$FD
    LDI  UH,$08
    VCS  ($48) ; ($48)($24)
    SJP  (ADD_ARU_ARX_1) ; $F92B
    VCS  ($48) ; ($48)($24)
    VEJ  (D0) \ ABYT($08) \ ABRF(DEC2HEX_67) ; $D7F3
    ADI  (NUMARGS),$01
    VCR  ($4C) ; ($4C)($26)
    PSH  U
    VMJ  ($30)
    SJP  (ADD_ARU_ARX_1) ; $F92B
    VCS  ($48) ; ($48)($24)
    VEJ  (D0) \ ABYT($08) \ ABRF(DEC2HEX_110) ; $D7F1
    POP  U
    STA  UH
    VMJ  ($4C) ; ($4C)($26)

DEC2HEX_110:  ; $D7F1
    POP  X

DEC2HEX_67:  ; $D7F3
    VMJ  ($48) ; ($48)($24)

DEC2HEX_93:  ; $D7F5
    JMP  DEC2HEX_87 ; $D6FA

DEC2HEX_108:  ; $D7F8
    SJP  (ISARXBCD_7) ; $DBD3
    CPI  UH,$60
    BZR DEC2HEX_88 ; $D805
    ADI  (NUMARGS),$01
    BCH DEC2HEX_89 ; $D7BD

DEC2HEX_88:  ; $D805
    CPI  UH,$20
    BZS DEC2HEX_75 ; $D89D
    LDI  XH,$10
    CPI  UH,$5B
    BCS DEC2HEX_76 ; $D87A
    CPI  UH,$40
    BCR DEC2HEX_76 ; $D87A
    BZR DEC2HEX_77 ; $D81D
    LDI  A,$00
    SJP  (DEC2HEX_78) ; $D52A
    VEJ  (DC)

DEC2HEX_115:  ; $D81B
    BCH DEC2HEX_73 ; $D821

DEC2HEX_77:  ; $D81D
    VMJ  ($0E) \ ABYT($52) \ ABRF(DEC2HEX_79) ; $D8F7

DEC2HEX_73:  ; $D821
    LDI  A,$02
    STA  ($7881)

DEC2HEX_64:  ; $D826
    VEJ  (CC) \ ABYTL($7881)
    SHR
    BCS $D833 ; ***
    SJP  (ISARXBCD_6) ; $DB95
    LDA  XL
    SJP  (BCMD_TIME_8) ; $DFA0
    VEJ  (C4) \ ACHR($BA) \ ABRF($D90C) ; ***
    ORA  (U)
    DEC  Y

DEC2HEX_74:  ; $D837
    STA  ($7881)

DEC2HEX_116:  ; $D83A
    VEJ  (CC) \ ABYTL($7893)
    CPI  UH,$10
    BZS DEC2HEX_80 ; $D7BF
    CPA  (GOSB_STK_PTR_L)
    BZR DEC2HEX_81 ; $D864
    LDA  ($7889)
    CPI  UH,$10
    BCS DEC2HEX_82 ; $D851
    SHR
    BCR DEC2HEX_83 ; $D859
    BCH DEC2HEX_84 ; $D877

DEC2HEX_82:  ; $D851
    CPI  UH,$60
    BZR DEC2HEX_85 ; $D893
    SHR
    BCS DEC2HEX_85 ; $D893

DEC2HEX_109:  ; $D858
    DEC  Y

DEC2HEX_83:  ; $D859
    VMJ  ($28) \ ABRF(DEC2HEX_79) ; $D8F7
    SJP  (ADD_ARU_ARX_1) ; $F92B
    VCS  ($48) ; ($48)($24)
    VMJ  ($4C) ; ($4C)($26)
    NOP

DEC2HEX_81:  ; $D864
    STA  XL
    LDI  XH,$7A
    INC  X
    LDA  (X)
    CPA  UH
    BZS DEC2HEX_86 ; $D88B
    BCR DEC2HEX_85 ; $D893

DEC2HEX_92:  ; $D86E
    LDX  U
    SJP  (ISARXBCD_7) ; $DBD3
    CPI  UH,$70
    BCS DEC2HEX_76 ; $D87A

DEC2HEX_84:  ; $D877
    JMP  BCMD_RLM_STR_1 ; $DA25

DEC2HEX_76:  ; $D87A
    PSH  X

DEC2HEX_111:  ; $D87C
    PSH  Y
    LDA  UL
    STA  YL
    LDA  UH
    STA  YH
    CPI  A,$E0
    BCR DEC2HEX_90 ; $D8D7
    VMJ  ($1C) \ ABYT($01)
    BCH DEC2HEX_91 ; $D8F2

DEC2HEX_86:  ; $D88B
    CPI  UH,$60
    BZS DEC2HEX_85 ; $D893
    CPI  UH,$84
    BZR DEC2HEX_92 ; $D86E

DEC2HEX_85:  ; $D893
    SJP  (ISARXBCD_5) ; $DBE0
    VCS  ($48) ; ($48)($24)
    SJP  (ISARXBCD_1); $DBF5
    VCS  ($48) ; ($48)($24)

DEC2HEX_75:  ; $D89D
    VEJ  (C0)
    BCR DEC2HEX_93 ; $D7F5

DEC2HEX_106:  ; $D8A0
    LDA  ($7881)
    CPI  UL,$80
    BCR DEC2HEX_94 ; $D8AD
    DEC  Y
    DEC  Y
    LDI  UH,$00
    BCH DEC2HEX_95 ; $D8BF

DEC2HEX_94:  ; $D8AD
    CPI  UL,$60
    BCS DEC2HEX_96 ; $D8C6
    CPI  UL,$50
    BZS DEC2HEX_97 ; $D8B9
    CPI  UL,$51
    BZR DEC2HEX_98 ; $D8CF

DEC2HEX_97:  ; $D8B9
    CPI  UH,$F1
    BZR DEC2HEX_98 ; $D8CF
    LDI  UH,$70

DEC2HEX_95:  ; $D8BF
    BII  A,$22
    BZS DEC2HEX_84 ; $D877
    JMP  DEC2HEX_99 ; $D77A

DEC2HEX_96:  ; $D8C6
    BII  A,$1D
    BZS DEC2HEX_84 ; $D877
    LDI  A,$10
    JMP  DEC2HEX_107 ; $D75F

DEC2HEX_98:  ; $D8CF
    BII  A,$1D
    BZS DEC2HEX_84 ; $D877
    PSH  U
    BCH DEC2HEX_111 ; $D87C

DEC2HEX_90:  ; $D8D7
    VMJ  ($28) \ ABRF(DEC2HEX_91) ; D8F2
    CPI  YH,$83
    BZR DEC2HEX_112 ; $D909
    VEJ  (D2) \ ABRF($D8F2) \ ABYT($80)
    CPI  YL,$2D
    BCR DEC2HEX_113 ; $D8F0
    LDI  XL,$02
    LDI  XH,$7A
    LDE  X
    BZS DEC2HEX_113 ; $D8F0
    LDI  A,$80
    EOR  (X)

DEC2HEX_124:  ; $D8EF
    STA  (X)

DEC2HEX_113:  ; $D8F0
    LDI  UH,$00

DEC2HEX_91:  ; $D8F2
    POP  Y
    POP  X
    LDA  UH

DEC2HEX_79:  ; $D8F7
    VZR  ($48) ; ($48)($24)
    CPI  XH,$E0
    BCR DEC2HEX_114 ; $D901
    CPI  XL,$60
    BCR DEC2HEX_115 ; $D81B

DEC2HEX_114:  ; $D901
    INC  A
    STA  (NUMARGS)
    STX  U
    BCH DEC2HEX_116 ; $D83A

DEC2HEX_112:  ; $D909
    BVS DEC2HEX_117 ; $D973
    PSH  Y
    SJP  (ISARXBCD_6) ; $DB95
    STA  (V)
    VEJ  (E6)
    VMJ  ($30)
    SJP  (ISARXBCD_6) ; $DB95
    LIN  Y
    POP  Y
    LDA  YH
    DEC  A
    BHR DEC2HEX_118 ; $D943
    DEC  A
    BHS DEC2HEX_119 ; $D96F
    CPI  YL,$2B
    BZR DEC2HEX_119 ; $D96F

; Concatenate two strings
    SJP  (BCMD_TIME_8) ; $DFA0
    LDI  XH,$DC
    STX  Y
    PSH  U
    LDI  UL,$15
    SJP  (BCMD_TIME_7) ; $DEBE
    SJP  (XREG2STRBUF) \ ABRF(BCMD_RLM_STR_2) ; $DA29
    LDA  (ARX + $07)
    POP  U
    ADC  UL
    LDX  Y
    VMJ  ($24)

DEC2HEX_126:  ; $D941
    BCH DEC2HEX_113 ; $D8F0

DEC2HEX_118:  ; $D943
    LDA  YL
    SJP  (DEL_DIM_VARS_15) ; $D0F9
    BCH DEC2HEX_113 ; $D8F0

DEC2HEX_120:  ; $D949
    LDA  YL
    SJP  (DEL_DIM_VARS_16) ; $D0D2
    BCH DEC2HEX_113 ; $D8F0
    VEJ  (D2) \ ABRF($D952) \ ABYT($80)
    VEJ  (E6)
    VMJ  ($30)
    VEJ  (D2) \ ABRF($D96D) \ ABYT($80) ; ABRF address +1 off
    POP  Y
    LDA  YH
    DEC  A
    BHR DEC2HEX_120 ; $D949
    DEC  A
    BHS DEC2HEX_121 ; $D964
    JMP  OUTBUFCLR_1 ; $EF94

DEC2HEX_121:  ; $D964
    DEC  A
    BHS DEC2HEX_122 ; $D96A
    JMP  OUTBUFCLR_2 ; $EFA5

DEC2HEX_122:  ; $D96A
    JMP  OUTBUFCLR_3 ; $EFB1
    POP  Y

DEC2HEX_119:  ; $D96F
    LDI  UH,$11

DEC2HEX_125:  ; $D971
    BCH DEC2HEX_91 ; $D8F2

DEC2HEX_117:  ; $D973
    VEJ  (D0) \ ABYT($04) \ ABRF(BCMD_RLM_STR_3) ; $DA2B
    PSH  U
    VMJ  ($30)
    VEJ  (D0) \ ABYT($04) \ ABRF(BCMD_RLM_STR_2) ; $DA29)
    POP  U
    LDI  XL,$06
    LDI  XH,$7A
    LDA  UL
    DEC  YL
    BHS DEC2HEX_123 ; $D98D
    AND  (X)
    SDE  X
    LDA  UH
    AND  (X)
    BCH DEC2HEX_124 ; $D8EF

DEC2HEX_123:  ; $D98D
    ORA  (X)
    SDE  X
    LDA  UH
    ORA  (X)
    BCH DEC2HEX_124 ; $D8EF



; Basic commands PEEK#/PEEK
BCMD_PEEK: ; $D993
    VEJ  (D0) \ ABYT($00) \ ABRF(ARUINT2ARX_1) ; $D9F2
    INC  YL
    LDA  (U)
    BHS BCMD_PEEK_1 ; $D99C
    LDA  #(U)

BCMD_PEEK_1: ; $D99C
    BCH BCMD_LEN_1 ; $D9E4



; Basic command NOT
BCMD_NOT: ; $D99E
    VEJ  (D0) \ ABYT($04) \ ABRF(ARUINT2ARX_1) ; $D9F2
    SJP  (TWOSCOMP)
    DEC  U
    SJP  (ARUINT2ARX)
    BCH BCMD_RLM_STR_4 ; $DA41



; Basic INKEY$ command
BCMD_INKY: ; $D9AA
    SJP  (KEY2ASCII)
    LDI  XH,$D0
    BCH BCMD_CHR_1 ; $D9B6



; Basic CHR$ Command
BCMD_CHR: ; $D981
    VEJ  (D0) \ ABYT($08) \ ABRF(ARUINT2ARX_1) ; $D9F2
    LDI  XH,$C1

BCMD_CHR_1: ; $D9B6
    STA  XL
    STA  UL
    LDA  UL
    BZS BCMD_CHR_2 ; $D9BD
    LDI  A,$01

BCMD_CHR_2: ; $D9B6
    SJP  (XREG2STRBUF_1) ; $DFB4
    BCS ARUINT2ARX_1 ; $D9F2
    LDA  XL
    BZS BCMD_CHR_3 ; $D9C6
    SIN  Y

BCMD_CHR_3: ; $D9C6
    LDA  XH
    STA  YH
    SJP  (ARX2STRBUF_1) ; $DFC5
    LDA  YH
    STA  (U)
    BCH BCMD_RLM_STR_4 ; $DA41



; Basic STRS command
BCMD_STR: ; $D9CF
    VEJ  (D2) \ ABRF(ARUINT2ARX_1) \ ABYT($80)
    SJP  (ARX2STRNG)
    BCH BCMD_RLM_STR_5 ; $DA3D



; Basic VAL command
BCMD_LEN: ; $D9D7
    SJP  (DEL_DIM_VARS_17) ; $D14C
    CPA  (Y)
    BCH BCMD_RLM_STR_4 ; $DA41

; Basic LEN / ASC Command $D9DD
    VEJ  (DC)
    BZS BCMD_LEN_2 ; $D9E5
    DEC  YL
    BHS BCMD_LEN_2 ; $D9E5
    LDA  (X)

BCMD_LEN_1: ; $D9E4
    STA  UL

BCMD_LEN_2: ; $D9E5
    LDI  UH,$00



; Transfers U-Reg as an integer to AR-X in the format '82 UH UL '.
ARUINT2ARX: ; $D9E7
    LDI  XL,$04
    LDI  XH,$7A
    LDI  A,$B2
    SIN  X
    LDA  UH
    SIN  X
    LDA  UL
    STA  (X)

ARUINT2ARX_1: ; $D9F2
    RTN



; Basic RIGHT$ / LEFT$ / MID$ Commands
BCMD_RLM_STR: ; D9F3
    LDA  YL
    ANI  A,$03
    SJP  (ISARXBCD_8) ; $DBB3
    BVR $D92B ; ***
    DCS  (X)
    RTN
    STA  YH
    LDI  UH,$00
    CPI  YL,$7B
    BZR BCMD_RLM_STR_6 ; $DA0B
    VMJ  ($30)
    VEJ  (D0) \ ABYT($0D) \ ABRF(MULT16B_2) ; $DA97
    DEC  A
    STA  UH

BCMD_RLM_STR_6: ; DA0B
    VMJ  ($30)
    SJP  (ISARXBCD_6) ; $DB95
    CPA  XH
    LDI  XL,$07
    LDI  XH,$7A
    LDA  (X)
    SEC
    SBC  UH
    BCR BCMD_RLM_STR_7 ; $DA3A
    SBC  YH
    BCR BCMD_RLM_STR_8 ; $DA2F
    CPI  YL,$7A
    BCS BCMD_RLM_STR_9 ; $DA22
    STA  UH

BCMD_RLM_STR_9: ; $DA22
    LDA  YH
    BCH BCMD_RLM_STR_10 ; $DA30

BCMD_RLM_STR_1: ; $DA25
    LDI  UH,$01
    VMJ  ($48) ; ($48)($24)

BCMD_RLM_STR_2: ; $DA29
    POP  X

BCMD_RLM_STR_3: ; $DA2B
    BCH DEC2HEX_125 ; $D971
    BCH DEC2HEX_126 ; $D941

BCMD_RLM_STR_8: ; $DA2F
    ADC  YH

BCMD_RLM_STR_10: ;$ DA30
    SDE  X
    LDA  (X)
    REC
    ADC  UH
    SDE  X
    LDA  (X)
    ADI  A,$00
    BCH BCMD_RLM_STR_11 ; $DA3C

BCMD_RLM_STR_7: ; $DA3A
    LDI  A,$00

BCMD_RLM_STR_11: ; $DA3C
    STA  (X)

BCMD_RLM_STR_5: ; $DA3D
    SJP  (BCMD_TIME_8) ; $DFA0
    DEC  U

BCMD_RLM_STR_4: ; $DA41
    LDI  UH,$00
    RTN



; Basic STATUS Command
BCMD_STATUS: ; $DA44
    VEJ  (D0) \ ABYT($08) \ ABRF(MULT16B_3) ; $DAA7
    DEC  UL
    BCR BCMD_MEM
    BZS BCMD_MEM_1 ; $DA62
    VEJ  (CC) \ ABYTL(BASPRG_END_H) ; 7867
    INC  X
    DEC  UL
    BZS BCMD_STATUS_1 ; $DA59
    VEJ  (CC) \ ABYTL($7899)
    DEC  UL
    BZS BCMD_STATUS_1 ; $DA59
    VEJ  (CC) \ ABYTL(PREV_LINE_H) ; $78A2

BCMD_STATUS_1: ; $DA59
    STX  U
    BCH BCMD_MEM_2 ; $DA6C



 ;Basic MEM Command
BCMD_MEM: ; $DA5D
    SJP  (MEM_IN_UREG)
    BCH BCMD_MEM_3 ; $DA65

BCMD_MEM_1: ; $DA62
    VMJ  ($14)
    INC  U

BCMD_MEM_3: ; $DA65
    INC  U
    BCS BCMD_MEM_2 ; $DA6C
    LDI  UL,$00
    LDI  UH,$00

BCMD_MEM_2: ; $DA6C
    VMJ  ($10) \ ABYT($00)
    BCH BCMD_RLM_STR_4 ; $DA41



;------------------------------------------------------------------------------
; (50) 16 * 16 Bit Multiplication (U-Reg * Y-Reg)
;            Address: DA71 (50)
;   Entry parameters: At entry, U-Reg and Y-Reg each contain a hex value that is to be multiplied with one another.
; 
; Modified registers: The result is in X-Reg and Y-Reg
;   Error conditions: Carry=1 when overflow occurs
;------------------------------------------------------------------------------
MULT16B: ; $DA71
    LDI  XL,$00
    LDI  XH,$00

MULT16B_8: ; $DA75
    LDA  UH
    SHR
    STA  UH
    LDA  UL
    ROR
    STA  UL
    BCR MULT16B_4 ; $DA86
    REC
    LDA  YL
    ADC  XL
    STA  XL
    LDA  YH
    ADC  XH
    STA  XH
    BCS MULT16B_5 ; $DA94

MULT16B_4: ; $DA86
    LDA  UL
    BZR MULT16B_6 ; $DA8C
    LDA  UH
    BZS MULT16B_7 ; $DA95

MULT16B_6: ; $DA8C
    LDA  YL
    SHL
    STA  YL
    LDA  YH
    ROL
    STA  YH
    BCR MULT16B_8 ; $DA75

MULT16B_5: ; $DA94
    RTN

MULT16B_7: ; $DA95
    STX  Y

MULT16B_2: ; $DA97
    RTN



; Searches operator table by value in accumulator
MULT16B_1: ; $DA98
    LDI  XL,$A7
    LDI  XH,$C3

MULT16B_9: ; $DA9C
    INC  X
    INC  X
    INC  X
    INC  X
    CIN
    BZS MULT16B_3 ; $DAA7
    LOP  UL,MULT16B_9 ; $DA9C
    LDI  XL,$D4

MULT16B_3: ; $DAA7
    RTN



; Forms a two’s complement of U-Reg
TWOSCOMP: ; $DAA8
    LDA  UH
    EAI  $FF
    STA  UH
    LDA  UL
    EAI  $FF
    STA  UL
    INC  U
    RTN



; Y-Reg points to a string with USING parameters. Evaluation and transfer to 
; the using pointers.
EVAL_USING: ; $DAB2
    LDI  A,$00

; Read USING parameters and update in memory. Jump in case of error.
EVAL_USING_1: ; $DAB4
    STA  (STK_PTR_GSB_FOR)
    VMJ  ($36)
    BCR EVAL_USING_2 ; $DAC0
    PSH  Y
    VEJ  (DC)
    BCH EVAL_USING_3 ; $DAC8

EVAL_USING_2: ; $DAC0
    CPI  UH,$15
    BZR EVAL_USING_4 ; $DB44
    LDI  UL,$00
    PSH  X

EVAL_USING_3: ; $DAC8
    LDI  A,$00
    LDI  YL,$08
    LDI  YH,$7A
    STA  UH
    SIN  Y
    SIN  Y
    STA  (Y)
    DEC  UL
    BCS EVAL_USING_5 ; $DB26

EVAL_USING_12: ; $DAD5
    POP  Y
    LIN  Y
    CPI  A,$E0
    BCR EVAL_USING_6 ; $DAE1
    INC  Y

EVAL_USING_9: ; $DADD
    LDI  UH,$01
    VMJ  ($48) ; ($48)($24)

EVAL_USING_6: ; $DAE1
    CPI  A,$3B
    BZS EVAL_USING_7 ; $DAEE
    CPI  A,$3A
    BZS EVAL_USING_8 ; $DAED
    CPI  A,$0D
    BZR EVAL_USING_9 ; $DADD

EVAL_USING_8: ; $DAED
    REC

EVAL_USING_7: ; $DAEE
    ROL
    EOR  (STK_PTR_GSB_FOR)
    ROR
    BCR EVAL_USING_9 ; $DADD
    PSH  Y
    LDI  YL,$95
    LDI  YH,$78
    LDI  XL,$0A
    LDI  XH,$7A
    LDA  UH
    BZS EVAL_USING_10 ; $DB0F
    SIN  Y
    LDI  XL,$08
    TIN
    LIN  X
    INC  Y
    SDE  Y
    LDA  (X)
    VZS  ($4E) ; ($4E)($27)

EVAL_USING_11: ; $DB0C
    STA  (Y)
    VMJ  ($4E) ; ($4E)($27)

EVAL_USING_10: ; $DB0F
    LDI  YL,$97
    LDA  (X)
    BZR EVAL_USING_11 ; $DB0C
    INC  Y
    SDE  Y
    SDE  Y
    SDE  Y
    BCH EVAL_USING_11 ; $DB0C

EVAL_USING_13: ; $DB1A
    ADI  (Y),$01
    DEC  UL
    BCR EVAL_USING_12 ; $DAD5
    CIN
    BZS EVAL_USING_13 ; $DB1A
    LDA  UH
    BZR EVAL_USING_14 ; $DB42
    DEC  X

EVAL_USING_5: ; $DB26
    LIN  X
    CPI  A,$26
    BZS EVAL_USING_13 ; $DB1A
    LDI  YL,$08

EVAL_USING_24: ; $DB2D
    PSH  X
    VMJ  ($34) \ ABYT($06) \ ABYT($23) \ ABRF(EVAL_USING_15) \
                             ABYT($2A) \ ABRF(EVAL_USING_16) \ 
                             ABYT($2B) \ ABRF(EVAL_USING_18) \ 
                             ABYT($5E) \ ABRF(EVAL_USING_17) \
                             ABYT($2C) \ ABRF(EVAL_USING_19) \ 
                             ABYT($2E) \ ABRF(EVAL_USING_20) \ 
                             ABYT($26) \ ABRF(EVAL_USING_21)

EVAL_USING_23: ; $DB40
    POP  X

EVAL_USING_14: ; $DB42
    LDI  UH,$0C

EVAL_USING_4: ; $DB44
    VMJ  ($4A) ;  ($4A)($25)

EVAL_USING_16: ; $DB46
    ORI  A,$40
    STA  UH

EVAL_USING_15: ; $DB49
    LDA  (Y)
    INC  A
    BHS EVAL_USING_22 ; $DB4E
    STA  (Y)

EVAL_USING_22: ; $DB4E
    CPI  UH,$80
    BCS EVAL_USING_23 ; $DB40
    LDA  UH
    ORI  A,$01
    STA  UH

EVAL_USING_25: ; $DB56
    POP  X
    LIN  X
    LOP  UL,EVAL_USING_24 ; $DB2D
    BCH EVAL_USING_12 ; $DAD5

EVAL_USING_18: ; $DB5D
    ORI  A,$20

EVAL_USING_26: ; $DB5F
    STA  UH
    BCH EVAL_USING_22 ; $DB4E

EVAL_USING_20: ; $DB62
    CPI  YL,$08
    BZR EVAL_USING_23 ; $DB40
    INC  Y
    ORI  (Y),$01
    BCH EVAL_USING_22 ; $DB4E

EVAL_USING_17: ; $DB6B
    ORI  A,$80
    STA  UH
    LDI  YL,$08
    LDI  A,$02
    CPA  (Y)
    BCR EVAL_USING_25 ; $DB56
    STA  (Y)
    BCH EVAL_USING_25 ; $DB56

EVAL_USING_21: ; $DB78
    LDI  YL,$0A
    LDA  (Y)
    BZR EVAL_USING_23 ; $DB40
    POP  X
    LDI  A,$26
    BCH EVAL_USING_13 ; $DB1A

EVAL_USING_19: ; $DB83
    ORI  A,$10
    BCH EVAL_USING_26 ; $DB5F



;------------------------------------------------------------------------------
; (26) Checks AR-X for BCD format and branches
; Branches to offset address P1 if a BCD value is present in AR-X. 
; If a CSI could be recognized in the AR-X, continue after the address following P1.
; 
;            Address:	DB87 (26)
;    Entry Parameter:	No
; Modified Registers:	X-Reg contains return address. U Reg, accumulator
;   Error conditions:	UH contains error code 11 if a BCD value is detected.
;------------------------------------------------------------------------------
ISARXBCD: ; $DB87
    LDI  A,$B2
    CPA  (ARX + $04)
    BCR ISARXBCD_9 ; $DB91
    JMP  LOAD_NEXT_3 ; $DCF1

ISARXBCD_9: ; $DB91
    LDI  UH,$11
    VMJ  ($48) ; ($48)($24)


; Checks whether the address in the AR-X is within the string buffer. If OK, 
; resets the string buffer pointer. If not, set error 11 in UH and jump.
ISARXBCD_6: ; $DB95
    LDI  XL,$04
    LDI  XH,$7A
    LIN  X
    CPI  A,$C1
    BCR ISARXBCD_9 ; $DB91
    LIN  X
    CPI  A,$7B
    VZR  ($4C) ; ($4C)($26)
    LDA  (X)
    CPI  A,$10
    VCR  ($4C) ; ($4C)($26)
    CPI  A,$60
    VCS  ($4C) ; ($4C)($26)
    STA  (STR_BUF_PTR_L)
    VMJ  ($4C) ; ($4C)($26)

;------------------------------------------------------------------------------
; (28) Checks in $788C to see if the variable was one-dimensional. If not, load 
; error code 12 to UH and jump.
;------------------------------------------------------------------------------
    LDI  A,$01 ; $DBB1

; Checks whether the variable is one-dimensional. Jump, if not
ISARXBCD_8: ; $DBB3
    CPA  (NUMARGS)
    VZS  ($4C) ; ($4C)($26) 
    LDI  UH,$12
    VMJ  ($48) ; ($48)



;------------------------------------------------------------------------------
; (F4) Loads U-Reg with address from main memory
; Address:	D8BC (F4)
;          Parameter: D1 & D2 identify address to load into U-Reg.
;
; Modified Registers: U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
ADDR_2_UREG: ; $D8BC 
    POP  U
    LIN  U
    INC  U
    PSH  U
    DEC  U
    PSH  A
    LDA  (U)
    STA  UL
    POP  A
    STA  UH

ISARXBCD_10: ; $DBCA
    LIN  U
    PSH  A
    LDA  (U)
    STA  UL
    POP  A
    STA  UH
    RTN

; Gets U-Reg from basic stack
ISARXBCD_7: ; $DBD3
    ADI  (BAS_PENOP_STK_L),$02
    LDA  (BAS_PENOP_STK_L)
    STA  UL
    DEC  UL
    LDI  UH,$7A
    BCH ISARXBCD_10 ; $DBCA


; Save U-Reg on the basic stack. Loads error code 0E to UH in case of stack 
; overflow. If o.k. C = 0.
ISARXBCD_5: ; $DBE0
    LDA  (BAS_PENOP_STK_L)
    STA  XL
    LDA  (BAS_DATA_STK_L)
    CPA  XL
    BCS ISARXBCD_11 ; $DC2F
    LDI  XH,$7A
    LDA  UL
    SDE  X
    LDA  UH
    SDE  X
    LDA  XL
    STA  (BAS_PENOP_STK_L)
    RTN


; Transfer AR-X to Basic Stack
ISARXBCD_1: ; $DBF5
    LDA  (BAS_DATA_STK_L)
    STA  XL
    CPI  A,$38
    BCR ISARXBCD_11 ; $DC2F
    ADI  A,$06
    BCS ISARXBCD_11 ; $DC2F
    CPA  (BAS_PENOP_STK_L)
    BCS ISARXBCD_11 ; $DC2F
    ADI  (BAS_DATA_STK_L),$08
    LDI  XH,$7A


; Transfers AR-X from the memory cell pointed to by X-Reg. (8-bytes).
ISARXBCD_24: ; $DC0C
    PSH  Y
    STX  Y
    LDI  XL,$00
    LDI  XH,$7A
    BCH ISARXBCD_12 ; $DC26


;------------------------------------------------------------------------------
; (30) Get AR-X from Basic Stack $DC16
;------------------------------------------------------------------------------
    ADI  (BAS_DATA_STK_L),$F8
    LDA  (BAS_DATA_STK_L)
    STA  XL
    LDI  XH,$7A

; Stores 8 bytes from address X-Reg to AR-X.
ISARXBCD_2: ; $ DC20
    PSH  Y
    LDI  YL,$00
    LDI  YH,$7A

ISARXBCD_12: ; $ DC26
    LDI  UL,$07

ISARXBCD_13: ; $ DC28
    TIN
    LOP  UL,ISARXBCD_13 ; $DC28
    POP  Y
    REC
    RTN

ISARXBCD_11: ; $ DC2F
    LDI  UH,$0E
    RTN

ISARXBCD_4: ; $ DC32
    POP  U
    PSH  Y

    BII  (DISPARAM),$10
    BZS ISARXBCD_15 ; $DC49
    DEC  UL
    BZS ISARXBCD_16 ; $DC44
    SJP  (BCD_Y2ARX_43) ; $D2D3
    BCH ISARXBCD_17 ; $DCA0

ISARXBCD_16: ; $ DC44
    SJP  ($D2B3)
    BCH ISARXBCD_17 ; $DCA0

ISARXBCD_15: ; $ DC49
    BII  (BREAKPARAM),$E0
    BZS ISARXBCD_18 ; $DC54
    SJP  (BCD_Y2ARX_44) ; $D24E
    BCH ISARXBCD_19 ; $DC5E

ISARXBCD_18: ; $ DC54
    VEJ  (CC) \ ABYTL(ERR_LINE_H) ; $78B4
    ORA  (ERR_LINE_L)
    BZS ISARXBCD_20 ; $DC93
    SJP  (BCD_Y2ARX_45) ; $D246

ISARXBCD_19: ; $ DC5E
    BCR ISARXBCD_21 ; $DC8F
    LDI  A,$54
    BII  (DISP_BUFF + $4F),$20
    VZR  ($44) ; ($44)($22)
    SJP  (SAVELCD2BUF)
    VEJ  (CC) \ ABYTL(DISPARAM) ; $7880)
    PSH  A
    LDI  A,$54
    STA  (DISPARAM)
    SJP  (PRGMDISP)
    ANI  (CURS_CTRL),$BF
    SJP  (WAITNOKEYS)
    SJP  (BUF2LCD)
    POP  A
    ANI  A,$DF
    STA  (DISPARAM)
    BII  A,$C0
    BZS ISARXBCD_21 ; $DC8F
    VEJ  (F2)
    VMJ  ($42) ; ($42)($21)

ISARXBCD_21: ; $DC8F
    POP  Y
    VMJ  ($46) ; ($46)($23)

ISARXBCD_20: ; $DC93
    DEC  UL
    BCR ISARXBCD_21 ; $DC8F
    BZS ISARXBCD_22 ; $DC9D
    SJP  (BCD_Y2ARX_46) ; $D277
    BCH ISARXBCD_17 ; $DCA0

ISARXBCD_22: ; $DC9D
    SJP  (BCD_Y2ARX_47) ; $D26F

ISARXBCD_17: ; $DCA0
    BCR ISARXBCD_21 ; $DC8F
    LDI  A,$14
    VMJ  ($44) ; ($44)($22)


;------------------------------------------------------------------------------
; (2C) Passes function result to AR-X. $DCA6
;------------------------------------------------------------------------------
    LDI  A,$01
    STA  ($7889)
    JMP  DEC2HEX_127 ; $D6E5

; Compares accumulator with pointer to the input buffer
ISARXBCD_3: ; $DCAE
    DEC  A
    CPA  (INBUFPTR_L)
    RTN
    .BYTE $80,$00,$FF


;------------------------------------------------------------------------------
; (02) Checks if next character in main memory in specific ASCII code range
; Address:	DCB6 (02)
; D1 = Smallest value within the interval
; D2 = Smallest value above the interval
; D3 = Distance 
; 
;    Entry Parameter:	Y-Reg points to character to be tested. U-Reg contains the character loaded from memory in UL.
; Modified Registers:	X-Reg return address, accumulators, Y-Reg points to the next character
;   Error conditions:	A token or character read outside of the interval continues the program at offset D3
;------------------------------------------------------------------------------
CHAR_MEM_N_RANGE_: ; $DCB6
    VEJ  (C0) ; $DCB6
    


;------------------------------------------------------------------------------
; (00) Checks whether character in U-Reg in specific ASCII code range
;            Address: DCB7 (00)
;                     D1 = smallest value within the interval
;                     D2 = smallest value above the interval
;                     D3 = distance address
; 
;    Entry Parameter: U-Reg contains character loaded from memory in UL.
; Modified Registers: X-Reg return address, accumulator
;   Error conditions: Token/caracter read outside interval continues program at offset D3
;------------------------------------------------------------------------------
CHAR_U_N_RANGE_: ; $DCB7
    POP  X 
    LDA  UH
    BZR LOAD_NEXT_4 ; $DCF5
    LDA  UL
    CIN
    BCR LOAD_NEXT_2 ; $DCF6
    CIN
    BCR LOAD_NEXT_5 ; $DCE6
    BCH LOAD_NEXT_6 ; $DD03


;------------------------------------------------------------------------------
; (C8) Branch if not end of command sequence or end of line
;            Address: DCC5 (C8)
;                 D1: Distance Address
;    Entry Parameter: None
; Modified Registers: X-Reg contains return address
;   Error conditions: Carry-Flag = 1 if an end of the command sequence was 
;                     recognized in a Basic program (:).
;------------------------------------------------------------------------------
CHECK_AT_END: ; $DCC5 (C8)
    VEJ  (C0)
    VEJ  (D8)
    BZS ISARXBCD_23 ; $DCCD
    CPI  UL,$3A
    BZS LOAD_NEXT_3 ; $DCF1

ISARXBCD_23: ; $DCCD
    CPI  UL,$0D
    REC
    BZS LOAD_NEXT_3 ; $DCF1
    BCH LOAD_NEXT_7 ; $DD01


;------------------------------------------------------------------------------
; (C2) Checks for the presence of a specific character or token. If found,  
; a branch is made to the offset address.
;            Address:	1. DCD4 (C2) with character/token loading
;                       2. DCD5 (C4) character/token already in U-Reg.
;                       D1, D2: character or token expected.
;                       D3: Distance Address
; 
;    Entry Parameter: Y-Reg points to main memory
; Modified Registers: Y-Reg has been incremented.
;   Error conditions: None
;------------------------------------------------------------------------------ 
LOAD_NEXT_C2: ; $DCD4 (C2)
    VEJ  (C0)

;Checks tokens/characters in U-Reg with data bytes If not equal, branch.
LOAD_NEXT_C4: ; $DCD5 (C4)
    POP  X
    LIN  X
    CPI  A,$E0
    BCS LOAD_NEXT_8 ; $DCDF
    DEC  X
    LDI  A,$00

LOAD_NEXT_8: ; $DCDF
    CPA  UH
    BZR LOAD_NEXT_2 ; $DCF6
    LIN  X
    CPA  UL
    BZR LOAD_NEXT_6 ; $DD03

LOAD_NEXT_5: ; $DCE6
    INC  X
    STX  P
    POP  X
    BCH LOAD_NEXT_3 ; $DCF1




;------------------------------------------------------------------------------
; (4C) Return to a main program (after the last data byte)
; Address:	(4C) DCE9
;   Entry parameters: The stack must show an address of main program pointing
;                     to the last of data bytes following the subprogram call.
; 
; Modified registers: X-Reg contains return address
;   Error conditions: None
;------------------------------------------------------------------------------
RTN_AFTER_DATA: ; $DCE9
    POP  X
    POP  Y

;------------------------------------------------------------------------------
; (4E) Return to main program (after data byte). Restore Basic program pointer
; Address:	(4E) DCED
;   Entry parameters: As (4C). In addition, Basic program pointer is on stack.
; 
; Modified registers: Basic program pointer (Y-Reg) restored, else like (4C).
;   Error conditions: None
;------------------------------------------------------------------------------
LOAD_NEXT_3: ; $DCF1
    POP  X
    BCH LOAD_NEXT_5 ; $DCE6

LOAD_NEXT_4: ; $DCF5
    INC  X

LOAD_NEXT_2: ; $DCF6
    INC  X
    BCH LOAD_NEXT_6 ; $DD03

;------------------------------------------------------------------------------
; (48) Return to a main program (relative jump)
;            Address: (48) DCF9
;   Entry parameters: The stack must show an address of the main program that 
;                     points to last of data bytes following subprogram call.
; 
; Modified registers: X-Reg contains address where the main program continues.
;   Error conditions: None
;------------------------------------------------------------------------------
RTN_TO_MAIN: ; $DCF9
    POP  X
    BCH LOAD_NEXT_7 ; $DD01

; (4A) Return to distance address. Restore Y-Reg $DCFD
    POP  X
    POP  Y

LOAD_NEXT_7: ; $DD01
    POP  X

LOAD_NEXT_6: ; $DD03
    LIN  X
    ADR  X
    STX  P

; (C0) Load next character/token into U-REG
    LDI  UH,$00
    LIN  Y
    CPI  A,$E0
    BCR LOAD_NEXT_9 ; $DD11
    STA  UH
    LIN  Y

LOAD_NEXT_9: ; $DD11
    STA  UL
    RTN

;------------------------------------------------------------------------------
; (C6) $$DD13 Decrements Y-Reg for tokens in U-Reg by 2-bytes, or by 1-byte 
; for characters
    CPI  UH,$00
    BZS LOAD_NEXT_10 ; $DD18
    DEC  Y

LOAD_NEXT_10: ; $DD18
    DEC  Y
    RTN



;------------------------------------------------------------------------------
; (D2) Convert AR-X with subroutine DD2D (10) if it is integer value.
; Else if address of a string is there, a branch is made to offset address D1.
;            Address:	DD1A (D2)
; 	                    D1: Distance Address if AR-X contains string address
;                       D2: Data byte for possibly called subprogram DD2D (10)
;
;    Entry Parameter:	None
; Modified Registers:	X-Reg, U-Reg, Accumulator
;   Error conditions:	None
;------------------------------------------------------------------------------
CONVERT_ARX_IF_INT: ; $DD1A (D2)
    LDA  (ARX + $04)
    CPI  A,$B2
    BCR LOAD_NEXT_11 ; $DD23
    BZR LOAD_NEXT_7 ; $DD01

LOAD_NEXT_11: ; $DD23
    POP  X
    INC  X
    BCR LOAD_NEXT_5 ; $DCE6
    PSH  X
    VEJ  (F4) \ AWRD(ARX + $05)
    


; (10)  Convert U-Reg according to data bytes
;       00: Save U-Reg to AR-X in BCD format. (0-65535)
;       40: Save to (Y-Reg) in ASCII
;       8D: Save U-Reg in AR-X as BCD. (integer number)
;       E0: Save to Y-Reg with 2 digits in ASCII
    LDX  U

; $DD2F Like subroutine (10-DD2D).
LOAD_NEXT_1:
    POP  U
    LIN  U
    PSH  U
    PSH  Y
    PSH  A
    PSH  X
    VEJ  (EC)
    SJP  (CLR_SM_ARX3)
    ORI  (ARZ + $04),$10
    POP  U
    POP  A
    SHL
    PSH  A
    LDI  YH,$7A
    BCR LOAD_NEXT_12 ; $DD58
    CPI  UH,$80
    BCR LOAD_NEXT_12 ; $DD58
    SJP  (TWOSCOMP)
    ORI  (ARX + $01),$80

LOAD_NEXT_12: ; $DD58
    LDI  XL,$04
    LDI  YL,$0C
    LDA  UL
    BZR LOAD_NEXT_13 ; $DD97
    LDA  UH
    BZR LOAD_NEXT_14 ; $DD98
    LDA  XL
    STA  (ARX)
    SJP  (ARX2BCD_ABS)
    LDA  (ARX)
    STA  UL
    POP  A
    SHL
    POP  Y
    BCR LOAD_NEXT_15 ; $DD96
    LDI  XL,$01
    SHL
    BCR LOAD_NEXT_16 ; $DD87
    LDE  X
    SHL
    LDI  A,$20
    BCR LOAD_NEXT_17 ; $DD81
    LDI  A,$2D

LOAD_NEXT_17: ; $DD81
    SIN  Y
    LDA  UL
    LDI  UL,$01
    BZS LOAD_NEXT_18 ; $DD91

LOAD_NEXT_16: ; $DD87
    LDI  XL,$04
    DRL  (X)
    DEC  X
    DRL  (X)
    DEC  X
    DRL  (X)
    AEX
    ANI  A,$0F

LOAD_NEXT_18: ; $DD91
    ORI  A,$30
    SIN  Y
    LOP  UL,LOAD_NEXT_16 ; $DD87

LOAD_NEXT_15: ; $DD96
    RTN

LOAD_NEXT_13: ; $DD97
    LDA  UH

LOAD_NEXT_14: ; $DD98
    SHR
    STA  UH
    LDA  UL
    ROR
    STA  UL
    BCR LOAD_NEXT_19 ; $DDAA
    REC
    LDE  Y
    DCA  (X)
    SDE  X
    LDE  Y
    DCA  (X)
    SDE  X
    LIN  Y
    DCA  (X)
    STA  (X)
    INC  Y

LOAD_NEXT_19: ; $DDAA
    LDA  (Y)
    DCA  (Y)
    SDE  Y
    LDA  (Y)
    DCA  (Y)
    SDE  Y
    LDA  (Y)
    DCA  (Y)
    STA  (Y)
    BCH LOAD_NEXT_12 ; $DD58


;------------------------------------------------------------------------------
; (F6) U-Reg transferred to main memory
;            Address: DDB5 (F6)
;          Parameter: D1 & D2 identify address to which U-Reg is transferred
; 
; Modified Registers: X-Reg contains address of 2nd memory cell, accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
UREG_2_MEM: ; $DDB5
    POP  X
    LIN  X
    INC  X
    PSH  X
    DEC  X
    PSH  A
    LDA  (X)
    STA  XL
    POP  A
    STA  XH
    LDA  UH
    SIN  X
    LDA  UL
    STA  (X)
    RTN



;------------------------------------------------------------------------------
; (CC) Load X-Reg with 16-bit value from memory page 78XX
;            Address: DDC8 (CC)
;                     D1: Low byte of address in memory page 78XX
;   Entry parameters: None
;
; Modified registers: X-Reg contains value from (7801 f.). Accumulator includes (78D1)
;   Error conditions: None
;------------------------------------------------------------------------------
    POP  X
    LIN  X
    PSH  X
    STA  XL
    LDI  XH,$78
    LIN  X
    PSH  A
    LDA  (X)
    STA  XL
    POP  A
    STA  XH
    RTN



;------------------------------------------------------------------------------
; (08) Transfers the result from AR-X to a fixed variable or clock module
;            Address: DDD9 (08)
;                     Distance Address
;   Entry parameters: AR-X contains BCD value, integer value or CSI (7883 ff.) 
;                     contains pointer of prepared variable with bit 7 of 
;                     address set if variable is not already set up in variable 
;                     memory. If there is a pointer greater than DB00 in 
;                     (7883 f.), the clock module is written with value from 
;                     AR-X. The subprogram checks whether the variable type of 
;                     prepared variable (output variable) matches that in AR-X.
; 
; Modified registers: X-Reg contains return address: Y-Reg pointer to main memory.
;   Error conditions: If an error is detected (wrong format, insufficient variable memory or invalid value for the clock module), the process continues with the distance address D1.
;------------------------------------------------------------------------------
ARX_2_VAR: ; $DDD9
    PSH  Y
    VMJ  ($26)
    SBC  XL
    ROR
    EOR  (CURVARTYPE) ; $7885
    SHL
    LDI  UH,$07
    VCS  ($4A) ;($4A)($25)
    VEJ  (CC) \ ABYTL(CURVARADD_H) ; $7883
    CPI  XH,$80
    BCR LOAD_NEXT_20 ; $DDF8
    CPI  XH,$DB
    BCS LOAD_NEXT_21 ;  $DE1D
    SJP  (SRCHPRGLINE_16) ; $D371
    VCS  ($4A) ;($4A)($25)
    LDX  Y

LOAD_NEXT_20: ; $DDF8
    BII  (CURVARTYPE),$80 ; $7885
    BZS LOAD_NEXT_22 ; $DE03
    SJP  (ISARXBCD_24) ; $DC0C
    VMJ  ($4E) ; ($4E)($27)

LOAD_NEXT_22: ; $DE03
    STX  Y
    VEJ  (DC)
    SEC
    SBC  (CURVARTYPE); $7885
    LDI  UH,$00
    BCR LOAD_NEXT_23 ; $DE14
    LDA  (CURVARTYPE); $7885
    STA  UL
    LDI  UH,$01

LOAD_NEXT_23: ; $DE14
    SJP  (XREG2YREG)
    LDA  UH
    BZR LOAD_NEXT_24 ; $DE1B
    STA  (Y)

LOAD_NEXT_24: ; $DE1B
    VMJ  ($4E) ; ($4E)($27)

LOAD_NEXT_21: ; $DE1D
    VEJ  (E6)
    LDA  (ARX)
    BII  A,$80
    BZR LOAD_NEXT_25 ; $DE2D
    SBI  A,$06
    BCR LOAD_NEXT_26 ; $DE35

LOAD_NEXT_31: ; $DE29
    LDI  UH,$17
    VMJ  ($4A) ; ($4A)($25)

LOAD_NEXT_25: ; $DE2D
    CPI  A,$FC
    LDI  UH,$F6
    BCR LOAD_NEXT_27 ; $DE36
    ADI  A,$F9

LOAD_NEXT_26: ; $DE35
    STA  UH

LOAD_NEXT_27: ; $DE36
    LDI  XH,$7A

LOAD_NEXT_29: ; $DE38
    LDI  XL,$02
    INC  UH
    BCS LOAD_NEXT_28 ; $DE48
    LDI  UL,$04
    LDI  A,$00

LOAD_NEXT_30: ; $DE42
    DRR  (X)
    INC  X
    LOP  UL,LOAD_NEXT_30 ; $DE42
    BCH LOAD_NEXT_29 ; $DE38

LOAD_NEXT_28: ; $DE48
    LDA  (X)
    CPI  A,$13
    BCS LOAD_NEXT_31 ; $DE29
    CPI  A,$10
    BCR LOAD_NEXT_32 ; $DE53
    ADI  A,$09

LOAD_NEXT_32: ; $DE53
    ANI  A,$0F
    AEX
    STA  (X)
    SJP  (ARX2TIME)
    VMJ  ($56) ; ($56)($2B)
    VMJ  ($4E) ; ($4E)($27)




;------------------------------------------------------------------------------
; (0A) Variable, whose address is in AR-X, is transferred numerically to AR-X, 
;      if string: determine length
;            Address: DE5E (0A)
;   Entry parameters: AR-X must contain the CSI of a variable. If the clock 
;                     module is to be read out, the high byte of the address 
;                     must be greater than DB.
; 
; Modified registers: Variable was transferred to AR-X. X-Reg points to the 1st
;                     byte after the transmitted value. Y Reg on 7A08
;   Error conditions: Like (CE)
;------------------------------------------------------------------------------
VAR_2_ARX: ; $DE5E
    VEJ  (DC) 
    CPI  XH,$80
    ANI  A,$80
    BCS LOAD_NEXT_33 ; $DE7A
    BZS LOAD_NEXT_34 ; $DE6A
    JMP  ISARXBCD_2 ; $DC20

LOAD_NEXT_34: ; $DE6A
    PSH  X
    DEC  UL
    LDI  UH,$00

LOAD_NEXT_36: ; $DE6F
    LIN  X
    BZS LOAD_NEXT_35 ; $DE76
    INC  UH
    LOP  UL,LOAD_NEXT_36 ; $DE6F

LOAD_NEXT_35: ; $DE76
    POP  X
    BCH BCMD_TIME_9 ; $DEAE

LOAD_NEXT_33: ; $DE71
    BZS BCMD_TIME_10 ; $DEAF
    CPI  XH,$DB
    BCS BCMD_TIME
    VEJ  (EC)
    RTN



; Basic command TIME
BCMD_TIME: ; $DE82
    VEJ  (EC)
    SJP  (TIME2ARX)
    LDI  XL,$02
    LDI  A,$00
    DRR  (X)
    CPI  A,$A0
    BCR BCMD_TIME_11 ; $DE91
    ADI  (X),$06

BCMD_TIME_11: ; $DE91
    ORI  (ARX),$05
    VEJ  (E8)
    RTN


; (0C) $DE97 Read the length of the string from U-Reg and creates CSI in AR-X.
    LDI  UL,$50
    LDX  Y
    LDI  UH,$00

BCMD_TIME_13: ; $DE9D
    DEC  UL
    BCR BCMD_TIME_9 ; $DEAE
    LIN  Y
    CPI  A,$22
    BZS BCMD_TIME_9 ; $DEAE
    CPI  A,$0D
    BZS BCMD_TIME_12 ; $DEAD
    INC  UH
    BCH BCMD_TIME_13 ; $DE9D

BCMD_TIME_12: ; $DEAD
    DEC  Y

BCMD_TIME_9: ; $DEAE
    LDA  UH



;------------------------------------------------------------------------------
; (24) Creates CSI in AR-X
;            Address: DEAF (24)
;          Parameter: X-Reg contains the start address of the string
;                     Accumulator contains the string length
; Modified Registers: (7A04) = D0
;                     (7A05 - 7A06) = address of the string
;                     (7A07) = String length
;                      U-Reg = 7A04, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
BCMD_TIME_10: ; $DEAF
    LDI  UL,$07
    LDI  UH,$7A
    SDE  U
    LDA  XL
    SDE  U
    LDA  XH
    SDE  U
    LDI  A,$D0
    STA  (U)
    RTN


; (DC) $DEBC Loads CSI from AR-X address to X-Reg length to UL and accumulator
    LDI  UL,$05

; Transfers from address 7A UL, 16-bit address to X-Reg and length to UL.
BCMD_TIME_7: ; $DEBE
    LDI  UH,$7A
    LIN  U
    STA  XH
    LIN  U
    STA  XL
    LDA  (U)
    STA  UL
    RTN


; $DEC7 Get program pointer from basic stack
BCMD_TIME_4: 
    VEJ  (D4) \ ABYT($A0)
    LDA  (STK_PTR_GSB_FOR)
    STA  UL
    LDI  UH,$7A
    BCH BCMD_TIME_14 ; $DED9


; (D6) $DED1 Loads address pointer from memory to AR-Y: A6=PROGRAM, AC=BREAK, B8=0N ERROR.
    POP  X
    LIN  X
    STA  UL
    PSH  X
    LDI  UH,$78

BCMD_TIME_14: ; $DED9
    LDI  XL,$9C
    LDI  XH,$78
    LIN  U
    STA  YH
    LIN  U
    STA  YL
    BCH BCMD_TIME_15 ; $DEF3



;------------------------------------------------------------------------------
; (D4) Save the pointer of the current processing status to memory
;            Address: DEE3 (D4)
;                     D1 determines which area of program pointer is updated.
;                     D1 can assume the following values:
;                     A0: The address of the line currently being processed is 
;                         transferred to (78A0-78A1). Contents of the Y Reg. 
;                         The current line number is taken from (789C-789D) and 
;                         transferred to (78A2 f.). The program start address
;                         is taken from (789E f.) and transferred to (78A4 f.).
;                     AC: Information about a BREAK that has been carried out 
;                         is saved in same way as data byte A0 to (78AC ff.).
;                     B2: Similar ERROR information as (78B2 ff.)
;   Entry parameters: Y-Reg points to Basic main memory
;
; Modified registers: X-Reg, Y-Reg
;   Error conditions: None
;------------------------------------------------------------------------------
    POP  U
    LIN  U
    STA  XL
    PSH  U
    LDI  XH,$78

BCMD_TIME_16: ; $DEEB
    LDI  UH,$78
    LDI  UL,$9C
    LDA  YH
    SIN  X
    LDA  YL

BCMD_TIME_17: ; $DEF2
    SIN  X

BCMD_TIME_15: ; $DEF3
    LIN  U
    SIN  X
    LIN  U
    SIN  X
    LIN  U
    SIN  X
    LIN  U
    SIN  X
    RTN


; Write address, line number, and start address of nth instruction to stack
BCMD_TIME_5: ; $DEFC
    VEJ  (C8) \ ABRF(BCMD_TIME_6) ; $DEFE


; Address, line number, program start of current instruction on basic stack
BCMD_TIME_6: ; $DEFE
    VMJ  ($18)
    VEJ  (CC) \ ABYTL($7881)
    LDI  XH,$7A
    BCH BCMD_TIME_16 ; $DEEB


; Transfers 3 addresses (program pointer) within memory map
; Relocate 6 bytes starting from address 78UL to 78XL.
BCMD_TIME_1: ; $DF06
    LDI  UH,$78
    LDI  XH,$78
    LIN  U
    SIN  X
    LIN  U
    BCH BCMD_TIME_17 ; $DEF2



;------------------------------------------------------------------------------
; (36) Create CSI in AR-X for string. C=0 if no string found
;            Address: DF0F (36)
;   Entry parameters: Y-Reg points to double quotes or name of string variable 
;                     in main memory.
;
; Modified registers: AR-X contains the CSI of the string
;   Error conditions: If no string was recognized, Carry=0
;------------------------------------------------------------------------------
STRING_2_CSI: ; DF0F
    PSH  Y
    VEJ  (C2) \ ACHR($22) \ ABRF(BCMD_TIME_18) ; $DF18
    VMJ  ($0C)
    BCH BCMD_TIME_19 ; $DF1C

BCMD_TIME_18: ; $DF18
    VEJ  (C6)
    VEJ  (CE) \ ABYT($40) \ ABRF(BCMD_TIME_20) ; $DF1F

BCMD_TIME_19: ; $DF1C
    SEC
    BCH BCMD_TIME_21 ; $DF20

BCMD_TIME_20: ; $DF1F
    REC

BCMD_TIME_21: ; $DF20
    POP  X
    RTN


;------------------------------------------------------------------------------
; (34) Syntax check and multiple branching
; Multiple branching after character test
; 
; Address:	DF23 (34)
;      D1: Number of character tests +1
;      D2: Sign that the accumulator is being checked for agreement.
;      D3: Relative jump by D3 bytes if agreement with the accumulator was
;          found. Each additional character that is tested for agreement
;          with the accumulator always occupies two bytes analogous to D2 & D3
;                     
; 
;    Entry Parameter: Accumulator contains characters whose occurrences are 
;                     searched for in the branching table. The character to be 
;                     tested should be stored in UH, otherwise it will be lost.
; Modified Registers: X-Reg contains return address. U Reg, accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
CHARTESTBRANCH: ; $DF23
    POP  X
    PSH  U
    STA  UH
    LIN  X
    STA  UL
    LDA  UH

BCMD_TIME_23: ; $DF2B
    CIN
    BZS BCMD_TIME_22 ; $DF33
    INC  X
    LOP  UL,BCMD_TIME_23 ; $DF2B
    BCH BCMD_TIME_24 ; $DF36

BCMD_TIME_22: ; $DF33
    LIN  X
    ADR  X

BCMD_TIME_24: ; $DF36
    POP  U
    LDA  UH
    STX  P



;------------------------------------------------------------------------------
; (D8) Checks calculator mode $DF3B
;            Address: DF3B (D8)
; 
;    Entry Parameter: None
; Modified Registers: Zero flag= 1 if calculator is in direct mode
;   Error conditions: None
;------------------------------------------------------------------------------
CHECK_CALC_MODE: ; $DF38 (d8)
    LDA  (CURR_LINE_L)
    ORA  (CURR_LINE_H)
    RTN


; Syntax check: Checks whether the string is enclosed in “…” max 80 characters. 
; Whether the program is running. If so, Z=0.
BCMD_TIME_3: ; $DF42
    LDI  UL,$50


; As above, Syntax check: whether the string is enclosed by “…”. If not UL=FF.
BCMD_TIME_2: ; $DF44
    LDI  UH,$00
    DEC  UL

BCMD_TIME_29: ; $DF47
    LIN  Y
    VMJ  ($34) \ ABYT($03) \ ABYT($2C) \ 
         ABRF(BCMD_TIME_25) \ ABYT($22) \ ABRF(BCMD_TIME_26) \ 
         ABYT($0D) \ ABRF(BCMD_TIME_27) \ ABYT($3A) \ ABRF(BCMD_TIME_28)
    BCH BCMD_TIME_29 ; $DF47

BCMD_TIME_28: ; $DF55
    BZR BCMD_TIME_29 ; $DF47

BCMD_TIME_27: ; $DF57
    DEC  Y
    RTN

BCMD_TIME_25: ; $DF59
    BZR BCMD_TIME_29 ; $DF47
    LOP  UL,BCMD_TIME_29 ; $DF47
    RTN

BCMD_TIME_26: ; $DF5E
    EAI  $01
    STA  UH
    BCH BCMD_TIME_29 ; $DF47



;------------------------------------------------------------------------------
;(22) If string constant follows in main memory, save CSI to AR-X $DF63
; Address:	DF63 (22)
; 
;    Entry Parameter:	Y-Reg must point to main memory
; Modified Registers:	Y-Reg points to the next memory location in main memory following the string. AR-X may contain CSI. U-Reg contains the next character/token.
;   Error conditions:	Carry=1 if string found and CSI created in AR-X Carry=0 if no string found
;------------------------------------------------------------------------------
IS_STRING: ; $DF63   
    VEJ  (C2) \ ACHR($22) \ ABRF($DF70)
    VMJ  ($0C)
    VEJ  (C2) \ ACHR($0D) \ ABRF($DF6C)
    RTN
    VEJ  (C4) \ ACHR($3A) \ ABRF($DF70)
    VEJ  (C0)
    REC
    RTN


; (20) $DF72 Find next beginning of line from (Y-Reg)
; Increments Y-Reg to the low byte of the next line number (REM).
    LDI  A,$0D
    LDI  UL,$4C
    LDX  Y

BCMD_TIME_31: ; $DF78
    CIN
    BZS BCMD_TIME_30 ; $DF7D
    LOP  UL,BCMD_TIME_31 ; $DF78

BCMD_TIME_30: ; $DF7D
    STX  Y
    RTN


; (18) $DF80 Updates program parameters for next instruction
    VEJ  (D4) \ ABYT($A0)
    BCS BCMD_TIME_32 ; $DF8E
    LIN  Y
    STA  (CURR_LINE_H)
    LIN  Y
    STA  (CURR_LINE_L)
    INC  Y
    RTN

BCMD_TIME_32: ; $DF8E
    LDA  YH
    ORI  A,$80
    STA  YH
    RTN


; (12) $DF93 Loads program start address to X-Reg
    VEJ  (CC) \ ABYTL($61) ; $7861
    ROL
    BCR BCMD_TIME_33 ; $DF9A
    VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865

BCMD_TIME_33: ; $DF9A
    RTN
    LDI  A,$10
    STA  (STR_BUF_PTR_L)

; Inserts a string, the address of which is stored in 
; the AR-X, into the string buffer. Jump if overflow. Update buffer pointers.
BCMD_TIME_8: ; $DFA0
    VEJ  (DC)



; Inserts String pointed to by X-Res into String buffer. Jump if overflow.
XREG2STRBUF: ; $DFA1
    PSH  Y
    SJP  (XREG2STRBUF_1) ; $DFB4
    VCS  ($4A) ;($4A)($25)
    LDA  UL

XREG2STRBUF_3: ; $DFA9
    DEC  A
    BCR XREG2STRBUF_2 ; $DFAF
    TIN
    BCH XREG2STRBUF_3 ; $DFA9

XREG2STRBUF_2: ; $DFAF
    SJP  (ARX2STRBUF_1) ; $DFC5
    VMJ  ($4E) ; ($4E)($27)


; $DFB4 Checks whether the string buffer can still hold the number of 
; characters contained in the accumulator. If not, C=1.
XREG2STRBUF_1: ; $DFB4
    STA  UL
    LDA  (STR_BUF_PTR_L)
    STA  YL
    REC
    ADC  UL
    LDI  UH,$0F
    BCS XREG2STRBUF_4 ; $DFC1
    CPI  A,$61

XREG2STRBUF_4: ; $DFC1
    LDI  YH,$7B
    RTN


; Save String buffer pointers to X-Reg and AR-X. Updating pointer with YL
ARX2STRBUF: ; $DFC4
    STA  UL

; $DFC5 Loads AR-X with a pointer to the string buffer.
ARX2STRBUF_1: ; $DFC5
    LDA  (STR_BUF_PTR_L)
    STA  XL
    LDA  YL
    STA  (STR_BUF_PTR_L)
    LDI  XH,$7B
    LDA  UL
    BZS ARX2STRBUF_2 ; $DFD6
    ANI  (CURSOR_ENA),$7F

ARX2STRBUF_2: ; $DFD6
    JMP  BCMD_TIME_10 ; $DEAF
    VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865

ARX2STRBUF_3: ; $DFD8
    LDA  (RAM_END_H)
    STA  UH
    LDI  UL,$00

ARX2STRBUF_4: ; $DFE1
    DEC  U



;  $DFE2 U-Reg=U-Reg-X-Reg. If overflow occurs C=0 and UH=16
U_MINUS_X: ; 
    SEC
    LDA  UL
    SBC  XL
    STA  UL
    LDA  UH
    SBC  XH
    STA  UH
    BCS U_MINUS_X_1 ; $DFED
    LDI  UH,$16

U_MINUS_X_1: ; $DFED
    RTN



; $DFEE Calculates the free memory space "MEM" in U-Reg
MEM_IN_UREG: ; 
    VEJ  (CC) \ ABYTL(BASPRG_END_H) ; $7867
    INC  X
    BCH ARX2STRBUF_3 ; $DFDB



; U-Reg= STATUS 1-2. Program start after X-Reg; length according to U.
PRGST2XREG: ; $DFF3
    VMJ  ($12)


; (16) $DFF5 U-Reg= U-Reg - X-Reg. Determines the difference between 
; the X-Reg and the end of the program memory (STATUS 1-2).
PRGST2XREG_1: ; $DFF5
    VEJ  (F4) \ AWRD(BASPRG_END_H)
    BCH ARX2STRBUF_4 ; $DFE1

; (14) $DFFA U-Reg= STATUS 1-2 . Loads X with program start, U with length.
    VEJ  (CC) \ ABYTL(BASPRG_ST_H) ; $7865
    BCH PRGST2XREG_1 ; $DFF5
    VEJ  (E4)
    VEJ  (E4)


; Reset-Routine
RESET: ; $E000
    RIE
    LDI  A,$00
    AM0
    RDP
    LDI  UL,$C0

RESET_1: ; $E00A
    LOP  UL,RESET_1 ; $E00A
    SDP
    LDI  UL,$C0

RESET_2: ; $E010
    LOP  UL,RESET_2 ; $E010
    RDP
    LDI  UH,$96
    LDI  UL,$FF

RESET_3: ; $E018
    LOP  UL,RESET_3 ; $E018
    DEC  UH
    BCS RESET_3 ; $E018
    LDI  A,$00
    STA  #(PC1500_MSK_REG)
    STA  #($B00A)
    STA  #(PC1500_IF_REG)
    STA  #($DC00)
    STA  #($B00B)
    LDI  XH,$7A
    LDI  XL,$10
    LDI  UL,$0F
    LDI  A,$A0
    CPA  (X)
    BZS RESET_4 ; $E040
    SHR

RESET_4: ; $E040
    CPA  (X)
    INC  X
    BZR RESET_5 ; $E04D
    INC  A
    LOP  UL,RESET_4 ; $E040
    SHL
    LDI  A,$00
    ROL
    BCH RESET_6 ; $E05D

RESET_5: ; $E04D
    LDI  A,$41
    STA  (DISP_BUFF + $4E)
    LDI  A,$43
    STA  (DISP_BUFF + $4F)
    ANI  (BEEP_PTR),$00
    LDI  A,$02

RESET_6: ; $E05D
    LDI  XH,$7A
    LDI  XL,$20
    SIN  X
    LDI  A,$00
    SIN  X
    SDE  X
    DEC  X
    BII  (X),$01
    BZR RESET_7 ; $E147
    LDI  S,(CPU_STACK + $4F)
    ORI  (KATAFLAGS),$FF
    ANI  (CURS_CTRL),$01
    LDI  A,$60
    STA  (OPN)
    SJP  (BCMD_PI)
    VMJ  ($5C) ; ($5C)($2E)
    LDI  XH,$79
    LDI  XL,$D2
    LDI  UL,$0C
    VMJ  ($BA) ; ($BA)($5D)

RESET_22: ; $E088
    SJP  (IO_INT)
    LDI  YH,$7A
    LDI  YL,$14
    LDI  A,$FF
    LDI  UL,$04

RESET_8: ; $E093
    SDE  Y
    LOP  UL,RESET_8 ; $E093
    LDI  XH,$00

RESET_11: ; $E098
    LDI  XL,$00
    LDA  (X)
    STA  UL
    LDI  A,$5A
    STA  (X)
    CPA  (X)
    BZR RESET_9 ; $E0C4
    LDI  A,$A5
    STA  (X)
    CPA  (X)
    BZR RESET_9 ; $E0C4
    LDA  UL
    STA  (X)
    LDI  YL,$13
    LDA  (Y)
    INC  A
    BCR RESET_10 ; $E0B2
    LDA  XH
    STA  (Y)

RESET_10: ; $E0B2
    INC  XH
    CPI  XH,$70
    BCR RESET_11 ; $E098
    LDI  YL,$14

RESET_15: ; $E0BA
    LDA  XH
    SDE  Y
    LDA  (Y)
    INC  A
    BCR RESET_12 ; $E0C2
    LDA  XH
    STA  (Y)

RESET_12: ; $E0C2
    BCH RESET_13 ; $E0ED

RESET_9: ; $E0C4
    LDI  YL,$13
    LIN  X
    CPI  A,$55
    BZR RESET_14 ; $E0E7
    LIN  Y
    INC  A
    BCR RESET_15 ; $E0BA
    LDI  YL,$10
    LDA  (Y)
    INC  A
    BCR RESET_10 ; $E0B2
    LIN  X
    INC  A
    BCS RESET_16 ; $E0DB
    DEC  A
    STA  XH

RESET_16: ; $E0DB
    LDA  XH
    SIN  Y
    LDA  (X)
    SHL
    BCS RESET_10 ; $E0B2
    LIN  X
    ADC  XH
    SIN  Y
    TIN
    BCH RESET_10 ; $E0B2

RESET_14: ; $E0E8
    LIN  Y
    INC  A
    BCR RESET_15 ; $E0BA
    BCH RESET_10 ; $E0B2

RESET_13: ; $E0ED
    LDI  XH,$78
    LDI  XL,$64
    INC  Y
    LDI  UL,$04

RESET_18: ; $E0F4
    LDE  Y
    CPA  (X)
    BZS RESET_17 ; $E0FC
    ORI  (ARV),$04

RESET_17: ; $E0FC
    SDE  X
    LOP  UL,RESET_18 ; $E0F4
    LDI  A,$00
    VMJ  ($5A) ; ($5A)($2D)
    ORI  (CURS_CTRL),$01
    VMJ  ($BE) ; ($BE)($5F)
    BCR RESET_19 ; $E120

RESET_20: ; $E10B
    PSH  A
    PSH  X
    LDI  XL,$0A
    LDI  UH,$E1
    LDI  UL,$18
    JMP  ISR_HANDLER_1 ; $E20E
    POP  X
    POP  A
    VMJ  ($BC) ; ($BC)($5E)
    BCS RESET_20 ; $E10B

RESET_19: ; $E120
    ORI  #(PC1500_MSK_REG),$01
    ORI  #($B00A),$01
    SDP
    SIE
    LDI  XH,$7A
    LDI  XL,$20
    LIN  X
    BII  A,$01
    BZS RESET_21 ; $E144
    LIN  X
    BZR RESET_21 ; $E144
    LDA  (X)
    BZR RESET_21 ; $E144
    POP  U
    POP  Y
    JMP  WAIT4KB ; $E243

RESET_21: ; $E144
    JMP  COLD_START ; $C9E4

RESET_7: ; $E147
    LDA  (ARS)
    STA  XH
    LDA  (ARS + $01)
    STA  XL
    STX  S
    BCH RESET_22 ; $E088


; $E153 Initializes I/O module with table from E168.
IO_INT:
    PSH  Y
    LDI  XH,$E1
    LDI  XL,$68
    LDI  YH,$F0
    LDI  YL,$07
    LDI  UL,$08

IO_INT_1: ; $E15F
    LIN  X
    STA  #(Y)
    INC  Y
    LOP  UL,IO_INT_1 ; $E15F
    POP  Y
    RTN



; Parameters for initializing the I/0 ports
IO_TBL: ; $E168
    .BYTE $23 ; #F007
    .BYTE $C0 ; #F008
    .BYTE $D7 ; #F009
    .BYTE $00 ; #F00A
    .BYTE $00 ; #F00B
    .BYTE $00 ; #F00C
    .BYTE $00 ; #F00D
    .BYTE $FF ; #F00E
    .BYTE $00 ; #F00F



; (F8) Maskable interrupt routine
ISR_HANDLER: ; $E171
    PSH  A
    PSH  X
    PSH  Y
    PSH  U
    LDA  (PU_PV)
    PSH  A
    BII  #(PC1500_IF_REG),$01
    BZS $E1EA
    ANI  #(PC1500_MSK_REG),$FE
    ANI  #($B00A),$FE
    LDA  #($DE00)
    ANI  #($B00B),$FE
    STA  #($DC00)
    EAI  $FF
    BZS ISR_HANDLER_2 ; $E1CE

ISR_HANDLER_8: ; $E1A0
    RPV

ISR_HANDLER_6:  ;$E1A1
    LDI  XH,$B0
    LDI  XL,$00

ISR_HANDLER_5: ; $E1A5
    PSH  X
    SHR
    PSH  A
    BCR ISR_HANDLER_3 ; $E1B9
    LDI  A,$55
    CPA  (X)
    BZR ISR_HANDLER_3 ; $E1B9
    LDI  UH,$E1
    LDI  UL,$B9
    LDI  XL,$13
    BCH ISR_HANDLER_1 ; $E20E

ISR_HANDLER_3: ; $E189
    POP  A
    POP  X
    BZS ISR_HANDLER_2 ; $E1CE
    CPI  XH,$90
    BCR ISR_HANDLER_4 ; $E1CB
    STA  YL
    LDI  A,$EF
    ADC  XH
    STA  XH
    LDA  YL
    BCH ISR_HANDLER_5 ; $E1A5

ISR_HANDLER_4: ; $E1CB
    SPV
    BCH ISR_HANDLER_6 ; $E1A1

ISR_HANDLER_2: ; $E1CE
    BII  #(PC1500_IF_REG),$01
    BZS ISR_HANDLER_7 ; $E1EA
    ANI  #(PC1500_IF_REG),$FE
    LDA  #($B00B)
    AND  #($B00A)
    ANI  A,$0E
    BZS ISR_HANDLER_7 ; $E1EA
    LDI  A,$01
    BCH ISR_HANDLER_8 ; $E1A0

ISR_HANDLER_7: ; $E1EA
    LDA  ($79DA)
    CPI  A,$55
    BZR ISR_HANDLER_9 ; $E212
    LDA  #(PC1500_IF_REG)
    AND  #(PC1500_MSK_REG)
    ANI  A,$0E
    BZS ISR_HANDLER_9 ; $E212
    LDI  UH,$E2
    LDI  UL,$12
    LDA  ($79DB)
    STA  XH
    LDA  ($79DC)
    STA  XL
    SHR
    RPV
    BCR ISR_HANDLER_1 ; $E20E
    SPV

ISR_HANDLER_1: ; $E20E
    PSH  U
    STX  P

ISR_HANDLER_9: ; $E212
    ORI  #($B00A),$01
    ORI  #(PC1500_MSK_REG),$01
    POP  A
    STA  (PU_PV)
    VMJ  ($A0) ; ($A0)($50)
    POP  U
    POP  Y
    POP  X

ISR_HANDLER_10: ; $E229
    POP  A



; (FC) Non-Maskable Interrupt
NMI_HANDLER: ; $E22B
    RTI



; (FA) Timer Interrupt
TIMER_ISR:  ; $E22C
    PSH  A
    LDI  A,$00
    AM0
    BCH ISR_HANDLER_10 ; $E229



; (A0) PV-banking according to status of Bit 0 in $7900. If 0, PV=1.
PVBANK: ; $E234
    RPV
    BII  (PU_PV),$01
    BZS PVBANK_1 ;$E23C
    SPV

PVBANK_1: ; $E23C
    RTN



; $E23D Waits until no more keys are pressed
WAITNOKEYS: 
    ORI  (CURS_CTRL),$03
    BCH WAIT4KB_2 ; $E24E



; Entering a Character Using the Keyboard (Page 324:Keyboard Status)
; Waiting for input from keyboard. Character is in accumulator
WAIT4KB: ; $E243
    LDA  ($79D4)

WAIT4KB_1: ; $E246
    CPI  A,$55
    BZS WAIT4KB_3 $E2B7
    ANI  (CURS_CTRL),$FD

WAIT4KB_2: ; $E24E
    LDI  XH,$7B
    BII  (CURS_CTRL),$40
    BZR WAIT4KB_4 ; $E25B
    LDI  XL,$09
    LDI  A,$60
    SIN  X

WAIT4KB_4: ; $E25B
    LDI  XL,$0A
    LDI  A,$FE
    SIN  X
    LDI  A,$1D
    SIN  X
    SIN  X
    LDI  A,$80
    SIN  X
    LDI  UH,$F8

WAIT4KB_11: ; $E269
    VMJ  ($A6) ; ($A6)($53)
    BZR WAIT4KB_5 ; $E33A
    SJP  (ISKEY)
    BZS WAIT4KB_6 ; $E2C4
    SJP  (KEY2ASCII)
    BCS WAIT4KB_6 ; $E2C4
    NOP
    BII  (CURS_CTRL),$01
    BZS WAIT4KB_7 ; $E2AC
    BII  (CURS_CTRL),$40
    BZS WAIT4KB_8 ; $E2FF
    LDA  XL
    CPA  (KEY_LAST)
    BZR WAIT4KB_9 ; $E2F6
    LDI  XH,$7B
    LDI  XL,$09
    LDA  (X)
    INC  A
    BCR WAIT4KB_10 ; $E29D
    LDI  A,$F2
    STA  (X)
    LDI  XH,$FE
    LDA  (KEY_LAST)
    STA  XL
    BCH AUTO_OFF_1 ; $E366

WAIT4KB_10: ; $E29D
    STA  (X)

WAIT4KB_20: ; $E29E
    ANI  ($79D9),$00
    LDI  A,$57
    AM0
    SIE
    HLT
    BCH WAIT4KB_11 ; $E269

WAIT4KB_7: ; $E2AC
    SJP  (KEY2ASCII)
    BCS WAIT4KB_6 ; $E2C4
    LDA  XL
    STA  (KEY_LAST)
    BCH AUTO_OFF_1 ; $E366

WAIT4KB_3: ; $E2B7
    VEJ  (CC) \ ABYTL($785B)
    NOP
    LDA  XL
    SHR
    RIE
    RPV
    BCR WAIT4KB_12 ; $E2C2
    SPV

WAIT4KB_12: ; $E2C2
    STX  P

WAIT4KB_6: ; $E2C4
    BII  (CURS_CTRL),$01
    BZS WAIT4KB_13 ; $E2D8
    BII  (CURS_CTRL),$40
    BZR WAIT4KB_9 ; $E2F6
    INC  UH
    BCR WAIT4KB_14 ; $E2DE
    ANI  (CURS_CTRL),$FE

WAIT4KB_13: ; $E2D8
    BII  (CURS_CTRL),$02
    BZR WAIT4KB_15 ; $E2F2

WAIT4KB_14: ; $E2DE
    LDI  UL,$02
    LDI  XH,$7B
    LDI  XL,$0D

WAIT4KB_17: ; $E2E4
    DEC  X
    ADI  (X),$01
    BCR WAIT4KB_16 ; $E303
    LOP  UL,WAIT4KB_17 ; $E2E4
    LDI  A,$FF
    SIN  X
    SIN  X
    STA  (X)
    BCH AUTO_OFF

WAIT4KB_15: ; $E2F2
    LDI  A,$00
    REC
    RTN

WAIT4KB_9: ; $E2F6
    LDI  A,$60
    STA  (KEY_REPEAT)
    ANI  (CURS_CTRL),$9F

WAIT4KB_8: ; $E2FF
    LDI  UH,$F8
    BCH WAIT4KB_14 ; $E2DE

WAIT4KB_16: ; $E303
    LDI  XL,$0B
    LIN  X
    BII  A,$07
    BZR WAIT4KB_18 ; $E315
    LDA  (X)
    BZR WAIT4KB_18 ; $E315
    RDP
    LDI  UL,$BC

WAIT4KB_19: ; $E311
    LOP  UL,WAIT4KB_19 ; $E311
    SDP

WAIT4KB_18: ; $E315
    BII  (CURSOR_BLNK),$01
    BZS WAIT4KB_20 ; $E29E
    ADI  (CURS_BLNK_CTR),$01
    BCR WAIT4KB_20 ; $E29E
    ORI  (CURS_BLNK_CTR),$80
    PSH  U
    VEJ  (CC) \ ABYTL(CURS_POS_NBUF_H) ; $787E
    ADI  (CURSOR_BLNK),$80
    LDI  A,$7F
    BCR WAIT4KB_21 ; $E334
    LDA  (BLNKD_CHAR_CODE)

WAIT4KB_21: ; $E334
    VMJ  ($8A) ; ($8A)($45) ; ($8A)($45)
    POP  U
    BCH WAIT4KB_20 ; $E29E

WAIT4KB_5: ; $E33A
    LDI  A,$0E
    SEC
    RTN
    NOP



; Auto-Power-Off Routine
AUTO_OFF: ; $E33F
    LDI  A,$A0
    LDI  XH,$7A
    LDI  XL,$10
    LDI  UL,$0F

AUTO_OFF_2: ; $E347
    SIN  X
    INC  A
    LOP  UL,AUTO_OFF_2 ; $E347
    PSH  Y
    PSH  U
    LDX  S
    LDA  XH
    STA  (ARS)
    LDA  XL
    STA  (ARS + $01)
    .BYTE $FD, $4C ;    OFF ***ADD TO TASM
    .BYTE $FD, $4C ;    OFF
    .BYTE $FD, $4C ;    OFF
    POP  U
    POP  Y
    JMP  WAIT4KB_11 ; $E269

AUTO_OFF_1: ; $E366
    LDI  UH,$76
    LDI  UL,$4E
    ORI  (CURS_CTRL),$01
    LDA  (X)
    CPI  A,$3E
    BCR AUTO_OFF_3 ; $E3C8
    CPI  A,$41
    BCS AUTO_OFF_4 ; $E38D
    BII  (U),$04
    BZS AUTO_OFF_5 ; $E3B1

AUTO_OFF_9: ; $E37B
    RIE
    LDA  (KATAFLAGS)
    SHL
    RPV
    BCR AUTO_OFF_6 ; $E385
    SPV

AUTO_OFF_6: ; $E385
    LDA  (KATACHAR)
    DEC  A
    STA  XH
    LDA  (X)
    BCH AUTO_OFF_7 ; $E3B3

AUTO_OFF_4: ; $E38D
    BII  (U),$80
    BZR AUTO_OFF_8 ; $E3A7
    BII  (U),$04
    BZR AUTO_OFF_9 ; $E37B
    BII  (U),$08
    BZR AUTO_OFF_10 ; $E3A1
    BII  (U),$02
    BZR AUTO_OFF_11 ; $E3AC

AUTO_OFF_12: ; $E39D
    REC
    ANI  (U),$7D
    RTN

AUTO_OFF_10: ; $E3A1
    BII  (U),$02
    BZS AUTO_OFF_11 ; $E3AC
    BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_8: ; $E3A7
    REC
    ADI  A,$40
    BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_11: ; $E3AC
    REC
    ADI  A,$20
    BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_5: ; $E3B1
    RIE

AUTO_OFF_7: ; $E3B3
    BII  (U),$02
    BZS AUTO_OFF_13 ; $E3BC
    LDI  A,$40
    ADR  X
    LDA  (X)

AUTO_OFF_13: ; $E3BC
    VMJ  ($A0) ; ($A0)($50)
    SIE
    BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_17: ; $E3C2
    BII  (U),$04
    BZR AUTO_OFF_9 ; $E37B
    BCH AUTO_OFF_5 ; $E3B1

AUTO_OFF_3: ; $E3C8
    CPI  A,$01
    BZS AUTO_OFF_14 ; $E3E8
    CPI  A,$02
    BZS AUTO_OFF_15 ; $E3F6
    CPI  A,$1B
    BZS AUTO_OFF_16 ; $E3EF
    BII  (U),$80
    BZS AUTO_OFF_17 ; $E3C2
    CPI  A,$20
    BZS $E3E4
    CPI  A,$3D
    BZR AUTO_OFF_17 ; $E3C2
    LDI  A,$9D
    BCH AUTO_OFF_12 ; $E39D
    LDI  A,$80
    BCH AUTO_OFF_12 ; $E39D

AUTO_OFF_14: ; $E3E8
    LDA  (U)
    EAI  $02
    ANI  A,$7F
    BCH AUTO_OFF_18 ; $E408

AUTO_OFF_16: ; $E3EF
    LDA  (U)
    EAI  $80
    ANI  A,$FD
    BCH AUTO_OFF_18 ; $E408

AUTO_OFF_15: ; $E3F6
    BII  #(PC1500_PRT_B),$08
    BZR AUTO_OFF_19 ; $E40C
    LDA  (KATAFLAGS)
    SHL
    BZR AUTO_OFF_20 ; $E413
    LDA  (U)
    EAI  $04
    ANI  A,$77

AUTO_OFF_18: ; $E408
    STA  (U)
    JMP  WAIT4KB ; $E243

AUTO_OFF_19: ; $E40C
    LDA  (U)
    EAI  $08
    ANI  A,$7B
    BCH AUTO_OFF_18 ; $E408

AUTO_OFF_20: ; $E413
    LDA  (U)
    ANI  A,$73
    BCH AUTO_OFF_18 ; $E408



; $E418 Checks whether key is pressed. If not, Z=1.
ISKEY:
    LDI  A,$FF

; Keyboard query. If no key is pressed Z=0.
ISKEY_1: ; $E41A
    STA  #(PC1500_PRT_A_DIR)
    ANI  #(PC1500_PRT_A),$00
    LDI  UL,$03

ISKEY_2: ; $E425
    LOP  UL,ISKEY_2 ; $E425
    ITA
    EAI  $FF
    RTN



; $E42C Keyboard query: ASCII code in accumulator. If no key pressed: C=1.
KEY2ASCII:
    LDI  XL,$80
    LDI  A,$01

KEY2ASCII_3: ; $E430
    STA  XH
    SJP  (ISKEY_1) ; $E41A
    BZR KEY2ASCII_1 ; $E444
    REC
    LDI  A,$08
    ADC  XL
    STA  XL
    LDA  XH
    SHL
    BCS KEY2ASCII_2 ; $E441
    BZR KEY2ASCII_3 ; $E430

KEY2ASCII_2: ; $E441
    LDI  A,$00
    RTN

KEY2ASCII_1: ; $E444
    SHL
    BCS KEY2ASCII_4 ; $E44C
    INC  XL
    BCR KEY2ASCII_1 ; $E444
    BCH KEY2ASCII_2 ; $E441

KEY2ASCII_4: ; $E44C
    LDI  XH,$FE
    LDA  (X)
    REC
    RTN



 ; (A6) $E451 Checks if Break was pressed. If so, Z=0; if no Z=1.
CHK_BRK:
    BII  #(PC1500_IF_REG),$02
    RTN



; Basic command OPN
    VEJ  (C8) \ ABRF(CHK_BRK_1) ; $E466
    PSH  Y

CHK_BRK_2: ; $E45B
    LDI  A,$60

CHK_BRK_6: ; $E45D
    STA  (OPN)
    POP  Y
    SIE
    DEC  Y
    VEJ  (E2)

CHK_BRK_1: ; $E466
    VEJ  (C6)
    VMJ  ($36)
    BCR BCMD_PRINT_1 ; $E52A
    VEJ  (C8) \ ABRF(BCMD_PRINT_1) ; $E52A
    PSH  Y
    LDI  XH,$7A
    LDI  YH,$7A
    VMJ  ($82) ; ($82)($41)
    LDI  YH,$E4
    LDI  YL,$E3
    VMJ  ($9E) ; ($9E)($4F)
    BZR CHK_BRK_2 ; $E45B
    VMJ  ($BE) ; ($BE)($5F)
    BCR CHK_BRK_3 ; $E495

CHK_BRK_5: ; $E481
    PSH  U
    PSH  X
    LDI  XL,$02
    STX  Y
    VMJ  ($9E) ; ($9E)($4F)
    POP  X
    POP  U
    BZR CHK_BRK_4 ; $E49A
    VMJ  ($BC) ; ($BC)($5E)
    BCS CHK_BRK_5 ; $E481

CHK_BRK_3: ; $E495
    POP  Y
    LDI  UH,$22
    VEJ  (E0)

CHK_BRK_4: ; $E49A
    LDA  UH
    SHR
    LDA  XH
    ROR
    BCH CHK_BRK_6 ; $E45D



;------------------------------------------------------------------------------
; (9E) Comparison of two strings
; Checks string 1st byte Y-Reg points to matches string CSI is stored in AR-Y.
; Address:	E4A0 (9E)
; 
;    Entry Parameter:	Y-Reg points to the 1st byte of string to be checked
;                       AR-Y contains CSI of the 2nd string
; Modified Registers:	All
;   Error conditions:	If match, numeric value (BCD format) loaded into AR-X
;------------------------------------------------------------------------------
STR_COMP: ; $E4A0 (9E)
    VMJ  ($0C)
    LDI  A,$04
    SJP  (DEL_DIM_VARS_15) ; $D0F9
    RTN



; (BE) Searches 1st token table below C000
; Searches token table if CE-158 or CE-150 connected C=1. With CE-150 UH=2 CE-158 UH=1.
TOK_TABL_SRCH: ; $E4A8
    RIE
    RPV
    LDI  A,$02

TOK_TABL_SRCH_5: ; $E4AD
    LDI  XH,$B8
    STA  UH

TOK_TABL_SRCH_3: ; $E4B0
    LDI  A,$55
    LDI  XL,$00
    CPA  (X)
    BZS TOK_TABL_SRCH_1 ; $E4CD


; (BC) $E4B7 Searches for the next lower token table (8000-BFFF) based on the
; address area pointed to by X-Reg.
    LDA  UH
    CPI  XH,$88
    BCR TOK_TABL_SRCH_2 ; $E4C2
    LDA  XH
    ADI  A,$F7
    STA  XH
    BCH TOK_TABL_SRCH_3 ; $E4B0

TOK_TABL_SRCH_2: ; $E4C2
    SHR
    BCS TOK_TABL_SRCH_4 ; $E4C8
    SPV
    BCH TOK_TABL_SRCH_5 ; $E4AD

TOK_TABL_SRCH_4: ; $E4C8
    VMJ  ($A0) ; ($A0)($50)
    REC
    SIE

TOK_TABL_SRCH_1: ; $E4CD
    RTN


; $E4CE Searches for token table whose number is in UL
; Searches for the start address of the token table, the number of which is in
;the accumulator. C=0 if not found. If available C=1.
    VMJ  ($BE) ; ($BE)($5F)
    BCR TOK_TABL_SRCH_6 ; $E4DB

TOK_TABL_SRCH_8: ; $E4D2
    INC  X
    LDA  UL
    CPA  (X)
    BZS TOK_TABL_SRCH_7 ; $E4DC
    VMJ  ($BC) ; ($BC)($5E)
    BCS TOK_TABL_SRCH_8 ; $E4D2

TOK_TABL_SRCH_6: ; $E4DB
    RTN

TOK_TABL_SRCH_7: ; $E4DC
    LDA  UH
    STA  (PU_PV)
    SIE
    RTN



; Text for comparison OPN "LCD"
    .BYTE $4C,$43,$44,$0D ; LCD/CR



; INPUT# - Routine
BCMD_INPUTNUM: ; $E427
    LDI  A,$84
    BCH BCMD_PRINT_2 ; $E4F0


; Basic-Command PRINT
BCMD_PRINT: ; $E4EB
    VEJ  (C2) \ ACHR($23) \ ABRF(BCMD_PRINT_3) ; $E513
    LDI  A,$04

BCMD_PRINT_2: ; $E4F0
    STA  (CASS_FLAG)
    VEJ  (C2) \ ACHR($2D) \ ABRF(BCMD_PRINT_4) ; $E51E
    VEJ  (DE) \ ABRF(BCMD_PRINT_5) ; $E529
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_PRINT_1) ; $E52A
    VEJ  (D0) \ ABYT($08) \ ABRF(BCMD_PRINT_5) ; $E529
    CPI  A,$02
    BCR BCMD_PRINT_6 ; $E517
    SJP  ($E4CE)
    BCR BCMD_PRINT_7 ; $E527
    LDI  XL,$10
    BII  (CASS_FLAG),$80
    BZS BCMD_PRINT_8 ; $E511
    LDI  XL,$0D

BCMD_PRINT_8: ; $E511
    STX  P

BCMD_PRINT_3: ; $E513
    VEJ  (C6)
    JMP  BCMD_PAUSE_1 ; $E6B6

BCMD_PRINT_6: ; $E517
    SHR
    BCR BCMD_PRINT_4 ; $E51E
    ORI  (CASS_FLAG),$10

BCMD_PRINT_4: ; $E51E
    LDI  A,$5C
    VMJ  ($3C)
    BCR BCMD_PRINT_7 ; $E527
    JMP  $B8A3 ; ***

BCMD_PRINT_7: ; $E527
    LDI  UH,$23

BCMD_PRINT_5: ; $E529
    VEJ  (E0)

BCMD_PRINT_1: ; $E52A
    VEJ  (E4)



; Writes to clock chip
WRITE2CLOCK: ; $E52B
    TTA
    PSH  A
    RIE
    LDI  A,$08
    VMJ  ($5A) ; ($5A)($2D)
    LDI  A,$00
    STA  #(PC1500_PRT_B_DIR)
    LDI  XH,$7A
    LDI  XL,$06
    LDI  UH,$04

WRITE2CLOCK_3: ; $E541
    LDA  (X)
    LDI  UL,$07
    BII  #(PC1500_PRT_B),$40
    REC
    BZS WRITE2CLOCK_1 ; $E54D
    SEC

WRITE2CLOCK_1: ; $E54D
    ROR
    BCS $E56B
    ANI  #(Y),$FE
    ANI  #(Y),$FE

WRITE2CLOCK_4: ; $E54D
    ORI  #(Y),$04
    ORI  #(Y),$04
    ANI  #(Y),$FB
    LOP  UL,$E544
    SDE  X
    DEC  UH
    BCS WRITE2CLOCK_3 ; $E541
    POP  A
    ATT
    RTN

WRITE2CLOCK_2: ; $E56B
    ORI  #(Y),$01
    ORI  #(Y),$01
    BCH WRITE2CLOCK_4 ; $E556



;------------------------------------------------------------------------------
; (5A) Timer-mode-select routine. The PD 1990AC timer module is switched to 
; its various operating modes via its inputs C0, C1, C2, which are fed via I/O 
; ports PC3, PC4 and PC5 (#F008).
;          Address:	E573 (5A)
;   Entry parameters: At entry, Accumulator contains the control byte of the 
;                     timer module. The timer can be operated with 4 modes.
;                       C2	C1	C0	Mode	Effect
;                       0	0	0	0	    Register hold
;                       0 	0	1	1	    Register shift
;                       0	1	0	2	    Time set
;                       0	1	1	3	    Time read
;                       B5	B4	B3 of Accumulator
;
; Modified registers: U-Reg
;                     Y-Reg contains F008
;                     Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
TIMEMODE: ; $E573
    LDI  YH,$F0
    LDI  YL,$08
    STA  UH
    TTA
    PSH  A
    RIE
    LDA  #(Y)
    ANI  A,$C0
    REC
    ADC  UH
    STA  #(Y)
    STA  #(Y)
    ADI  A,$02
    STA  #(Y)
    STA  #(Y)
    ADI  A,$FE
    STA  #(Y)
    STA  #(Y)
    LDI  UL,$02

TIMEMODE_1: ; $E596
    LOP  UL,TIMEMODE_1 ; $E596
    BCH $E566



 ; Transfers TIME from AR-X to clock module
ARX2TIME: ; $ E59A
    PSH  Y
    PSH  X
    SJP  (WRITE2CLOCK)
    LDI  A,$10
    VMJ  ($5A) ; ($5A)($2D)

ARX2TIME_1: ; $ E5A5
    LDI  A,$00
    VMJ  ($5A) ; ($5A)($2D)
    ANI  #(Y),$C7
    ORI  #(Y),$08

ARX2TIME_2: ; $ E5AF
    POP  X
    POP  Y
    RTN



 ; Reads clock chip to AR-X
TIME2ARX: ; $ E5B4
    PSH  Y
    PSH  X
    LDI  A,$18
    VMJ  ($5A) ; ($5A)($2D)
    SJP  (WRITE2CLOCK)



; Basic command BEEP $E5C1
    BCH ARX2TIME_1 ; $E5A5
    VEJ  (C2) \ AWRD($F19C) \ ABRF(TIME2ARX_1) ; $E5CC
    ANI  (BEEP_PTR),$FE

TIME2ARX_3: ; $ E5C9
    VMJ  ($A2) ; ($A2)($51)
    VEJ  (E2)

TIME2ARX_1: ; $ E5CC
    VEJ  (C4) \ AWRD($F19E) \ ABRF(TIME2ARX_2) ; $E5D6
    ORI  (BEEP_PTR),$01
    BCH TIME2ARX_3 ; $E5C9

TIME2ARX_2: ; $ E5D6
    VEJ  (C6)
    BII  (BEEP_PTR),$01
    BZR TIME2ARX_4 ; $E650
    VEJ  (DE) \ ABRF(TIME2ARX_12) ; $E653
    VEJ  (D2) \ ABRF(TIME2ARX_12) \ ABYT($80)
    BII  (ARX + $01),$80
    BZR TIME2ARX_4 ; $E650
    BII  (ARX + $02),$F0
    BZS TIME2ARX_4 ; $E650
    VEJ  (D0) \ ABYT($00) \ ABRF(TIME2ARX_12) ; $E653
    PSH  U
    VEJ  (C8) \ ABRF(TIME2ARX_5) ; $E622
    LDI  A,$FF

TIME2ARX_15: ; $ E5F7
    POP  U
    PSH  Y
    STA  YL
    PSH  U

TIME2ARX_9: ; $ E5FE
    LDA  YL
    BZS TIME2ARX_6 ; $E619
    SJP  (BCMD_BEEP_STD)

TIME2ARX_10: ; $ E604
    POP  U
    BZR TIME2ARX_7 ; $E64A
    DEC  U
    LDA  UL
    BZR TIME2ARX_8 ; $E60F
    LDA  UH
    BZS TIME2ARX_7 ; $E64A

TIME2ARX_8: ; $ E60F
    PSH  U
    LDI  UH,$00
    LDI  UL,$06
    VMJ  ($AC) ; ($AC)($56)
    BCH TIME2ARX_9 ; $E5FE

TIME2ARX_6: ; $ E619
    LDA  (BEEP_FREQ)
    STA  UL
    SJP  (BCMD_BEEP)
    BCH TIME2ARX_10 ; $E604

TIME2ARX_5: ; $ E622
    VEJ  (C4) \ ACHR($2C) \ ABRF(TIME2ARX_11) ; $E654
    VEJ  (DE) \ ABRF(TIME2ARX_12) ; $E653
    VEJ  (D0) \ ABYT($08) \ ABRF(TIME2ARX_12) ; $E653
    LDA  UL
    STA  (BEEP_FREQ)
    VEJ  (C8) \ ABRF(TIME2ARX_13) ; $E636
    LDI  XH,$01
    LDI  XL,$A0
    BCH TIME2ARX_14 ; $E646

TIME2ARX_13: ; $ E636
    VEJ  (C4) \ ACHR($2C) \ ABRF(TIME2ARX_11) ; $E654
    VEJ  (DE) \ ABRF(TIME2ARX_12) ; $E653
    VEJ  (D0) \ ABYT($02) \ ABRF(TIME2ARX_12) ; $E653
    PSH  U
    VEJ  (C8) \ ABRF(TIME2ARX_11) ; $E654
    POP  X
    INC  XH

TIME2ARX_14: ; $ E646
    LDI  A,$00
    BCH TIME2ARX_15 ; $E5F7

TIME2ARX_7: ; $ E64A
    POP  Y
    VMJ  ($A2) ; ($A2)($51)
    DEC  Y
    VEJ  (E2)

TIME2ARX_4: ; $ E650
    JMP  BCMD_DATA ; $C684

TIME2ARX_12: ; $ E653
    VEJ  (E0)

TIME2ARX_11: ; $ E654
    VEJ  (E4)



;------------------------------------------------------------------------------
; (A2) Beep-On/Off
;            Address: (A2) E655
;   Entry parameters: (7868) contains in bit 0 the information whether beep ON 
;                     (bit 0=1) or beep OFF (bit 0=1) should be switched.
; 
; Modified registers: Bit 6 in #(F008), i.e. PC6 is set to 0 at Beep Off. No 
;                     registers changed. If beep off: Carry flag=1
;   Error conditions: None
;------------------------------------------------------------------------------
BEEP_ON_OFF: ; $E655
    BII  (BEEP_PTR),$01
    BZS BEEP_ON_OFF_1 ; $E662
    ANI  #(PC1500_PRT_C),$BF
    SEC
    RTN

BEEP_ON_OFF_1: ; $E662
    ORI  #(PC1500_PRT_C),$40
    REC
    RTN


; $E669 Standard Beep
BCMD_BEEP_STD:
    LDI  UL,$08
    LDI  XH,$01
    LDI  XL,$A0



; $E66F Beep with duration in X-Reg and pitch in UL
BCMD_BEEP: ; 
    PSH  Y
    PSH  X
    PSH  U
    LDI  YH,$F0
    LDI  YL,$08
    LDA  UL
    STA  UH

BCMD_BEEP_5: ; $E67B
    LDI  A,$C8
    STA  #(Y)
    LDA  UH
    STA  UL

BCMD_BEEP_1: ; $E681
    LOP  UL,BCMD_BEEP_1 ; $E681
    BII  #(PC1500_IF_REG),$03
    BZR BCMD_BEEP_2 ; $E69E
    DEC  X
    LDA  XH
    BZS BCMD_BEEP_2 ; $E69E
    LDI  A,$88
    STA  #(Y)
    LDA  UH
    STA  UL

BCMD_BEEP_3: ; $E694
    LOP  UL,BCMD_BEEP_3 ; $E694
    LDI  UL,$01

BCMD_BEEP_4: ; $E698
    LOP  UL,BCMD_BEEP_4 ; $E698
    ANI  (X),$FF
    BCH BCMD_BEEP_5 ; $E67B

BCMD_BEEP_2: ; $E69E
    POP  U
    BCH ARX2TIME_2 ; $E5AF
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)



 ; Basic command PAUSE
BCMD_PAUSE: ; $E6A5
    LDI  A,$FF
    BCH BCMD_PAUSE_2 ; $E6B8

BCMD_PAUSE_25: ; $E6A9
    LDI  A,$AA
    PSH  A
    LDI  A,$60
    STA  ($788F)
    PSH  Y
    BCH BCMD_PAUSE_3 ; $E70D

BCMD_PAUSE_1: ; $E6B6
    LDI  A,$00

BCMD_PAUSE_2: ; $E6B8
    PSH  A
    LDI  A,$60
    STA  ($788F)
    VEJ  (C8) \ ABRF(BCMD_PAUSE_4); $E6FD

BCMD_PAUSE_16: ; $E6C1
    SJP  (INIT_CURS)

BCMD_PAUSE_21: ; $E6C4
    VMJ  ($84) ; ($84)($84)($42)
    POP  A
    SHL
    BCS BCMD_PAUSE_5 ; $E6E2

BCMD_PAUSE_24: ; $E6CB
    VEJ  (D8)
    BZR BCMD_PAUSE_6 ; $E6D2
    LDI  A,$20
    BCH BCMD_PAUSE_7 ; $E6F6

BCMD_PAUSE_6: ; $E6D2
    LDA  (WAIT_CFG)
    SHR
    BCS BCMD_PAUSE_8 ; $E6E0
    SHR
    BCR BCMD_PAUSE_9 ; $E6EC
    VEJ  (F4) \ AWRD(WAIT_CTR_H)

BCMD_PAUSE_10: ; $E6DE
    VMJ  ($AC) ; ($AC)($56)

BCMD_PAUSE_8: ; $E6E0
    DEC  Y
    VEJ  (E2)

BCMD_PAUSE_5: ; $E6E2
    SHL
    LDI  UH,$00
    LDI  UL,$36
    BCS  BCMD_PAUSE_10 ; $E6DE
    JMP  BCMD_POINT_4 ; $EEF7

BCMD_PAUSE_9: ; $E6EC
    ORI  (BREAKPARAM),$20
    VEJ  (D4) \ ABYT($AC)
    VEJ  (D4) \ ABYT($A0)
    LDI  A,$02

BCMD_PAUSE_7: ; $E6F6
    STA  (DISPARAM)
    VMJ  ($84) ; ($84)($42)
    VMJ  ($46)

BCMD_PAUSE_4: ; $E6FD
    VMJ  ($9A) ; ($9A)($4D)
    VCS  ($E0)
    VEJ  (DE) \ ABRF(BCMD_PAUSE_11) ; $E7A8
    VEJ  (C8) \ ABRF(BCMD_PAUSE_12) ; $E744
    PSH  Y
    BII  (CURSOR_ENA),$01
    BZR BCMD_PAUSE_13 ; $E733

BCMD_PAUSE_3: ; $E70D
    SJP  (OUTBUFCLR)
    VMJ  ($98) ; ($98)($4C
    BCS BCMD_PAUSE_14 ; $E724
    LDI  A,$02
    VMJ  ($96) ; ($96)($4B)
    BCS BCMD_PAUSE_15 ; $E7A4
    STA  UL
    EAI  $FF
    ADI  A,$7B
    STA  ($788F)
    VMJ  ($94) ; ($94)($4A)

BCMD_PAUSE_14: ; $E724
    LDI  A,$1A
    SJP  (INIT_MTRX)

BCMD_PAUSE_18: ; $E729
    LDI  UH,$7B
    LDI  UL,$60
    VMJ  ($92) ; ($92)($49)
    POP  Y
    BCH BCMD_PAUSE_16 ; $E6C1

BCMD_PAUSE_13: ; $E733
    VMJ  ($98) ; ($98)($4C)
    BCS BCMD_PAUSE_17 ; $E73E
    LDI  A,$01
    SJP  (ARX2OUTBUF_F)
    BCS BCMD_PAUSE_15 ; $E7A4

BCMD_PAUSE_17: ; $E73E
    SEC
    LDA  YL
    SBI  A,$60
    BCH BCMD_PAUSE_18 ; $E729

BCMD_PAUSE_12: ; $E744
    VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_PAUSE_19) ; $E785
    PSH  Y
    VMJ  ($9C); ($9C)($4E)
    BCS BCMD_PAUSE_15 ; $E7A4
    POP  Y
    VEJ  (C8) \ ABRF(BCMD_PAUSE_20) ; $E766
    ANI  (CURSOR_ENA),$FE
    SJP  (CLRNOCURSOR)
    LDI  UH,$7B
    LDI  UL,$60
    VMJ  ($92) ; ($92)($49)
    ORI  (CURSOR_ENA),$01
    BCR BCMD_PAUSE_21 ; $E6C4
    BCH BCMD_PAUSE_16 ; $E6C1

BCMD_PAUSE_20: ; $E766
    VMJ  ($9A) ; ($9A)($4D)
    VCS  ($E0)
    VEJ  (DE) \ ABRF(BCMD_PAUSE_11) ; $E7A8
    VEJ  (C2) \ ACHR($2C) \ ABRF(BCMD_PAUSE_22) ; $E770
    VEJ  (E4)

BCMD_PAUSE_22: ; $E770
    VMJ  ($04) \ ABRF(BCMD_PAUSE_23) ; $E7A9
    PSH  Y
    VMJ  ($9C) ; ($9C)($4E)
    BCS BCMD_PAUSE_15 ; $E7A4
    SJP  (INIT_MTRX)
    BCH BCMD_PAUSE_17 ; $E73E
    VMJ  ($9A) ; ($9A)($4D)
    VCS  ($E0)
    VEJ  (DE) \ ABRF(BCMD_PAUSE_11) ; $E7A8
    VEJ  (C0)

BCMD_PAUSE_19: ; $E785
    VEJ  (C4) \ ACHR($3B) \ ABRF($E795)
    PSH  Y
    SJP  (ARXASCII2OUTBUF)
    BCS BCMD_PAUSE_15 ; $E7A4
    POP  Y
    VEJ  (C8) \ ABRF($E7AA)
    BCH $E755
    VMJ  ($04) \ ABRF(BCMD_PAUSE_23) ; $E7A9
    PSH  Y
    SJP  (ARXASCII2OUTBUF)
    BCS BCMD_PAUSE_15 ; $E7A4
    SJP  (CLRNOCURSOR)
    BCH BCMD_PAUSE_18 ; $E729

BCMD_PAUSE_15: ; $E7A4
    LDI  UH,$24
    POP  Y

BCMD_PAUSE_11: ; $E7A8
    VEJ  (E0)

BCMD_PAUSE_23: ; $E7A9
    VEJ  (E4)
    BCH $E77E



 ; Basic command GPRINT
BCMD_GPRINT: ; $E7AC
    VEJ  (C8) \ ABRF(BCMD_GPRINT_1) ; $E7B0
    BCH $E80B

BCMD_GPRINT_1: ; $E7B0
    PSH  U
    SJP  (CLRNOCURSOR)
    POP  U

BCMD_GPRINT_19: ; $E7B7
    VEJ  (C6)
    VEJ  (DE) \ ABRF($E831)
    SJP  (MTRXNRANGE);($48)
    BCS BCMD_GPRINT_2 ; $E7F7
    PSH  Y
    VMJ  ($8C) ; ($8C)($46)
    PSH  X
    LDA  (ARX + $04)
    CPI  A,$C0
    BCR BCMD_GPRINT_3 ; $E7E8
    VEJ  (DC)

BCMD_GPRINT_7: ; $E7CD
    CPI  UL,$02
    BCR BCMD_GPRINT_4 ; $E7F3
    SJP  (ASCII2HEX)
    STX  Y
    POP  X
    BCR BCMD_GPRINT_5 ; $E832
    VMJ  ($88) ; ($88)($44)
    DEC  UL
    DEC  UL
    VMJ  ($8E) ; ($8E)($47)
    BCS BCMD_GPRINT_6 ; $E7F5
    PSH  X
    LDX  Y
    BCH BCMD_GPRINT_7 ; $E7CD

BCMD_GPRINT_3: ; $E7E8
    VEJ  (D0) \ ABYT($08) \ ABRF(BCMD_GPRINT_8) ; $E836
    POP  X
    VMJ  ($88) ; ($88)($44)
    VMJ  ($8E) ; ($8E)($47)
    BCH BCMD_GPRINT_6 ; $E7F5

BCMD_GPRINT_4: ; $E7F3
    POP  X

BCMD_GPRINT_6: ; $E7F5
    POP  Y

BCMD_GPRINT_2: ; $E7F7
    VEJ  (C2) \ ACHR($3B) \ ABRF(BCMD_GPRINT_9) ; $E808
    VEJ  (C8) \ ABRF(BCMD_GPRINT_10) ; $E83C

BCMD_GPRINT_20: ; $E7FC
    ORI  (CURSOR_ENA),$01
    SJP  (MTRXNRANGE);($48)
    BCS BCMD_GPRINT_11 ; $E80F

BCMD_GPRINT_13: ; $E805
    JMP  BCMD_PAUSE_24 ; $E6CB

BCMD_GPRINT_9: ; $E808
    VMJ  ($04) \ ABRF(BCMD_GPRINT_12) ; $E814
    ANI  (CURSOR_ENA),$FE

BCMD_GPRINT_11: ; $E80F
    SJP  (INIT_MTRX)
    BCH BCMD_GPRINT_13 ; $E805

BCMD_GPRINT_12: ; $E814
    VEJ  (C4) \ ACHR($2C) \ ABRF(BCMD_GPRINT_14) ; $E827
    SJP  (MTRXNRANGE);($48)
    BCS BCMD_GPRINT_15 ; $E823
    LDI  A,$00
    SJP  (HEX2COL)
    VMJ  ($8E) ; ($8E)($47)

BCMD_GPRINT_15: ; $E823
    VEJ  (C8) \ ABRF(BCMD_GPRINT_10) ; $E83C
    BCH BCMD_GPRINT_20 ; $E7FC

BCMD_GPRINT_14: ; $E827
    LDI  UH,$01

BCMD_GPRINT_18: ; $E829
    SJP  (MTRXNRANGE);($48)
    BCR BCMD_GPRINT_16 ; $E831
    SJP  (INIT_MTRX)

BCMD_GPRINT_16: ; $E831
    VEJ  (E0)

BCMD_GPRINT_5: ; $E932
    LDI  UH,$24
    BCH BCMD_GPRINT_17 ; $E838

BCMD_GPRINT_8: ; $E836
    POP  X

BCMD_GPRINT_17: ; $E838
    POP  Y
    BCH BCMD_GPRINT_18 ; $E829

BCMD_GPRINT_10: ; $E82C
    BCH BCMD_GPRINT_19 ; $E7B7



 ; Basic command GCURSOR
BCMD_GCURSOR: ; $E83E
    VEJ  (DE) \ ABRF(BCMD_WAIT_1) ; $E88A
    VEJ  (D0) \ ABYT($0A) \ ABRF(BCMD_WAIT_1) ; $E88A
    LDA  UL
    BCH BCMD_CURSOR_2 ; $E85D




; Basic command CURSOR
BCMD_CURSOR_1: ; $E846
    VEJ  (C8) \ ABRF(BCMD_CURSOR_3) ; $E852
    ANI  (CURSOR_PTR),$00
    ANI  (CURSOR_ENA),$FE
    DEC  Y
    VEJ  (E2)

BCMD_CURSOR_3: ; $E852
    VEJ  (C6)
    VEJ  (DE) \ ABRF(BCMD_WAIT_1) ; $E88A
    VEJ  (D0) \ ABYT($10) \ ABRF(BCMD_WAIT_1) ; $E88A
    LDA  UL
    SHL
    REC
    ADC  UL
    SHL

BCMD_CURSOR_2: ; $E85D
    STA  (CURSOR_PTR)
    ORI  (CURSOR_ENA),$01
    VEJ  (E2)



; Basic Command CLS
BCMD_CLS: ; $E865
    VEJ  (F2)
    SJP  (INIT_CURS)
    VEJ  (E2)


; Basic Command WAIT
BCMD_WAIT: ; $E86A
    VEJ  (C8) \ ABRF(BCMD_WAIT_2) ; $E871
    DEC  Y
    LDI  A,$00
    BCH BCMD_WAIT_3 ; $E886

BCMD_WAIT_2: ; $E871
    VEJ  (C6)
    VEJ  (DE) \ ABRF(BCMD_WAIT_1) ; $E88A
    VEJ  (D0) \ ABYT($00) \ ABRF(BCMD_WAIT_1) ; $E88A
    VEJ  (F6) \ AWRD(WAIT_CTR_H)
    LDI  A,$02
    CPI  UH,$00
    BZR BCMD_WAIT_3 ; $E886
    CPI  UL,$00
    BZR BCMD_WAIT_3 ; $E886
    LDI  A,$03

BCMD_WAIT_3: ; $E886
    STA  (WAIT_CFG)
    VEJ  (E2)

BCMD_WAIT_1: ; $E86A
    VEJ  (E0)
    VEJ  (E4)



;------------------------------------------------------------------------------
; Time delay by 15.625 ms * U-Reg
;            Address: E88C (AC)
;   Entry parameters: U-Reg contains the number of delay loops.
; 
; Modified registers: U-Reg
;   Error conditions: It is possible to abort with the break key
;------------------------------------------------------------------------------
TIMEDELAY: ; $E88C
    PSH  Y
    PSH  U
    LDI  A,$20
    VMJ  ($5A) ; ($5A)($2D)
    POP  U
    LDI  A,$00
    STA  #(PC1500_PRT_B_DIR)

TIMEDELAY_2: ; $E89C
    BII  #(PC1500_PRT_B),$20
    BZS TIMEDELAY_1 ; $E8A9
    VMJ  ($A6) ; ($A6)($53)
    BZS TIMEDELAY_2 ; $E89C
    BCH TIMEDELAY_3 ; $E8B4

TIMEDELAY_1: ; $E8A9
    BII  #(PC1500_PRT_B),$20
    BZR TIMEDELAY_4 ; $E8BC
    VMJ  ($A6) ; ($A6)($53)
    BZS TIMEDELAY_1 ; $E8A9

TIMEDELAY_3: ; $E8B4
    LDI  A,$00
    VMJ  ($5A) ; ($5A)($2D)
    SEC

TIMEDELAY_5: ; $E8B9
    POP  Y
    RTN

TIMEDELAY_4: ; $E8BC
    DEC  UL
    BCS TIMEDELAY_2 ; $E89C
    DEC  UH
    BCS TIMEDELAY_2 ; $E89C
    LDI  A,$00
    VMJ  ($5A) ; ($5A)($2D)
    REC
    BCH TIMEDELAY_5 ; $E8B9



 ; Display Program
PRGMDISP: ; $E8CA
    LDA  (DISPARAM)
    BII  A,$31
    BZR PRGMDISP_1 ; $E967
    PSH  Y
    LDA  YL
    PSH  A
    LDI  XH,$7A
    LDI  XL,$08
    BII  (BREAKPARAM),$10
    BZR PRGMDISP_2 ; $E8F0
    BII  (DISPARAM),$40
    BZS PRGMDISP_3 ; $E8F7
    PSH  X
    LDI  A,$E5

PRGMDISP_5: ; $E8EA
    LDI  UH,$7B
    LDI  UL,$B0
    BCH PRGMDISP_4 ; $E918

PRGMDISP_2: ; $E8F0
    PSH  X
    LDA  ($7877)
    BCH PRGMDISP_5 ; $E8EA

PRGMDISP_3: ; $E8F7
    LDI  YH,$7B
    LDI  YL,$B0
    BCH PRGMDISP_6 ; $E96E

PRGMDISP_31: ; $E8FF
    BII  (DISPARAM),$40
    BZS PRGMDISP_6 ; $E96E
    POP  A
    PSH  A
    PSH  X
    PSH  Y
    POP  U
    BII  ($787B),$FF
    BZR PRGMDISP_7 ; $E914
    STA  YL

PRGMDISP_7: ; $E914
    REC
    LDA  XL
    ADI  A,$DD

PRGMDISP_4: ; $E918
    INC  U
    PSH  A
    PSH  U
    VEJ  (C0)
    BCR PRGMDISP_8 ; $E936
    VMJ  ($1C) \ ABYT($04)
    BZS PRGMDISP_8 ; $E936
    STA  UL
    POP  X
    REC
    POP  A
    ADC  UL
    BCS PRGMDISP_9 ; $E930
    BCH PRGMDISP_10 ; $E941

PRGMDISP_9: ; $E930
    VEJ  (C6)
    BCH PRGMDISP_11 ; $E95B

PRGMDISP_15: ; $E933
    VEJ  (C0)
    BCS PRGMDISP_12 ; $E95F

PRGMDISP_8: ; $E936
    LDI  A,$01

PRGMDISP_16: ; $E938
    STA  UL
    POP  X
    REC
    POP  A
    ADC  UL
    BCS PRGMDISP_11 ; $E95B

PRGMDISP_10: ; $E941
    VEJ  (C6)
    PSH  A
    LDA  YL
    CPA  XL
    BCR PRGMDISP_13 ; $E959
    PSH  X
    BZS PRGMDISP_14 ; $E956
    DEC  Y
    DEC  Y
    LDA  (Y)
    CPI  A,$E0
    BCS PRGMDISP_15 ; $E933
    INC  Y
    BCH PRGMDISP_15 ; $E933

PRGMDISP_14: ; $E956
    DEC  Y
    BCH PRGMDISP_15 ;  $E933

PRGMDISP_13: ; $E959
    POP  A

PRGMDISP_11: ; $E95B
    POP  X
    BCH PRGMDISP_6 ; $E96E

PRGMDISP_12: ; $E95F
    VMJ  ($1C) \ ABYT($04)
    BZS PRGMDISP_8 ; $E936
    INC  A
    BCH PRGMDISP_16 ; $E938

PRGMDISP_1: ; $E967
    AEX
    SHR
    BCS STATUSCHK_1 $EA26
    JMP  BCMD_POINT_2 ; $EEEC

PRGMDISP_6: ; $E96E
    POP  A
    PSH  A
    CPA  YL
    BZR PRGMDISP_17 ; $E979
    LDA  XL
    STA  ($787B)

PRGMDISP_17: ; $E979
    VEJ  (C0)
    BCS PRGMDISP_18 ; $E997
    CPI  A,$0D
    BZS PRGMDISP_19 ; $E9AC

PRGMDISP_23: ; $E980
    SIN  X
    CPI  XL,$22
    BCR PRGMDISP_6 ; $E96E
    SJP  (STATUSCHK)
    BCS PRGMDISP_20 ; $E9B8
    LDI  A,$1A

PRGMDISP_30: ; $E98C
    STA  UH

PRGMDISP_29: ; $E98D
    POP  A
    LDA  (CURSOR_PTR)
    PSH  A
    LDA  UH
    BCH PRGMDISP_21 ; $E9C5

PRGMDISP_18: ; $E997
    PSH  Y
    STX  Y
    VMJ  ($1C) \ ABYT($02)
    BZS PRGMDISP_22 ; $E9A8
    LDI  A,$20

PRGMDISP_24: ; $E9A2
    LDX  Y
    POP  Y
    BCH PRGMDISP_23 ; $E980

PRGMDISP_22: ; $E9A8
    LDI  A,$7E
    BCH PRGMDISP_24 ; $E9A2

PRGMDISP_19: ; $E9AC
    SJP  (STATUSCHK)
    BCR PRGMDISP_25 ; $E9CD
    LDI  A,$00

PRGMDISP_26: ; $E9B3
    SIN  X
    CPI  XL,$22
    BCR PRGMDISP_26 ; $E9B3

PRGMDISP_20: ; $E9B8
    POP  A
    LDA  (CURSOR_PTR)
    PSH  A
    ANI  (CURSOR_PTR),$00
    LDI  A,$1A

PRGMDISP_21: ; $E9C5
    LDI  UH,$7A
    LDI  UL,$08
    VMJ  ($92) ; ($92)($49)
    BCH STATUSCHK_2 ; $E9F9

PRGMDISP_25: ; $E9CD
    ANI  (X),$00
    LDA  XL
    SBI  A,$06
    CPA  (CHARPOS_LCD)
    BCS PRGMDISP_27 ; $E9E6
    STA  UL
    LDA  (CHARPOS_LCD)
    STA  UH
    INC  A
    SBC  UL
    STA  UL
    LDI  A,$00

PRGMDISP_28: ; $E9E1
    SIN  X
    LOP  UL,PRGMDISP_28 ; $E9E1
    BCH PRGMDISP_29 ; $E98D

PRGMDISP_27: ; $E9E6
    STA  (CHARPOS_LCD)
    BCH PRGMDISP_30 ; $E98C



 ; $E9EB Checks display and input status. Checks computer status.
STATUSCHK: ; 
    BII  (DISPARAM),$10
    BZR STATUSCHK_3 ; $E9F8
    BII  (BREAKPARAM),$10
    BZS STATUSCHK_3 ; $E9F8
    REC

STATUSCHK_3: ; $E9F8
    RTN

STATUSCHK_2: ; $E9F9
    BII  (DISPARAM),$40
    BZS STATUSCHK_4 ; $EA18
    VEJ  (CC) \ ABYTL(CURS_POS_NBUF_H) ; $787E
    LDA  (BLNKD_CHAR_CODE)
    CPI  A,$20
    BCR STATUSCHK_5 ; $EA1E
    LDI  A,$7F
    ORI  (CURSOR_BLNK),$81

STATUSCHK_7: ; $EA0E
    VMJ  ($8A) ; ($8A)($45)

STATUSCHK_6: ; $EA10
    POP  A
    STA  (CURSOR_PTR)
    POP  Y
    RTN

STATUSCHK_4: ; $EA18
    ANI  (CURSOR_BLNK),$7E
    BCH STATUSCHK_6 ; $EA10

STATUSCHK_5: ; $EA1E
    LDI  A,$5F
    ANI  (CURSOR_BLNK),$7E
    BCH STATUSCHK_7 ; $EA0E

STATUSCHK_1: ; $EA26
    PSH  Y
    ANI  ($787B),$00
    BII  (DISPARAM),$40
    BZR STATUSCHK_8 ; $EA34
    LDI  YL,$B0

STATUSCHK_8: ; $EA34
    LDA  YL
    PSH  A
    LDI  XH,$7A
    LDI  XL,$08
    LDI  YL,$B0

STATUSCHK_11: ; $EA3D
    POP  A
    PSH  A
    CPA  YL
    BZS STATUSCHK_9 ; $EA67
    VEJ  (C0)
    CPI  A,$3A
    BCS STATUSCHK_10 ; $EA60
    CPI  A,$30
    BCR STATUSCHK_10 ; $EA60
    SIN  X
    CPI  XL,$0E
    BCR STATUSCHK_11 ; $EA3D

STATUSCHK_14: ; $EA52
    LDI  A,$20
    BII  (DISPARAM),$04
    BZS STATUSCHK_12 ; $EA5C
    LDI  A,$3A

STATUSCHK_12: ; $EA5C
    SIN  X

STATUSCHK_13: ; $EA5D
    JMP  PRGMDISP_31 ; $E8FD

STATUSCHK_10: ; $EA60
    VEJ  (C6)
    CPI  XL,$09
    BCR STATUSCHK_13 ; $EA5D
    BCH STATUSCHK_14 ; $EA52

STATUSCHK_9: ; $EA67
    VEJ  (C0)
    CPI  A,$3A
    BCS STATUSCHK_10 ; $EA60
    CPI  A,$30
    BCR STATUSCHK_10 ; $EA60
    STA  (X)
    LDA  XL
    STA  ($787B)
    INC  X
    BCH $EA4E



 ; (96) Using formatting. If error C=1.
USING_FRMT: ; $EA78
    PSH  A
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$10
    LDI  UL,$0D
    LDI  A,$20

USING_FRMT_1: ; $EA82
    SIN  X
    LOP  UL,USING_FRMT_1 ; $EA82
    BII  (USINGM),$FF
    BZS USING_FRMT_2 ; $EACE
    BII  (USINGF),$80
    BZR USING_FRMT_3 ; $EB26
    LDA  (USINGMD)
    VMJ  ($86) ; ($86)($43)
    BCS USING_FRMT_4 ; $EB3C
    LDA  UH
    STA  YL

USING_FRMT_12: ; $EA9A
    POP  A
    SHR
    BCR USING_FRMT_5 ; $EAA5

USING_FRMT_7: ; $EA9F
    SEC
    LDA  YL
    SBC  XL
    INC  A
    REC
    RTN

USING_FRMT_5: ; $EAA5
    SHR
    BCR USING_FRMT_6 ; $EAB1
    CPI  YL,$2A
    BCR USING_FRMT_7 ; $EA9F
    LDA  YL
    ADI  A,$E6
    BCH USING_FRMT_8 ; $EAB4

USING_FRMT_6: ; $EAB1
    LDA  YL
    ADI  A,$F4

USING_FRMT_8: ; $EAB4
    STA  XL

USING_FRMT_10: ; $EAB5
    LDA  (X)
    CPI  A,$20
    BZS USING_FRMT_7 ; $EA9F
    CPI  A,$2D
    BZS USING_FRMT_7 ; $EA9F
    CPI  A,$2B
    BZS USING_FRMT_7 ; $EA9F
    BCH USING_FRMT_9 ; $EACC
    BZS USING_FRMT_9 ; $EACC
    DEC  X
    DEC  YL
    CPI  YL,$1E
    BCS USING_FRMT_10 ; $EAB5

USING_FRMT_9: ; $EACC
    SEC
    RTN

USING_FRMT_2: ; $EACE
    SJP  (BCMD_DEC9)
    BCS USING_FRMT_11 ; $EADC
    LDI  A,$0A
    VMJ  ($86) ; ($86)($43)
    SJP  (TRUNCDEC)
    BCH USING_FRMT_12 ; $EA9A

USING_FRMT_11: ; $EADC
    LDI  XL,$00
    LDA  (X)
    ANI  (X),$00
    PSH  A
    LDI  A,$0A
    VMJ  ($86) ; ($86)($43)
    SJP  (TRUNCDEC)

USING_FRMT_17: ; $EAEA
    INC  Y
    POP  A
    STA  (ARX)
    STA  UL
    POP  A
    PSH  A
    BZS USING_FRMT_13 ; $EB1E

USING_FRMT_15: ; $EAF7
    LDI  A,$45
    SIN  Y
    PSH  X
    PSH  Y
    LDA  UL
    PSH  A
    VMJ  ($80) ; ($80)($40)
    POP  A
    STA  UL
    LDI  UH,$00
    SHL
    BCR USING_FRMT_14 ; $EB0D
    LDI  UH,$FF

USING_FRMT_14: ; $EB0D
    POP  Y
    VMJ  ($10) \ ABYT($E0)
    PSH  Y
    SJP  (XFER_ARY2ARX)
    POP  Y
    DEC  Y
    POP  X
    BCH USING_FRMT_12 ; $EA9A

USING_FRMT_13: ; $EB1E
    CPI  YL,$27
    BCR USING_FRMT_15 ; $EAF7
    LDI  YL,$26
    BCH USING_FRMT_15 ; $EAF7

USING_FRMT_3: ; $EB26
    LDI  XL,$00
    LDA  (X)
    ANI  (X),$00
    PSH  A
    LDA  (USINGMD)
    CPI  A,$0E
    BCR USING_FRMT_16 ; $EB36
    LDI  A,$0D

USING_FRMT_16: ; $EB36
    VMJ  ($86) ; ($86)($43)
    LDA  UH
    STA  YL
    BCH USING_FRMT_17 ; $EAEA

USING_FRMT_4: ; $EB3C
    POP  A
    SEC
    RTN



 ; (86) $EB40 Converts AR-X to ASCII according to USING parameters
ARX2ASCII: ; 
    REC
    ADI  A,$1E
    STA  UH
    VMJ  ($80) ; ($80)($40)
    LDI  XL,$31
    LDA  (X)
    ANI  (X),$00
    PSH  A
    DEC  X
    LDA  (X)
    BII  A,$80
    BZR ARX2ASCII_1 ; $EBCC
    BII  (USINGF),$10
    BZR ARX2ASCII_2 ; $EB8B
    CPI  A,$0E
    BCS USING_FRMT_4 ; $EB3C

ARX2ASCII_9: ; $EB5D
    EAI  $FF
    ADI  A,$1E
    STA  YL
    PSH  A
    INC  Y

ARX2ASCII_15: ; $EB65
    LDI  A,$09

ARX2ASCII_5: ; $EB67
    PSH  A
    SJP  (ARS_SHL_4BITS)
    AEX
    ANI  A,$0F
    ORI  A,$30
    SIN  Y

ARX2ASCII_8: ; $EB72
    LDA  UH
    CPA  YL
    BCR ARX2ASCII_3 ; $EC2B
    CPI  YL,$1F
    BZS ARX2ASCII_4 ; $EB88
    POP  A
    DEC  A
    BCS ARX2ASCII_5 ; $EB67

ARX2ASCII_6: ; $EB7F
    LDI  A,$30
    SIN  Y
    LDA  UH
    CPA  YL
    BCS ARX2ASCII_6 ; $EB7F
    BCH ARX2ASCII_7 ; $EBEC

ARX2ASCII_4: ; $EB88
    INC  Y
    BCH ARX2ASCII_8 ; $EB72

ARX2ASCII_2: ; $EB8B
    CPI  A,$0B
    BCS USING_FRMT_4 ; $EB3C
    CPI  A,$03
    BCR ARX2ASCII_9 ; $EB5D
    CPI  A,$06
    BCR ARX2ASCII_10 ; $EC1E
    CPI  A,$09
    ADI  A,$02

ARX2ASCII_21: ; $EB9B
    REC
    EAI  $FF
    ADI  A,$1E
    STA  YL
    PSH  A
    INC  Y
    LDI  A,$09

ARX2ASCII_12: ; $EBA6
    PSH  A
    SJP  (ARS_SHL_4BITS)
    AEX
    ANI  A,$0F
    ORI  A,$30
    SIN  Y

ARX2ASCII_13: ; $EBB1
    LDA  UH
    CPA  YL
    BCR ARX2ASCII_3 ; $EC2B
    CPI  YL,$1F
    BZS ARX2ASCII_4 ; $EB88
    LDA  YL
    EAI  $FF
    BII  A,$03
    BZS ARX2ASCII_11 ; $EBC7
    POP  A
    DEC  A
    BCS ARX2ASCII_12 ; $EBA6
    BCH ARX2ASCII_6 ; $EB7F

ARX2ASCII_11: ; $EBC7
    LDI  A,$2C
    SIN  Y
    BCH ARX2ASCII_13 ; $EBB1

ARX2ASCII_1: ; $EBCC
    STA  UL
    LDI  YL,$1E
    LDA  (USINGM)
    CPI  A,$01
    BZS ARX2ASCII_14 ; $EBD9
    LDI  A,$30
    SDE  Y

ARX2ASCII_14: ; $EBD9
    LDA  YL
    PSH  A
    LDA  UL
    EAI  $FF
    STA  UL
    LDI  YL,$20

ARX2ASCII_16: ; $EBE2
    DEC  UL
    BCR ARX2ASCII_15 ; $EB65
    LDI  A,$30
    SIN  Y
    LDA  UH
    CPA  YL
    BCS ARX2ASCII_16 ; $EBE2

ARX2ASCII_7: ; $EBEC
    LDI  A,$2E
    STA  (ARU + $07)
    POP  A
    STA  YL
    LDA  (USINGM)
    BZS ARX2ASCII_17 ; $EC12
    EAI  $FF
    ADI  A,$20
    STA  XL
    LDA  (X)
    CPI  A,$20
    BZR USING_FRMT_4 ; $EB3C
    BII  (USINGF),$40
    BZS ARX2ASCII_18 ; $EC14

ARX2ASCII_19: ; $EC09
    LDA  XL
    CPA  YL
    BZS ARX2ASCII_18 ; $EC14
    LDI  A,$2A
    SDE  Y
    BCH ARX2ASCII_19 ; $EC09

ARX2ASCII_17: ; $EC12
    LDX  Y

ARX2ASCII_18: ; $EC14
    POP  A
    SHL
    BCR ARX2ASCII_20 ; $EC21
    LDI  A,$2D

ARX2ASCII_23: ; $EC1B
    STA  (Y)

ARX2ASCII_22: ; $EC1C
    REC
    RTN

ARX2ASCII_10: ; $EC1E
    INC  A
    BCH ARX2ASCII_21 ; $EB9B

ARX2ASCII_20: ; $EC21
    BII  (USINGF),$20
    BZS ARX2ASCII_22 ; $EC1C
    LDI  A,$2B
    BCH ARX2ASCII_23 ; $EC1B

ARX2ASCII_3: ; $EC2B
    POP  A
    BCH ARX2ASCII_7 ; $EBEC



; $EC2F Determines the address at which the rightmost character is located
; from the ASCII number string below 7A28 in the Y-Reg. (Truncation of the 
; decimal places).
TRUNCDEC: ; $EC2F
    LDI  YL,$28

TRUNCDEC_1: ; $EC31
    LDE  Y
    CPI  A,$30
    BZS TRUNCDEC_1 ; $EC31
    CPI  A,$2E
    BZS TRUNCDEC_2 ; $EC3B
    INC  Y

TRUNCDEC_2: ;$EC3B
    RTN


; $EC3C Checks whether the value in AR-X can be completely represented with 9 decimal places. If not, C=1.
BCMD_DEC9: ; 
    LDA  (ARX)
    BII  A,$80
    BZR BCMD_DEC9_1 ; $EC46
    CPI  A,$0A
    RTN

BCMD_DEC9_1: ; $EC46
    CPI  A,$F7
    BCR XP_STROUT_1 ; $EC95
    ADI  A,$0C
    SHR
    STA  YL
    LIN  Y
    BCS BCMD_DEC9_2 ; $EC59
    BII  A,$0F

BCMD_DEC9_3: ; $EC53
    BZR XP_STROUT_1 ; $EC95
    CPI  YL,$07
    BCS ARX2ASCII_22 ; $EC1C

BCMD_DEC9_2: ; $EC59
    LIN  Y
    BCH BCMD_DEC9_3 ; $EC53



; (94) Transfers the string whose address is in the X-Reg (lengh in UL) to the
;  free area of the output buffer. If error C=1.
X_STROUT: ; $EC5C
    LDA  ($788F)
    STA  YL
    LDI  YH,$7B
    BCH X_STROUT_1 ; $EC69

X_STROUT_3: ; $EC64
    CPI  YL,$B0
    BCS X_STROUT_2 ; $EC6B
    TIN

X_STROUT_1: ; $EC69
    LOP  UL,X_STROUT_3 ; $EC64

X_STROUT_2: ; $EC6B
    RTN



; $EC6C If AR-X contains numeric value, if necessary. Convert integer to BCD:
; C=0. If CSI available: Address from X-Reg; load length from to UL; C=1.
ARX2BCD:
    VEJ  (D2) \ ABRF(ARX2BCD_2) \ ABYT($80)
    REC
    RTN

ARX2BCD_2: ; $ 
    VEJ  (DC)

ARX2BCD_1: ; $EC72
    SEC
    RTN



; (98) $EC74 Converts AR-X from BCD to ASCII and transfers to Output buffer
ARXBCD2ASCII: ; 
    SJP  (ARX2BCD)
    BCR $EC96
    STA  UL
    LDA  (USING_CHR)
    BZS $EC98
    CPA  UL
    BCR $EC97



; $EC82 Transfers string pointed to by X-Reg into output buffer. Then writes
; A-UL spaces to the output buffer. Sets C=1 if the output buffer is full
XP_STROUT:
    SBC  UL
    PSH  A
    VMJ  ($94) ; ($94)($4A)
    POP  A
    STA  UL
    LDI  A,$20
    BCH XP_STROUT_3 ; $EC93
    CPI  YL,$B0
    BCS XP_STROUT_2 ; $EC96
    SIN  Y

XP_STROUT_3: ; $EC93
    LOP  UL,$EC8E


XP_STROUT_1: ; $EC82
    SEC

XP_STROUT_2: ; $EC96
    RTN
    STA  UL
    VMJ  ($94) ; ($94)($4A)
    BCH XP_STROUT_1 ; $EC95



; $EC9C Clears LCD if cursor is not allowed and sets matrix pointer to 00
CLRNOCURSOR: ; 
    BII  (CURSOR_ENA),$01
    BZR $ECA7
    VEJ  (F2)
    ANI  (CURSOR_PTR),$00
    LDA  ($788F)
    SEC
    SBI  A,$60
    RTN



;------------------------------------------------------------------------------
; Deletes cursor flag and matrix pointer
;            Address: ECAE
;          Parameter: None
;
; Modified Registers: Cursor flag (7874) and matrix pointer are deleted
;   Error conditions: None
;------------------------------------------------------------------------------
INIT_CURS: ; $ECAE
    ANI  (CURSOR_ENA),$FE

INIT_MTRX: ; $ECB2
    ANI  (CURSOR_PTR),$00
    RTN



; (97) $ECB7 Transfers value to output buffer
ARX2OUTBUF: 
    SJP  (ARX2BCD)
    BCR ARX2OUTBUF_1 ; $ECD4
    STA  UL
    LDA  (USING_CHR)
    BZS ARX2OUTBUF_2 ; $ECC6
    CPI  A,$0E
    BCR ARX2OUTBUF_3 ; $ECC8

ARX2OUTBUF_2: ; $ECC6
    LDI  A,$0D

ARX2OUTBUF_3: ; $ECC8
    CPA  UL
    BCS ARX2OUTBUF_4 ; $ECCC
    STA  UL

ARX2OUTBUF_4: ; $ECCC
    LDI  A,$0D
    SEC
    SJP  (XP_STROUT)
    BCH ARX2OUTBUF_F_1 ; $ECDD

ARX2OUTBUF_1: ; $ECD4
    LDI  A,$00



; Transfer AR-X formatted to Output Buffer
ARX2OUTBUF_F: ; $ECD6
    VMJ  ($96) ; ($96)($4B)
    BCS ARX2OUTBUF_F_2 ; $ECE2
    STA  UL
    VMJ  ($94) ; ($94)($4A)

ARX2OUTBUF_F_1: ; $ECDD
    LDA  YL
    STA  ($788F)
    REC

ARX2OUTBUF_F_2: ; $ECE2
    RTN



; $ECE3 Transfers value (string or numeric) to output buffer and resets output buffer pointer.
ARXASCII2OUTBUF: 
    VMJ  ($98) ; ($98)($4C)
    BCS ARX2OUTBUF_F_1 ; $ECDD
    LDI  A,$01
    BCH ARX2OUTBUF_F



; (9A) Executes using command pointed to by Y-Reg. If an error occurs C=1.
USING_PARAM: ; $ECEB
    VEJ  (C4) \ AWRD($F085) \ ABRF($ECF5)
    SJP  (EVAL_USING)
    LDA  (X)
    REC
    RTN
    VEJ  (C6)
    REC
    RTN
    SEC
    RTN



; Output of 26 characters of the output buffer
OUTBUF2LCD: ; $ECFA
    LDI  A,$1A
    LDI  UH,$7B
    LDI  UL,$60



; (92) Output of text on the LCD. U-Reg contains start address; A the length.
TEXTUREG_A: ; $ED00
    PSH  A
    VMJ  ($8C) ; ($8C)($46)
    POP  A
    PSH  Y
    PSH  A
    DEC  U

TEXTUREG_A4: ; $ED0B
    INC  U
    LDA  ($787B)
    CPA  UL
    BZS TEXTUREG_A1 ; $ED28
    POP  A
    DEC  A
    BCR TEXTUREG_A2 ; $ED38
    PSH  A
    PSH  U
    LDA  (U)
    VMJ  ($8A) ; ($8A)($45)
    POP  U
    BCS TEXTUREG_A3 ; $ED36
    ADI  (CURSOR_PTR),$06
    BCH TEXTUREG_A4 ; $ED0B

TEXTUREG_A1: ; $ED28
    LDA  XH
    STA  (CURS_POS_NBUF_H)
    LDA  XL
    STA  (CURS_POS_NBUF_L)
    LDA  (U)
    STA  (BLNKD_CHAR_CODE)
    BCH $ED12

TEXTUREG_A3: ; $ED36
    POP  A

TEXTUREG_A2: ; $ED38
    POP  Y
    RTN


; $ED3B Outputs XL characters of text starting from U-Reg. The output is 
; independent of the value of the matrix pointer. Its old value is then restored.
TEXTUREG_XL:
    LDA  (CURSOR_PTR)
    ANI  (CURSOR_PTR),$00
    PSH  A
    LDA  XL
    VMJ  ($92) ; ($92)($49)
    POP  A
    STA  (CURSOR_PTR)
    RTN



; Output a character at the next matrix column
CHAR2COL: ; $ED4D
    SJP  (CHARA2COL)
    BCS INIT_MTRX
    ADI  (CURSOR_PTR),$06
    RTN



; $ED57 Output of the character in accumulator at next matrix column. 
; The output address is calculated automatically.
CHARA2COL: ; $ED57
    STA  UH
    VMJ  ($8C) ; ($8C)($46)
    LDA  UH



; (8A) $ED5B Output of ASCII character in accumulator starting at matrix
; column address pointed to by X-Reg. Second character set is recognized.
CHARA2COLX: ; 
    PSH  Y
    SJP  (CHAR2ADDR)
    LDI  UL,$04

CHARA2COLX_2: ; $ED62
    LIN  Y
    VMJ  ($88) ; ($88)($44)
    CPI  XH,$78
    BCS CHARA2COLX_1 ; $ED71
    LOP  UL,CHARA2COLX_2 ; $ED62
    LDI  A,$00
    VMJ  ($88) ; ($88)($44)
    CPI  XH,$78

CHARA2COLX_1: ; $ED71
    RPV
    BII  (PU_PV),$01
    BZS $ED79 ; CHARA2COLX_3
    SPV

CHARA2COLX_3: ; $ED79
    SIE
    BCH TEXTUREG_A2 ; $ED38



;------------------------------------------------------------------------------
; Converts characters in the accumulator to HEX nibble
;            Address: ED7D
;   Entry parameters: Accumulator contains ASCII characters
;
; Modified registers: Accumulator contains converted HEX nibble (00-0F)
;   Error conditions: Carry=0 if ASCII characters cannot be converted
;------------------------------------------------------------------------------
A2HEX: ; $ED7D
    CPI  A,$47
    BCS A2HEX_1 ; $ED8D
    CPI  A,$41
    BCS A2HEX_2 ; $ED92
    CPI  A,$3A
    BCS A2HEX_1 ; $ED8D
    CPI  A,$30
    BCS A2HEX_3 ; $ED8F

A2HEX_1: ; $ED8D
    REC
    RTN

A2HEX_3: ; $ED8F
    SBI  A,$30
    RTN

A2HEX_2: ; $ED92
    SBI  A,$37
    RTN



;------------------------------------------------------------------------------
; Convert 2 ASCII characters to a hex byte
;            Address: ED95
;   Entry parameters: X-Reg must point to the 1st character to be converted
; 
; Modified registers: X-Reg was incremented by 2 Accumulator contains hex value. Carry=0
;   Error conditions: Carry=0 if ASCII characters cannot be converted to hex.
;------------------------------------------------------------------------------
ASCII2HEX: ; $ED95
    PSH  U
    LIN  X
    SJP  (A2HEX)
    BCR ASCII2HEX_1 ; $EDA8
    AEX
    STA  UH
    LIN  X
    SJP  (A2HEX)
    BCR ASCII2HEX_1 ; $EDA8
    REC
    ADC  UH
    SEC

ASCII2HEX_1: ; $EDA8
    POP  U
    RTN



; (90) $EDAB Checks whether the matrix pointer is still in the permissible range 0-155. Set C=1 if not.
MTRXNRANGE: 
    LDA  (CURSOR_PTR)
    CPI  A,$9C
    RTN



; (8E) $EDB1 Increases matrix pointer if still in the permissible range 0-155 C=1 if not.
MTRXINC: 
    LDA  (CURSOR_PTR)
    INC  A
    BCS MTRXINC_1 ; $EDB9
    CPI  A,$9C

MTRXINC_1: ; $EDB9
    BCR $EDBD
    LDI  A,$9C

MTRXINC_2: ; $EDBD
    STA  (CURSOR_PTR)
    RTN



; Cache LCD display of 7810-7BFF
LCDCACHE: ; $EDC1
    PSH  Y

LCDCACHE_3: ; $EDC3
    SEC
    LDI  YH,$7B
    LDI  YL,$10
    LDI  XH,$76

LCDCACHE_2: ; $EDCA
    LDI  XL,$00
    LDI  UL,$4D

LCDCACHE_1: ; $EDCE
    TIN
    LOP  UL,LCDCACHE_1 ; $EDCE
    BCR TEXTUREG_A2 ; $ED38
    REC
    LDI  XH,$77
    BCH LCDCACHE_2 ; $EDCA



; Retrieve LCD display from 7610-7BFF
BCMD_BFF: ; $EDD8
    PSH  Y

BCMD_BFF_3: ; $EDDA
    SEC
    LDI  XH,$7B
    LDI  XL,$10
    LDI  YH,$76

BCMD_BFF_2: ; $EDE1
    LDI  YL,$00
    LDI  UL,$4D

BCMD_BFF_1: ; $EDD8
    TIN
    LOP  UL,BCMD_BFF_1 ; $EDE5
    BCR TEXTUREG_A2 ; $ED38
    REC
    LDI  YH,$77
    BCH BCMD_BFF_2 ; $EDE1



; $EDEF Output characters from accumulator to next matrix column address.
HEX2COL: 
    STA  UH
    VMJ  ($8C) ; ($8C)($46)
    LDA  UH
    BCH GPRNT_A_2LCD
    LIN  Y



; (88) $EDF6 Output of accumulator as "GPRINT" value on LCD
; Output of the accumulator as a bit pattern on the LCD (X-Reg and f.).
GPRNT_A_2LCD:
    STA  UH
    ANI  A,$0F
    CPI  XH,$76
    BCS GPRNT_A_2LCD_1 ; $EE13
    ANI  (X),$F0
    ORA  (X)
    SIN  X
    LDA  UH
    AEX
    ANI  A,$0F
    ANI  (X),$F0

GPRNT_A_2LCD_3: ; $EE07
    ORA  (X)
    SIN  X
    CPI  XL,$4E
    BCS GPRNT_A_2LCD_2 ; $EE0E
    RTN

GPRNT_A_2LCD_2: ; $EE0E
    LDI  XL,$00
    INC  XH
    RTN

GPRNT_A_2LCD_1: ; $EE13
    AEX
    ANI  (X),$0F
    ORA  (X)
    SIN  X
    LDA  UH
    ANI  A,$F0
    ANI  (X),$0F
    BCH GPRNT_A_2LCD_3 ; $EE07



; (8C) $EE1F Calculates in X-Reg matrix column address from matrix pointer
; Calculates the matrix column address from the matrix pointer $7875 in the X-Reg.
MATRIX_PTR2XREG:
    LDA  (CURSOR_PTR)



; $EE22 Calculated from the accumulator matrix column address in the X-Reg.
MATRIX_A2XREG: 
    CPI  A,$4E
    BCS MATRIX_A2XREG_1 ; $EE36
    CPI  A,$27
    BCS MATRIX_A2XREG_2 ; $EE2F
    LDI  XH,$74
    SHL
    STA  XL
    RTN

MATRIX_A2XREG_2: ; $EE2F
    SBI  A,$27
    LDI  XH,$75
    SHL
    STA  XL
    RTN

MATRIX_A2XREG_1: ; $EE36
    CPI  A,$75
    BCS MATRIX_A2XREG_3 ; $EE41
    SBI  A,$4D
    LDI  XH,$76
    SHL
    STA  XL
    RTN

MATRIX_A2XREG_3: ; $EE41
    SBI  A,$75
    LDI  XH,$77
    SHL
    STA  XL
    RTN



; $EE48 Retrieves address in character set table for character in accumulator
; Retrieves the address in the character set table for characters in the
; accumulator. 2. Character set is taken into account. Table address is passed to Y-Reg.
CHAR2ADDR: 
    SHL
    BCS CHAR2ADDR_1 ; $EE5A

CHAR2ADDR_6: ; $EE4B
    LDI  YH,$FC
    CPI  A,$40
    BCS CHAR2ADDR_2 ; $EE53
    LDI  A,$40

CHAR2ADDR_2: ; $EE53
    STA  YL

CHAR2ADDR_5: ; $EE54
    ADR  Y
    SHR
    ADR  Y
    RTN

CHAR2ADDR_1: ; $EE5A
    STA  YL
    LDA  (KATAFLAGS)
    SHL
    BZR CHAR2ADDR_3 ; $EE6E
    RIE
    RPV
    BCR CHAR2ADDR_4 ; $EE67
    SPV

CHAR2ADDR_4: ; $EE67
    LDA  (KATACHAR)
    STA  YH
    LDA  YL
    BCH CHAR2ADDR_5 ; $EE54

CHAR2ADDR_3: ; $EE6E
    LDA  YL
    BCH CHAR2ADDR_6 ; $EE4B



;------------------------------------------------------------------------------
; (F2) Clears the LCD display
;            Address: EE71 (F2)
;          Parameter: None
;
; Modified Registers: U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
LCDCLR: ; $EE71
    LDI  UH,$76
    SJP  (LCDCLRRNG)
    LDI  UH,$77



; Clears area from (UH00)-(UH4D)
LCDCLRRNG: ; $EE78
    LDI  UL,$4D
    LDI  A,$00

LCDCLRRNG_1: ; $EE7C
    STA  (U)
    LOP  UL,LCDCLRRNG_1 ; $EE7C
    RTN



; $EE80 Saves cursor parameters in cache from $786C. Transfers the display to the buffer area.
SAVELCD2BUF: ; 
    ANI  (ARX + $07),$00
    ORI  (CURSOR_ENA),$80
    PSH  Y
    LDI  XH,$78
    LDI  XL,$7C
    LDI  YH,$78
    LDI  YL,$6C
    LDI  UL,$03

SAVELCD2BUF_1: ; $EE94
    TIN
    LOP  UL,SAVELCD2BUF_1 ; $EE94
    BCH LCDCACHE_3 ; $EDC3



; $EE99 Transfer back cursor parameters and display.
BUF2LCD:
    BII  (CURSOR_ENA),$80
    BZS LCDCHRLEFT_1 ; $EEC0
    PSH  Y
    LDI  XH,$78
    LDI  XL,$6C
    LDI  YH,$78
    LDI  YL,$7C
    LDI  UL,$03

BUF2LCD_1: ; $EEAB
    TIN
    LOP  UL,BUF2LCD_1 ; $EEAB
    BCH BCMD_BFF_3 ; $EDDA



; $EEB0 Determines from accumulator number of characters that can be displayed. 
; If output not possible C=1.
LCDCHRLEFT: ; 
    LDI  UL,$19
    LDA  (CURSOR_PTR)
    BZS LCDCHRLEFT_2 ; $EEC5
    DEC  A
    LDI  UH,$06
    SEC

LCDCHRLEFT_4: ; $EEBB
    SBC  UH
    BCR LCDCHRLEFT_3 ; $EEC2
    LOP  UL,LCDCHRLEFT_4 ; $EEBB

LCDCHRLEFT_1: ; $EEC0
    SEC
    RTN

LCDCHRLEFT_3: ; $EEC2
    ADC  UH
    BZR LCDCHRLEFT_5 ; $EEC6

LCDCHRLEFT_2: ; $EEC5
    INC  UL

LCDCHRLEFT_5: ; $EEC6
    LDA  UL
    BZS LCDCHRLEFT_1 ; $EEC0
    REC
    RTN



; Basic command POINT
BCMD_POINT: ; $EECB
    VEJ  (D0) \ ABYT($0A) \ ABRF($EF19) ; ***
    SJP  (MATRIX_A2XREG)
    CPI  XH,$76
    BCS BCMD_POINT_1 ; $EEE2
    LIN  X
    ANI  A,$0F
    STA  UL
    LIN  X
    ANI  A,$0F
    AEX

BCMD_POINT_3: ; $EEE2
    REC
    ADC  UL
    JMP  BCMD_LEN_1 ; $D9E4

BCMD_POINT_1: ; $EEE2
    LIN  X
    ANI  A,$F0
    AEX
    STA  UL
    LIN  X
    ANI  A,$F0
    BCH BCMD_POINT_3 ; $EEDD

BCMD_POINT_2: ; $EEEC
    SHR
    BCR CURSOR_OFF_1 ; $EF04
    PSH  Y
    SJP  (USING2STK)
    JMP  BCMD_PAUSE_25 ; $E6A9

BCMD_POINT_4: ; $EEF7
    ANI  (CURSOR_ENA),$7F
    SJP  (STK2USING)
    POP  Y



; (84) $EF00 Turns off the blinking cursor.
CURSOR_OFF: ;
    ANI  (CURSOR_BLNK),$FC

CURSOR_OFF_1: ; $EF04
    RTN



; $EF05 Saves USING parameters on processor stack ($7895-$7897) and deletes USING parameters.
USING2STK: ; 
    LDI  XH,$78
    LDI  XL,$95
    POP  Y
    LDI  UL,$02

USING2STK_1: ; $EF0D
    LIN  X
    PSH  A
    LOP  UL,USING2STK_1 ; $EF0D
    DEC  X
    LDI  A,$00
    SDE  X
    SDE  X
    STA  (X)

USING2STK_2: ; $EF18
    PSH  Y
    RTN



; Convert AR-X to string
ARX2STRNG: ; $EF1B
    SJP  (USING2STK)
    LDI  A,$01
    VMJ  ($96) ; ($96)($4B)
    STA  UL
    LDA  (X)
    CPI  A,$20
    BZR ARX2STRNG_1 ; $EF2A
    DEC  UL
    INC  X

ARX2STRNG_1: ; $EF2A
    LDA  UL
    VMJ  ($24)
    ANI  (CURSOR_ENA),$7F
    SJP  (STK2USING)
    RTN



; $EF35 Gets USING parameters from stack
STK2USING: ; 
    LDI  XH,$78
    LDI  XL,$97
    POP  Y
    LDI  UL,$02

STK2USING_1: ; $EF3D
    POP  A
    SDE  X
    LOP  UL,STK2USING_1 ; $EF3D
    BCH USING2STK_2 ; $EF18



; $EF44 Outputs text on LCD display
TXT2LCD: ; 
    PSH  X
    LDI  A,$00
    LDI  UL,$19
    BII  (X),$FF
    BZS TXT2LCD_1 ; $EF52
    INC  A
    INC  X
    LOP  UL,$EF4A

TXT2LCD_1: ; $EF52
    STA  XL
    VEJ  (F2)
    POP  U
    SJP  (TEXTUREG_XL)
    BCH CURSOR_OFF


; Text output on LCD from (AR-Y)
TXT2LCD_ARY: ; $EF5B
    REC
    LDI  A,$F0
    ADC  XL
    LDI  UH,$7A
    LDI  UL,$10
    PSH  U
    BCH TXT2LCD_1 ; $EF52



; $EF67 Prepare the LCD output
PREPLCDOUT:
    ORI  (BREAKPARAM),$10
    BII  (CURSOR_ENA),$01
    BZR PREPLCDOUT_1 ; $EF72
    VEJ  (F2)

PREPLCDOUT_1: ; $EF72
    ANI  (CHARPOS_LCD),$00
    SJP  (LCDCHRLEFT)
    BCS PREPLCDOUT_2 ; $EF80
    EAI  $FF
    STA  ($7877)

PREPLCDOUT_2: ; $EF80
    RTN



;------------------------------------------------------------------------------
; Clears output buffer
;            Address: EF81
;          Parameter: None
; 
; Modified Registers: X-Reg, U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
OUTBUFCLR: ; $EF81
    LDI  XH,$7B
    LDI  XL,$60
    LDI  UL,$4F
    VMJ  ($BA) ; ($BA)($5D)
    RTN

OUTBUFCLR_8: ; $EF8A
    LDI  YL,$07
    LDI  A,$06
    JMP  BCMD_SIN_1 ; $F3BA

OUTBUFCLR_7: ; $EF91
    JMP  ARX2BCD_ABS ; $F65D

OUTBUFCLR_1: ; $EF94
    CPI  YL,$2B
    BZS OUTBUFCLR_4 ; $EF9C
    ADI  (ARY + $01),$80

OUTBUFCLR_4: ; $EF9C
    VEJ  (F0)

OUTBUFCLR_6: ; $EF9D
    BCS $EFA2
    JMP  DEC2HEX_113 ; $D8F0
    JMP  DEC2HEX_91 ; $D8F2

OUTBUFCLR_2: ; $EFA5
    CPI  YL,$2A
    BZR OUTBUFCLR_5 ; $EFAD
    VMJ  ($7E) ; ($7E)($3F)
    BCH OUTBUFCLR_6 ; $EF9D

OUTBUFCLR_5: ; $EFAD
    VMJ  ($58) ; ($58)($2C)
    BCH OUTBUFCLR_6 ; $EF9D

OUTBUFCLR_3: ; $EFB1
    SJP  ($F89C)
    BCH OUTBUFCLR_6 ; $EF9D



; $EFB6 Subtraction: AR-X = ARX – AR-Y
SUBTR: ; 
    ADI  (ARY + $01),$80



; (F0) $EFBA Addition: AR-X = AR-X + AR-Y
ADDIT: ; 
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$02
    LDI  YL,$12
    LDE  X
    BZS ADDIT_1 ; $EFF6
    LDE  Y
    BZS MULTIPLY_1 ; $F065
    VMJ  ($7C) ; ($7C)($3E)
    LDA  (X)
    SEC
    SBC  (Y)
    BZS ADDIT_2 ; $EFE5
    BVS ADDIT_3 ; $EFFA
    ROL

ADDIT_6: ; $EFD0
    BCR ADDIT_4 ; $EFFE
    ROR
    EAI  $FF
    INC  A
    PSH  A
    LDA  (Y)
    STA  (X)
    POP  A
    LDI  XL,$07

ADDIT_7: ; $EFDE
    CPI  A,$0C
    BCS ADDIT_5 ; $F003
    SJP  (ADD_ARU_ARX_2) ; $F7F7

ADDIT_2: ; $EFE5
    POP  A
    PSH  A
    SHL
    BCS PC1500_PRT_A_DIR
    VEJ  (EE)

ADDIT_8: ; $EFED
    POP  A

ADDIT_9: ; $EFEF
    STA  UH
    POP  A
    REC
    ADC  UH
    BCH MULTIPLY_2 ; $F057

ADDIT_1: ; $EFF6
    VMJ  ($56) ; ($56)($2B)
    BCH OUTBUFCLR_7 ; $EF91

ADDIT_3: ; $EFFA
    LDI  A,$1F
    BCH ADDIT_6 ; $EFD0

ADDIT_4: ; $EFFE
    ROR
    LDI  XL,$17
    BCH ADDIT_7 ; $EFDE

ADDIT_5: ; $F003
    LDA  XL
    ANI  A,$F9
    STA  XL
    SJP  (CLR_7_XREG)
    BCH ADDIT_2 ; $EFE5
    VMJ  ($7A) ; ($7A)($3D)
    BCS ADDIT_8 ; $EFED
    SJP  (ADD_ARU_ARX_3) ; $F7EB
    POP  A
    EAI  $80
    BCH ADDIT_9 ; $EFEF



; ; $F019 AR-X = AR-X * AR-X
SQUARE: 
    VEJ  (E6)



; $F01A (7E) Multiplication: AR-X = AR-X* AR-Y
MULTIPLY: ;
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$01
    LDI  YL,$11
    VMJ  ($7C) ; ($7C)($3E)
    LDA  (Y)
    REC
    ADC  (X)
    BVS MULTIPLY_3 ; $F05A
    STA  (X)
    VMJ  ($78) ; ($78)($3C)
    VMJ  ($76) ; ($76)($3B)
    SJP  (ADD_ARU_ARX_4) ; $F820
    LDI  YL,$0F

MULTIPLY_5: ; $F031
    PSH  Y
    LDA  (Y)
    PSH  A
    ANI  A,$0F
    AEX
    SJP  (ADDMANY)
    VMJ  ($74) ; ($74)($3A)
    POP  A
    ANI  A,$F0
    SJP  (ADDMANY)
    POP  Y
    DEC  Y
    CPI  YL,$0A
    BCR DIVISION_11 ; $F050
    VMJ  ($74) ; ($74)($3A)
    BCH MULTIPLY_5 ; $F031

DIVISION_11: ; $F050
    POP  U
    LDA  UL
    STA  (ARY + $01)
    LDA  UH

MULTIPLY_2: ; $F057
    VMJ  ($52) ; ($52)($29
    RTN

MULTIPLY_3: ; $F05A
    POP  U
    BCS MULTIPLY_6 ; $F062
    LDI  UH,$25
    SEC
    RTN

MULTIPLY_6: ; $F062
    VEJ  (EC)

MULTIPLY_7: ; $F063
    LDI  UH,$00

MULTIPLY_1: ; $F065
    REC
    RTN


; $F067 Adds the mantissas of those AR to the AR-X that are preselected by 
; the value in the accumulator. If bit# is set 7:AR-W, 6:AR-V, 5:AR-U,
; 4:AR-Y, 3:AR-Z are added.
ADDMANY: ; 
    STA  UH
    LDI  A,$2F

ADDMANY_2: ; $F06A
    PSH  A
    STA  YL
    LDA  UH
    SHL
    STA  UH
    BCR ADDMANY_1 ; $F07B
    VMJ  ($72) ; ($72)($39)

ADDMANY_3: ; $F074
    REC
    POP  A
    ADI  A,$F8
    BCH ADDMANY_2 ; $F06A

ADDMANY_1: ; $F07B
    BZR ADDMANY_3 ; $F074
    POP  A
    RTN



; (6E) $F080 Reciprocal of AR-X AR-X=1/AR-X (if error C=1).
RECIPRICAL: ; 
    VMJ  ($6A) ; ($6A)($35)
    VMJ  ($66) ; ($66)($33)



; (58) $F084 Division: AR-X = AR-X / AR- Y
DIVISION: ; 
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$01
    LDI  YL,$11
    VMJ  ($7C) ; ($7C)($3E)
    BII  (ARY + $02),$F0
    BZS DIVISION_1 ; $F0E3
    REC
    LDA  (X)
    SBC  (Y)
    BVS MULTIPLY_3 ; $F05A
    STA  (X)
    SJP  (CLR_SM_ARZ)
    SJP  (ADD_ARU_ARX_5) ; $F81C
    LDI  A,$0C
    PSH  A

DIVISION_6: ; $F0A2
    SJP  (ADD_ARU_ARX_6) ; $F7D9
    BCS DIVISION_2 ; $F0BD

DIVISION_8: ; $F0A7
    SJP  (ADD_ARU_ARX)
    BCS DIVISION_3 ; $F0CE
    VEJ  (EE)
    BCS DIVISION_4 ; $F0D8

DIVISION_10: ; $F0AF
    VEJ  (EE)

DIVISION_12: ; $F0B0
    POP  A
    DEC  A
    BCR DIVISION_5 ; $F0DE
    PSH  A
    VEJ  (EA)
    SJP  (ARZ_SHL_4BITS)
    BCH DIVISION_6 ; $F0A2

DIVISION_2: ; $F0BD
    SJP  (ADD_ARU_ARX_6) ; $F7D9
    BCS DIVISION_7 ; $F0C8
    ORI  (ARZ + $07),$04
    BCH DIVISION_8 ; $F0A7

DIVISION_7: ; $F0C8
    ORI  (ARZ + $07),$08
    BCH DIVISION_9 ; $F0D2

DIVISION_3: ; $F0CE
    ORI  (ARZ + $07),$02

DIVISION_9: ; $F0D2
    VMJ  ($7A) ; ($7A)($3D)
    BCS DIVISION_4 ; $F0D8
    BCH DIVISION_10 ; $F0AF

DIVISION_4: ; $F0D8
    ORI  (ARZ + $07),$01
    BCH DIVISION_12 ; $F0B0

DIVISION_5: ; $F0DE
    SJP  (XFER_SM_ARZ2ARX)
    BCH DIVISION_11 ; $F050

DIVISION_1: ; $F0E3
    POP  X
    LDI  UH,$26
    SEC
    RTN



; $F0E9 AR-X = SQR (AR-X)
SQR_ROOT: ; 
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$01
    LDE  X
    SHL
    BCS SQR_ROOT_1 ; $F15D
    LDA  (X)
    BII  A,$80
    BZS SQR_ROOT_2 ; $F0F7
    SEC

SQR_ROOT_2: ; $F0F7
    ROR
    STA  (X)
    BCR SQR_ROOT_3 ; $F0FC
    VEJ  (EA)

SQR_ROOT_3: ; $F0FC
    VMJ  ($70) ; ($70)($38)
    SJP  (CLR_SM_ARZ)
    LDI  A,$24
    ORI  (ARY + $02),$10
    BCH SQR_ROOT_4 ; $F12F

SQR_ROOT_9: ; $F109
    VEJ  (EE)
    POP  Y
    LDX  Y
    LDA  XL
    REC
    ADI  A,$F8
    STA  XL
    POP  A
    CPI  A,$0F
    LDA  UH
    BCR SQR_ROOT_5 ; $F120
    AEX
    STA  (X)
    ADI  (Y),$F1
    BCH SQR_ROOT_6 ; $F12B

SQR_ROOT_5: ; $F120
    ORA  (X)
    STA  (X)
    CPI  YL,$17
    BCS SQR_ROOT_7 ; $F156
    ADI  (Y),$FF
    INC  Y
    ORI  (Y),$10

SQR_ROOT_6: ; $F12B
    VEJ  (EA)
    POP  A
    INC  A

SQR_ROOT_4: ; $F12F
    PSH  A
    SHR
    STA  YL
    LDI  A,$20
    BCR SQR_ROOT_8 ; $F139
    LDI  A,$02

SQR_ROOT_8: ; $F139
    LDI  UH,$00
    PSH  A
    PSH  Y

SQR_ROOT_11: ; $F13F
    VMJ  ($7A) ; ($7A)($3D)
    BCR SQR_ROOT_9 ; $F109
    POP  Y
    POP  A
    PSH  A
    PSH  Y
    REC

SQR_ROOT_10: ; $F14C
    DCA  (Y)
    SDE  Y
    LDI  A,$00
    BCS SQR_ROOT_10 ; $F14C
    INC  UH
    BCH SQR_ROOT_11 ; $F13F

SQR_ROOT_7: ; $F156
    SJP  (XFER_SM_ARZ2ARX)
    POP  A
    VEJ  (E8)
    RTN

SQR_ROOT_1: ; $F15D
    LDI  UH,$27
    BCH BCMD_LOG_2 ; $F1C0



; Basic command LN
BCMD_LN: ; $F161
    LDI  A,$02
    BCH BCMD_LOG_3 ; $F167



; Basic command LOG
BCMD_LOG: ; $F165
    LDI  A,$00

BCMD_LOG_3: ; $F167
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$02
    LDI  XL,$02
    BII  (X),$F0
    BZS SQR_ROOT_1 ; $F15D
    DEC  X
    BII  (X),$FF
    BZR SQR_ROOT_1 ; $F15D
    DEC  X
    BII  (X),$80
    BZR BCMD_LOG_4 ; $F1C2
    PSH  A

BCMD_LOG_8: ; $F17D
    LDA  (X)
    PSH  A

BCMD_LOG_1: ; $F180
    ANI  (X),$00
    ADI  (ARX + $02),$F0
    VEJ  (E8)
    LDA  (ARX)
    EAI  $FF
    INC  A
    STA  UH
    LDI  A,$01
    STA  (ARU)
    JMP  EXPONENT_1 ; $F2EC

BCMD_LOG_9: ; $F196
    ADI  (ARX),$FF
    VEJ  (E8)
    VEJ  (E6)
    POP  A
    STA  UL
    LDI  A,$00
    STA  UH
    BCS BCMD_LOG_5 ; $F1A8
    VMJ  ($10) \ ABYT($00)
    VEJ  (F0)

BCMD_LOG_5: ; $F1A8
    POP  A
    BCS BCMD_LOG_6 ; $F1BE
    SHR
    BCR BCMD_LOG_7 ; $F1B3
    ORI  (ARX + $01),$80

BCMD_LOG_7: ; $F1B3
    SHR
    BCR EXPONENT_2 ; $F230
    SJP  (ADD_ARU_ARX_7) ; $F87B
    VMJ  ($58) ; ($58)($2C)
    BCS BCMD_LOG_6 ; $F1BE
    RTN

BCMD_LOG_6: ; $F1BE
    LDI  UH,$25

BCMD_LOG_2: ; $F1C0
    SEC
    RTN

BCMD_LOG_4: ; $F1C2
    INC  A
    PSH  A
    VMJ  ($6E) ; ($6E)($37)
    LDI  XL,$00
    BCH BCMD_LOG_8 ; $F17D



; Basic command EXP
BCMD_EXP: ; $F1CB
    VMJ  ($54) ; ($54)($2A)
    SJP  (ADD_ARU_ARX_7) ; $F87B
    VMJ  ($7E) ; ($7E)($3F)
    BCS BCMD_LOG_6 ; $F1BE



; $F1D4 AR-X = 10 to the power of AR-X
EXPONENT: ; 
    VMJ  ($54) ; ($54)($2A)
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    DEC  X
    LDA  (X)
    BZS EXPONENT_3 ; $F226
    BII  A,$80
    BZR EXPONENT_4 ; $F222
    CPI  A,$01
    BZR EXPONENT_5 ; $F229
    LDI  XL,$01
    LDI  UL,$05

EXPONENT_6: ; $F1EA
    INC  X
    LDE  X
    SIN  X
    LOP  UL,EXPONENT_6 ; $F1EA
    ANI  (X),$00

EXPONENT_11: ; $F1F1
    LDI  A,$00

EXPONENT_10: ; $F1F3
    STA  UH
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    LDI  A,$01
    STA  (ARU)
    BCH EXPONENT_7 ; $F233

EXPONENT_26: ; $F1FF
    POP  A
    LDI  XL,$02
    SDE  X
    LDA  XL
    DEC  X
    STA  (X)
    VEJ  (E8)
    VEJ  (D0) \ ABYT($08) \ ABRF(EXPONENT_8) ; $F220
    LDI  XH,$7A
    LDA  UL
    STA  (ARX)
    SJP  (XFER_SM_ARY2ARX)
    VMJ  ($74) ; ($74)($3A)
    POP  A

EXPONENT_12: ; $F218
    SHL
    BCR EXPONENT_9 ; $F21F
    VMJ  ($6E) ; ($6E)($37)
    BCS BCMD_LOG_6 ; $F1BE

EXPONENT_9: ; $F21F
    RTN

EXPONENT_8: ; $F220
    BCH BCMD_LOG_6 ; $F1BE

EXPONENT_4: ; $F222
    EAI  $FF
    BCH EXPONENT_10 ; $F1F3

EXPONENT_3: ; $F226
    VEJ  (EA)
    BCH EXPONENT_11 ; $F1F1

EXPONENT_5: ; $F229
    VEJ  (EC)
    POP  A
    EAI  $80
    BCH EXPONENT_12 ; $F218

EXPONENT_2: ; $F230
    JMP  MULTIPLY_7 ; $F063

EXPONENT_7: ; $F233
    SJP  (CLR_SM_ARW)
    VMJ  ($70) ; ($70)($38)
    LDI  A,$00
    PSH  A

EXPONENT_18: ; $F23C
    LDA  UH
    BII  (ARU),$01
    BZS EXPONENT_13 ; $F24B
    CPI  A,$0D
    BCR EXPONENT_14 ; $F254
    LDI  A,$0C
    BCH EXPONENT_14 ; $F254

EXPONENT_13: ; $F24B
    REC
    ADI  A,$0D
    CPI  A,$14
    BCR EXPONENT_14 ; $F254
    LDI  A,$13

EXPONENT_14: ; $F254
    SHL
    SHL
    SHL
    ORI  A,$07
    PSH  A
    LDI  YH,$FC

EXPONENT_16: ; $F25D
    POP  A
    PSH  A
    STA  YL
    SJP  (ADD_ARU_ARX_8) ; $F7DF
    BCR EXPONENT_15 ; $F26D
    ADI  (ARW + $07),$01
    BCH EXPONENT_16 ; $F25D

EXPONENT_15: ; $F26D
    POP  A
    STA  YL
    VMJ  ($72) ; ($72)($39)
    POP  A
    CPI  A,$0C
    BCS EXPONENT_17 ; $F283
    INC  A
    PSH  A
    INC  UH
    SJP  (ARW_SHL_4BITS)
    VEJ  (EA)
    BCH EXPONENT_18 ; $F23C

EXPONENT_17: ; $F283
    LDI  YH,$7A
    PSH  A
    VMJ  ($76) ; ($76)($3B)
    VMJ  ($70) ; ($70)($38)
    ORI  (ARY + $01),$01

EXPONENT_25: ; $F28F
    LDA  UH
    CPI  A,$07
    BII  (ARU),$01
    BZS EXPONENT_19 ; $F29A
    CPI  A,$0D

EXPONENT_19: ; $F29A
    BCR EXPONENT_20 ; $F29E
    LDI  A,$FF

EXPONENT_20: ; $F29E
    INC  A
    STA  (ARZ)

EXPONENT_23: ; $F2A2
    LDI  XL,$2F
    BII  (X),$0F
    BZS EXPONENT_21 ; $F2CF
    ADI  (X),$FF
    BII  (ARU),$01
    BZS EXPONENT_22 ; $F2B8
    SJP  (XFER_SM_ARY2ARZ)
    SJP  (ADD_ARU_ARX_9) ; $F83C
    BCH EXPONENT_23 ; $F2A2

EXPONENT_22: ; $F2B8
    VMJ  ($78) ; ($78)($3C)
    VEJ  (EE)
    LDA  (ARZ)
    BZS EXPONENT_23 ; $F2A2
    DEC  A
    LDI  XL,$0F
    SJP  (ADD_ARU_ARX_10) ; $F805
    LDI  XL,$17
    LDI  YL,$0F
    SJP  (ADD_ARU_ARX_11) ; $F7E1
    BCH EXPONENT_23 ; $F2A2

EXPONENT_21: ; $F2CF
    POP  A
    DEC  A
    BCR EXPONENT_24 ; $F2E3
    DEC  UH
    PSH  A
    SJP  (ARW_SHR_4BITS)
    BII  (ARU),$01
    VZS  ($74) ; ($74)($3A)
    BCH EXPONENT_25 ; $F28F

EXPONENT_24: ; $F2E3
    BII  (ARU),$01
    BZR EXPONENT_26 ; $F1FF
    JMP  BCMD_SIN_2 ; $F432

EXPONENT_1: ; $F2EC
    SJP  (CLR_SM_ARW)
    VMJ  ($6A) ; ($6A)($35)
    LDI  A,$00
    PSH  A

EXPONENT_35: ; $F2F5
    LDA  UH
    CPI  A,$07
    BII  (ARU),$01
    BZS EXPONENT_27 ; $F300
    CPI  A,$0D

EXPONENT_27: ; $F300
    BCR EXPONENT_28 ; $F304
    LDI  A,$FF

EXPONENT_28: ; $F304
    INC  A
    STA  (ARZ)
    BII  (ARU),$01
    BZS EXPONENT_29 ; $F313
    BCH EXPONENT_30 ; $F326

EXPONENT_32: ; $F310
    SJP  (ADD_ARU_ARX_12) ; $F84D

EXPONENT_29: ; $F313
    VMJ  ($78) ; ($78)($3C)

EXPONENT_33: ; $F315
    VMJ  ($7A) ; ($7A)($3D)
    BCR EXPONENT_31 ; $F32B
    ADI  (ARW + $07),$01
    BII  (ARU),$01
    BZS EXPONENT_32 ; $F310
    SJP  (ADD_ARU_ARX_9) ; $F83C

EXPONENT_30: ; $F326
    SJP  (XFER_SM_ARY2ARZ)
    BCH EXPONENT_33 ; $F315

EXPONENT_31: ; $F32B
    VEJ  (EE)
    POP  A
    CPI  A,$0C
    BCS EXPONENT_34 ; $F33D
    INC  A
    PSH  A
    INC  UH
    SJP  (ARW_SHL_4BITS)
    VEJ  (EA)
    BCH EXPONENT_35 ; $F2F5

EXPONENT_34: ; $F33D
    PSH  A
    VMJ  ($76) ; ($76)($3B)

EXPONENT_41: ; $F341
    LDA  UH
    BII  (ARU),$01
    BZS EXPONENT_36 ; $F350
    CPI  A,$0D
    BCR EXPONENT_37 ; $F359
    LDI  A,$0C
    BCH EXPONENT_37 ; $F359

EXPONENT_36: ; $F350
    REC
    ADI  A,$0D
    CPI  A,$14
    BCR EXPONENT_37 ; $F359
    LDI  A,$13

EXPONENT_37: ; $F359
    SHL
    SHL
    SHL
    ORI  A,$07
    PSH  A
    LDI  YH,$FC

EXPONENT_39: ; $F362
    LDI  XL,$2F
    POP  A
    BII  (X),$0F
    BZS EXPONENT_38 ; $F373
    ADI  (X),$FF
    PSH  A
    STA  YL
    VMJ  ($72) ; ($72)($39)
    BCH EXPONENT_39 ; $F362

EXPONENT_38: ; $F373
    POP  A
    DEC  A
    BCR EXPONENT_40 ; $F383
    PSH  A
    DEC  UH
    SJP  (ARW_SHR_4BITS)
    VMJ  ($74) ; ($74)($3A)
    BCH EXPONENT_41 ; $F341

EXPONENT_40: ; $F383
    LDI  YH,$7A
    BII  (ARU),$01
    BZS EXPONENT_42 ; $F38E
    JMP  BCMD_LOG_9 ; $F196

EXPONENT_42: ; $F38E
    JMP  BCMD_ASN_1 ; $F4F7



; Basic command COS
BCMD_COS: ; $F391
    ANI  (ARX + $01),$00
    LDI  A,$00
    STA  (ARU)
    LDI  A,$01
    BCH BCMD_SIN_3 ; $F3A9



; Basic command TAN
BCMD_TAN: ; $F39E
    LDI  A,$40
    BCH BCMD_SIN_4 ; $F3A4



; Basic command SIN
BCMD_SIN: ; $F3A2
    LDI  A,$00

BCMD_SIN_4: ; $F3A4
    STA  (ARU)
    LDI  A,$00

BCMD_SIN_3: ; $F3A9
    STA  (ARV)
    VMJ  ($54) ; ($54)($2A)
    SJP  (ADD_ARU_ARX_13) ; $F85A
    BCR BCMD_SIN_5 ; $F3C9
    VMJ  ($7E) ; ($7E)($3F)
    BCS BCMD_SIN_6 ; $F48E
    JMP  OUTBUFCLR_8 ; $EF8A

BCMD_SIN_1: ; $F3BA
    DCA  (Y)
    SDE  Y
    LDI  A,$00
    BCS BCMD_SIN_1 ; $F3BA
    ANI  (ARX + $07),$F0
    SJP  (ARX2BCD_ABS)
    BCS BCMD_SIN_6 ; $F48E

BCMD_SIN_5: ; $F3C9
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    DEC  X
    LDA  (X)
    BII  A,$80
    BZR BCMD_SIN_7 ; $F429
    CPI  A,$0A
    BCS BCMD_SIN_8 ; $F48C
    VMJ  ($70) ; ($70)($38)
    ORI  (ARY + $01),$36
    VMJ  ($74) ; ($74)($3A)
    SJP  (ARY_SHR_4BITS)

BCMD_SIN_9: ; $F3E2
    INC  UH

BCMD_SIN_12: ; $F3E4
    VMJ  ($7A) ; ($7A)($3D)
    BCS BCMD_SIN_9 ; $F3E2
    VEJ  (EE)
    BII  (ARY + $01),$0F
    BZS BCMD_SIN_10 ; $F402
    ADI  (ARX),$FF
    BCR BCMD_SIN_11 ; $F3F8
    VEJ  (EA)
    BCH BCMD_SIN_9 ; $F3E2

BCMD_SIN_11: ; $F3F8
    VMJ  ($70) ; ($70)($38)
    ORI  (ARY + $02),$90
    LDI  UH,$00
    BCH BCMD_SIN_12 ; $F3E4

BCMD_SIN_10: ; $F402
    VEJ  (EA)
    ANI  (ARX),$00
    LDA  UH
    LDI  XL,$20
    REC
    ADC  (X)
    STA  (X)
    AEX
    ORA  (X)
    STA  (X)
    VMJ  ($70) ; ($70)($38)
    LDI  XL,$11
    LDI  A,$04
    SIN  X
    ORI  (X),$50
    VMJ  ($7A) ; ($7A)($3D)
    BCR BCMD_SIN_13 ; $F424
    SJP  (ADD_ARU_ARX_3) ; $F7EB
    ADI  (ARV),$01

BCMD_SIN_13: ; $F424
    VEJ  (EE)
    VEJ  (E8)
    LDI  XL,$00
    LDA  (X)

BCMD_SIN_7: ; $F429
    DEC  A
    STA  (X)
    EAI  $FF
    INC  A
    STA  UH
    JMP  EXPONENT_7 ; $F233

BCMD_SIN_2: ; $F432
    ANI  (ARY),$00
    VEJ  (E8)
    VMJ  ($66) ; ($66)($33)
    VEJ  (E8)
    VMJ  ($66) ; ($66)($33)
    VMJ  ($58) ; ($58)($2C)
    POP  A
    STA  (ARX + $01)
    BII  (ARU),$40
    BZR BCMD_SIN_14 ; $F480
    VMJ  ($80) ; ($80)($40)
    SJP  (SQUARE)
    BCS BCMD_ASN_2 ; $F52E
    VMJ  ($6A) ; ($6A)($35)
    VEJ  (F0)
    BCS BCMD_ASN_2 ; $F52E
    SJP  (SQR_ROOT)
    BCS BCMD_ASN_2 ; $F52E
    VMJ  ($68) ; ($68)($34)
    VMJ  ($7C) ; ($7C)($3E)
    BII  (ARV),$01
    BZS $F466
    VMJ  ($6A) ; ($6A)($35)
    VMJ  ($66) ; ($66)($33)
    VMJ  ($58) ; ($58)($2C)
    POP  A
    STA  (ARX + $01)
    POP  A
    BII  (ARV),$20

BCMD_SIN_16: ; $F475
    BCS BCMD_ASN_2 ; $F52E
    BZS BCMD_SIN_15 ; $F47D
    ADI  (ARX + $01),$80

BCMD_SIN_15: ; $F47D
    JMP  ARX2BCD_ABS ; $F65D

BCMD_SIN_14: ; $F480
    BII  (ARV),$01
    VZR  ($6E) ; ($6E)($37)
    BII  (ARV),$10
    BCH BCMD_SIN_16 ; $F475

BCMD_SIN_8: ; $F48C
    POP  A

BCMD_SIN_6: ; $F48E
    LDI  UH,$27
    SEC
    RTN



; Basic command ACS
BCMD_ACS: ; $F492
    LDI  A,$20
    BCH BCMD_ASN_3 ; $F49C



; Basic command ATN
BCMD_ATN: ; $F496
    LDI  A,$40
    BCH BCMD_ASN_3 ; $F49C



; Basic command ASN
BCMD_ASN: ; $F49A
    LDI  A,$00

BCMD_ASN_3: ; $F49C
    STA  (ARU)
    VMJ  ($54) ; ($54)($2A)
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    BII  (ARU),$40
    BZR BCMD_ASN_4 ; $F4D2
    VMJ  ($80) ; ($80)($40)
    SJP  (SQUARE)
    BCS BCMD_SIN_8 ; $F48C
    VMJ  ($6A) ; ($6A)($35)
    ADI  (ARX + $01),$80
    VEJ  (F0)
    BCS BCMD_SIN_8 ; $F48C
    SJP  (SQR_ROOT)
    BCS BCMD_SIN_8 ; $F48C
    VMJ  ($68) ; ($68)($34)
    BII  (ARU),$20
    BZR BCMD_ASN_5 ; $F4CA
    VMJ  ($66) ; ($66)($33)

BCMD_ASN_5: ; $F4CA
    BII  (ARY + $02),$F0
    BZS BCMD_ASN_6 ; $F4F0
    VMJ  ($58) ; ($58)($2C)

BCMD_ASN_4: ; $F4D2
    BII  (ARX + $02),$F0
    BZS BCMD_ASN_7 ; $F50E
    BII  (ARX),$80
    BZR BCMD_ASN_8 ; $F4E4
    VMJ  ($6E) ; ($6E)($37)
    ADI  (ARU),$80

BCMD_ASN_8: ; $F4E4
    BCS BCMD_SIN_8 ; $F48C
    LDA  (ARX)
    EAI  $FF
    INC  A
    STA  UH
    JMP EXPONENT_1 ; $F2EC

BCMD_ASN_6: ; $F4F0
    SJP  (ADD_ARU_ARX_14) ; $F883
    VMJ  ($56) ; ($56)($2B)
    BCH BCMD_ASN_7 ; $F50E

BCMD_ASN_1: ; $F4F7
    ADI  (ARX),$01
    VEJ  (E8)
    BCS BCMD_ASN_9 ; $F52C
    BII  (ARU),$80
    BZS BCMD_ASN_7 ; $F50E
    SJP  (ADD_ARU_ARX_14) ; $F883
    ADI  (ARX + $01),$80
    VEJ  (F0)
    BCS BCMD_ASN_9 ; $F52C

BCMD_ASN_7: ; $F50E
    POP  A
    STA  (ARX + $01)
    SHL
    BCR BCMD_ASN_10 ; $F522
    BII  (ARU),$20
    BZS BCMD_ASN_10 ; $F522
    SJP  (ADD_ARU_ARX_15) ; $F887
    VEJ  (F0)
    BCS BCMD_ASN_2 ; $F52E

BCMD_ASN_10: ; $F522
    SJP  (ADD_ARU_ARX_13) ; $F85A
    BCR BCMD_PI_1 ; $F5BC
    VMJ  ($58) ; ($58)($2C)
    BCS BCMD_ASN_2 ; $F52E
    RTN

BCMD_ASN_9: ; $F52C
    POP  A

BCMD_ASN_2: ; $F52E
    JMP  ARX2BCD2_1 ; $F698



; Basic command DEG
BCMD_DEG: ; $F531
    VMJ  ($54) ; ($54)($2A)
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    SJP  (ARX2BCD2_2) ; $F6A9
    VMJ  ($64) ; ($64)($32)
    VMJ  ($56) ; ($56)($2B)
    VEJ  (E8)
    VMJ  ($62) ; ($62)($31)
    VMJ  ($58) ; ($58)($2C)
    BCS BCMD_ASN_9 ; $F52C
    VMJ  ($64) ; ($64)($32)
    VEJ  (E8)
    VMJ  ($60) ; ($60)($30)
    VMJ  ($64) ; ($64)($32)
    VMJ  ($66) ; ($66)($33)
    VEJ  (E8)
    VEJ  (F0)
    BCS BCMD_ASN_9 ; $F52C
    VMJ  ($62) ; ($62)($31)
    VMJ  ($58) ; ($58)($2C)
    BCS BCMD_ASN_9 ; $F52C
    VEJ  (E6)
    VMJ  ($64) ; ($64)($32)
    VEJ  (E8)
    VEJ  (F0)
    BCS BCMD_ASN_9 ; $F52C
    POP  A
    JMP  ARX2BCD2 ; $F663


; Basic command DMS
BCMD_DMS: ; $F564
    VMJ  ($54) ; ($54)($2A)
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    VMJ  ($60) ; ($60)($30)
    VMJ  ($64) ; ($64)($32)
    VMJ  ($56) ; ($56)($2B)
    VEJ  (E8)
    VMJ  ($62) ; ($62)($31)
    VMJ  ($7E) ; ($7E)($3F)
    VEJ  (E6)
    VMJ  ($64) ; ($64)($32)
    VEJ  (E8)
    VEJ  (F0)
    SJP  (ARX2BCD2_2) ; $F6A9
    VMJ  ($80) ; ($80)($40)
    VMJ  ($56) ; ($56)($2B)
    VEJ  (E8)
    VMJ  ($62) ; ($62)($31)
    VMJ  ($7E) ; ($7E)($3F)
    SJP  (ARXX)
    VEJ  (E6)
    VMJ  ($64) ; ($64)($32)
    VEJ  (E8)
    VEJ  (F0)
    BCS BCMD_ASN_9 ; $F52C



BCMD_SGN: ; $F590 *** valid??
    POP  A
    VMJ  ($52) ; ($52)($29
    JMP  ARXX ; $F63C



; Basic command ABS
BCMD_ABS: ; $F597
    ANI  (ARX + $01),$00
    BCH BCMD_PI_1 ; $F5BC

; Basic command SGN
    LDI  XH,$7A
    LDI  XL,$01
    LIN  X
    STA  UH
    LDA  (X)
    PSH  A
    VEJ  (EC)
    POP  A
    BII  A,$F0
    BZS $F59B
    LDA  UH
    LDI  XL,$01
    SIN  X
    ORI  (X),$10
    BCH $F59B



; $F5B5 Basic command PI, Loads PI to AR-Y.
BCMD_PI: ; 
    VMJ  ($54) ; ($54)($2A)
    SJP  ($F875)
    VMJ  ($56) ; ($56)($2B)

BCMD_PI_1: ; $F5BC
    BCH ARX2BCD2_9 ; $F6A5



; Basic command INT
BCMD_INT: ; $F5BE
    VMJ  ($54) ; ($54)($2A)
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    VMJ  ($60) ; ($60)($30)
    POP  A
    BZS BCMD_INT_1 ; $F5D5
    LDI  XL,$11
    LDI  UL,$06

BCMD_INT_3: ; $F5CE
    LIN  X
    BZR BCMD_INT_2 ; $F5D8
    LOP  UL,BCMD_INT_3 ; $F5CE

BCMD_INT_4: ; $F5D3
    LDI  A,$80

BCMD_INT_1: ; $F5D5
    VMJ  ($52) ; ($52)($29
    RTN

BCMD_INT_2: ; $F5D8
    VMJ  ($6A) ; ($6A)($35)
    VEJ  (F0)
    BCH BCMD_INT_4 ; $F5D3


; Basic command RND
    VMJ  ($54) ; ($54)($2A)
    BII  (ARX + $01),$80
    BZR RANDGEN_1 ; $F5F5
    BII  (ARX),$80
    BZS RANDGEN_2 ; $F5FB



; $F5EB Determines random number in AR-X
RANDGEN: ; 
    VMJ  ($5E) ; ($5E)($2F)

RANDGEN_3: ; $F5ED
    VMJ  ($5C) ; ($5C)($2E)
    ORI  (ARX),$FF
    VEJ  (E8)
    RTN

RANDGEN_1: ; $F5F5
    ANI  (ARX + $01),$00
    BCH RANDGEN_3 ; $F5ED

RANDGEN_2: ; $F5FB
    BII  (ARX + $02),$F0
    BZS RANDGEN
    VMJ  ($80) ; ($80)($40)
    SJP  (RANDGEN)
    VMJ  ($68) ; ($68)($34)
    LDA  (ARY)
    CPI  A,$0A
    BCS RANDGEN_4 ; $F618
    VMJ  ($7E) ; ($7E)($3F)
    VMJ  ($60) ; ($60)($30)
    VEJ  (E8)
    VMJ  ($6A) ; ($6A)($35)
    VEJ  (F0)
    RTN

RANDGEN_4: ; $F618
    JMP  SQR_ROOT_1 ; $F15D


; $F618 Generates RANDOM number and updates RND pointer
    VMJ  ($82) ; ($82)($41)

; $F61B (5C) Generates RANDOM number and updates RND pointers.
    VEJ  (EE)
    VEJ  (EA)
    VEJ  (EE)
    VEJ  (EE)
    LDI  XL,$07
    LDI  YL,$17
    LDI  UL,$05
    SEC

RANDGEN_5: ; $F628
    LDE  Y
    DCA  (X)
    SDE  X
    LOP  UL,RANDGEN_5 ; $F628
    ANI  (ARX + $01),$00
    LDI  YH,$7B
    LDI  YL,$01
    LDI  XL,$01
    SJP  (XREG2YREG2) ; $F733
    LDI  YH,$7A


; $F63C Sets the 11th and 12th digit of the result to 00
; Sets Byte 7 in the AR-X to 00.
ARXX: ; 
    ANI  (ARX + $07),$00
    RTN



; Basic command RANDOM
BCMD_RANDOM: ; $F641
    PSH  Y
    VMJ  ($54) ; ($54)($2A)
    SJP  (CLR_SM_ARX)
    SJP  (TIME2ARX)
    LDA  (ARX + $06)
    ANI  A,$77
    ORI  A,$20
    STA  (ARY + $02)
    VMJ  ($5E) ; ($5E)($2F)
    VEJ  (EE)
    VMJ  ($5C) ; ($5C)($2E)
    POP  Y
    VEJ  (E2)


; $F65D Converts AR-X into BCD form (absolute value).
ARX2BCD_ABS: 
    VMJ  ($6C) ; ($6C)($36)
    BCH ARX2BCD2


; (E8) $F661 Converts AR-X to BCD form (absolute value) 
; Converts AR-X into BCD format, whereby the absolute value (positive number) is formed.  
    LDI  A,$00



; (52) $F663 Converts AR-X to BCD form
; Converts the result in the AR-X into the correct BCD format. With overflow 
; C=1. AR-X is set to 0 if below the permissible value range.
ARX2BCD2: ; $F663
    PSH  A
    LDI  XL,$01
    LDI  UL,$06

ARX2BCD2_4: ; $F669
    LIN  X
    BZR ARX2BCD2_3 ; $F670
    LOP  UL,ARX2BCD2_4 ; F669
    BCH ARX2BCD2_5 ; $F6A2

ARX2BCD2_3: ; $F670
    LDI  XL,$01
    LDE  X
    BZS ARX2BCD2_6 ; $F67B
    ADI  (X),$01
    VMJ  ($74) ; ($74)($3A)
    BCH ARX2BCD2_3 ; $F670

ARX2BCD2_6: ; $F67B
    BII  (ARX + $02),$F0
    BZR ARX2BCD2_7 ; $F688
    ADI  (ARX),$FF
    VEJ  (EA)
    BCH ARX2BCD2_6 ; $F67B

ARX2BCD2_7: ; $F688
    LDA  (ARX)
    BII  A,$80
    BZR ARX2BCD2_8 ; $F69C
    CPI  A,$64

ARX2BCD2_10: ; $F691
    POP  A
    STA  (ARX + $01)
    BCR ARX2BCD2_9 ; $F6A5

ARX2BCD2_1: ; $F698
    LDI  UH,$25
    SEC
    RTN

ARX2BCD2_8: ; $F69C
    EAI  $FF
    CPI  A,$63
    BCR ARX2BCD2_10 ; $F691

ARX2BCD2_5: ; $F698
    VEJ  (EC)
    POP  A

ARX2BCD2_9: ; $F6A5
    LDI  UH,$00
    REC
    RTN


; Limit result to 2 decimal places
ARX2BCD2_2: ; $F6A9
    SJP  (CLR_SM_ARX)
    LDI  XL,$00
    LDA  (X)
    REC
    ADI  A,$02
    BCH XFER_DEC_ARX2ARY_1 ; $F6BA



; $F6B4 TTransfers decimal places from AR-X to AR-Y, whereby their position 
; from AR-X is retained.
XFER_DEC_ARX2ARY: ; 
    SJP  (CLR_SM_ARX)
    LDI  XL,$00
    LDA  (X)

XFER_DEC_ARX2ARY_1: ; $F6BA
    BII  A,$80
    BZR XFER_DEC_ARX2ARY_2 ; $F6DB
    CPI  A,$0B
    BCS XFER_DEC_ARX2ARY_3 ; $F6DA
    ADI  A,$05

XFER_DEC_ARX2ARY_6: ; $F6C4
    SHR
    STA  XL
    ORI  A,$10
    STA  YL
    BCS XFER_DEC_ARX2ARY_4 ; $F6DF

XFER_DEC_ARX2ARY_5: ; $F6CB
    LDA  (X)
    ANI  (X),$00

XFER_DEC_ARX2ARY_7: ; $F6CE
    SIN  Y
    INC  XL
    CPI  XL,$08
    BCR XFER_DEC_ARX2ARY_5 ; $F6CB
    LDA  (ARX)
    STA  (ARY)

XFER_DEC_ARX2ARY_3: ; $F6DA
    RTN

XFER_DEC_ARX2ARY_2: ; $F6DB
    LDI  A,$04
    BCH XFER_DEC_ARX2ARY_6 ; $F6C4

XFER_DEC_ARX2ARY_4: ; $F6DF
    LDA  (X)
    ANI  (X),$F0
    ANI  A,$0F
    BCH XFER_DEC_ARX2ARY_7 ; $F6CE



; (7C) $F6E6 Determines the sign of the result and puts it on the stack
; Sign test. Put the result of a sign combination (AR-X and AR-Y) on the stack.
; Ditto for sign of AR-Y. For further calculations set AR to 00.
SIGN_TEST: ; 
    POP  U
    LDI  XL,$01
    LDI  YL,$11
    LDA  (Y)
    ANI  (Y),$00
    PSH  A
    EOR  (X)
    ANI  (X),$00
    PSH  A
    DEC  X
    DEC  Y
    PSH  U
    RTN



; (6C) $F6FB Loads signs from AR-X into Accumulator and clears signs from AR-X.
LDA_SGN_ARX: ; 
    LDI  XL,$01
    LDA  (X)
    ANI  (X),$00
    RTN



; $F701 Transfers AR-Y to AR-S
XFER_ARY2ARS:  ; 
    LDI  XL,$10
    LDI  YL,$30
    BCH XFER_ARY2ARX2_1 ; $F741



; $F707 (80) Transfers AR-X to AR-S
XFER_ARX2ARS:  ; 
    VMJ  ($54) ; ($54)($2A)
    LDI  YL,$30
    BCH XFER_ARX2ARY_1 ; $F711


; (E6) $F70D Transfers AR-X to AR-Y
XFER_ARX2ARY: ; 
    VMJ  ($54) ; ($54)($2A)
    LDI  YL,$10

XFER_ARX2ARY_1: ; $F711
    LDI  XL,$00
    BCH XFER_ARY2ARX2_1 ; $F741



; (68) $F715 Transfers AR-S to AR-Y
XFER_ARS2ARY: ; 
    LDI  XL,$30
    LDI  YL,$10
    BCH XFER_ARY2ARX2_1 ; $F741



; $F71B Transfers sign and mantissa from AR-Y to AR-X
XFER_SM_ARY2ARX: ;
    LDI  XL,$11
    BCH XFER_SM_ARZ2ARX_1 ; $F721



; Transfers sign and mantissa from AR-Z to AR-X
XFER_SM_ARZ2ARX: ; $F71F
    LDI  XL,$09

XFER_SM_ARZ2ARX_1: ; $F721
    LDI  YL,$01
    BCH XREG2YREG2 ; XFER_SM_ARX2ARZ 



; $F725 Transfers sign and mantissa from AR-Z to AR-X
XFER_SM_ARY2ARZ: ; 
    LDI  XL,$11
    BCH XFER_SM_ARX2ARZ_1 ; $F731



; (82) $F729 The sign and mantissa of the BCD value in AR-X are transferred to AR-Y.
XFER_SM_ARX2ARY: ; 
    LDI  XL,$01
    LDI  YL,$11
    BCH XREG2YREG2



; $F733 Block shift: 7 bytes from (X-Reg) to (Y-Reg)
; Save UL+1 bytes from X-Reg to Y-Reg.
XFER_SM_ARX2ARZ: ; 
    LDI  XL,$01

XFER_SM_ARX2ARZ_1: ; $F731
    LDI  YL,$09



; Transfers AR-S to AR-X
XREG2YREG2:
    LDI  UL,$06
    BCH XFER_ARY2ARX2_2 ; $F743

; $F737 Transfer AR-S to AR-X.
XFER_ARY2ARX:
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$30
    BCH XFER_ARY2ARX2_3 ; $F73F



; $F73D Transfers AR-S to AR-X
XFER_ARY2ARX2: ; 
    LDI  XL,$10

XFER_ARY2ARX2_3: ; $F73F
    LDI  YL,$00

XFER_ARY2ARX2_1: ; $F741
    LDI  UL,$07

XFER_ARY2ARX2_2: ; $F743
    TIN
    LOP  UL,XFER_ARY2ARX2_2 ; $F743
    RTN



;------------------------------------------------------------------------------
; Clear sign and mantissa of arithmetic registers
;             Address: AR-Y: F747 (70)
;                      AR-Z: F74B
;                      AR-W: F74F
;                      AR-X: F753 (76)
;          Parameter:	XH must contain 7A
;
; Modified Registers:	X-Reg, Accumulator
;   Error conditions:	None
;------------------------------------------------------------------------------
; (70) Clears the sign and mantissa of AR-Y
CLR_SM_ARY: ; $F747
    LDI  XL,$11
    BCH CLR_7_XREG

;  Clears the sign and mantissa of AR-Z
CLR_SM_ARZ: ; $F74B
    LDI  XL,$09
    BCH CLR_7_XREG

; Clears sign and mantissa of AR-W
CLR_SM_ARW: ; $F74F
    LDI  XL,$29
    BCH CLR_7_XREG

; (76) Clears arithmetic register AR-X
CLR_SM_ARX: ; $F753
    LDI  XL,$10
    BCH CLR_SM_ARX3


;------------------------------------------------------------------------------
; Clears arithmetic registers
;            Address: AR-X: F757 (EC)
;               AR-Y: F753
;          Parameter: XH must contain 7A
;
; Modified Registers: X-Reg, U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
CLR_ARITHMETIC_REGS: ; $F757
    LDI  XH,$7A
    LDI  XL,$00

; Clears 8 bytes from (X-Reg).
CLR_SM_ARX3: ; $F75B
    LDI  UL,$07
    BCH CLR_N_XREG

; (76) Clears sign and mantissa in AR-X
CLR_SM_XREG: ; $F75F
    LDI  XL,$01

; Clear 7 bytes from (X-Reg).
CLR_7_XREG: ; $F761
    LDI  UL,$06



;------------------------------------------------------------------------------
; (BA) Delete UL+1 bytes from (X-Reg)
;            Address: AR-X: F763 (BA)
;          Parameter: None
; 
; Modified Registers: X-Reg, U-Reg, Accumulator
;   Error conditions: None
;------------------------------------------------------------------------------
CLR_N_XREG: ; $F763
    LDI  A,$00

CLR_N_XREG_1: ; $F765
    SIN  X
    LOP  UL,$F765
    RTN



; AR-W shift one nibble to the right (/10)
ARW_SHR_4BITS: ; $F769
    LDI  XL,$28
    BCH X_REG_SHR_4BITS



; Push AR-Z right one nibble (/10)
ARZ_SHR_4BITS: ; $F76D
    LDI  XL,$08
    BCH X_REG_SHR_4BITS



; Shift AR-Y one nibble to the right (/10)
ARY_SHR_4BITS: ; $F771
    LDI  XL,$10
    BCH X_REG_SHR_4BITS



; (74) Push AR-X one nibble to the right (/10)
ARX_SHR_4BITS: ; $F775
    LDI  XL,$00



; Shift 7 bytes from (X-Reg) one nibble to the right (/10)
X_REG_SHR_4BITS: ; $F777
    LDI  UL,$06
    LDI  A,$00

X_REG_SHR_4BITS_1: ; $F77B
    INC  X
    DRR  (X)
    LOP  UL,X_REG_SHR_4BITS_1 ; $F77B
    RTN
    LDI  XL,$0F
    LDI  UL,$05

X_REG_SHR_4BITS_2: ; $F784
    DEC  X
    LIN  X
    SDE  X
    LOP  UL,X_REG_SHR_4BITS_2 ; $F784
    ANI  (X),$00
    RTN



; Push AR-S left one nibble (*10)
ARS_SHL_4BITS: ; $F78C
    LDI  XH,$7A
    LDI  XL,$37
    LDI  UL,$04
    BCH ARX_SHL_4BITS_1 ; $F7A0



; Push AR-W one nibble to the left (*10)
ARW_SHL_4BITS: ; $F794
    LDI  XL,$30
    BCH ARX_SHL_4BITS_2 ; $F79E



; Push AR-Z left one nibble (*10)
ARZ_SHL_4BITS: ; $F798
    LDI  XL,$10
    BCH ARX_SHL_4BITS_2 ; $F79E



; (EA) Push AR-X left one nibble (*10)
ARX_SHL_4BITS: ; $F79C
    LDI  XL,$08

ARX_SHL_4BITS_2: ; $F79E
    LDI  UL,$06

ARX_SHL_4BITS_1: ; $F7A0
    LDI  A,$00

ARX_SHL_4BITS_3: ; $F7A2
    DEC  X
    DRL  (X)
    LOP  UL,ARX_SHL_4BITS_3 ; $F7A2
    RTN



; (5E) Transfer random number from RND pointer to AR-X
RND2ARX: ; $F7A7
    LDI  YL,$01
    LDI  XH,$7B
    LDI  XL,$01
    SJP  (XREG2YREG2) ; F8A5



;------------------------------------------------------------------------------
; (5A) Make pointer to arithmetic register
; Position high bytes in X-Reg and Y-Reg on arithmetic registers
;            Address: F7B0 (54)
;   Entry parameters: None
;
; Modified registers: XH and YH are set to 7A
;   Error conditions: None
;------------------------------------------------------------------------------
SET_HB_XYREGS: ; $F7B0
    LDI  XH,$7A
    LDI  YH,$7A
    RTN



; (64) Swaps AR-X with AR-S
SWAP_AARX_ARY: ; $F7B5
    LDI  YL,$30
    BCH SWAP_ARX_ARY_1 ; $F7BB



; (66) Swaps AR-X with AR-Y
SWAP_ARX_ARY: ; $F7B9
    LDI  YL,$10

SWAP_ARX_ARY_1: ; $F7BB
    LDI  XL,$00
    LDI  UL,$07



; (UL+1) Swap Bytes
SWAP_BYTES: ; $F7BF
    LDA  (X)
    STA  UH
    LDA  (Y)
    SIN  X
    LDA  UH
    SIN  Y
    LOP  UL,SWAP_BYTES
    RTN



; Add AR-U to AR-X
ADD_ARU_ARX: ; $F7C8
    LDI  YL,$1F
    BCH ADD_ARU_ARX_16 ; $F7CE

; (EE) $F7CC Add the sign and mantissa of AR-X and AR-Y and store them in AR-X.
    LDI  YL,$17

; (72) $F7CE Adds the mantissa of the AR-Y to the AR-X.
ADD_ARU_ARX_16: ; 
    LDI  XL,$07

ADD_ARU_ARX_26: ; $F7D0
    REC
    LDI  UL,$06

ADD_ARU_ARX_17: ; $F7D3
    LDE  Y
    DCA  (X)
    SDE  X
    LOP  UL,ADD_ARU_ARX_17 ; $F7D3
    RTN


; $F7D9 AR-X=AR-X-AR-V.
ADD_ARU_ARX_6: ; 
    LDI  YL,$27
    BCH ADD_ARU_ARX_8 ; $F7DF

; (7A) $F7DD AR-X=AR-X-AR-V.
    LDI  YL,$17

; $F7DF Subtract from AR-X the AR pointed to by Y-Reg on entry.
ADD_ARU_ARX_8: ; $F7DF
    LDI  XL,$07

; $F7E1 From the arithmetic register pointed to by X-Reg, subtract AR pointed to by Y-Reg.
ADD_ARU_ARX_11: ; 
    SEC
    LDI  UL,$06

ADD_ARU_ARX_18: ; $F7E4
    LDA  (X)
    DCS  (Y)
    SDE  X
    DEC  Y
    LOP  UL,ADD_ARU_ARX_18 ; $F7E4
    RTN

; $F7EB Calculates the decimal to AR-X in AR-X.
ADD_ARU_ARX_3: ; 
    LDI  XL,$07
    SEC
    LDI  UL,$06

ADD_ARU_ARX_19: ; $F7F0
    LDI  A,$00
    DCS  (X)
    SDE  X
    LOP  UL,ADD_ARU_ARX_19 ; $F7F0
    RTN

ADD_ARU_ARX_2: ; $F7F7
    SHR
    BCR ADD_ARU_ARX_10 ; $F805
    PSH  A
    LDA  XL
    ANI  A,$F8
    STA  XL
    SJP  (X_REG_SHR_4BITS)
    POP  A

; $F805 Accumulator contains the number of places by which the AR pointed 
; to by the X-Reg is shifted to the right
ADD_ARU_ARX_10: ; 
    BII  A,$FF
    BZS ADD_ARU_ARX_20 ; $F83B
    STX  Y
    EAI  $FF
    SEC
    ADC  YL
    STA  YL
    LDI  UL,$06

ADD_ARU_ARX_22: ; $F812
    LDA  YL
    ANI  A,$07
    BZS ADD_ARU_ARX_21 ; $F818
    LDE  Y

ADD_ARU_ARX_21: ; $F818
    SDE  X
    LOP  UL,ADD_ARU_ARX_22 ; $F812
    RTN

ADD_ARU_ARX_5: ; $F81C
    LDI  UH,$01
    BCH ADD_ARU_ARX_23 ; $F822

ADD_ARU_ARX_4: ; $F820
    LDI  UH,$02

ADD_ARU_ARX_23: ; $F822
    LDI  XL,$17
    LDI  YL,$1F

ADD_ARU_ARX_25: ; $F826
    LDI  UL,$06
    REC

ADD_ARU_ARX_24: ; $F829
    LDA  (X)
    DCA  (X)
    SDE  Y
    DEC  X
    LOP  UL,ADD_ARU_ARX_24 ; $F829
    DEC  UH
    BCR ADD_ARU_ARX_20 ; $F83B
    LDI  A,$0F
    ADR  X
    ADR  Y
    BCH ADD_ARU_ARX_25 ; $F826

ADD_ARU_ARX_20: ; $F83B
    RTN

ADD_ARU_ARX_9: ; $F83C
    LDA  (ARZ)
    BZS ADD_ARU_ARX_20 ; $F83B
    DEC  A
    LDI  XL,$0F
    SJP  (ADD_ARU_ARX_2) ; $F7F7

ADD_ARU_ARX_27: ; $F847
    LDI  XL,$17
    LDI  YL,$0F
    BCH ADD_ARU_ARX_26 ; $F7D0

ADD_ARU_ARX_12: ; $F84D
    LDA  (ARZ)
    BZS ADD_ARU_ARX_20 ; $F83B
    DEC  A
    LDI  XL,$0F
    SJP  (ADD_ARU_ARX_10) ; $F805
    BCH ADD_ARU_ARX_27 ; $F847


; $F85A Loads auxiliary constants to AR-Y according to the evaluation of the
;  display according to 'RAD' or 'DEG'.
ADD_ARU_ARX_13: ; 
    LDA  (DISP_BUFF + $4F)
    BII  A,$04
    REC
    BZS ADD_ARU_ARX_20 ; $F83B
    BII  A,$02
    BZR ADD_ARU_ARX_28 ; $F87F
    LDI  XL,$98

ADD_ARU_ARX_31: ; $F868
    LDI  UL,$07
    LDI  XH,$FC

ADD_ARU_ARX_33: ; $F86C
    LDI  YL,$10

ADD_ARU_ARX_29: ; $F86E
    TIN
    LOP  UL,ADD_ARU_ARX_29 ; $F86E
    LDI  XH,$7A
    SEC

ADD_ARU_ARX_42: ; $F874
    RTN

; $F875  Transfers PI to AR-Y.
    LDI  XL,$F8
    LDI  UL,$07
    BCH ADD_ARU_ARX_30 ; $F898

; $F87B Transfers auxiliary constants to AR-Y.
ADD_ARU_ARX_7: ; $F87B
    LDI  XL,$60
    BCH ADD_ARU_ARX_31 ; $F868

ADD_ARU_ARX_28: ; $F87F
    LDI  A,$E9
    BCH ADD_ARU_ARX_32 ; $F891


; $F883 Loads AR-Y with auxiliary constant.
ADD_ARU_ARX_14: ; $F883
    LDI  A,$EF
    BCH ADD_ARU_ARX_32 ; $F891

; $F887 Loads AR-Y with auxiliary constant.
ADD_ARU_ARX_15: ; $F887
    LDI  A,$F2
    BCH ADD_ARU_ARX_32 ; $F891

; (62) $F88B Transfers 0.6 to AR-V (FF 00 60 ...).
    LDI  A,$F5
    BCH ADD_ARU_ARX_32 ; $F891

; (6A) $F88F Transfers numerical value 1 to AR-Y.
    LDI  A,$EC

ADD_ARU_ARX_32: ; $F891
    STA  YL
    VMJ  ($70) ; ($70)($38)
    LDA  YL
    STA  XL
    LDI  UL,$02

ADD_ARU_ARX_30: ; $F898
    LDI  XH,$FB
    BCH ADD_ARU_ARX_33 ; $F86C

; $F89C AR-X=AR-X to the power of AR-Y.
    VMJ  ($54) ; ($54)($2A)
    LDI  XL,$02
    LDE  X
    BZS ADD_ARU_ARX_34 ; $F920
    BII  (X),$80
    BZR ADD_ARU_ARX_45 ; $F8E0
    BII  (ARY + $02),$FF
    BZS ADD_ARU_ARX_35 ; $F8DA
    LDI  A,$00
    PSH  A

ADD_ARU_ARX_41: ; $F8B1
    SJP  (XFER_ARY2ARS)
    SJP  (BCMD_LOG)
    BCS ADD_ARU_ARX_36 ; $F8C2
    VMJ  ($68) ; ($68)($34)
    VMJ  ($7E) ; ($7E)($3F)
    BCS ADD_ARU_ARX_36 ; $F8C2
    SJP  (EXPONENT)

ADD_ARU_ARX_36: ; $F8C2
    POP  A
    BCS ADD_ARU_ARX_37 ; $F8D0
    BII  A,$F0
    BZS ADD_ARU_ARX_38 ; $F8D7
    SHR
    BCS $F8D3
    SHL
    BCR ADD_ARU_ARX_38 ; $F8D7

ADD_ARU_ARX_37: ; $F8D0
    JMP  SQR_ROOT_1 ; $F15D
    ORI  (ARX + $01),$80

ADD_ARU_ARX_38: ; $F8D7
    JMP  MULTIPLY_7 ; $F063

ADD_ARU_ARX_35: ; $F8DA
    VMJ  ($6A) ; ($6A)($35)
    VMJ  ($56) ; ($56)($2B)
    BCH ADD_ARU_ARX_38 ; $F8D7

ADD_ARU_ARX_45: ; $F8E0
    ANI  (X),$00
    VMJ  ($80) ; ($80)($40)
    VMJ  ($56) ; ($56)($2B)
    LDA  (ARX)
    BII  A,$80
    BZR ADD_ARU_ARX_37 ; $F8D0
    CPI  A,$0B
    LDI  A,$00
    BCS ADD_ARU_ARX_39 ; $F913
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    VMJ  ($60) ; ($60)($30)
    SEC
    LDI  YL,$11
    LDI  UL,$06
    LIN  Y
    BZR ADD_ARU_ARX_36 ; $F8C2
    LOP  UL,$F8FE
    POP  A
    STA  (ARX + $01)
    LDA  (ARX)
    ADI  A,$04
    SHR
    STA  XL
    BCS ADD_ARU_ARX_40 ; $F91C
    DEC  XL
    LDA  (X)

ADD_ARU_ARX_39: ; $F913
    ORI  A,$F0
    PSH  A
    VEJ  (E6)
    VMJ  ($64) ; ($64)($32)
    BCH ADD_ARU_ARX_41 ; $F8B1

ADD_ARU_ARX_40: ; $F91C
    LDA  (X)
    AEX
    BCH ADD_ARU_ARX_39 ; $F913

ADD_ARU_ARX_34: ; $F920
    LDI  XL,$12
    LDE  X
    BZS ADD_ARU_ARX_37 ; $F8D0
    BII  (X),$80
    BZS ADD_ARU_ARX_38 ; $F8D7
    BCH ADD_ARU_ARX_37 ; $F8D0


; $F92B Convert AR-X from integer to BCD format.
ADD_ARU_ARX_1: ; $F92B
    LDI  A,$A0
    CPA  (ARX + $04)
    BCR ADD_ARU_ARX_42 ; $F874
    LDI  XH,$7A
    LDA  (ARX + $07)
    REC
    ADI  A,$B0
    BCR ADD_ARU_ARX_43 ; $F94E
    VMJ  ($6C) ; ($6C)($36)
    PSH  A
    LDI  XL,$06
    LDI  UL,$05

ADD_ARU_ARX_44: ; $F944
    LDI  A,$00
    DCA  (X)
    SDE  X
    LOP  UL,ADD_ARU_ARX_44 ; $F944
    POP  A
    VMJ  ($52) ; ($52)($29

ADD_ARU_ARX_43: ; $F94E
    JMP  ARXX ; $F63C
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)



;------------------------------------------------------------------------------
;  Tokenizer program: Converts subsets of ASCII character strings into tokens, 
;                     provided these could be fount in the token tables. 
;                     The input buffer is compressed in the process. All Basic 
;                     commands tokenized to 2 bytes, insert codes are deleted 
;                     and spaces outside of strings as well.
;            Address: F957
; 
;         Parameters: Y-Reg must point to the input buffer
; Modified Registers: All
;   Error conditions: Error 28 when strings contain tokens.
;------------------------------------------------------------------------------
TOKENIZE_INBUF: ; $F957
    LDI  UH,$00

; $F959 Tokenizer (string flag already in UH).
TOKENIZE_INBUF_4: ; $F959
    LDA  (INBUFPTR_L)
    STA  YL
    LDI  YH,$7B
    LDX  Y

TOKENIZE_INBUF_1: ; $F961
    LIN  Y
    CPI  A,$27
    BZS TOKENIZE_INBUF_1 ; $F961
    CPI  A,$0D
    BZR TOKENIZE_INBUF_2 ; $F96E
    LDI  UH,$00
    BCH VAR_TYPE_1 ; $FA18

TOKENIZE_INBUF_2: ; $F96E
    CPI  A,$22
    BZR VAR_TYPE_2 ; $F9A1
    DEC  UH
    BZS TOKENIZE_INBUF_3 ; $F978
    LDI  UH,$01

TOKENIZE_INBUF_3: ; $F978
    SIN  X
    BCH TOKENIZE_INBUF_1 ; $F961



; $F97B ; $F87B Convert input line into tokens and use formula interpreter
VAR_TYPE: ; $F97B
    LDI  UH,$00
    BII  (CURVARTYPE),$80 ; $7885
    BZR VAR_TYPE_3 ; $F985
    LDI  UH,$01

VAR_TYPE_3: ; $F985
    SJP  (TOKENIZE_INBUF_4) ; $F959
    BZS VAR_TYPE_4 ; $F99F
    CPA  XL
    BCS VAR_TYPE_5 ; $F998
    LDA  (CURVARTYPE); $7885
    ROL
    BCS VAR_TYPE_6 ; $F999
    VMJ  ($0C)

VAR_TYPE_8: ; $F995
    VEJ  (C8) \ ABRF(VAR_TYPE_7) ; $F99D
    DEC  UL

VAR_TYPE_5: ; $F998
    RTN

VAR_TYPE_6: ; $F999
    VEJ  (DE) \ ABRF(VAR_TYPE_4) ; $F99F
    BCH VAR_TYPE_8 ; $F995

VAR_TYPE_7: ; $F99D
    LDI  UH,$01

VAR_TYPE_4: ; $F99F
    REC
    RTN

VAR_TYPE_2: ; $F9A1
    CPI  UH,$00
    BZS VAR_TYPE_9 ; $F9AB
    CPI  A,$E0
    BCR TOKENIZE_INBUF_3 ; $F978
    BCH VAR_TYPE_1 ; $FA18

VAR_TYPE_9: ; $F9AB
    CPI  A,$20
    BZS TOKENIZE_INBUF_1 ; $F961
    CPI  A,$41
    BCR TOKENIZE_INBUF_3 ; $F978
    CPI  A,$5B
    BCR $F9C0
    CPI  A,$E0
    BCR TOKENIZE_INBUF_3 ; $F978
    STA  UH
    LIN  Y
    STA  UL
    BCH VAR_TYPE_10 ; $FA09
    PSH  X
    STA  UH
    LDI  UL,$60
    LDI  XH,$C0

; $F9C7 work off. Search Token Table
    LDA  (PU_PV)

VAR_TYPE_22: ; $F9CA
    PSH  A
    LDI  XL,$1E
    LDA  UH
    ANI  A,$1F
    SHL
    ADR  X
    LIN  X
    BZS VAR_TYPE_11 ; $FA40
    PSH  A
    LDA  (X)
    STA  XL
    POP  A
    STA  XH

VAR_TYPE_20: ; $F9DE
    PSH  Y

VAR_TYPE_12: ; $F9E0
    LIN  Y
    CPI  A,$20
    BZS VAR_TYPE_12 ; $F9E0
    CPI  A,$27
    BZS VAR_TYPE_12 ; $F9E0
    CPI  A,$2E
    BZR VAR_TYPE_13 ; $F9F5

VAR_TYPE_14: ; $F9ED
    LDI  A,$E0
    CIN
    BCS VAR_TYPE_14 ; $F9ED
    DEC  X
    BCH VAR_TYPE_15 ; $F9FD

VAR_TYPE_13: ; $F9F5
    CIN
    BZR VAR_TYPE_16 ; $FA30
    LDA  (X)
    CPI  A,$E0
    BCR VAR_TYPE_12 ; $F9E0

VAR_TYPE_15: ; $F9FD
    LIN  X
    STA  UH
    LDA  (X)
    STA  UL
    POP  X
    POP  A
    VMJ  ($1E)
    POP  X

VAR_TYPE_10: ; $FA09
    LDA  UH
    SIN  X
    LDA  UL
    SIN  X
    CPI  UH,$F1
    LDI  UH,$00
    BZR TOKENIZE_INBUF_1 ; $F961
    CPI  UL,$AB
    BZR TOKENIZE_INBUF_1 ; $F961

VAR_TYPE_17: ; $FA17
    LIN  Y

VAR_TYPE_1: ; $FA18
    SIN  X
    CPI  A,$0D
    BZR VAR_TYPE_17 ; $FA17
    DEC  Y
    DEC  X
    PSH  X

VAR_TYPE_18: ; $FA21
    STA  (X)
    INC  XL
    BCR VAR_TYPE_18 ; $FA21
    POP  X
    LDA  (INBUFPTR_L)
    STA  YL
    DEC  UH
    LDI  UH,$1C
    RTN

VAR_TYPE_16: ; $FA30
    LDI  A,$E0

VAR_TYPE_19: ; $FA32
    CIN
    BCS VAR_TYPE_19 ; $FA32
    INC  X
    INC  X
    INC  X
    LIN  X
    INC  X
    ANI  A,$10
    POP  Y
    BZS VAR_TYPE_20 ; $F9DE

VAR_TYPE_11: ; $FA40
    POP  A
    VMJ  ($1E)

VAR_TYPE_23: ; $FA44
    LDA  UL
    SJP  (DEC_OPN)
    STA  UL
    BCS VAR_TYPE_21 ; $FA51
    VMJ  ($3C)
    BZS VAR_TYPE_22 ; $F9CA
    BCH VAR_TYPE_23 ; $FA44

VAR_TYPE_21: ; $FA51
    POP  X
    LDA  UH
    LDI  UH,$00
    BCH TOKENIZE_INBUF_3 ; $F978



; Decrements accumulator (OPN byte) in 2K steps
DEC_OPN: ; $FA58
    BII  A,$3C
    BZS DEC_OPN_1 ; $FA61
    SEC
    SBI  A,$04
    REC
    RTN

DEC_OPN_1: ; $FA61
    ROL
    LDI  A,$DC
    RTN



; Sets PV bit and PV byte according to Carry bit 0 or 1.
SET_PV: ; $FA65
    ANI  A,$FE
    RIE
    RPV
    BCR SET_PV_1 ; $FA6E
    SPV
    INC  A

SET_PV_1: ; $FA6E
    STA  (PU_PV)
    SIE
    RTN




; (3C) $FA74 Checks whether a certain token table (whose right-shifted 
; high-byte address is in the accumulator, exists. If not, C=0.
TOKEN_CHECK: ; $FA74
    SHL

; $FA75 Checks whether there is a corresponding token table for a token.
TOKEN_CHECK_1: ; $FA75
    STA  XH
    LDA  (PU_PV)
    PSH  A
    SJP  (SET_PV)
    LDI  XL,$00
    LDA  (X)
    STA  XL
    POP  A
    CPI  XL,$55
    BZR PVBANK2
    RTN



; (1C) $FA89 Processes tokens corresponding to data bytes
TOKEN_PROCESS: ; $FA89
    POP  X
    LIN  X
    PSH  X
    CPI  UH,$F2
    BCS TOKEN_PROCESS_1 ; $FAE2
    PSH  A
    ANI  (OPN),$FC
    LDA  (OPN)
    CPI  UH,$F0
    BZR TOKEN_PROCESS_2 ; $FAA4

TOKEN_PROCESS_9: ; $FA9F
    PSH  A

TOKEN_PROCESS_4: ; $FAA1
    SHL
    BCH TOKEN_PROCESS_3 ; $FAB0

TOKEN_PROCESS_2: ; $FAA4
    LDI  A,$60
    BCS TOKEN_PROCESS_4 ; $FAA1
    SEC
    LDA  UH
    ANI  A,$07
    AEX
    ROR
    CPI  UH,$E8

TOKEN_PROCESS_3: ; $FAB0
    SJP  (TOKEN_CHECK_1) ; $FA75
    BCR TOKEN_PROCESS_5 ; $FAC5
    PSH  A
    LDI  XL,$51

TOKEN_PROCESS_10: ; $FAB9
    INC  X

TOKEN_PROCESS_11: ; $FABA
    INC  X
    INC  X
    LIN  X
    ANI  A,$0F
    BZR TOKEN_PROCESS_6 ; $FAE7
    POP  A
    VMJ  ($1E)

TOKEN_PROCESS_5: ; $FAC5
    POP  A
    CPI  UH,$F0
    BZR TOKEN_PROCESS_1 ; $FAE2
    CPA  (OPN)
    BZR TOKEN_PROCESS_7 ; $FAD4
    LDI  A,$60
    BCH TOKEN_PROCESS_8 ; $FAD9

TOKEN_PROCESS_7: ; $FAD4
    SJP  (DEC_OPN)
    BCS $FAE0

TOKEN_PROCESS_8: ; $FAD9
    CPA  (OPN)
    BZS TOKEN_PROCESS_7 ; $FAD4
    BCH TOKEN_PROCESS_9 ; $FA9F
    POP  A

TOKEN_PROCESS_1: ; $FAE2
    LDI  A,$00
    LDI  UH,$1B
    RTN

TOKEN_PROCESS_6: ; $FAE7
    ADR  X
    LIN  X
    CPA  UH
    BZR TOKEN_PROCESS_10 ; $FAB9
    LIN  X
    CPA  UL
    BZR TOKEN_PROCESS_11 ; $FABA
    CPI  UH,$F0
    BZR TOKEN_PROCESS_12 ; $FAFB
    POP  A
    POP  U
    BCH TOKEN_PROCESS_13 ; $FAFE

TOKEN_PROCESS_12: ; $FAFB
    POP  U
    LDA  UH

TOKEN_PROCESS_13: ; $FAFE
    PSH  A
    LDA  UL
    BZS PVBANK2_1 ; $FB7A
    SHR
    BCS PVBANK2_2 ; $FB3A
    PSH  A
    DEC  X
    LDE  X
    STA  UL
    LDE  X
    STA  UH

TOKEN_PROCESS_14: ; $FB0D
    DEC  X
    LDA  (X)
    CPI  A,$80
    BCR TOKEN_PROCESS_14 ; $FB0D
    POP  A
    ROR
    BCS TOKEN_PROCESS_15 ; $FB20
    POP  A
    SHR
    LDA  (X)
    ANI  A,$0F
    BCH PVBANK2_3 ; $FB2D

TOKEN_PROCESS_15: ; $FB20
    LIN  X
    ANI  A,$0F
    DEC  A
    STA  UL

TOKEN_PROCESS_16: ; $FB25
    TIN
    LOP  UL,TOKEN_PROCESS_16 ; $FB25
    POP  A



; (1E) $FB2A Performs PV banking according to PV byte $79D0.
PVBANK2: ; $FB2A
    ROR
    LDI  A,$EF

PVBANK2_3: ; $FB2D
    PSH  A
    LDA  (PU_PV)
    SJP  (SET_PV)
    POP  A
    RTN

; $FB38 Execution of functions and trace.
PVBANK2_10: ; $FB38
    PSH  A

PVBANK2_2: ; $FB3A
    LDI  UL,$28
    LDI  UH,$FB
    PSH  U
    STX  U
    LIN  U
    STA  XH
    LIN  U
    STA  XL
    LIN  U
    SHL
    SHL
    BCS PVBANK2_4 ; $FB75
    STA  UL
    LDI  UH,$12
    LDA  (NUMARGS)
    DEC  A
    BZR PVBANK2_5 ; $FB79
    LDI  A,$B2
    CPA  (ARX + $04)
    LDI  A,$00
    ROR
    LDI  UH,$11
    ADC  UL
    SHL
    BCS PVBANK2_5 ; $FB79
    CPI  UL,$80
    BCR PVBANK2_4 ; $FB75
    LDA  XH
    CPI  A,$80
    ORI  A,$80
    STA  XH
    BCR PVBANK2_4 ; $FB75
    PSH  X
    VEJ  (D2) \ ABRF($FB77) \ ABYT($80)
    POP  X

PVBANK2_4: ; $FB75
    STX  P
    POP  X

PVBANK2_5: ; $FB79
    RTN

PVBANK2_1: ; $FB7A
    STX  U
    LIN  U
    STA  XH
    LIN  U
    STA  XL
    VEJ  (D8)
    BZR PVBANK2_6 ; $FB93
    LDI  A,$20
    BII  (U),$60
    BZR PVBANK2_7 ; $FB95
    LDI  UH,$1A
    LIN  X
    AND  (DISP_BUFF + $4F)
    BZS PVBANK2_8 ; $FB9C

PVBANK2_9: ; $FB91
    STX  P

PVBANK2_6: ; $FB93
    LDI  A,$00

PVBANK2_7: ; $FB95
    EOR  (U)
    ANI  A,$60
    BZR PVBANK2_9 ; $FB91
    LDI  UH,$01

PVBANK2_8: ; $FB9C
    VEJ  (E0)



; (3E) $FB9D Determine and run through the trace routine.
TRACE2: ; 
    STA  (TRACE)
    CPI  A,$02
    LDA  (TRACE_ON)
    BZS TRACE2_1 ; $FBC8
    BCR TRACE2_2 ; $FBBB
    CPI  A,$58
    BZS TRACE2_2 ; $FBBB
    VMJ  ($3C)
    BZR TRACE2_3 ; $FBB9
    LDI  XL,$1D
    SJP  (PVBANK2_10) ; $FB38
    LDA  UH
    BZR TRACE2_4 ; $FBC7

TRACE2_3: ; $FBB9
    LDI  A,$58

TRACE2_2: ; $FBBB
    LDI  UH,$00
    VMJ  ($3C)
    LDI  XL,$1D
    BZR TRACE2_5 ; $FBC6
    SJP  (PVBANK2_10) ; $FB38

TRACE2_5: ; $FBC6
    LDA  UH

TRACE2_4: ; $FBC7
    RTN

TRACE2_1: ; $FBC8
    BCS TRACE2_3 ; $FBB9
    RTN



; $FBCB Transfer string to output buffer or output to string buffer
STRXFR: ; $FBCB
    PSH  Y
    LDI  XH,$7B
    LDI  YH,$7B
    LDI  XL,$10
    LDI  YL,$60
    BCR STRXFR_1 ;$FBDB
    LDI  XL,$60
    LDI  YL,$10

STRXFR_1: ; $FBDB
    LDI  UL,$4F
    JMP  ISARXBCD_13 ; $DC28
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)
    VEJ  (E4)



; Auxiliary constants for arithmetic routines
AUX_CONST: ; $FBE9
    .BYTE  $FF,$00,$90                      ; 0.9
    .BYTE  $00,$00,$10                      ; 1
    .BYTE  $01,$00,$90                      ; 90
    .BYTE  $02,$00,$18                      ; 180
    .BYTE  $FF,$00,$60                      ; 0.6
    .BYTE  $00,$00,$31,$41,$59,$26,$53,$59  ; PI= 3.14159265359
    .BYTE  $00,$00,$30,$10,$29,$99,$56,$64  ; 3.01029995664
    .BYTE  $00,$00,$41,$39,$26,$85,$15,$82  ; 4.13926851582
    .BYTE  $00,$00,$43,$21,$37,$37,$82,$64  ; 4.32137378264
    .BYTE  $00,$00,$43,$40,$77,$47,$93,$19  ; 4.34077479319
    .BYTE  $00,$00,$43,$42,$72,$76,$86,$27  ; 4.34272768627
    .BYTE  $00,$00,$43,$42,$92,$31,$04,$45  ; 4.34292310445
    .BYTE  $00,$00,$43,$42,$94,$26,$47,$56  ; 4.34294264756
    .BYTE  $00,$00,$43,$42,$94,$46,$01,$89  ; 4.34294460189
    .BYTE  $00,$00,$43,$42,$94,$47,$97,$32  ; 4.34294479732
    .BYTE  $00,$00,$43,$42,$94,$48,$16,$86  ; 4.34294481686
    .BYTE  $00,$00,$43,$42,$94,$48,$18,$82  ; 4.34294481882
    .BYTE  $00,$00,$43,$42,$94,$48,$19,$01  ; 4.34294481901
    .BYTE  $FF,$00,$43,$42,$94,$48,$19,$03  ; 0.434294481903
    .BYTE  $00,$00,$45,$00,$00,$00,$00,$00  ; 4.5
    .BYTE  $00,$00,$57,$10,$59,$31,$37,$50  ; 5.7105931375
    .BYTE  $00,$00,$57,$29,$38,$69,$76,$83  ; 5.72938697683
    .BYTE  $00,$00,$57,$29,$57,$60,$41,$45  ; 5.72957604145
    .BYTE  $00,$00,$57,$29,$57,$79,$32,$21  ; 5.72957793221
    .BYTE  $00,$00,$57,$29,$57,$79,$51,$11  ; 5.72957795111
    .BYTE  $01,$00,$57,$29,$57,$79,$51,$31  ; 57.2957595131



CHARSET: ; $FCA0
    .BYTE  $00,$00,$00,$00,$00  ; Space
    .BYTE  $00,$00,$5F,$00,$00  ; !
    .BYTE  $00,$03,$04,$03,$00  ; "
    .BYTE  $22,$7F,$22,$7F,$22  ; #
    .BYTE  $24,$2A,$7F,$2A,$12  ; $
    .BYTE  $23,$13,$08,$64,$62  ; %
    .BYTE  $36,$49,$55,$22,$50  ; &
    .BYTE  $63,$41,$41,$41,$63  ; Insert
    .BYTE  $00,$1C,$22,$41,$00  ; (
    .BYTE  $00,$41,$22,$1C,$00  ; )
    .BYTE  $14,$08,$3E,$08,$14  ; *
    .BYTE  $08,$08,$3E,$08,$08  ; +
    .BYTE  $00,$58,$38,$00,$00  ; '
    .BYTE  $08,$08,$08,$08,$08  ; -
    .BYTE  $00,$60,$60,$00,$00  ; .
    .BYTE  $20,$10,$08,$04,$02  ; /
    .BYTE  $3E,$51,$49,$45,$3E  ; 0
    .BYTE  $00,$42,$7F,$40,$00  ; 1
    .BYTE  $42,$61,$51,$49,$46  ; 2
    .BYTE  $41,$49,$4D,$4B,$31  ; 3
    .BYTE  $18,$14,$12,$7F,$10  ; 4
    .BYTE  $27,$45,$45,$45,$39  ; 5
    .BYTE  $3C,$4A,$49,$49,$30  ; 6
    .BYTE  $01,$01,$79,$05,$03  ; 7
    .BYTE  $36,$49,$49,$49,$36  ; 8
    .BYTE  $06,$49,$49,$29,$1E  ; 9
    .BYTE  $00,$36,$36,$00,$00  ; :
    .BYTE  $00,$5B,$3B,$00,$00  ; 
    .BYTE  $08,$14,$22,$41,$00  ; 
    .BYTE  $14,$14,$14,$14,$14  ; =
    .BYTE  $00,$41,$22,$14,$08  ; 
    .BYTE  $02,$01,$51,$09,$06  ; ?
    .BYTE  $32,$49,$79,$41,$3E  ; 
    .BYTE  $7C,$12,$11,$12,$7C  ; A
    .BYTE  $41,$7F,$49,$49,$36  ; B
    .BYTE  $3E,$41,$41,$41,$22  ; C
    .BYTE  $41,$7F,$41,$41,$3E  ; D
    .BYTE  $7F,$49,$49,$49,$41  ; E
    .BYTE  $7F,$09,$09,$09,$01  ; F
    .BYTE  $3E,$41,$41,$49,$39  ; G
    .BYTE  $7F,$08,$08,$08,$7F  ; H
    .BYTE  $00,$41,$7F,$41,$00  ; I
    .BYTE  $20,$40,$41,$3F,$01  ; J
    .BYTE  $7F,$08,$14,$22,$41  ; K
    .BYTE  $7F,$40,$40,$40,$40  ; L
    .BYTE  $7F,$02,$0C,$02,$7F  ; M
    .BYTE  $7F,$04,$08,$10,$7F  ; N
    .BYTE  $3E,$41,$41,$41,$3E  ; O
    .BYTE  $7F,$09,$09,$09,$06  ; P
    .BYTE  $3E,$41,$51,$21,$5E  ; Q
    .BYTE  $7F,$09,$19,$29,$46  ; R
    .BYTE  $26,$49,$49,$49,$32  ; S
    .BYTE  $01,$01,$7F,$01,$01  ; T
    .BYTE  $3F,$40,$40,$40,$3F  ; U
    .BYTE  $07,$18,$60,$18,$07  ; V
    .BYTE  $7F,$20,$18,$20,$7F  ; W
    .BYTE  $63,$14,$08,$14,$63  ; X
    .BYTE  $03,$04,$78,$04,$03  ; Y
    .BYTE  $61,$51,$49,$45,$43  ; Z
    .BYTE  $10,$20,$7F,$01,$01  ; 
    .BYTE  $15,$16,$7C,$16,$15  ; 
    .BYTE  $41,$3F,$01,$3F,$41  ; 
    .BYTE  $18,$04,$02,$04,$18  ;
    .BYTE  $40,$40,$40,$40,$40  ; 
    .BYTE  $00,$00,$00,$00,$00  ; 
    .BYTE  $38,$44,$44,$3C,$40  ; a
    .BYTE  $7F,$48,$44,$44,$38  ; b
    .BYTE  $38,$44,$44,$44,$20  ; c
    .BYTE  $38,$44,$44,$48,$7F  ; d
    .BYTE  $38,$54,$54,$54,$18  ; e
    .BYTE  $00,$08,$7E,$09,$02  ; f
    .BYTE  $08,$54,$54,$3C,$00  ; g
    .BYTE  $7F,$04,$04,$78,$00  ; h
    .BYTE  $00,$00,$7D,$00,$00  ; i
    .BYTE  $20,$40,$44,$3D,$00  ; j
    .BYTE  $7F,$10,$28,$44,$00  ; k
    .BYTE  $00,$00,$7F,$00,$00  ; l
    .BYTE  $78,$04,$78,$04,$78  ; m
    .BYTE  $7C,$08,$04,$04,$78  ; n
    .BYTE  $38,$44,$44,$44,$38  ; o
    .BYTE  $7C,$14,$14,$14,$08  ; p
    .BYTE  $18,$24,$14,$7C,$40  ; q
    .BYTE  $7C,$08,$04,$04,$00  ; r
    .BYTE  $48,$54,$54,$54,$20  ; s
    .BYTE  $04,$3E,$44,$20,$00  ; t
    .BYTE  $3C,$40,$40,$20,$7C  ; u
    .BYTE  $1C,$20,$40,$20,$1C  ; v
    .BYTE  $3C,$40,$30,$40,$3C  ; w
    .BYTE  $44,$24,$7C,$48,$44  ; x
    .BYTE  $0C,$50,$50,$3C,$00  ; y
    .BYTE  $44,$64,$54,$4C,$44  ; z
    .BYTE  $00,$08,$77,$41,$00  ; 
    .BYTE  $00,$00,$77,$00,$00  ; 
    .BYTE  $00,$41,$77,$08,$00  ; 
    .BYTE  $08,$04,$08,$10,$08  ; 
    .BYTE  $FF,$FF,$FF,$FF,$FF  ; Cursor block



; Keyboard layout (basic function)
KB_LAYOUT_NORM: ; $FE80
    .BYTE  $0B,$4E,$59,$01,$48,$38,$35,$32
    .BYTE  $09,$58,$57,$11,$53,$0F,$2D,$2E
    .BYTE  $30,$4D,$55,$15,$4A,$37,$34,$31
    .BYTE  $0D,$28,$49,$16,$4B,$4F,$4C,$29
    .BYTE  $19,$43,$45,$12,$44,$2F,$2A,$2B
    .BYTE  $20,$56,$52,$13,$46,$50,$08,$3D
    .BYTE  $02,$5A,$51,$1B,$41,$18,$1F,$0C
    .BYTE  $0A,$42,$54,$14,$47,$39,$36,$33



; Keyboard layout (shift function)
KB_LAYOUT_SH: ; $FEC0
    .BYTE  $5B,$6E,$79,$01,$68,$38,$35,$32
    .BYTE  $09,$78,$77,$21,$73,$0F,$2C,$2E
    .BYTE  $30,$6D,$75,$25,$6A,$37,$34,$31
    .BYTE  $0D,$3C,$69,$26,$6B,$6F,$6C,$3E
    .BYTE  $19,$63,$65,$22,$64,$3F,$3A,$3B
    .BYTE  $5E,$76,$72,$23,$66,$70,$1D,$40
    .BYTE  $02,$7A,$71,$1B,$61,$1A,$1E,$1C
    .BYTE  $5D,$62,$74,$24,$67,$39,$36,$33



; Table for CALL vectors
CALL_VECTORS: ; $FF00                        Vector>Target, Vector>Target, Vector>Target, Vector>Target
    .BYTE  $DC,$B7,$DC,$B6,$DC,$C6,$D0,$65 ; $FF(00)>$DCB7, $FF(02)>$DCB6, $FF(04)>$DCC6, $FF(06)>$D065
    .BYTE  $DD,$D9,$DE,$5E,$DE,$97,$D4,$61 ; $FF(08)>$DDD9, $FF(0A)>$DE5E, $FF(0C)>$DE97, $FF(0E)>$D461
    .BYTE  $DD,$2D,$DF,$93,$DF,$FA,$DF,$F5 ; $FF(10)>$DD2D, $FF(12)>$DF93, $FF(14)>$DFFA, $FF(16)>$DFF5
    .BYTE  $DF,$80,$D2,$E6,$FA,$89,$FB,$2A ; $FF(18)>$DF80, $FF(1A)>$D2E6, $FF(1C)>$FA89, $FF(1E)>$FB2A
    .BYTE  $DF,$72,$DF,$63,$DE,$AF,$DB,$87 ; $FF(20)>$DF72, $FF(22)>$DF63, $FF(24)>$DEAF, $FF(26)>$DB87
    .BYTE  $DB,$B1,$D0,$3E,$DC,$A6,$D6,$C0 ; $FF(28)>$DBB1, $FF(2A)>$D03E, $FF(2C)>$DCA6, $FF(2E)>$D6C0
    .BYTE  $DC,$16,$D0,$71,$DF,$23,$DF,$0F ; $FF(30)>$DC16, $FF(32)>$D071, $FF(34)>$DF23, $FF(36)>$DF0F
    .BYTE  $CE,$9F,$CF,$FB,$FA,$74,$FB,$9D ; $FF(38)>$CE9F, $FF(3A)>$CFFB, $FF(3C)>$FA74, $FF(3E)>$FB9D
    .BYTE  $C4,$01,$CA,$58,$CA,$7A,$CA,$80 ; $FF(40)>$C401, $FF(42)>$CA58, $FF(44)>$CA7A, $FF(46)>$CA80
    .BYTE  $DC,$F9,$DC,$FD,$DC,$E9,$DC,$ED ; $FF(48)>$DCF9, $FF(4A)>$DCFD, $FF(4C)>$DCE9, $FF(4E)>$DCED
    .BYTE  $DA,$71,$F6,$63,$F7,$B0,$F7,$3D ; $FF(50)>$DA71, $FF(52)>$F663, $FF(54)>$F7B0, $FF(56)>$F73D
    .BYTE  $F0,$84,$E5,$73,$F6,$1B,$F7,$A7 ; $FF(58)>$F084, $FF(5A)>$E573, $FF(5C)>$F61B, $FF(5E)>$F7A7
    .BYTE  $F6,$B4,$F8,$8B,$F7,$B5,$F7,$B9 ; $FF(60)>$F6B4, $FF(62)>$F88B, $FF(64)>$F7B5, $FF(66)>$F7B9
    .BYTE  $F7,$15,$F8,$8F,$F6,$FB,$F0,$80 ; $FF(68)>$F715, $FF(6A)>$F88F, $FF(6C)>$F6FB, $FF(6E)>$F080
    .BYTE  $F7,$47,$F7,$CE,$F7,$75,$F7,$5F ; $FF(70)>$F747, $FF(72)>$F7CE, $FF(74)>$F775, $FF(76)>$F75F
    .BYTE  $F7,$2F,$F7,$DD,$F6,$E6,$F0,$1A ; $FF(78)>$F72F, $FF(7A)>$F7DD, $FF(7C)>$F6E6, $FF(7E)>$F01A
    .BYTE  $F7,$07,$F7,$29,$EF,$00,$EB,$40 ; $FF(80)>$F707, $FF(82)>$F729, $FF(84)>$EF00, $FF(86)>$EB40
    .BYTE  $ED,$F6,$ED,$5B,$EE,$1F,$ED,$B1 ; $FF(88)>$EDF6, $FF(8A)>$ED5B, $FF(8C)>$EE1F, $FF(8E)>$EDB1
    .BYTE  $ED,$AB,$ED,$00,$EC,$5C,$EA,$78 ; $FF(90)>$EDAB, $FF(92)>$ED00, $FF(94)>$EC5C, $FF(96)>$EA78
    .BYTE  $EC,$74,$EC,$EB,$EC,$B7,$E4,$A0 ; $FF(98)>$EC74, $FF(9A)>$ECEB, $FF(9C)>$ECB7, $FF(9E)>$E4A0
    .BYTE  $E2,$34,$E6,$55,$B8,$88,$E4,$51 ; $FF(A0)>$E234, $FF(A2)>$E655, $FF(A4)>$B888, $FF(A6)>$E451
    .BYTE  $B8,$8B,$B8,$8E,$E8,$8C,$B8,$91 ; $FF(A8)>$B88B, $FF(AA)>$B88E, $FF(AC)>$E88C, $FF(AE)>$B891
    .BYTE  $B8,$94,$B8,$97,$B8,$9A,$B8,$9D ; $FF(B0)>$B894, $FF(B2)>$B897, $FF(B4)>$B89A, $FF(B6)>$B89D
    .BYTE  $B8,$A0,$F7,$63,$E4,$B7,$E4,$A8 ; $FF(B8)>$B8A0, $FF(BA)>$F763, $FF(BC)>$E4B7, $FF(BE)>$E4A8
    .BYTE  $DD,$08,$DC,$D4,$DC,$D5,$DD,$13 ; $FF(C0)>$DD08, $FF(C2)>$DCD4, $FF(C4)>$DCD5, $FF(C6)>$DD13
    .BYTE  $DC,$C5,$C0,$01,$DD,$C8,$D4,$5D ; $FF(C8)>$DCC5, $FF(CA)>$C001, $FF(CC)>$DDC8, $FF(CE)>$D45D
    .BYTE  $D5,$F9,$DD,$1A,$DE,$E3,$DE,$D1 ; $FF(D0)>$D5F9, $FF(D2)>$DD1A, $FF(D4)>$DEE3, $FF(D6)>$DED1
    .BYTE  $DF,$3B,$C0,$0E,$DE,$BC,$D6,$DF ; $FF(D8)>$DF3B, $FF(DA)>$C00E, $FF(DC)>$DEBC, $FF(DE)>$D6DF
    .BYTE  $CD,$8B,$C4,$00,$CD,$89,$F7,$0D ; $FF(E0)>$CD8B, $FF(E2)>$C400, $FF(E4)>$DEBC, $FF(E6)>$F70D
    .BYTE  $F6,$61,$F7,$9C,$F7,$57,$F7,$CC ; $FF(E8)>$F661, $FF(EA)>$F79C, $FF(EC)>$F757, $FF(EE)>$F7CC
    .BYTE  $EF,$BA,$EE,$71,$DB,$BC,$DD,$B5 ; $FF(F0)>$EFBA, $FF(F2)>$EE71, $FF(F4)>$D8BC, $FF(F6)>$DDB5
    .BYTE  $E1,$71,$E2,$2C,$E2,$2B,$E0,$00 ; $FF(F8)>$E171, $FF(FA)>$E22C, $FF(FC)>$E22B, $FF(FE)>$E000

.END
