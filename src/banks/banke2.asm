SECTION "Bank E2", ROMX[$4000], BANK[$E2]
    db $E2

Func_0E2_4001:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7080
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $443B
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_401A
    ld bc, $0000
    call Func_0E2_64CE

Jump_0E2_401A::
    ld hl, $4B3D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_402A
    ld bc, $0001
    call Func_0E2_64CE

Jump_0E2_402A::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_403A
    ld bc, $0002
    call Func_0E2_64CE

Jump_0E2_403A::
    ld hl, Jump_0E2_4CE5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_404E
    and a, a
    jr nz, Jump_0E2_404E
    ld bc, $0003
    call Func_0E2_64F5

Jump_0E2_404E::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_405E
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_405E::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_406E
    ld bc, $0006
    call Func_0E2_64CE

Jump_0E2_406E::
    ld hl, $6481
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_407E
    ld bc, $0066
    call Func_0E2_64CE

Jump_0E2_407E::
    ld hl, $6494
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_408E
    ld bc, $0067
    call Func_0E2_64CE

Jump_0E2_408E::
    ld hl, Data_0E2_64CC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_409E
    ld bc, $0068
    call Func_0E2_64CE

Jump_0E2_409E::
    ld hl, Data_0E2_6972
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_40AE
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_40AE::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_40BE
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_40BE::
    ret

Func_0E2_40BF:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_708C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_40D8
    ld bc, $0008
    call Func_0E2_64F5

Jump_0E2_40D8::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_40E8
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_40E8::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_40F8
    ld bc, $000B
    call Func_0E2_64CE

Jump_0E2_40F8::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4108
    ld bc, $000C
    call Func_0E2_64CE

Jump_0E2_4108::
    call Func_0E2_6822
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_411B
    ld bc, $0010
    call Func_0E2_64F5

Jump_0E2_411B::
    ret

Func_0E2_411C:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_708C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4676
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4139
    and a, a
    jr nz, Jump_0E2_4139
    ld bc, $0004
    call Func_0E2_64F5

Jump_0E2_4139::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4149
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_4149::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4159
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4159::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4169
    ld bc, $000B
    call Func_0E2_64CE

Jump_0E2_4169::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4179
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4179::
    call Func_0E2_6822
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_418C
    ld bc, $0014
    call Func_0E2_64CE

Jump_0E2_418C::
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_419C
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_419C::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41B0
    and a, a
    jr nz, Jump_0E2_41B0
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_41B0::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41C4
    and a, a
    jr nz, Jump_0E2_41C4
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_41C4::
    ret

Func_0E2_41C5:: ; heuristic: follows a terminator; C0
    call Func_0E2_41E0
    ld a, c
    and a, a
    ret z
    ld hl, $6153
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41DF
    and a, a
    jr nz, Jump_0E2_41DF
    ld bc, $00B5
    call Func_0E2_64CE

Jump_0E2_41DF::
    ret

Func_0E2_41E0::
    ld hl, Data_0E2_70C9
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4676
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41FD
    and a, a
    jr nz, Jump_0E2_41FD
    ld bc, $0004
    call Func_0E2_64F5

Jump_0E2_41FD::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4213
    ld bc, $00CD
    call Func_0E2_64CE
    ld bc, $00CF
    call Func_0E2_64F5

Jump_0E2_4213::
    call Func_0E2_6822
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4226
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_4226::
    ld hl, $6153
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_423A
    and a, a
    jr nz, Jump_0E2_423A
    ld bc, $00B5
    call Func_0E2_64CE

Jump_0E2_423A::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_424E
    and a, a
    jr nz, Jump_0E2_424E
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_424E::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4262
    and a, a
    jr nz, Jump_0E2_4262
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4262::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4276
    and a, a
    jr nz, Jump_0E2_4276
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4276::
    ld c, $01
    ret

Func_0E2_4279:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7109
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4707
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4292
    ld bc, $0017
    call Func_0E2_64F5

Jump_0E2_4292::
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_42A2
    ld bc, $0017
    call Func_0E2_64F5

Jump_0E2_42A2::
    ld hl, $4B3D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_42B2
    ld bc, $0011
    call Func_0E2_64F5

Jump_0E2_42B2::
    ld hl, $4BE1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_42C2
    ld bc, $001B
    call Func_0E2_64F5

Jump_0E2_42C2::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_42D2
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_42D2::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_42E8
    ld bc, $00CD
    call Func_0E2_64CE
    ld bc, $00CF
    call Func_0E2_64F5

Jump_0E2_42E8::
    call Func_0E2_6843
    ld hl, $5803
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_42FB
    ld bc, $0019
    call Func_0E2_64CE

Jump_0E2_42FB::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_430F
    and a, a
    jr nz, Jump_0E2_430F
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_430F::
    ret

Func_0E2_4310:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_715F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $6556
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Func_0E2_432D
    and a, a
    jr nz, Func_0E2_432D
    ld bc, $0069
    call Func_0E2_64F5

Func_0E2_432D::
    ld hl, $44CF
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_433D
    ld bc, $001A
    call Func_0E2_64CE

Jump_0E2_433D::
    ld hl, $4664
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_434D
    ld bc, $001A
    call Func_0E2_64CE

Jump_0E2_434D::
    ld hl, $4BE1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_435D
    ld bc, $001B
    call Func_0E2_64F5

Jump_0E2_435D::
    ld a, [$D8A4]
    call Func_0E2_667F
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4373
    ld bc, $0023
    call Func_0E2_64CE

Jump_0E2_4373::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4389
    ld bc, $0024
    call Func_0E2_64CE
    ld bc, $00C8
    call Func_0E2_64CE

Jump_0E2_4389::
    call Func_0E2_6865
    ret

Func_0E2_438D:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_715F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_432D
    ld hl, $53A5
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_43A9
    ld bc, $0023
    call Func_0E2_64CE

Jump_0E2_43A9::
    ld hl, $6556
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_43BD
    and a, a
    jr nz, Jump_0E2_43BD
    ld bc, $0069
    call Func_0E2_64CE

Jump_0E2_43BD::
    ret

Func_0E2_43BE:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7187
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ret

Func_0E2_43C8:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_71AC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67D5
    ld hl, Func_0E2_667F
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_43E8
    and a, a
    jr nz, Jump_0E2_43E8
    ld bc, $002E
    call Func_0E2_64F5

Jump_0E2_43E8::
    ret

Func_0E2_43E9:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_71BE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67D5
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_440B
    ld bc, $00BC
    call Func_0E2_64CE
    ld bc, $00C4
    call Func_0E2_64F5

Jump_0E2_440B::
    ld hl, Func_0E2_667F
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_441F
    and a, a
    jr nz, Jump_0E2_441F
    ld bc, $002E
    call Func_0E2_64F5

Jump_0E2_441F::
    ret

Func_0E2_4420:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_71DE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call Func_0E2_64CE
    call Func_0E2_6865
    ret

Func_0E2_4433:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_71F4
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call Func_0E2_64CE
    call Func_0E2_6865
    ret

Func_0E2_4446:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_720A
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call Func_0E2_64CE
    call Func_0E2_6865
    ret

Func_0E2_4459:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7220
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call Func_0E2_64CE
    call Func_0E2_6865
    ret

Func_0E2_446C:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7236
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4485
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4485::
    call Func_0E2_6854
    call Func_0E2_6773
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_449B
    ld bc, $00C1
    call Func_0E2_64F5

Jump_0E2_449B::
    ret

Func_0E2_449C:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_724F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_44B5
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_44B5::
    ld hl, $50E3
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_44C9
    and a, a
    jr nz, Jump_0E2_44C9
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_44C9::
    ld hl, $517D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_44DD
    and a, a
    jr nz, Jump_0E2_44DD
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_44DD::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_44F3
    ld bc, $00CC
    call Func_0E2_64CE
    ld bc, $00D1
    call Func_0E2_64F5

Jump_0E2_44F3::
    call Func_0E2_6854
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_450A
    and a, a
    jr nz, Jump_0E2_450A
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_450A::
    call Func_0E2_678C
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4521
    and a, a
    jr nz, Jump_0E2_4521
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4521::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4535
    and a, a
    jr nz, Jump_0E2_4535
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4535::
    ret

Func_0E2_4536:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_727A
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4B97
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_454F
    ld bc, $002D
    call Func_0E2_64F5

Jump_0E2_454F::
    ld hl, $50B7
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4563
    and a, a
    jr nz, Jump_0E2_4563
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_4563::
    call Func_0E2_6854
    ret

Func_0E2_4567:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7293
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4676
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4584
    and a, a
    jr nz, Jump_0E2_4584
    ld bc, $0004
    call Func_0E2_64F5

Jump_0E2_4584::
    ld hl, $4B97
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4594
    ld bc, $002D
    call Func_0E2_64F5

Jump_0E2_4594::
    ld hl, $50B7
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45A8
    and a, a
    jr nz, Jump_0E2_45A8
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_45A8::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_45BE
    ld bc, $00CC
    call Func_0E2_64CE
    ld bc, $00D1
    call Func_0E2_64F5

