; ROM bank $17: Super Game Boy packets and border
; The annotated listing of this bank is build/listing/bank17.asm.

SECTION "Bank 17", ROMX[$4000], BANK[$17]
    db $17

; When wSGBActive is set, sends a packet set through rP1 (ldh [c] with C = 0): wSGBPacketBuffer when
; wSGBPacketIndex is $FF, else the pointer in SGBPacketSetTable_Bank17; the first byte's low three
; bits give the number of 16-byte packets, each sent as a reset pulse, 128 bits ($10 for 1, $20 for
; 0, each followed by $30) and a stop bit, with SpinDelay between packets. The same instructions as
; SendSGBPacketSet in bank $1F with this bank's own table; its only caller, SendSGBPaletteSetPacket,
; sets wSGBPacketIndex to $FF first. (C2, E-0370; probed E-0378)
SendSGBPaletteSetPacket_SendPacketSet::
    ld a, [wSGBActive]
    or a
    ret z
    ld a, [wSGBPacketIndex]
    cp $ff
    jr nz, .skip
    ld hl, wSGBPacketBuffer
    jr .skip2

.skip:
    ld l, a
    ld h, $00
    add hl, hl
    ld de, SGBPacketSetTable_Bank17
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    pop hl

.skip2:
    ld a, [hl]
    and $07
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
    ld a, [hli]
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

; A table of 21 words (the first two written as the bytes $FF $40 $0F $41, that is $40FF and $410F),
; indexed by wSGBPacketIndex: each word points to a Super Game Boy packet set whose first byte is
; command * 8 + packet count. Entries 0 and 1 point into the unlabeled packets after
; SgbDataSnd_Bank17_Id9 (MASK_EN 1 and MASK_EN 0), 2 to 9 are the eight DATA_SND packets, 10 and 11
; MLT_REQ, 12 PAL_TRN, 13 ATTR_TRN, 14 PAL_SET, 15 PCT_TRN, 16 and 17 CHR_TRN, 18 PAL_PRI, 19
; ICON_EN, 20 MASK_EN 2. The bank $1F table SGBPacketSetTable has the same 21 entries; here the
; pointer branch is not taken because the only caller, SendSGBPaletteSetPacket, sets wSGBPacketIndex
; to $FF so that the packet in wSGBPacketBuffer is sent instead. (C1, E-0381)
SGBPacketSetTable_Bank17::
    db $ff, $40, $0f, $41
    dw SgbDataSnd_Bank17_Id2
    dw SgbDataSnd_Bank17_Id3
    dw SgbDataSnd_Bank17_Id4
    dw SgbDataSnd_Bank17_Id5
    dw SgbDataSnd_Bank17_Id6
    dw SgbDataSnd_Bank17_Id7
    dw SgbDataSnd_Bank17_Id8
    dw SgbDataSnd_Bank17_Id9
    dw SgbMltReq_Bank17_Id10
    dw SgbMltReq_Bank17_Id11
    dw SgbPalTrn_Bank17_Id12
    dw SgbAttrTrn_Bank17_Id13
    dw SgbPalSet_Bank17_Id14
    dw SgbPctTrn_Bank17_Id15
    dw SgbChrTrn_Bank17_Id16
    dw SgbChrTrn_Bank17_Id17
    dw SgbPalPri_Bank17_Id18
    dw SgbIconEn_Bank17_Id19
    dw SgbMaskEn_Bank17_Id20

; A 16-byte Super Game Boy packet, table entry 2 of SGBPacketSetTable_Bank17. DATA_SND ($79: command
; $0F, one packet): SNES address $00:085D, 11 data bytes $8C $D0 $F4 $60 and seven zeros. It is one
; of eight DATA_SND packets (table entries 2 to 9) that write 88 bytes to SNES addresses $0810 to
; $0867 in descending chunks; the bytes look like machine code for the SNES CPU (opcodes such as
; $EA, $4C and $60 appear), but what the code does is not established here. The packet is not a
; pointer run: the label comes from the dw list in SGBPacketSetTable_Bank17. (C1, E-0381)
SgbDataSnd_Bank17_Id2::
    db $79, $5d, $08, $00, $0b, $8c, $d0, $f4, $60, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet, table entry 3 of SGBPacketSetTable_Bank17. DATA_SND: SNES address
