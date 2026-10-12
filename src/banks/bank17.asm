SECTION "Bank 17", ROMX[$4000], BANK[$17]
    db $17

; only called from SendSGBPaletteSetPacket (E-0047)
; 1 call site from 1 routine (e.g. SendSGBPaletteSetPacket)
; reads: wSGBActive, wSGBPacketIndex
; points at: wSGBPacketBuffer
SendSGBPaletteSetPacket_WaitSGBActive::
Func_017_4001:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z
    ld a, [wSGBPacketIndex]
    cp a, $FF
    jr nz, .skip
    ld hl, wSGBPacketBuffer
    jr .skip2

.skip:
    ld l, a
    ld h, $00
    add hl, hl
    ld de, SendSGBPaletteSetPacket_WaitSGBActive_Data
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    pop hl

.skip2:
    ld a, [hl]
    and a, $07
    ret z
    ld b, a
    ld c, $00

.skip3:
    push bc
    ld a, $00
    ldh [c], a
    ld a, $30
    ldh [c], a
    ld b, $10

.loop:
    ld e, $08
    ld a, [hl+]
    ld d, a

.loop2:
    bit 0, d
    ld a, $10
    jr nz, .skip4
    ld a, $20

.skip4:
    ldh [c], a
    ld a, $30
    ldh [c], a
    rr d
    dec e
    jr nz, .loop2
    dec b
    jr nz, .loop
    ld a, $20
    ldh [c], a
    ld a, $30
    ldh [c], a
    pop bc
    dec b
    ret z
    call SpinDelay
    jr .skip3

; address loaded by SendSGBPaletteSetPacket_WaitSGBActive
SendSGBPaletteSetPacket_WaitSGBActive_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_017_4055:: ; address name
    db $FF, $40, $0F, $41
    dw PointerRun_17_4059_Entry00
    dw PointerRun_17_4059_Entry01
    dw PointerRun_17_4059_Entry02
    dw PointerRun_17_4059_Entry03
    dw PointerRun_17_4059_Entry04
    dw PointerRun_17_4059_Entry05
    dw PointerRun_17_4059_Entry06
    dw PointerRun_17_4059_Entry07
    dw PointerRun_17_4059_Entry08
    dw PointerRun_17_4059_Entry09
    dw PointerRun_17_4059_Entry0A
    dw PointerRun_17_4059_Entry0B
    dw PointerRun_17_4059_Entry0C
    dw PointerRun_17_4059_Entry0D
    dw PointerRun_17_4059_Entry0E
    dw PointerRun_17_4059_Entry0F
    dw PointerRun_17_4059_Entry10
    dw PointerRun_17_4059_Entry11
    dw PointerRun_17_4059_Entry12

PointerRun_17_4059_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_017_407F:: ; address name
    db $79, $5D, $08, $00, $0B, $8C, $D0, $F4, $60, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry01:: ; heuristic: target of a monotone pointer table; C0
Data_017_408F:: ; address name
    db $79, $52, $08, $00, $0B, $A9, $E7, $9F, $01, $C0, $7E, $E8, $E8, $E8, $E8, $E0

PointerRun_17_4059_Entry02:: ; heuristic: target of a monotone pointer table; C0
Data_017_409F:: ; address name
    db $79, $47, $08, $00, $0B, $C4, $D0, $16, $A5, $CB, $C9, $05, $D0, $10, $A2, $28

PointerRun_17_4059_Entry03:: ; heuristic: target of a monotone pointer table; C0
Data_017_40AF:: ; address name
    db $79, $3C, $08, $00, $0B, $F0, $12, $A5, $C9, $C9, $C8, $D0, $1C, $A5, $CA, $C9

PointerRun_17_4059_Entry04:: ; heuristic: target of a monotone pointer table; C0
Data_017_40BF:: ; address name
    db $79, $31, $08, $00, $0B, $0C, $A5, $CA, $C9, $7E, $D0, $06, $A5, $CB, $C9, $7E

PointerRun_17_4059_Entry05:: ; heuristic: target of a monotone pointer table; C0
Data_017_40CF:: ; address name
    db $79, $26, $08, $00, $0B, $39, $CD, $48, $0C, $D0, $34, $A5, $C9, $C9, $80, $D0

PointerRun_17_4059_Entry06:: ; heuristic: target of a monotone pointer table; C0
Data_017_40DF:: ; address name
    db $79, $1B, $08, $00, $0B, $EA, $EA, $EA, $EA, $EA, $A9, $01, $CD, $4F, $0C, $D0

PointerRun_17_4059_Entry07:: ; heuristic: target of a monotone pointer table; C0
Data_017_40EF:: ; address name
    db $79, $10, $08, $00, $0B, $4C, $20, $08, $EA, $EA, $EA, $EA, $EA, $60, $EA, $EA
    db $B9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $B9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry08:: ; heuristic: target of a monotone pointer table; C0
Data_017_411F:: ; address name
    db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry09:: ; heuristic: target of a monotone pointer table; C0
Data_017_412F:: ; address name
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry0A:: ; heuristic: target of a monotone pointer table; C0
Data_017_413F:: ; address name
    db $59, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry0B:: ; heuristic: target of a monotone pointer table; C0