Jump_0E2_45BE::
    call Func_0E2_6854
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45D5
    and a, a
    jr nz, Jump_0E2_45D5
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_45D5::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45E9
    and a, a
    jr nz, Jump_0E2_45E9
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_45E9::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45FD
    and a, a
    jr nz, Jump_0E2_45FD
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_45FD::
    ret

Func_0E2_45FE:: ; heuristic: follows a terminator; C0
    call Func_0E2_4619
    ld a, c
    and a, a
    ret z
    ld hl, $5F3D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4618
    and a, a
    jr nz, Jump_0E2_4618
    ld bc, $00B3
    call Func_0E2_64CE

Jump_0E2_4618::
    ret

Func_0E2_4619::
    ld hl, Data_0E2_72AC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $51EA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4636
    and a, a
    jr nz, Jump_0E2_4636
    ld bc, $002F
    call Func_0E2_64CE

Jump_0E2_4636::
    ld hl, $5228
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_464A
    and a, a
    jr nz, Jump_0E2_464A
    ld bc, $0030
    call Func_0E2_64CE

Jump_0E2_464A::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_465A
    ld bc, $00BA
    call Func_0E2_64CE

Jump_0E2_465A::
    call Func_0E2_6854
    ld hl, $5F3D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4671
    and a, a
    jr nz, Jump_0E2_4671
    ld bc, $00B3
    call Func_0E2_64CE

Jump_0E2_4671::
    ld c, $01
    ret

Func_0E2_4674:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_72BE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4676
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4691
    and a, a
    jr nz, Jump_0E2_4691
    ld bc, $0004
    call Func_0E2_64F5

Jump_0E2_4691::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_46A1
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_46A1::
    ld hl, $5275
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_46B5
    and a, a
    jr nz, Jump_0E2_46B5
    ld bc, $0031
    call Func_0E2_64CE

Jump_0E2_46B5::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_46D1
    ld bc, $00BA
    call Func_0E2_64F5
    ld bc, $00CC
    call Func_0E2_64CE
    ld bc, $00D1
    call Func_0E2_64F5

Jump_0E2_46D1::
    call Func_0E2_6854
    ld hl, $585D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_46E4
    ld bc, $0032
    call Func_0E2_64CE

Jump_0E2_46E4::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_46F8
    and a, a
    jr nz, Jump_0E2_46F8
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_46F8::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_470C
    and a, a
    jr nz, Jump_0E2_470C
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_470C::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4720
    and a, a
    jr nz, Jump_0E2_4720
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4720::
    ret

Func_0E2_4721:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_72DE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4676
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_473E
    and a, a
    jr nz, Jump_0E2_473E
    ld bc, $0004
    call Func_0E2_64F5

Jump_0E2_473E::
    ld hl, $50B7
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4752
    and a, a
    jr nz, Jump_0E2_4752
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_4752::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4762
    ld bc, $00BC
    call Func_0E2_64F5

Jump_0E2_4762::
    call Func_0E2_6854
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4779
    and a, a
    jr nz, Jump_0E2_4779
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4779::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_478D
    and a, a
    jr nz, Jump_0E2_478D
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_478D::
    ret

Func_0E2_478E:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_72F7
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $558B
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_47A7
    ld bc, $0034
    call Func_0E2_64F5

Jump_0E2_47A7::
    call Func_0E2_6854
    ret

Func_0E2_47AB:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7322
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0035
    call Func_0E2_64CE
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_47CA
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_47CA::
    call Func_0E2_6854
    ret

Func_0E2_47CE:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7345
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4676
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_47EB
    and a, a
    jr nz, Jump_0E2_47EB
    ld bc, $0004
    call Func_0E2_64F5

Jump_0E2_47EB::
    call Func_0E2_6854
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4804
    ld bc, $00CC
    call Func_0E2_64CE
    ld bc, $00D1
    call Func_0E2_64F5

Jump_0E2_4804::
    ld hl, $57A1
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4818
    and a, a
    jr nz, Jump_0E2_4818
    ld bc, $0036
    call Func_0E2_64CE

Jump_0E2_4818::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_482C
    and a, a
    jr nz, Jump_0E2_482C
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_482C::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4840
    and a, a
    jr nz, Jump_0E2_4840
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4840::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4854
    and a, a
    jr nz, Jump_0E2_4854
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4854::
    ret

Func_0E2_4855:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7370
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_486E
    ld bc, $00CA
    call Func_0E2_64CE

Jump_0E2_486E::
    call Func_0E2_6854
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4885
    and a, a
    jr nz, Jump_0E2_4885
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_4885::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4899
    and a, a
    jr nz, Jump_0E2_4899
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4899::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_48AD
    and a, a
    jr nz, Jump_0E2_48AD
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_48AD::
    ret

Func_0E2_48AE:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_48CB
    ld bc, $00D0
    call Func_0E2_64CE

Jump_0E2_48CB::
    call Func_0E2_6854
    ret

Func_0E2_48CF:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_73D7
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_48E8
    ld bc, $00C0
    call Func_0E2_64F5

Jump_0E2_48E8::
    ld hl, $57A1
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_48FC
    and a, a
    jr nz, Jump_0E2_48FC
    ld bc, $0036
    call Func_0E2_64CE

Jump_0E2_48FC::
    ret

Func_0E2_48FD:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7410
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $53FA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_491A
    and a, a
    jr nz, Jump_0E2_491A
    ld bc, $003A
    call Func_0E2_64CE

Jump_0E2_491A::
    call Func_0E2_6854
    ret

Func_0E2_491E:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7449
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_6854
    ld hl, $57A1
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_493E
    and a, a
    jr nz, Jump_0E2_493E
    ld bc, $0036
    call Func_0E2_64CE

Jump_0E2_493E::
    ret

Func_0E2_493F:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7482
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $517D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_495C
    and a, a
    jr nz, Jump_0E2_495C
    ld bc, $003B
    call Func_0E2_64CE

Jump_0E2_495C::
    ld hl, $544F
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4970
    and a, a
    jr nz, Jump_0E2_4970
    ld bc, $003C
    call Func_0E2_64CE

Jump_0E2_4970::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4980
    ld bc, $00CE
    call Func_0E2_64CE

Jump_0E2_4980::
    call Func_0E2_6854
    ret

Func_0E2_4984:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7482
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $53FA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_49A1
    and a, a
    jr nz, Jump_0E2_49A1
    ld bc, $003A
    call Func_0E2_64CE

Jump_0E2_49A1::
    call Func_0E2_6854
    ld hl, $5BBC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_49B4
    ld bc, $003D
    call Func_0E2_64CE

Jump_0E2_49B4::
    ret

Func_0E2_49B5:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7494
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_49CE
    ld bc, $003F
    call Func_0E2_64CE

Jump_0E2_49CE::
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_49DE
    ld bc, $0040
    call Func_0E2_64CE

Jump_0E2_49DE::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_49F4
    ld bc, $00BF
    call Func_0E2_64CE
    ld bc, $00C5
    call Func_0E2_64F5

Jump_0E2_49F4::
    call Func_0E2_6854
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A07
    ld bc, $0042
    call Func_0E2_64CE

Jump_0E2_4A07::
    ret

Func_0E2_4A08:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_74B5
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A21
    ld bc, $0043
    call Func_0E2_64CE

Jump_0E2_4A21::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A31
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4A31::
    ld hl, $4D1A
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A41
    ld bc, $0044
    call Func_0E2_64F5

Jump_0E2_4A41::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A51
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4A51::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A61
    ld bc, $0045
    call Func_0E2_64CE

Jump_0E2_4A61::
    ld hl, $56FC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A71
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_4A71::
    ld hl, $5731
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A81
    ld bc, $0046
    call Func_0E2_64CE

Jump_0E2_4A81::
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A91
    ld bc, $0047
    call Func_0E2_64CE

Jump_0E2_4A91::
    ld hl, $5CE1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AA1
    ld bc, $0048
    call Func_0E2_64CE

Jump_0E2_4AA1::
    ld hl, $6392
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4AB5
    or a, a
    jr nz, Jump_0E2_4AB5
    ld bc, $003E
    call Func_0E2_64F5

Jump_0E2_4AB5::
    ret

Func_0E2_4AB6:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_74D1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4707
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ACF
    ld bc, $0049
    call Func_0E2_64CE

Jump_0E2_4ACF::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ADF
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_4ADF::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AEF
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4AEF::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AFF
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4AFF::
    call Func_0E2_6898
    ld hl, $5731
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B12
    ld bc, $0046
    call Func_0E2_64CE

Jump_0E2_4B12::
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B22
    ld bc, $0047
    call Func_0E2_64CE

Jump_0E2_4B22::
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B32
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_4B32::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4B46
    and a, a
    jr nz, Jump_0E2_4B46
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_4B46::
    ld hl, Func_0E2_5CCE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B56
    ld bc, $004B
    call Func_0E2_64CE

Jump_0E2_4B56::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4B6A
    and a, a
    jr nz, Jump_0E2_4B6A
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_4B6A::
    ret

Func_0E2_4B6B:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_74F9
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $46B4
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B84
    ld bc, $004C
    call Func_0E2_64F5