; $00:0852, 11 data bytes $A9 $E7 $9F $01 $C0 $7E $E8 $E8 $E8 $E8 $E0. It is one of eight DATA_SND
; packets (table entries 2 to 9) that write 88 bytes to SNES addresses $0810 to $0867 in descending
; chunks; the bytes look like machine code for the SNES CPU (opcodes such as $EA, $4C and $60
; appear), but what the code does is not established here. The packet is not a pointer run: the
; label comes from the dw list in SGBPacketSetTable_Bank17. (C1, E-0381)
SgbDataSnd_Bank17_Id3::
    db $79, $52, $08, $00, $0b, $a9, $e7, $9f, $01, $c0, $7e, $e8, $e8, $e8, $e8, $e0

; A 16-byte Super Game Boy packet, table entry 4 of SGBPacketSetTable_Bank17. DATA_SND: SNES address
; $00:0847, 11 data bytes $C4 $D0 $16 $A5 $CB $C9 $05 $D0 $10 $A2 $28. It is one of eight DATA_SND
; packets (table entries 2 to 9) that write 88 bytes to SNES addresses $0810 to $0867 in descending
; chunks; the bytes look like machine code for the SNES CPU (opcodes such as $EA, $4C and $60
; appear), but what the code does is not established here. The packet is not a pointer run: the
; label comes from the dw list in SGBPacketSetTable_Bank17. (C1, E-0381)
SgbDataSnd_Bank17_Id4::
    db $79, $47, $08, $00, $0b, $c4, $d0, $16, $a5, $cb, $c9, $05, $d0, $10, $a2, $28

; A 16-byte Super Game Boy packet, table entry 5 of SGBPacketSetTable_Bank17. DATA_SND: SNES address
; $00:083C, 11 data bytes $F0 $12 $A5 $C9 $C9 $C8 $D0 $1C $A5 $CA $C9. It is one of eight DATA_SND
; packets (table entries 2 to 9) that write 88 bytes to SNES addresses $0810 to $0867 in descending
; chunks; the bytes look like machine code for the SNES CPU (opcodes such as $EA, $4C and $60
; appear), but what the code does is not established here. The packet is not a pointer run: the
; label comes from the dw list in SGBPacketSetTable_Bank17. (C1, E-0381)
SgbDataSnd_Bank17_Id5::
    db $79, $3c, $08, $00, $0b, $f0, $12, $a5, $c9, $c9, $c8, $d0, $1c, $a5, $ca, $c9

; A 16-byte Super Game Boy packet, table entry 6 of SGBPacketSetTable_Bank17. DATA_SND: SNES address
; $00:0831, 11 data bytes $0C $A5 $CA $C9 $7E $D0 $06 $A5 $CB $C9 $7E. It is one of eight DATA_SND
; packets (table entries 2 to 9) that write 88 bytes to SNES addresses $0810 to $0867 in descending
; chunks; the bytes look like machine code for the SNES CPU (opcodes such as $EA, $4C and $60
; appear), but what the code does is not established here. The packet is not a pointer run: the
; label comes from the dw list in SGBPacketSetTable_Bank17. (C1, E-0381)
SgbDataSnd_Bank17_Id6::
    db $79, $31, $08, $00, $0b, $0c, $a5, $ca, $c9, $7e, $d0, $06, $a5, $cb, $c9, $7e

; A 16-byte Super Game Boy packet, table entry 7 of SGBPacketSetTable_Bank17. DATA_SND: SNES address
; $00:0826, 11 data bytes $39 $CD $48 $0C $D0 $34 $A5 $C9 $C9 $80 $D0. It is one of eight DATA_SND
; packets (table entries 2 to 9) that write 88 bytes to SNES addresses $0810 to $0867 in descending
; chunks; the bytes look like machine code for the SNES CPU (opcodes such as $EA, $4C and $60
; appear), but what the code does is not established here. The packet is not a pointer run: the
; label comes from the dw list in SGBPacketSetTable_Bank17. (C1, E-0381)
SgbDataSnd_Bank17_Id7::
    db $79, $26, $08, $00, $0b, $39, $cd, $48, $0c, $d0, $34, $a5, $c9, $c9, $80, $d0