Data_017_414F:: ; address name
    db $A9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry0C:: ; heuristic: target of a monotone pointer table; C0
Data_017_415F:: ; address name
    db $51, $00, $00, $01, $00, $02, $00, $03, $00, $C0, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry0D:: ; heuristic: target of a monotone pointer table; C0
Data_017_416F:: ; address name
    db $A1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry0E:: ; heuristic: target of a monotone pointer table; C0
Data_017_417F:: ; address name
    db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry0F:: ; heuristic: target of a monotone pointer table; C0
Data_017_418F:: ; address name
    db $99, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry10:: ; heuristic: target of a monotone pointer table; C0
Data_017_419F:: ; address name
    db $C9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry11:: ; heuristic: target of a monotone pointer table; C0
Data_017_41AF:: ; address name
    db $71, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_17_4059_Entry12:: ; heuristic: target of a monotone pointer table; C0
Data_017_41BF:: ; address name
    db $B9, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; when the Super Game Boy is active, builds a PAL_SET ($51) packet from Data_017_426C[wC51F] (also kept in wC577), attribute file wC520 | $80, loads the object palettes and sends it (E-0125)
; 9 call sites from 9 routines (e.g. BootAndMainLoop, GameMode1_Init, GameMode5_Init_InitSoundHardware, GameMode5_Init_SendSGBPaletteSetPacket, ...)
; reads: wSGBActive, wSGBPaletteSet, wTemp0, wSGBAttrFile
; writes: wSGBPacketBuffer, wTemp0, wSGBPacketIndex
; points at: wSGBPaletteNum0Lo
SendSGBPaletteSetPacket::
Func_017_41CF:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z
    call ClearSGBPacketBuffer
    ld a, $51
    ld [wSGBPacketBuffer], a
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, SGBPaletteSets
    add hl, de
    ld de, wSGBPacketBuffer + $1
    ld bc, wSGBPaletteNum0Lo
    ld a, $08
    ld [wTemp0], a

.loop:
    ld a, [hl+]
    ld [de], a
    ld [bc], a
    inc de
    inc bc
    ld a, [wTemp0]
    dec a
    ld [wTemp0], a
    jr nz, .loop
    ld a, [wSGBAttrFile]
    or a, $80
    ld [de], a
    call LoadSGBObjectPalettesFromPointers
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPaletteSetPacket_WaitSGBActive
    call SpinDelay
    ret

; when the Super Game Boy is active, converts the four palettes pointed to by wC577-wC57E into wOBJPaletteBuffer, wC4E7, wC4EF and wC4F7 (Func_017_4258) (E-0121)
; 7 call sites from 7 routines (e.g. SendSGBPaletteSetPacket, SendSGBFieldPaletteSet, GameMode5_Init_LoadSGBObjectPalettesFromPointers, ResetLinkScreenPalettes, ...)
; reads: wSGBActive, wSGBPaletteNum0Lo, wSGBPaletteNum0Hi, wSGBPaletteNum1Lo, wSGBPaletteNum1Hi, wSGBPaletteNum2Lo, wSGBPaletteNum2Hi, wSGBPaletteNum3Lo, ...
; points at: wOBJPaletteBuffer
LoadSGBObjectPalettesFromPointers::
Func_017_421A:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z
    ld a, [wSGBPaletteNum0Lo]
    ld l, a
    ld a, [wSGBPaletteNum0Hi]
    ld h, a
    ld de, wOBJPaletteBuffer
    call LoadSGBObjectPalettesFromPointers_Sub01
    ld de, wOBJPaletteBuffer + $8
    ld a, [wSGBPaletteNum1Lo]
    ld l, a
    ld a, [wSGBPaletteNum1Hi]
    ld h, a
    call LoadSGBObjectPalettesFromPointers_Sub01
    ld de, wOBJPaletteBuffer + $10
    ld a, [wSGBPaletteNum2Lo]
    ld l, a
    ld a, [wSGBPaletteNum2Hi]
    ld h, a
    call LoadSGBObjectPalettesFromPointers_Sub01
    ld de, wOBJPaletteBuffer + $18
    ld a, [wSGBPaletteNum3Lo]
    ld l, a
    ld a, [wSGBPaletteNum3Hi]
    ld h, a
    call LoadSGBObjectPalettesFromPointers_Sub01
    ret

; only called from LoadSGBObjectPalettesFromPointers (E-0047)
; 4 call sites from 1 routine (e.g. LoadSGBObjectPalettesFromPointers)
LoadSGBObjectPalettesFromPointers_Sub01::
Func_017_4258:: ; address name
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $6C
    ld l, a
    ld a, h
    adc a, $44
    ld h, a
    ld c, $08

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