Jump_0E2_4B84::
    ld hl, $4B3D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B94
    ld bc, $0011
    call Func_0E2_64F5

Jump_0E2_4B94::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BA4
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_4BA4::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BB4
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4BB4::
    ld hl, $53E6
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BC4
    ld bc, $004D
    call Func_0E2_64CE

Jump_0E2_4BC4::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BD4
    ld bc, $006A
    call Func_0E2_64CE

Jump_0E2_4BD4::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BE4
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4BE4::
    call Func_0E2_6876
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BF7
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_4BF7::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4C0B
    and a, a
    jr nz, Jump_0E2_4C0B
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_4C0B::
    ld hl, $5D31
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C1B
    ld bc, $004E
    call Func_0E2_64F5

Jump_0E2_4C1B::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4C2F
    and a, a
    jr nz, Jump_0E2_4C2F
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_4C2F::
    ret

Func_0E2_4C30:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_74D1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Func_0E2_4C49
    ld bc, $0010
    call Func_0E2_64F5

Func_0E2_4C49::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C59
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4C59::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C69
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_4C69::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C79
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4C79::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C89
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4C89::
    call Func_0E2_6898
    ld hl, $5D44
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CA0
    and a, a
    jr nz, Jump_0E2_4CA0
    ld bc, $004F
    call Func_0E2_64CE

Jump_0E2_4CA0::
    ret

Func_0E2_4CA1:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_74D1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_4C49
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4CBD
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_4CBD::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CD1
    and a, a
    jr nz, Jump_0E2_4CD1
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_4CD1::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CE5
    and a, a
    jr nz, Jump_0E2_4CE5
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_4CE5::
    ret

Func_0E2_4CE6:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7512
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4CFF
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4CFF::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D0F
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_4D0F::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D1F
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4D1F::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D2F
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4D2F::
    call Func_0E2_6898
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D42
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_4D42::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4D56
    and a, a
    jr nz, Jump_0E2_4D56
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_4D56::
    ld hl, Data_0E2_64CC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D66
    ld bc, $006B
    call Func_0E2_64F5

Jump_0E2_4D66::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4D7A
    and a, a
    jr nz, Jump_0E2_4D7A
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_4D7A::
    ret

Func_0E2_4D7B:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7512
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D94
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4D94::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DA4
    ld bc, $000D
    call Func_0E2_64F5

Jump_0E2_4DA4::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DB4
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4DB4::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DC4
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4DC4::
    call Func_0E2_6898
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DD7
    ld bc, $0010
    call Func_0E2_64F5

Jump_0E2_4DD7::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4DEB
    and a, a
    jr nz, Jump_0E2_4DEB
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_4DEB::
    ret

Func_0E2_4DEC:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7512
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E05
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4E05::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E15
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_4E15::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E25
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4E25::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E35
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4E35::
    call Func_0E2_6898
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E48
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_4E48::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4E5C
    and a, a
    jr nz, Jump_0E2_4E5C
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_4E5C::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4E70
    and a, a
    jr nz, Jump_0E2_4E70
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_4E70::
    ret

Func_0E2_4E71:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7512
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E8A
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4E8A::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E9A
    ld bc, $0008
    call Func_0E2_64F5

Jump_0E2_4E9A::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EAA
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4EAA::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EBA
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_4EBA::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ED0
    ld bc, $00BE
    call Func_0E2_64F5
    ld bc, $00C5
    call Func_0E2_64CE

Jump_0E2_4ED0::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EE0
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4EE0::
    call Func_0E2_6898
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EF3
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_4EF3::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F07
    and a, a
    jr nz, Jump_0E2_4F07
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_4F07::
    ld hl, $5D44
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F1B
    and a, a
    jr nz, Jump_0E2_4F1B
    ld bc, $004F
    call Func_0E2_64CE

Jump_0E2_4F1B::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F2F
    and a, a
    jr nz, Jump_0E2_4F2F
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_4F2F::
    ret

Func_0E2_4F30:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7512
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F49
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_4F49::
    ld hl, Jump_0E2_4CE5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F5D
    and a, a
    jr nz, Jump_0E2_4F5D
    ld bc, $0003
    call Func_0E2_64F5

Jump_0E2_4F5D::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F6D
    ld bc, $0008
    call Func_0E2_64F5

Jump_0E2_4F6D::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F7D
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_4F7D::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F8D
    ld bc, $0055
    call Func_0E2_64CE

Jump_0E2_4F8D::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F9D
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_4F9D::
    call Func_0E2_6898
    ld hl, $6481
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FB0
    ld bc, $0066
    call Func_0E2_64CE

Jump_0E2_4FB0::
    ld hl, $6494
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FC0
    ld bc, $0067
    call Func_0E2_64CE

Jump_0E2_4FC0::
    ld hl, Data_0E2_6972
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FD0
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_4FD0::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FE0
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_4FE0::
    ret

Func_0E2_4FE1:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7524
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE

Jump_0E2_4FF0::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5000
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5000::
    ld hl, Jump_0E2_4CE5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5014
    and a, a
    jr nz, Jump_0E2_5014
    ld bc, $0003
    call Func_0E2_64F5

Jump_0E2_5014::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5024
    ld bc, $0053
    call Func_0E2_64CE

Jump_0E2_5024::
    call Func_0E2_6898
    ld hl, $6481
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5037
    ld bc, $0066
    call Func_0E2_64CE

Jump_0E2_5037::
    ld hl, $6494
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5067
    ld bc, $0067
    call Func_0E2_64CE
    ld hl, Data_0E2_6972
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5057
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_5057::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5067
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_5067::
    ret

Func_0E2_5068:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_753A
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_507A:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7550
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_508C:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7566
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_509E:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_757C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_50B0:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7592
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_50C2:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_75A8
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_50D4:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_75BE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_50E6:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_75D4
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_50F8:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_75EA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_510A:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7600
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0053
    call Func_0E2_64CE
    jp Jump_0E2_4FF0

Func_0E2_511C:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_763E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call Func_0E2_64CE

Jump_0E2_512B::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_513B
    ld bc, $0055
    call Func_0E2_64CE

Jump_0E2_513B::
    call Func_0E2_6898
    ld hl, $6481
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_514E
    ld bc, $0066
    call Func_0E2_64CE

Jump_0E2_514E::
    ld hl, $6494
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_515E
    ld bc, $0067
    call Func_0E2_64CE

Jump_0E2_515E::
    ld hl, Data_0E2_64CC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_516E
    ld bc, $0039
    call Func_0E2_64F5

Jump_0E2_516E::
    ld hl, Data_0E2_6972
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_517E
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_517E::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_518E
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_518E::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51A2
    and a, a
    jr nz, Jump_0E2_51A2
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_51A2::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51B6
    and a, a
    jr nz, Jump_0E2_51B6
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_51B6::
    ret

Func_0E2_51B7:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_765B
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call Func_0E2_64CE
    jp Jump_0E2_512B

Func_0E2_51C9:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7671
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call Func_0E2_64CE
    jp Jump_0E2_512B

Func_0E2_51DB:: ; heuristic: follows a terminator; C0
    call Func_0E2_51F6
    ld a, c
    and a, a
    ret z
    ld hl, $604C
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51F5
    and a, a
    jr nz, Jump_0E2_51F5
    ld bc, $00B4
    call Func_0E2_64CE

Jump_0E2_51F5::
    ret

Func_0E2_51F6::
    ld hl, Data_0E2_76A3
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67A5
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5213
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5213::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5223
    ld bc, $00C8
    call Func_0E2_64F5

Jump_0E2_5223::
    call Func_0E2_6898
    ld hl, $5C8C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5236
    ld bc, $0056
    call Func_0E2_64CE

Jump_0E2_5236::
    ld hl, $604C
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_524A
    and a, a
    jr nz, Jump_0E2_524A
    ld bc, $00B4
    call Func_0E2_64CE

Jump_0E2_524A::
    ld hl, Data_0E2_6972
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_525A
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_525A::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_526A
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_526A::
    ld c, $01
    ret

Func_0E2_526D:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_76CE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5286
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5286::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5296
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_5296::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_52A6
    ld bc, $00C8
    call Func_0E2_64F5

Jump_0E2_52A6::
    call Func_0E2_6898
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_52B9
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_52B9::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_52CD
    and a, a
    jr nz, Jump_0E2_52CD
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_52CD::
    ld hl, $5C8C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_52DD
    ld bc, $0056
    call Func_0E2_64CE

Jump_0E2_52DD::
    ld hl, Data_0E2_676E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_52ED
    ld bc, $0056
    call Func_0E2_64CE

Jump_0E2_52ED::
    ld hl, Data_0E2_6972
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_52FD
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_52FD::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_530D
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_530D::
    ret

Func_0E2_530E:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_76E2
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5327
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_5327::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_533D
    ld bc, $00C3
    call Func_0E2_64CE
    ld bc, $00CB
    call Func_0E2_64F5

Jump_0E2_533D::
    call Func_0E2_6898
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5350
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_5350::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5364
    and a, a
    jr nz, Jump_0E2_5364
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_5364::
    ld hl, Data_0E2_6972
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5374
    ld bc, $0005
    call Func_0E2_64CE