; A 16-byte Super Game Boy packet, table entry 8 of SGBPacketSetTable_Bank17. DATA_SND: SNES address
; $00:081B, 11 data bytes $EA x5 $A9 $01 $CD $4F $0C $D0. It is one of eight DATA_SND packets (table
; entries 2 to 9) that write 88 bytes to SNES addresses $0810 to $0867 in descending chunks; the
; bytes look like machine code for the SNES CPU (opcodes such as $EA, $4C and $60 appear), but what
; the code does is not established here. The packet is not a pointer run: the label comes from the
; dw list in SGBPacketSetTable_Bank17. (C1, E-0381)
SgbDataSnd_Bank17_Id8::
    db $79, $1b, $08, $00, $0b, $ea, $ea, $ea, $ea, $ea, $a9, $01, $cd, $4f, $0c, $d0

; Three 16-byte Super Game Boy packets. The first is table entry 9 of SGBPacketSetTable_Bank17, the
; last DATA_SND packet: SNES address $00:0810, 11 data bytes $4C $20 $08 $EA x5 $60 $EA $EA (the
; first bytes read like a jump to $0820, then no-ops and a return). The next 16 bytes ($B9 $01, at
; $40FF) and the 16 after them ($B9 $00, at $410F) are MASK_EN packets with mode 1 (freeze the
; screen) and mode 0 (cancel the mask); they are table entries 0 and 1 and have no label of their
; own. (C1, E-0381)
SgbDataSnd_Bank17_Id9::
    db $79, $10, $08, $00, $0b, $4c, $20, $08, $ea, $ea, $ea, $ea, $ea, $60, $ea, $ea
    db $b9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $b9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 10 of
; SGBPacketSetTable_Bank17: MLT_REQ ($89: command $11, one packet) with parameter 0, which selects
; one-player mode. It has the same bytes as the packet of the same table entry in bank $1F
; (SGBPacketSetTable). The label comes from the dw list, the data is a packet and not a run of
; pointers. (C1, E-0381)
SgbMltReq_Bank17_Id10::
    db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 11 of
; SGBPacketSetTable_Bank17: MLT_REQ with parameter 1, which selects two-player mode. It has the same
; bytes as the packet of the same table entry in bank $1F (SGBPacketSetTable). The label comes from
; the dw list, the data is a packet and not a run of pointers. (C1, E-0381)
SgbMltReq_Bank17_Id11::
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 12 of
; SGBPacketSetTable_Bank17: PAL_TRN ($59: command $0B), whose parameters are all zero: the SNES
; takes palette data from the screen transfer sent next. It has the same bytes as the packet of the
; same table entry in bank $1F (SGBPacketSetTable). The label comes from the dw list, the data is a
; packet and not a run of pointers. (C1, E-0381)
SgbPalTrn_Bank17_Id12::
    db $59, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 13 of
; SGBPacketSetTable_Bank17: ATTR_TRN ($A9: command $15), whose parameters are all zero: the SNES
; takes attribute files from the screen transfer sent next. It has the same bytes as the packet of
; the same table entry in bank $1F (SGBPacketSetTable). The label comes from the dw list, the data
; is a packet and not a run of pointers. (C1, E-0381)
SgbAttrTrn_Bank17_Id13::
    db $a9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 14 of
; SGBPacketSetTable_Bank17: PAL_SET ($51: command $0A) with palette numbers 0, 1, 2, 3 in bytes 1 to
; 8 and $C0 in byte 9 (apply attribute file 0, cancel the screen mask). It has the same bytes as the
; packet of the same table entry in bank $1F (SGBPacketSetTable). The label comes from the dw list,
; the data is a packet and not a run of pointers. (C1, E-0381)
SgbPalSet_Bank17_Id14::
    db $51, $00, $00, $01, $00, $02, $00, $03, $00, $c0, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 15 of
; SGBPacketSetTable_Bank17: PCT_TRN ($A1: command $14), whose parameters are all zero: the SNES
; takes the border picture from the screen transfer sent next. It has the same bytes as the packet
; of the same table entry in bank $1F (SGBPacketSetTable). The label comes from the dw list, the
; data is a packet and not a run of pointers. (C1, E-0381)
SgbPctTrn_Bank17_Id15::
    db $a1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 16 of