; E-0178 (C1: SendSGBPaletteSetPacket copies the 8 bytes at $426C + 8 * wSGBPaletteSet into a PAL_SET ($51) packet after the command byte and into wSGBPaletteNum0Lo onward, then adds the attribute file wSGBAttrFile | $80; entries 0-63 hold four words below 512 (the SGB's system palette count), the words after them do not).
; record: four SGB system palette numbers for PAL_SET
SGBPaletteSets::
Data_017_426C:: ; address name
    dw 0, 1, 2, 3 ; id 0
    dw 4, 5, 6, 7 ; id 1
    dw 8, 9, 10, 11 ; id 2
    dw 12, 13, 14, 15 ; id 3
    dw 16, 17, 18, 19 ; id 4
    dw 20, 21, 22, 23 ; id 5
    dw 24, 25, 26, 27 ; id 6
    dw 28, 29, 30, 31 ; id 7
    dw 32, 33, 34, 35 ; id 8
    dw 36, 37, 38, 39 ; id 9
    dw 40, 41, 42, 43 ; id 10
    dw 44, 45, 46, 47 ; id 11
    dw 48, 49, 50, 51 ; id 12
    dw 52, 53, 54, 55 ; id 13
    dw 56, 57, 58, 59 ; id 14
    dw 60, 61, 62, 63 ; id 15
    dw 64, 65, 66, 67 ; id 16
    dw 68, 69, 70, 71 ; id 17
    dw 72, 73, 74, 75 ; id 18
    dw 76, 77, 78, 79 ; id 19
    dw 80, 81, 82, 83 ; id 20
    dw 84, 85, 86, 87 ; id 21
    dw 88, 89, 90, 91 ; id 22
    dw 92, 93, 94, 95 ; id 23
    dw 96, 97, 98, 99 ; id 24
    dw 100, 101, 102, 103 ; id 25
    dw 104, 105, 106, 107 ; id 26
    dw 108, 109, 110, 111 ; id 27
    dw 112, 113, 114, 115 ; id 28
    dw 116, 117, 118, 119 ; id 29
    dw 120, 121, 122, 123 ; id 30
    dw 124, 125, 126, 127 ; id 31
    dw 128, 129, 130, 131 ; id 32
    dw 132, 133, 134, 135 ; id 33
    dw 136, 137, 138, 139 ; id 34
    dw 140, 141, 142, 143 ; id 35
    dw 144, 145, 146, 147 ; id 36
    dw 148, 149, 150, 151 ; id 37
    dw 152, 153, 154, 155 ; id 38
    dw 156, 157, 158, 159 ; id 39
    dw 160, 161, 162, 163 ; id 40
    dw 164, 165, 166, 167 ; id 41
    dw 168, 169, 170, 171 ; id 42
    dw 172, 173, 174, 175 ; id 43
    dw 176, 177, 178, 179 ; id 44
    dw 180, 181, 182, 183 ; id 45
    dw 184, 185, 186, 187 ; id 46
    dw 188, 189, 190, 191 ; id 47
    dw 192, 193, 194, 195 ; id 48
    dw 196, 197, 198, 199 ; id 49
    dw 200, 201, 202, 203 ; id 50
    dw 204, 205, 206, 207 ; id 51
    dw 208, 209, 210, 211 ; id 52
    dw 212, 213, 214, 215 ; id 53
    dw 216, 217, 218, 219 ; id 54
    dw 220, 221, 222, 223 ; id 55
    dw 224, 225, 226, 227 ; id 56
    dw 228, 229, 230, 231 ; id 57
    dw 232, 233, 234, 235 ; id 58
    dw 236, 237, 238, 239 ; id 59
    dw 240, 241, 242, 243 ; id 60
    dw 244, 245, 246, 247 ; id 61
    dw 248, 249, 250, 251 ; id 62
    dw 252, 253, 254, 255 ; id 63
    db $DE, $6F, $1F, $33, $3C, $12, $00, $00, $DE, $6F, $1F, $33, $3C, $12, $00, $00
    db $DE, $6F, $1F, $33, $3C, $12, $00, $00, $DE, $6F, $1F, $33, $3C, $12, $00, $00

; LZSS-compressed asset: 7 bytes expand to 90 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Gfx_17_448C:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_017_448C:: ; address name
    db $5A, $00, $01, $01, $A0, $FF, $47

; Super Game Boy border set 0: border tiles $00-$7F (4096 bytes, sent with packet set $10); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3015 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder0TilesA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_017_4493:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $05C493, $BC7

; Super Game Boy border set 0: border tiles $80-$FF (4096 bytes, packet set $11); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 2729 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder0TilesB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_017_505A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $05D05A, $AA9

; Super Game Boy border set 0: border map and palettes ($880 bytes, packet set $0F); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 989 bytes expand to 2176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder0MapAndPalettes:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_017_5B03:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $05DB03, $3DD

; Super Game Boy border set 1: border map and palettes ($880 bytes, packet set $0F); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 710 bytes expand to 2176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder1MapAndPalettes:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_017_5EE0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $05DEE0, $2C6

; Super Game Boy border set 2: border map and palettes ($880 bytes, packet set $0F); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 949 bytes expand to 2176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder2MapAndPalettes:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_017_61A6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $05E1A6, $3B5

; Super Game Boy border set 3: border map and palettes ($880 bytes, packet set $0F); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 989 bytes expand to 2176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder3MapAndPalettes:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_017_655B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $05E55B, $3DD
    ds $16C8, $00