Jump_0E2_5374::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5384
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_5384::
    ret

Func_0E2_5385:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_76F8
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_53A2
    and a, a
    jr nz, Jump_0E2_53A2
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_53A2::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_53B2
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_53B2::
    ld hl, Jump_0E2_4E48
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_53C2
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_53C2::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_53D2
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_53D2::
    ld hl, $557E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_53E2
    ld bc, $000D
    call Func_0E2_64CE

Jump_0E2_53E2::
    call Func_0E2_6898
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_53F5
    ld bc, $0057
    call Func_0E2_64CE

Jump_0E2_53F5::
    ld hl, $57CF
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5409
    and a, a
    jr nz, Jump_0E2_5409
    ld bc, $004A
    call Func_0E2_64F5

Jump_0E2_5409::
    ret

Func_0E2_540A:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7512
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5423
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_5423::
    jp Jump_0E2_53A2

Func_0E2_5426:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_772B
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $50E3
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5443
    and a, a
    jr nz, Jump_0E2_5443
    ld bc, $0058
    call Func_0E2_64CE

Jump_0E2_5443::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5459
    ld bc, $00BA
    call Func_0E2_64CE
    ld bc, $00BF
    call Func_0E2_64F5

Jump_0E2_5459::
    call Func_0E2_6898
    ret

Func_0E2_545D:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_774F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4B97
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5476
    ld bc, $002D
    call Func_0E2_64F5

Jump_0E2_5476::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5486
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5486::
    ld hl, $50B7
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_549A
    and a, a
    jr nz, Jump_0E2_549A
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_549A::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_54AA
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_54AA::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_54C0
    ld bc, $00BA
    call Func_0E2_64CE
    ld bc, $00BF
    call Func_0E2_64F5

Jump_0E2_54C0::
    call Func_0E2_6898
    ret

Func_0E2_54C4:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_54DD
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_54DD::
    ld hl, $50E3
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_54F1
    and a, a
    jr nz, Jump_0E2_54F1
    ld bc, $0058
    call Func_0E2_64F5

Jump_0E2_54F1::
    ld hl, $517D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5505
    and a, a
    jr nz, Jump_0E2_5505
    ld bc, $0059
    call Func_0E2_64F5

Jump_0E2_5505::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5515
    ld bc, $000A
    call Func_0E2_64F5

Jump_0E2_5515::
    call Func_0E2_6898
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5528
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_5528::
    ret

Func_0E2_5529:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7616
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4605
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5542
    ld bc, $005A
    call Func_0E2_64CE

Jump_0E2_5542::
    ld hl, $4664
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5552
    ld bc, $005B
    call Func_0E2_64CE

Jump_0E2_5552::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5562
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5562::
    ld hl, $50E3
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5576
    and a, a
    jr nz, Jump_0E2_5576
    ld bc, $0058
    call Func_0E2_64CE

Jump_0E2_5576::
    ld hl, $517D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_558A
    and a, a
    jr nz, Jump_0E2_558A
    ld bc, $0059
    call Func_0E2_64CE

Jump_0E2_558A::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_559A
    ld bc, $005C
    call Func_0E2_64F5

Jump_0E2_559A::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_55AA
    ld bc, $00BD
    call Func_0E2_64CE

Jump_0E2_55AA::
    call Func_0E2_6898
    ld hl, $5EA1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_55BD
    ld bc, $00B0
    call Func_0E2_64CE

Jump_0E2_55BD::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_55CD
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_55CD::
    ret

Func_0E2_55CE:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7616
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4B3D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_55E7
    ld bc, $0011
    call Func_0E2_64F5

Jump_0E2_55E7::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_55F7
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_55F7::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5607
    ld bc, $00C4
    call Func_0E2_64CE

Jump_0E2_5607::
    call Func_0E2_6898
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_561A
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_561A::
    ret

Func_0E2_561B:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7786
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $431C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5634
    ld bc, $005E
    call Func_0E2_64F5

Jump_0E2_5634::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5644
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5644::
    ld hl, $50E3
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5658
    and a, a
    jr nz, Jump_0E2_5658
    ld bc, $005F
    call Func_0E2_64F5

Jump_0E2_5658::
    ld hl, $517D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_566C
    and a, a
    jr nz, Jump_0E2_566C
    ld bc, $005F
    call Func_0E2_64F5

Jump_0E2_566C::
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_567C
    ld bc, $0060
    call Func_0E2_64F5

Jump_0E2_567C::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_568C
    ld bc, $005C
    call Func_0E2_64F5

Jump_0E2_568C::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_56A2
    ld bc, $00C7
    call Func_0E2_64CE
    ld bc, $00D0
    call Func_0E2_64F5

Jump_0E2_56A2::
    call Func_0E2_6898
    ld hl, Jump_0E2_6452
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_56B5
    ld bc, $0062
    call Func_0E2_64F5

Jump_0E2_56B5::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_56C5
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_56C5::
    ret

Func_0E2_56C6:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_779F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67A5
    ret z
    ld hl, $4605
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_56E3
    ld bc, $005A
    call Func_0E2_64CE

Jump_0E2_56E3::
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_56F3
    ld bc, $0017
    call Func_0E2_64F5

Jump_0E2_56F3::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5703
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5703::
    ld hl, $50E3
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5717
    and a, a
    jr nz, Jump_0E2_5717
    ld bc, $005F
    call Func_0E2_64F5

Jump_0E2_5717::
    ld hl, $517D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_572B
    and a, a
    jr nz, Jump_0E2_572B
    ld bc, $005F
    call Func_0E2_64F5

Jump_0E2_572B::
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_573B
    ld bc, $0060
    call Func_0E2_64F5

Jump_0E2_573B::
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_574B
    ld bc, $005C
    call Func_0E2_64F5

Jump_0E2_574B::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5761
    ld bc, $00C7
    call Func_0E2_64CE
    ld bc, $00D0
    call Func_0E2_64F5

Jump_0E2_5761::
    call Func_0E2_6898
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5774
    ld bc, $0063
    call Func_0E2_64F5

Jump_0E2_5774::
    ld hl, Jump_0E2_6452
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5784
    ld bc, $005F
    call Func_0E2_64F5

Jump_0E2_5784::
    ld hl, $67B2
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5798
    and a, a
    jr nz, Jump_0E2_5798
    ld bc, $0064
    call Func_0E2_64CE

Jump_0E2_5798::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_57A8
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_57A8::
    ret

Func_0E2_57A9:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_77C7
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $431C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_57C2
    ld bc, $005E
    call Func_0E2_64F5

Jump_0E2_57C2::
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_57D2
    ld bc, $0017
    call Func_0E2_64F5

Jump_0E2_57D2::
    ld hl, $6820
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_57E6
    and a, a
    jr nz, Jump_0E2_57E6
    ld bc, $0064
    call Func_0E2_64CE

Jump_0E2_57E6::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_57F6
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_57F6::
    ld hl, $5052
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5806
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5806::
    ld a, [$D8A4]
    call Func_0E2_670B
    ld hl, $53CA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_581C
    ld bc, $005C
    call Func_0E2_64F5

Jump_0E2_581C::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5832
    ld bc, $00C7
    call Func_0E2_64CE
    ld bc, $00D0
    call Func_0E2_64F5

Jump_0E2_5832::
    call Func_0E2_6898
    ld hl, Jump_0E2_6452
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5845
    ld bc, $005F
    call Func_0E2_64F5

Jump_0E2_5845::
    ld hl, Data_0E2_69DA
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5855
    ld bc, $0033
    call Func_0E2_64F5

Jump_0E2_5855::
    ret

Func_0E2_5856:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_77E0
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $689C
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5873
    and a, a
    jr nz, Jump_0E2_5873
    ld bc, $0064
    call Func_0E2_64CE

Jump_0E2_5873::
    jp Jump_0E2_57E6

Func_0E2_5876:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_77F9
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_588F
    ld bc, $00BC
    call Func_0E2_64F5

Jump_0E2_588F::
    call Func_0E2_6876

Jump_0E2_5892::
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_58A2
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_58A2::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58B6
    and a, a
    jr nz, Jump_0E2_58B6
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_58B6::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58CA
    and a, a
    jr nz, Jump_0E2_58CA
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_58CA::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58DE
    and a, a
    jr nz, Jump_0E2_58DE
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_58DE::
    ret

Func_0E2_58DF:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7824
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

Func_0E2_58EA:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7847
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

Func_0E2_58F5:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7860
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

Func_0E2_5900:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7879
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5919
    ld bc, $00BD
    call Func_0E2_64F5

Jump_0E2_5919::
    call Func_0E2_6854
    jp Jump_0E2_5892

Func_0E2_591F:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_78A8
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0009
    call Func_0E2_64CE
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5944
    ld bc, $00C2
    call Func_0E2_64F5
    ld bc, $00D2
    call Func_0E2_64CE