; SGBPacketSetTable_Bank17: CHR_TRN ($99: command $13) with parameter 0, the transfer of border
; tiles $00 to $7F. It has the same bytes as the packet of the same table entry in bank $1F
; (SGBPacketSetTable). The label comes from the dw list, the data is a packet and not a run of
; pointers. (C1, E-0381)
SgbChrTrn_Bank17_Id16::
    db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 17 of
; SGBPacketSetTable_Bank17: CHR_TRN with parameter 1, the transfer of border tiles $80 to $FF. It
; has the same bytes as the packet of the same table entry in bank $1F (SGBPacketSetTable). The
; label comes from the dw list, the data is a packet and not a run of pointers. (C1, E-0381)
SgbChrTrn_Bank17_Id17::
    db $99, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 18 of
; SGBPacketSetTable_Bank17: PAL_PRI ($C9: command $19) with parameter 1. It has the same bytes as
; the packet of the same table entry in bank $1F (SGBPacketSetTable). The label comes from the dw
; list, the data is a packet and not a run of pointers. (C1, E-0381)
SgbPalPri_Bank17_Id18::
    db $c9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 19 of
; SGBPacketSetTable_Bank17: ICON_EN ($71: command $0E) with parameter 1. It has the same bytes as
; the packet of the same table entry in bank $1F (SGBPacketSetTable). The label comes from the dw
; list, the data is a packet and not a run of pointers. (C1, E-0381)
SgbIconEn_Bank17_Id19::
    db $71, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; A 16-byte Super Game Boy packet (command * 8 + packet count in byte 0), table entry 20 of
; SGBPacketSetTable_Bank17: MASK_EN ($B9: command $17) with mode 2, which blanks the screen to
; black. It has the same bytes as the packet of the same table entry in bank $1F
; (SGBPacketSetTable). The label comes from the dw list, the data is a packet and not a run of
; pointers. (C1, E-0381)
SgbMaskEn_Bank17_Id20::
    db $b9, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; Does nothing unless wSGBActive is non-zero. Then it clears wSGBPacketBuffer and builds a PAL_SET
; ($51) packet there: bytes 1-8 are the four palette-number words of SGBPaletteSets[wSGBPaletteSet]
; (also copied to wSGBPaletteNum0Lo-3Hi), byte 9 is wSGBAttrFile or $80. It converts the four object
; palettes (LoadSGBObjectPalettesFromPointers), sets wSGBPacketIndex to $FF, sends the packet
; (SendSGBPaletteSetPacket_SendPacketSet) and runs SpinDelay. (C2, E-0378)
; when the Super Game Boy is active, builds a PAL_SET ($51) packet from
; SGBPaletteSets[wSGBPaletteSet] (also kept in wSGBPaletteNum0Lo), attribute file wSGBAttrFile |
; $80, loads the object palettes and sends it (E-0125)
SendSGBPaletteSetPacket::
    ld a, [wSGBActive]
    or a
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
    ld a, [hli]
    ld [de], a
    ld [bc], a
    inc de
    inc bc
    ld a, [wTemp0]
    dec a
    ld [wTemp0], a
    jr nz, .loop
    ld a, [wSGBAttrFile]
    or $80
    ld [de], a
    call LoadSGBObjectPalettesFromPointers
    ld a, $ff
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPaletteSetPacket_SendPacketSet
    call SpinDelay
    ret