Jump_0E2_5944::
    call Func_0E2_6887
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_595B
    and a, a
    jr nz, Jump_0E2_595B
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_595B::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_596F
    and a, a
    jr nz, Jump_0E2_596F
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_596F::
    ret

Func_0E2_5970:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_78CC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5995
    ld bc, $00C2
    call Func_0E2_64F5
    ld bc, $00CA
    call Func_0E2_64CE
    ld bc, $00D2
    call Func_0E2_64CE

Jump_0E2_5995::
    call Func_0E2_6887
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_59A8
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_59A8::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59BC
    and a, a
    jr nz, Jump_0E2_59BC
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_59BC::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59D0
    and a, a
    jr nz, Jump_0E2_59D0
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_59D0::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59E4
    and a, a
    jr nz, Jump_0E2_59E4
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_59E4::
    ret

Func_0E2_59E5:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_790D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A04
    ld bc, $00CD
    call Func_0E2_64CE
    ld bc, $00CF
    call Func_0E2_64F5

Jump_0E2_5A04::
    call Func_0E2_6887
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A17
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_5A17::
    ld hl, $6153
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A2B
    and a, a
    jr nz, Jump_0E2_5A2B
    ld bc, $00B5
    call Func_0E2_64CE

Jump_0E2_5A2B::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A3F
    and a, a
    jr nz, Jump_0E2_5A3F
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_5A3F::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A53
    and a, a
    jr nz, Jump_0E2_5A53
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5A53::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A67
    and a, a
    jr nz, Jump_0E2_5A67
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5A67::
    ret

Func_0E2_5A68:: ; heuristic: follows a terminator; C0
    call Func_0E2_5A72
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

Func_0E2_5A72::
    ld hl, Data_0E2_791F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A91
    ld bc, $00C2
    call Func_0E2_64F5
    ld bc, $00D2
    call Func_0E2_64CE

Jump_0E2_5A91::
    call Func_0E2_6887
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5AA4
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_5AA4::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5AB8
    and a, a
    jr nz, Jump_0E2_5AB8
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_5AB8::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5ACC
    and a, a
    jr nz, Jump_0E2_5ACC
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5ACC::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5AE0
    and a, a
    jr nz, Jump_0E2_5AE0
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5AE0::
    call Func_0E2_67F9
    ld c, $01
    ret

Func_0E2_5AE6:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7946
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B05
    ld bc, $00BC
    call Func_0E2_64CE
    ld bc, $00C4
    call Func_0E2_64F5

Jump_0E2_5B05::
    call Func_0E2_6887
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B18
    ld bc, $0029
    call Func_0E2_64CE

Jump_0E2_5B18::
    ld hl, $5CF1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B28
    ld bc, $0029
    call Func_0E2_64CE

Jump_0E2_5B28::
    ld hl, Func_0E2_667F
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5B3C
    and a, a
    jr nz, Jump_0E2_5B3C
    ld bc, $002E
    call Func_0E2_64F5

Jump_0E2_5B3C::
    ret

Func_0E2_5B3D:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7975
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld a, [$D8A4]
    call Func_0E2_66C5
    ld hl, $44CF
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B5C
    ld bc, $001A
    call Func_0E2_64CE

Jump_0E2_5B5C::
    ld hl, $4664
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B6C
    ld bc, $001A
    call Func_0E2_64CE

Jump_0E2_5B6C::
    ld hl, $4BE1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B7C
    ld bc, $001B
    call Func_0E2_64F5

Jump_0E2_5B7C::
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B8C
    ld bc, $0023
    call Func_0E2_64CE

Jump_0E2_5B8C::
    ld hl, $53A5
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B9C
    ld bc, $0023
    call Func_0E2_64CE

Jump_0E2_5B9C::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BAC
    ld bc, $0024
    call Func_0E2_64CE

Jump_0E2_5BAC::
    call Func_0E2_6887
    ld hl, $6556
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5BC3
    and a, a
    jr nz, Jump_0E2_5BC3
    ld bc, $0069
    call Func_0E2_64CE

Jump_0E2_5BC3::
    ret

Func_0E2_5BC4:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7996
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $459D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BDD
    ld bc, $006C
    call Func_0E2_64F5

Jump_0E2_5BDD::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BED
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5BED::
    ld hl, $5275
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C01
    and a, a
    jr nz, Jump_0E2_5C01
    ld bc, $006D
    call Func_0E2_64CE

Jump_0E2_5C01::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C11
    ld bc, $00BE
    call Func_0E2_64CE

Jump_0E2_5C11::
    call Func_0E2_6887
    ld hl, $585D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C24
    ld bc, $0032
    call Func_0E2_64CE

Jump_0E2_5C24::
    ret

Func_0E2_5C25:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_79C5
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z

Jump_0E2_5C2E::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C3E
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5C3E::
    ld hl, $5275
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C52
    and a, a
    jr nz, Jump_0E2_5C52
    ld bc, $006D
    call Func_0E2_64CE

Jump_0E2_5C52::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C62
    ld bc, $00BA
    call Func_0E2_64F5

Jump_0E2_5C62::
    call Func_0E2_6854
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C75
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_5C75::
    ld hl, $585D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C85
    ld bc, $0032
    call Func_0E2_64CE

Jump_0E2_5C85::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C99
    and a, a
    jr nz, Jump_0E2_5C99
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_5C99::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5CAD
    and a, a
    jr nz, Jump_0E2_5CAD
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5CAD::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5CC1
    and a, a
    jr nz, Jump_0E2_5CC1
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5CC1::
    ret

Func_0E2_5CC2:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_79E5
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    jp Jump_0E2_5C2E

Func_0E2_5CCE:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7A0D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5CED
    ld bc, $00CC
    call Func_0E2_64CE
    ld bc, $00D1
    call Func_0E2_64F5

Jump_0E2_5CED::
    call Func_0E2_6854
    ld hl, $577F
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D00
    ld bc, $0015
    call Func_0E2_64CE

Jump_0E2_5D00::
    ld hl, $64FE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D14
    and a, a
    jr nz, Jump_0E2_5D14
    ld bc, $0012
    call Func_0E2_64F5

Jump_0E2_5D14::
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D28
    and a, a
    jr nz, Jump_0E2_5D28
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5D28::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D3C
    and a, a
    jr nz, Jump_0E2_5D3C
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5D3C::
    ret

Func_0E2_5D3D:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7A27
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call Func_0E2_64CE
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D5C
    ld bc, $00CA
    call Func_0E2_64F5

Jump_0E2_5D5C::
    call Func_0E2_6865
    ret

Func_0E2_5D60:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7A3E
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call Func_0E2_64CE
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D7F
    ld bc, $00CC
    call Func_0E2_64CE

Jump_0E2_5D7F::
    call Func_0E2_6854
    ret

Func_0E2_5D83:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7A55
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld bc, $0071
    call Func_0E2_64CE
    ld hl, Jump_0E2_41FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DA2
    ld bc, $0070
    call Func_0E2_64CE

Jump_0E2_5DA2::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DB8
    ld bc, $00C9
    call Func_0E2_64F5
    ld bc, $00CB
    call Func_0E2_64CE

Jump_0E2_5DB8::
    call Func_0E2_6854
    ret

Func_0E2_5DBC:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7A6C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DD5
    ld bc, $00C9
    call Func_0E2_64CE

Jump_0E2_5DD5::
    call Func_0E2_6854
    ld hl, $57A1
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5DEC
    and a, a
    jr nz, Jump_0E2_5DEC
    ld bc, $0072
    call Func_0E2_64CE

Jump_0E2_5DEC::
    ret

Func_0E2_5DED:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7A91
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E06
    ld bc, $0073
    call Func_0E2_64CE

Jump_0E2_5E06::
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E16
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5E16::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E32
    ld bc, $0074
    call Func_0E2_64CE
    ld bc, $00BB
    call Func_0E2_64CE
    ld bc, $00C7
    call Func_0E2_64F5

Jump_0E2_5E32::
    call Func_0E2_6854
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E45
    ld bc, $0075
    call Func_0E2_64CE

Jump_0E2_5E45::
    ret

Func_0E2_5E46:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7AA4
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E5F
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5E5F::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E6F
    ld bc, $0076
    call Func_0E2_64CE

Jump_0E2_5E6F::
    call Func_0E2_6876
    ld hl, $5D31
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E82
    ld bc, $0077
    call Func_0E2_64F5

Jump_0E2_5E82::
    ret

Func_0E2_5E83:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7ACC
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E9C
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_5E9C::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5EB2
    ld bc, $00C2
    call Func_0E2_64CE
    ld bc, $00D2
    call Func_0E2_64F5

Jump_0E2_5EB2::
    call Func_0E2_6854
    ret

Func_0E2_5EB6:: ; heuristic: follows a terminator; C0
    call Func_0E2_5EC0
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

Func_0E2_5EC0::
    ld hl, Data_0E2_7AD8
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5ED9
    ld bc, $0078
    call Func_0E2_64CE

Jump_0E2_5ED9::
    call Func_0E2_6854
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5EF0
    and a, a
    jr nz, Jump_0E2_5EF0
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5EF0::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F04
    and a, a
    jr nz, Jump_0E2_5F04
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5F04::
    call Func_0E2_67F9
    ld c, $01
    ret

Func_0E2_5F0A:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7B11
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $443B
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5F23
    ld bc, $0079
    call Func_0E2_64F5

Jump_0E2_5F23::
    ld hl, $50E3
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F37
    and a, a
    jr nz, Jump_0E2_5F37
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_5F37::
    ld hl, $517D
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F4B
    and a, a
    jr nz, Jump_0E2_5F4B
    ld bc, $002C
    call Func_0E2_64CE

Jump_0E2_5F4B::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5F5B
    ld bc, $0078
    call Func_0E2_64CE

Jump_0E2_5F5B::
    call Func_0E2_6854
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F72
    and a, a
    jr nz, Jump_0E2_5F72
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5F72::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F86
    and a, a
    jr nz, Jump_0E2_5F86
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5F86::
    call Func_0E2_67F9
    ret

Func_0E2_5F8A:: ; heuristic: follows a terminator; C0
    call Func_0E2_5F94
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

Func_0E2_5F94::
    ld hl, Data_0E2_7B40
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_5FAD
    ld bc, $007B
    call Func_0E2_64CE

Jump_0E2_5FAD::
    call Func_0E2_6854
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5FC4
    and a, a
    jr nz, Jump_0E2_5FC4
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5FC4::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5FD8
    and a, a
    jr nz, Jump_0E2_5FD8
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_5FD8::
    call Func_0E2_67F9
    ld c, $01
    ret

Func_0E2_5FDE:: ; heuristic: follows a terminator; C0
    call Func_0E2_5FE8
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

Func_0E2_5FE8::
    ld hl, Data_0E2_7AD8
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6013
    ld bc, $00C0
    call Func_0E2_64CE
    ld bc, $00C3
    call Func_0E2_64F5
    ld bc, $00CE
    call Func_0E2_64F5
    ld bc, $00D3
    call Func_0E2_64CE

Jump_0E2_6013::
    call Func_0E2_6854
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_602A
    and a, a
    jr nz, Jump_0E2_602A
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_602A::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_603E
    and a, a
    jr nz, Jump_0E2_603E
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_603E::
    call Func_0E2_67F9
    ld c, $01
    ret

Func_0E2_6044:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7B5C
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_605D
    ld bc, $007D
    call Func_0E2_64CE

Jump_0E2_605D::
    call Func_0E2_6854
    ld hl, Data_0E2_69F5
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6074
    and a, a
    jr nz, Jump_0E2_6074
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_6074::
    ld hl, Data_0E2_6A6B
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6088
    and a, a
    jr nz, Jump_0E2_6088
    ld bc, $0009
    call Func_0E2_64CE

Jump_0E2_6088::
    ret

Func_0E2_6089:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7B84
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_60A2
    ld bc, $007E
    call Func_0E2_64CE

Jump_0E2_60A2::
    call Func_0E2_6887
    ret

Func_0E2_60A6:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7BBE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $53FA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_60C3
    and a, a
    jr nz, Jump_0E2_60C3
    ld bc, $007F
    call Func_0E2_64CE

Jump_0E2_60C3::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_60D3
    ld bc, $0080
    call Func_0E2_64CE

Jump_0E2_60D3::
    call Func_0E2_6876
    ret

Func_0E2_60D7:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7BE6
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld a, [$D8A4]
    call Func_0E2_656D
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_60FA
    ld bc, $00C1
    call Func_0E2_64F5

Jump_0E2_60FA::
    ld hl, $5500
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_610E
    and a, a
    jr nz, Jump_0E2_610E
    ld bc, $0000
    call Func_0E2_64CE

Jump_0E2_610E::
    call Func_0E2_6865
    ret

Func_0E2_6112:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7C12
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6135
    ld bc, $0088
    call Func_0E2_64CE
    ld bc, $00C1
    call Func_0E2_64F5

Jump_0E2_6135::
    call Func_0E2_6854
    ret

Func_0E2_6139:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7C45
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_615C
    ld bc, $008A
    call Func_0E2_64CE
    ld bc, $00C1
    call Func_0E2_64F5

Jump_0E2_615C::
    call Func_0E2_6865
    ret

Func_0E2_6160:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7C69
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld a, [$D8A4]
    call Func_0E2_672D
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6189
    ld bc, $00CD
    call Func_0E2_64F5
    ld bc, $00D1
    call Func_0E2_64CE

Jump_0E2_6189::
    call Func_0E2_6854
    ret

Func_0E2_618D:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7C82
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67C0
    ret z

Jump_0E2_619A::
    ld hl, $53FA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_61AE
    and a, a
    jr nz, Jump_0E2_61BE
    ld bc, $003A
    call Func_0E2_64CE

Jump_0E2_61AE::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_61BE
    ld bc, $008C
    call Func_0E2_64CE

Jump_0E2_61BE::
    call Func_0E2_6854
    ret

Func_0E2_61C2:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7CA2
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_619A

Func_0E2_61CD:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7CC2
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld a, [$D8A4]
    call Func_0E2_65B8
    call Func_0E2_6854
    ret

Func_0E2_61E0:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7CE7
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4E20
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_61F9
    ld bc, $008D
    call Func_0E2_64F5

Jump_0E2_61F9::
    ld hl, $53FA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_620D
    and a, a
    jr nz, Jump_0E2_620D
    ld bc, $008E
    call Func_0E2_64CE

Jump_0E2_620D::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_621D
    ld bc, $00CB
    call Func_0E2_64CE

Jump_0E2_621D::
    ld hl, $5500
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6231
    and a, a
    jr nz, Jump_0E2_6231
    ld bc, $008F
    call Func_0E2_64CE

Jump_0E2_6231::
    call Func_0E2_6854
    ld hl, $57A1
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6248
    and a, a
    jr nz, Jump_0E2_6248
    ld bc, $0090
    call Func_0E2_64CE

Jump_0E2_6248::
    ret

Func_0E2_6249:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7CF3
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6266
    ld bc, $0091
    call Func_0E2_64CE

Jump_0E2_6266::
    ld hl, $4BE1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6276
    ld bc, $0092
    call Func_0E2_64F5

Jump_0E2_6276::
    ld a, [$D8A4]
    call Func_0E2_6603
    ld hl, $53FA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6290
    and a, a
    jr nz, Jump_0E2_6290
    ld bc, $008E
    call Func_0E2_64CE

Jump_0E2_6290::
    call Func_0E2_6876
    ld hl, $5D20
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_62A3
    ld bc, $0097
    call Func_0E2_64F5

Jump_0E2_62A3::
    ret

Func_0E2_62A4:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7D5B
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld hl, $4C5D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_62C1
    ld bc, $0007
    call Func_0E2_64F5

Jump_0E2_62C1::
    ld hl, $53FA
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_62D5
    and a, a
    jr nz, Jump_0E2_62D5
    ld bc, $0098
    call Func_0E2_64CE

Jump_0E2_62D5::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_62EB
    ld bc, $00BB
    call Func_0E2_64F5
    ld bc, $00C6
    call Func_0E2_64CE

Jump_0E2_62EB::
    call Func_0E2_6854
    ld hl, $57A1
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6302
    and a, a
    jr nz, Jump_0E2_6302
    ld bc, $009A
    call Func_0E2_64CE

Jump_0E2_6302::
    ret

Func_0E2_6303:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7D95
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld a, [$D8A4]
    call Func_0E2_6634
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6322
    ld bc, $00A1
    call Func_0E2_64CE

Jump_0E2_6322::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6338
    ld bc, $00C2
    call Func_0E2_64CE
    ld bc, $00D2
    call Func_0E2_64F5

Jump_0E2_6338::
    call Func_0E2_6865
    ld hl, $6556
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_634F
    and a, a
    jr nz, Jump_0E2_634F
    ld bc, $0069
    call Func_0E2_64F5

Jump_0E2_634F::
    ret

Func_0E2_6350:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7DA8
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_636F
    ld bc, $00CC
    call Func_0E2_64F5
    ld bc, $00D3
    call Func_0E2_64F5

Jump_0E2_636F::
    call Func_0E2_6865
    ld hl, Func_0E2_667F
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6386
    and a, a
    jr nz, Jump_0E2_6386
    ld bc, $002E
    call Func_0E2_64F5

Jump_0E2_6386::
    ret

Func_0E2_6387:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7DC2
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $4BE1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_63A0
    ld bc, $001B
    call Func_0E2_64F5

Jump_0E2_63A0::
    ld a, [$D8A4]
    call Func_0E2_66C5
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_63B6
    ld bc, $00A3
    call Func_0E2_64CE

Jump_0E2_63B6::
    ld hl, $53A5
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_63C6
    ld bc, $00A4
    call Func_0E2_64CE

Jump_0E2_63C6::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_63E2
    ld bc, $00CC
    call Func_0E2_64F5
    ld bc, $00CF
    call Func_0E2_64CE
    ld bc, $00D3
    call Func_0E2_64F5

Jump_0E2_63E2::
    call Func_0E2_6865
    ld hl, $6556
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_63F9
    and a, a
    jr nz, Jump_0E2_63F9
    ld bc, $0069
    call Func_0E2_64CE