; Does nothing unless wSGBActive is non-zero. Otherwise copies the four 8-byte palettes numbered by
; the words wSGBPaletteNum0Lo/Hi to wSGBPaletteNum3Lo/Hi
; (LoadSGBObjectPalettesFromPointers_CopyPaletteEntry, data at $446C + 8 x number in bank $17) to
; wOBJPaletteBuffer, + $8, + $10 and + $18. (C2, E-0378)
; when the Super Game Boy is active, converts the four palettes pointed to by
; wSGBPaletteNum0Lo-wSGBPaletteNum3Hi into wOBJPaletteBuffer, wOBJPaletteBuffer + $8,
; wOBJPaletteBuffer + $10 and wOBJPaletteBuffer + $18
; (LoadSGBObjectPalettesFromPointers_CopyPaletteEntry) (E-0121)
LoadSGBObjectPalettesFromPointers::
    ld a, [wSGBActive]
    or a
    ret z
    ld a, [wSGBPaletteNum0Lo]
    ld l, a
    ld a, [wSGBPaletteNum0Hi]
    ld h, a
    ld de, wOBJPaletteBuffer
    call LoadSGBObjectPalettesFromPointers_CopyPaletteEntry
    ld de, wOBJPaletteBuffer + $8
    ld a, [wSGBPaletteNum1Lo]
    ld l, a
    ld a, [wSGBPaletteNum1Hi]
    ld h, a
    call LoadSGBObjectPalettesFromPointers_CopyPaletteEntry
    ld de, wOBJPaletteBuffer + $10
    ld a, [wSGBPaletteNum2Lo]
    ld l, a
    ld a, [wSGBPaletteNum2Hi]
    ld h, a
    call LoadSGBObjectPalettesFromPointers_CopyPaletteEntry
    ld de, wOBJPaletteBuffer + $18
    ld a, [wSGBPaletteNum3Lo]
    ld l, a
    ld a, [wSGBPaletteNum3Hi]
    ld h, a
    call LoadSGBObjectPalettesFromPointers_CopyPaletteEntry
    ret

; HL = palette number, DE = destination: copies the 8 bytes at $446C + 8 x HL (bank $17) to DE; DE
; ends past them. (C2, E-0378)
; copies the 8 bytes at $446C + 8 * HL to DE
LoadSGBObjectPalettesFromPointers_CopyPaletteEntry::
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add $6c
    ld l, a
    ld a, h
    adc $44
    ld h, a
    ld c, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

; SendSGBPaletteSetPacket copies the 8 bytes at $426C + 8 * wSGBPaletteSet into a PAL_SET ($51)
; packet after the command byte and into wSGBPaletteNum0Lo onward, then adds the attribute file
; wSGBAttrFile | $80; entries 0-63 hold four words below 512 (the SGB's system palette count), the
; words after them do not (E-0178, C1)
; record: four SGB system palette numbers for PAL_SET
SGBPaletteSets::
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
    db $de, $6f, $1f, $33, $3c, $12, $00, $00, $de, $6f, $1f, $33, $3c, $12, $00, $00
    db $de, $6f, $1f, $33, $3c, $12, $00, $00, $de, $6f, $1f, $33, $3c, $12, $00, $00

; LZSS-compressed: 7 bytes that expand to 90 (E-0016, E-0017)
BootAndMainLoop_StartUp_Gfx::
    db $5a, $00, $01, $01, $a0, $ff, $47

; Super Game Boy border set 0: border tiles $00-$7F (4096 bytes, sent with packet set $10);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3015 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py,
; E-0016/E-0017; C1)
SGBBorder0TilesA::
    INCBIN "gfx/sgb_border/0_tiles_a.lz"

; Super Game Boy border set 0: border tiles $80-$FF (4096 bytes, packet set $11);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 2729 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py,
; E-0016/E-0017; C1)
SGBBorder0TilesB::
    INCBIN "gfx/sgb_border/0_tiles_b.lz"

; Super Game Boy border set 0: border map and palettes ($880 bytes, packet set $0F);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed: 989 bytes that expand to 2176 (E-0016, E-0017)
SGBBorder0MapAndPalettes::
    INCBIN "gfx/sgb_border/0_map_and_palettes.lz"

; Super Game Boy border set 1: border map and palettes ($880 bytes, packet set $0F);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed: 710 bytes that expand to 2176 (E-0016, E-0017)
SGBBorder1MapAndPalettes::
    INCBIN "gfx/sgb_border/1_map_and_palettes.lz"

; Super Game Boy border set 2: border map and palettes ($880 bytes, packet set $0F);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed: 949 bytes that expand to 2176 (E-0016, E-0017)
SGBBorder2MapAndPalettes::
    INCBIN "gfx/sgb_border/2_map_and_palettes.lz"

; Super Game Boy border set 3: border map and palettes ($880 bytes, packet set $0F);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed: 989 bytes that expand to 2176 (E-0016, E-0017)
SGBBorder3MapAndPalettes::
    INCBIN "gfx/sgb_border/3_map_and_palettes.lz"
    ds $16c8, $00