Jump_0E2_63F9::
    ret

Func_0E2_63FA:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7DDC
    ld b, $05
    rst $10
    ret

Func_0E2_6401:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7B11
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_641A
    ld bc, $00A5
    call Func_0E2_64CE

Jump_0E2_641A::
    call Func_0E2_6898
    ret

Func_0E2_641E:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7DDC
    ld b, $05
    rst $10
    ret

Func_0E2_6425:: ; heuristic: follows a terminator; C0
    call Func_0E2_67A5
    ret z
    ld hl, Data_0E2_7DE8
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $459D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6442
    ld bc, $00A6
    call Func_0E2_64F5

Jump_0E2_6442::
    ld hl, $4777
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6452
    ld bc, $00A7
    call Func_0E2_64F5

Jump_0E2_6452::
    ld hl, $5397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6462
    ld bc, $00A8
    call Func_0E2_64F5

Jump_0E2_6462::
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6472
    ld bc, $00A9
    call Func_0E2_64CE

Jump_0E2_6472::
    ret

Func_0E2_6473:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7370
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_648C
    ld bc, $0037
    call Func_0E2_64CE

Jump_0E2_648C::
    ret

Func_0E2_648D:: ; heuristic: follows a terminator; C0
    ld hl, Data_0E2_7397
    ld b, $05
    rst $10
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld hl, $54FD
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_64AA
    ld bc, $0038
    call Func_0E2_64CE

Jump_0E2_64AA::
    ld hl, $57A1
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_64BE
    and a, a
    jr nz, Jump_0E2_64BE
    ld bc, $0039
    call Func_0E2_64CE

Jump_0E2_64BE::
    ret
    db $C9, $C9, $CD, $D4, $3E, $FA, $E7, $C5, $CB, $7F, $CC, $40, $65

Data_0E2_64CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C9

Func_0E2_64CE::
    call Func_0E2_654B
    cp a, $FF
    jr nz, Jump_0E2_64DA
    ld bc, $1388
    jr Jump_0E2_64EE

Jump_0E2_64DA::
    bit 7, b
    jr nz, Jump_0E2_64E0
    jr Jump_0E2_64EE

Jump_0E2_64E0::
    cpl
    ld c, a
    ld a, b
    cpl
    ld b, a
    inc bc
    ld hl, $DA70
    call Func_0E2_651C
    jr Jump_0E2_64F4

Jump_0E2_64EE::
    ld hl, $DA6E
    call Func_0E2_651C

Jump_0E2_64F4::
    ret

Func_0E2_64F5::
    call Func_0E2_654B
    cp a, $FF
    jr nz, Jump_0E2_6501
    ld bc, $1388
    jr Jump_0E2_6515

Jump_0E2_6501::
    bit 7, b
    jr nz, Jump_0E2_6507
    jr Jump_0E2_6515

Jump_0E2_6507::
    cpl
    ld c, a
    ld a, b
    cpl
    ld b, a
    inc bc
    ld hl, $DA6E
    call Func_0E2_651C
    jr Jump_0E2_651B

Jump_0E2_6515::
    ld hl, $DA70
    call Func_0E2_651C

Jump_0E2_651B::
    ret

Func_0E2_651C::
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, bc
    ld b, h
    ld c, l
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret
    db $E5, $2A, $66, $6F, $7D, $91, $6F, $7C, $98, $67, $CB, $7C, $28, $03, $21, $00
    db $00, $44, $4D, $E1, $71, $23, $70, $C9, $AF, $21, $6E, $DA, $22, $22, $3E, $FF
    db $22, $22, $C9

Func_0E2_654B::
    ld a, $36
    call Func_000_16AA
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld a, [$D2C7]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E2_6561
    inc h

Jump_0E2_6561::
    ld a, $06
    ld [$D7FE], a
    call Func_000_0B6C
    ld a, b
    ld b, c
    ld c, a
    ret

Func_0E2_656D:: ; heuristic: follows a terminator; C0
    ldh [$FFC6], a
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr z, Jump_0E2_6591
    cp a, $01
    jr z, Jump_0E2_6599
    cp a, $02
    jr z, Jump_0E2_65A1
    cp a, $03
    jr z, Jump_0E2_65A9
    cp a, $04
    jr z, Jump_0E2_65B1
    ld bc, $0085
    call Func_0E2_64CE
    jr Jump_0E2_65B7

Jump_0E2_6591::
    ld bc, $0083
    call Func_0E2_64F5
    jr Jump_0E2_65B7

Jump_0E2_6599::
    ld bc, $0083
    call Func_0E2_64F5
    jr Jump_0E2_65B7

Jump_0E2_65A1::
    ld bc, $0083
    call Func_0E2_64F5
    jr Jump_0E2_65B7

Jump_0E2_65A9::
    ld bc, $0083
    call Func_0E2_64F5
    jr Jump_0E2_65B7

Jump_0E2_65B1::
    ld bc, $0084
    call Func_0E2_64CE

Jump_0E2_65B7::
    ret

Func_0E2_65B8:: ; heuristic: follows a terminator; C0
    ldh [$FFC6], a
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr z, Jump_0E2_65DC
    cp a, $01
    jr z, Jump_0E2_65E4
    cp a, $02
    jr z, Jump_0E2_65EC
    cp a, $03
    jr z, Jump_0E2_65F4
    cp a, $04
    jr z, Jump_0E2_65FC
    ld bc, $0086
    call Func_0E2_64F5
    jr Jump_0E2_6602

Jump_0E2_65DC::
    ld bc, $0081
    call Func_0E2_64CE
    jr Jump_0E2_6602

Jump_0E2_65E4::
    ld bc, $0082
    call Func_0E2_64CE
    jr Jump_0E2_6602

Jump_0E2_65EC::
    ld bc, $0083
    call Func_0E2_64F5
    jr Jump_0E2_6602

Jump_0E2_65F4::
    ld bc, $0084
    call Func_0E2_64F5
    jr Jump_0E2_6602

Jump_0E2_65FC::
    ld bc, $0085
    call Func_0E2_64F5

Jump_0E2_6602::
    ret

Func_0E2_6603:: ; heuristic: follows a terminator; C0
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6608::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0E2_6615
    ldh [$FFC6], a
    push bc
    call Func_0E2_661A
    pop bc

Jump_0E2_6615::
    inc c
    dec b
    jr nz, Jump_0E2_6608
    ret

Func_0E2_661A::
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    cp a, $02
    jr nc, Jump_0E2_662D
    ld bc, $0093
    call Func_0E2_64CE
    jr Jump_0E2_6633

Jump_0E2_662D::
    ld bc, $0094
    call Func_0E2_64F5

Jump_0E2_6633::
    ret

Func_0E2_6634:: ; heuristic: follows a terminator; C0
    ldh [$FFC6], a
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr z, Jump_0E2_6658
    cp a, $01
    jr z, Jump_0E2_6660
    cp a, $02
    jr z, Jump_0E2_6668
    cp a, $03
    jr z, Jump_0E2_6670
    cp a, $04
    jr z, Jump_0E2_6678
    ld bc, $00A0
    call Func_0E2_64CE
    jr Jump_0E2_667E

Jump_0E2_6658::
    ld bc, $009B
    call Func_0E2_64F5
    jr Jump_0E2_667E

Jump_0E2_6660::
    ld bc, $009C
    call Func_0E2_64F5
    jr Jump_0E2_667E

Jump_0E2_6668::
    ld bc, $009D
    call Func_0E2_64F5
    jr Jump_0E2_667E

Jump_0E2_6670::
    ld bc, $009E
    call Func_0E2_64CE
    jr Jump_0E2_667E

Jump_0E2_6678::
    ld bc, $009F
    call Func_0E2_64CE

Jump_0E2_667E::
    ret

Func_0E2_667F:: ; heuristic: follows a terminator; C0
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6684::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0E2_6691
    ldh [$FFC6], a
    push bc
    call Func_0E2_6696
    pop bc

Jump_0E2_6691::
    inc c
    dec b
    jr nz, Jump_0E2_6684
    ret

Func_0E2_6696::
    push bc
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    pop bc
    ld b, a
    ld a, [$D8A4]
    cp a, c
    ld hl, Data_0E2_66B9
    jr z, Jump_0E2_66AC
    ld hl, Data_0E2_66BF

Jump_0E2_66AC::
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_0E2_66B2
    inc h

Jump_0E2_66B2::
    ld c, [hl]
    ld b, $00
    call Func_0E2_64CE
    ret

Data_0E2_66B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1E, $1F, $20, $21, $22, $22

Data_0E2_66BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AB, $AC, $AD, $AE, $AF, $AF

Func_0E2_66C5::
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_66CA::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0E2_66D7
    ldh [$FFC6], a
    push bc
    call Func_0E2_66DC
    pop bc

Jump_0E2_66D7::
    inc c
    dec b
    jr nz, Jump_0E2_66CA
    ret

Func_0E2_66DC::
    push bc
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    pop bc
    ld b, a
    ld a, [$D8A4]
    cp a, c
    ld hl, Data_0E2_66FF
    jr z, Jump_0E2_66F2
    ld hl, Data_0E2_6705

Jump_0E2_66F2::
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_0E2_66F8
    inc h

Jump_0E2_66F8::
    ld c, [hl]
    ld b, $00
    call Func_0E2_64CE
    ret

Data_0E2_66FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1D, $1E, $1F, $20, $21, $22

Data_0E2_6705:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $AB, $AC, $AD, $AE, $AF

Func_0E2_670B::
    ldh [$FFC6], a
    push bc
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    pop bc
    ld b, a
    ld hl, Func_0E2_6727
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_0E2_6720
    inc h

Jump_0E2_6720::
    ld c, [hl]
    ld b, $00
    call Func_0E2_64CE
    ret

Func_0E2_6727:: ; heuristic: follows a terminator; C0
    dec e
    ld e, $1F
    jr nz, Jump_0E2_674D
    ld [hl+], a

Func_0E2_672D::
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6732::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0E2_673F
    ldh [$FFC6], a
    push bc
    call Func_0E2_6744
    pop bc

Jump_0E2_673F::
    inc c
    dec b
    jr nz, Jump_0E2_6732
    ret

Func_0E2_6744::
    push bc
    ld hl, $5317
    ld b, $05
    rst $10
    ld a, c
    pop bc

Jump_0E2_674D::
    ld b, a
    ld a, [$D8A4]
    cp a, c
    ld hl, Data_0E2_6767
    jr z, Jump_0E2_675A
    ld hl, Data_0E2_676D

Jump_0E2_675A::
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_0E2_6760
    inc h

Jump_0E2_6760::
    ld c, [hl]
    ld b, $00
    call Func_0E2_64CE
    ret

Data_0E2_6767:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $20, $1F, $1E, $1D, $1D

Data_0E2_676D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA

Data_0E2_676E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $AB, $AC, $AD, $AE

Func_0E2_6773::
    ld hl, $585D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6785
    ld bc, $002B
    call Func_0E2_64CE
    jr Jump_0E2_678B

Jump_0E2_6785::
    ld bc, $0013
    call Func_0E2_64F5

Jump_0E2_678B::
    ret

Func_0E2_678C:: ; heuristic: follows a terminator; C0
    ld hl, $65C1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_679E
    ld bc, $0013
    call Func_0E2_64F5
    jr Jump_0E2_67A4

Jump_0E2_679E::
    ld bc, $002B
    call Func_0E2_64CE

Jump_0E2_67A4::
    ret

Func_0E2_67A5:: ; heuristic: follows a terminator; C0
    ld a, [$D2CC]
    and a, $01
    xor a, $01
    ld c, a
    ret nz
    xor a, a
    ld [$DA6E], a
    ld [$DA6F], a
    ld a, $FF
    ld [$DA70], a
    ld [$DA71], a
    xor a, a
    ld c, a
    ret

Func_0E2_67C0:: ; heuristic: follows a terminator; C0
    ld a, [$D891]
    ld c, a
    or a, a
    ret nz
    ld bc, $00B6
    call Func_0E2_64F5
    ld c, $FF
    ret

Func_0E2_67CF::
    call Func_0E2_67A5
    ret z
    jr Func_0E2_67C0

Func_0E2_67D5::
    call Func_0E2_6865
    ld hl, $5758
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_67E8
    ld bc, $0029
    call Func_0E2_64CE

Jump_0E2_67E8::
    ld hl, $5CF1
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_67F8
    ld bc, $0029
    call Func_0E2_64CE

Jump_0E2_67F8::
    ret

Func_0E2_67F9:: ; heuristic: follows a terminator; C0
    ld hl, $5ECE
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_680D
    and a, a
    jr nz, Jump_0E2_680D
    ld bc, $00B1
    call Func_0E2_64CE

Jump_0E2_680D::
    ld hl, $5FC7
    ld b, $05
    rst $10
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6821
    and a, a
    jr nz, Jump_0E2_6821
    ld bc, $00B2
    call Func_0E2_64CE

Jump_0E2_6821::
    ret

Func_0E2_6822::
    ld hl, $55BE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6832
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_6832::
    ld hl, $5731
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6842
    ld bc, $000F
    call Func_0E2_64CE

Jump_0E2_6842::
    ret

Func_0E2_6843:: ; heuristic: follows a terminator; C0
    ld hl, $55BE
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6853
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_6853::
    ret

Func_0E2_6854:: ; heuristic: follows a terminator; C0
    ld hl, $55F3
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6864
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_6864::
    ret

Func_0E2_6865:: ; heuristic: follows a terminator; C0
    ld hl, $5628
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6875
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_6875::
    ret

Func_0E2_6876:: ; heuristic: follows a terminator; C0
    ld hl, $565D
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6886
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_6886::
    ret

Func_0E2_6887:: ; heuristic: follows a terminator; C0
    ld hl, $5692
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_6897
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_6897::
    ret

Func_0E2_6898:: ; heuristic: follows a terminator; C0
    ld hl, $56C7
    ld b, $05
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_0E2_68A8
    ld bc, $000E
    call Func_0E2_64F5

Jump_0E2_68A8::
    ret

Func_0E2_68A9:: ; heuristic: follows a terminator; C0
    ld hl, $D8FF
    jr Jump_0E2_68D6
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0E2_68D6::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E2_68DC
    inc h

Jump_0E2_68DC::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_0E2_68E0:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E2_68E6
    inc h

Jump_0E2_68E6::
    ret

Func_0E2_68E7:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0E2_68FC
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0E2_68FC
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_0E2_68FC::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_0E2_6902:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0E2_6917
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0E2_6917
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_0E2_6917::
    ld a, [$D8A5]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $38A91D, $55

Data_0E2_6972:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $38A972, $68

Data_0E2_69DA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CD, $25, $3F, $2A, $E6, $C0, $20, $03, $7E, $E6, $0C, $E1, $C9, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0E2_69F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $76, $00

Data_0E2_6A6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $615, $00

Data_0E2_7080:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0E2_708C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3D, $00

Data_0E2_70C9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $40, $00

Data_0E2_7109:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $56, $00

Data_0E2_715F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_7187:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $25, $00

Data_0E2_71AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $12, $00

Data_0E2_71BE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20, $00

Data_0E2_71DE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_71F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_720A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7220:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7236:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_724F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2B, $00

Data_0E2_727A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_7293:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_72AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $12, $00

Data_0E2_72BE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20, $00

Data_0E2_72DE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_72F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2B, $00

Data_0E2_7322:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $23, $00

Data_0E2_7345:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2B, $00

Data_0E2_7370:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $27, $00

Data_0E2_7397:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $40, $00

Data_0E2_73D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $39, $00

Data_0E2_7410:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $39, $00

Data_0E2_7449:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $39, $00

Data_0E2_7482:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $12, $00

Data_0E2_7494:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $21, $00

Data_0E2_74B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1C, $00

Data_0E2_74D1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_74F9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_7512:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $12, $00

Data_0E2_7524:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_753A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7550:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7566:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_757C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7592:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_75A8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_75BE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_75D4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_75EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7600:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7616:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_763E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1D, $00

Data_0E2_765B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_7671:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $32, $00

Data_0E2_76A3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2B, $00

Data_0E2_76CE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $14, $00

Data_0E2_76E2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $00

Data_0E2_76F8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $33, $00

Data_0E2_772B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $24, $00

Data_0E2_774F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_7777:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0E2_7786:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_779F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_77C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_77E0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_77F9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2B, $00

Data_0E2_7824:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $23, $00

Data_0E2_7847:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_7860:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_7879:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2F, $00

Data_0E2_78A8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $24, $00

Data_0E2_78CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $41, $00

Data_0E2_790D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $12, $00

Data_0E2_791F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $27, $00

Data_0E2_7946:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2F, $00

Data_0E2_7975:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $21, $00

Data_0E2_7996:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2F, $00

Data_0E2_79C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20, $00

Data_0E2_79E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_7A0D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1A, $00

Data_0E2_7A27:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $17, $00

Data_0E2_7A3E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $17, $00

Data_0E2_7A55:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $17, $00

Data_0E2_7A6C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $25, $00

Data_0E2_7A91:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13, $00

Data_0E2_7AA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_7ACC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0E2_7AD8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $39, $00

Data_0E2_7B11:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2F, $00

Data_0E2_7B40:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1C, $00

Data_0E2_7B5C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_7B84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3A, $00

Data_0E2_7BBE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_0E2_7BE6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2C, $00

Data_0E2_7C12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $33, $00

Data_0E2_7C45:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $24, $00

Data_0E2_7C69:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $19, $00

Data_0E2_7C82:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20, $00

Data_0E2_7CA2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20, $00

Data_0E2_7CC2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $25, $00

Data_0E2_7CE7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0E2_7CF3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $68, $00

Data_0E2_7D5B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3A, $00

Data_0E2_7D95:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13, $00

Data_0E2_7DA8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1A, $00

Data_0E2_7DC2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1A, $00

Data_0E2_7DDC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0E2_7DE8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $218, $00
