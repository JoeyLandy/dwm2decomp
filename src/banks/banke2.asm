SECTION "Bank E2", ROMX[$4000], BANK[$E2]
    db $E2

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4001:: ; heuristic: follows a terminator; C0
    farcall Func_005_7080
    ld a, c
    and a, a
    ret z
    farcall Func_005_443B
    ld a, c
    and a, a
    jr nz, Jump_0E2_401A
    ld bc, $0000
    call AccumulateBank6WordToDA6E

Jump_0E2_401A::
    farcall Func_005_4B3D
    ld a, c
    and a, a
    jr nz, Jump_0E2_402A
    ld bc, $0001
    call AccumulateBank6WordToDA6E

Jump_0E2_402A::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_403A
    ld bc, $0002
    call AccumulateBank6WordToDA6E

Jump_0E2_403A::
    farcall Func_005_4CE5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_404E
    and a, a
    jr nz, Jump_0E2_404E
    ld bc, $0003
    call AccumulateBank6WordToDA70

Jump_0E2_404E::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_405E
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_405E::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_406E
    ld bc, $0006
    call AccumulateBank6WordToDA6E

Jump_0E2_406E::
    farcall Func_005_6481
    ld a, c
    and a, a
    jr nz, Jump_0E2_407E
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_407E::
    farcall Func_005_6494
    ld a, c
    and a, a
    jr nz, Jump_0E2_408E
    ld bc, $0067
    call AccumulateBank6WordToDA6E

Jump_0E2_408E::
    farcall Func_005_64CC
    ld a, c
    and a, a
    jr nz, Jump_0E2_409E
    ld bc, $0068
    call AccumulateBank6WordToDA6E

Jump_0E2_409E::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_40AE
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_40AE::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_40BE
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_40BE::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_40BF:: ; heuristic: follows a terminator; C0
    farcall Func_005_708C
    ld a, c
    and a, a
    ret z
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_40D8
    ld bc, $0008
    call AccumulateBank6WordToDA70

Jump_0E2_40D8::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_40E8
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_40E8::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_40F8
    ld bc, $000B
    call AccumulateBank6WordToDA6E

Jump_0E2_40F8::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4108
    ld bc, $000C
    call AccumulateBank6WordToDA6E

Jump_0E2_4108::
    call Func_0E2_6822
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_411B
    ld bc, $0010
    call AccumulateBank6WordToDA70

Jump_0E2_411B::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_411C:: ; heuristic: follows a terminator; C0
    farcall Func_005_708C
    ld a, c
    and a, a
    ret z
    farcall Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4139
    and a, a
    jr nz, Jump_0E2_4139
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_4139::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4149
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4149::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4159
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4159::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4169
    ld bc, $000B
    call AccumulateBank6WordToDA6E

Jump_0E2_4169::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4179
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4179::
    call Func_0E2_6822
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_418C
    ld bc, $0014
    call AccumulateBank6WordToDA6E

Jump_0E2_418C::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_419C
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_419C::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41B0
    and a, a
    jr nz, Jump_0E2_41B0
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_41B0::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41C4
    and a, a
    jr nz, Jump_0E2_41C4
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_41C4::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_41C5:: ; heuristic: follows a terminator; C0
    call Func_0E2_41E0
    ld a, c
    and a, a
    ret z
    farcall Func_005_6153
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41DF
    and a, a
    jr nz, Jump_0E2_41DF
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

Jump_0E2_41DF::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_41C5)
Func_0E2_41E0::
    farcall Func_005_70C9
    ld a, c
    and a, a
    ret z
    farcall Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41FD
    and a, a
    jr nz, Jump_0E2_41FD
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_41FD::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4213
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

Jump_0E2_4213::
    call Func_0E2_6822
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4226
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4226::
    farcall Func_005_6153
    ld a, c
    cp a, $01
    jr z, Jump_0E2_423A
    and a, a
    jr nz, Jump_0E2_423A
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

Jump_0E2_423A::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_424E
    and a, a
    jr nz, Jump_0E2_424E
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_424E::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4262
    and a, a
    jr nz, Jump_0E2_4262
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4262::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4276
    and a, a
    jr nz, Jump_0E2_4276
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4276::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4279:: ; heuristic: follows a terminator; C0
    farcall Func_005_7109
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr nz, Jump_0E2_4292
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_4292::
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_42A2
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_42A2::
    farcall Func_005_4B3D
    ld a, c
    and a, a
    jr nz, Jump_0E2_42B2
    ld bc, $0011
    call AccumulateBank6WordToDA70

Jump_0E2_42B2::
    farcall Func_005_4BE1
    ld a, c
    and a, a
    jr nz, Jump_0E2_42C2
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_42C2::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_42D2
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_42D2::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_42E8
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

Jump_0E2_42E8::
    call Func_0E2_6843
    farcall Func_005_5803
    ld a, c
    and a, a
    jr nz, Jump_0E2_42FB
    ld bc, $0019
    call AccumulateBank6WordToDA6E

Jump_0E2_42FB::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_430F
    and a, a
    jr nz, Jump_0E2_430F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_430F::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_4310:: ; heuristic: follows a terminator; C0
    farcall Func_005_715F
    ld a, c
    and a, a
    ret z
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Func_0E2_432D
    and a, a
    jr nz, Func_0E2_432D
    ld bc, $0069
    call AccumulateBank6WordToDA70

; 1 call site from 1 routine (e.g. Func_0E2_438D)
; reads: wBattleActor
Func_0E2_432D::
    farcall Func_005_44CF
    ld a, c
    and a, a
    jr nz, Jump_0E2_433D
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_433D::
    farcall Func_005_4664
    ld a, c
    and a, a
    jr nz, Jump_0E2_434D
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_434D::
    farcall Func_005_4BE1
    ld a, c
    and a, a
    jr nz, Jump_0E2_435D
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_435D::
    ld a, [wBattleActor]
    call Func_0E2_667F
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_4373
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_4373::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4389
    ld bc, $0024
    call AccumulateBank6WordToDA6E
    ld bc, $00C8
    call AccumulateBank6WordToDA6E

Jump_0E2_4389::
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_438D:: ; heuristic: follows a terminator; C0
    farcall Func_005_715F
    ld a, c
    and a, a
    ret z
    call Func_0E2_432D
    farcall Func_005_53A5
    ld a, c
    and a, a
    jr nz, Jump_0E2_43A9
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_43A9::
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_43BD
    and a, a
    jr nz, Jump_0E2_43BD
    ld bc, $0069
    call AccumulateBank6WordToDA6E

Jump_0E2_43BD::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_43BE:: ; heuristic: follows a terminator; C0
    farcall Func_005_7187
    ld a, c
    and a, a
    ret z
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_43C8:: ; heuristic: follows a terminator; C0
    farcall Func_005_71AC
    ld a, c
    and a, a
    ret z
    call Func_0E2_67D5
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_43E8
    and a, a
    jr nz, Jump_0E2_43E8
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_43E8::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_43E9:: ; heuristic: follows a terminator; C0
    farcall Func_005_71BE
    ld a, c
    and a, a
    ret z
    call Func_0E2_67D5
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_440B
    ld bc, $00BC
    call AccumulateBank6WordToDA6E
    ld bc, $00C4
    call AccumulateBank6WordToDA70

Jump_0E2_440B::
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_441F
    and a, a
    jr nz, Jump_0E2_441F
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_441F::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4420:: ; heuristic: follows a terminator; C0
    farcall Func_005_71DE
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4433:: ; heuristic: follows a terminator; C0
    farcall Func_005_71F4
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4446:: ; heuristic: follows a terminator; C0
    farcall Func_005_720A
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4459:: ; heuristic: follows a terminator; C0
    farcall Func_005_7220
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_446C:: ; heuristic: follows a terminator; C0
    farcall Func_005_7236
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4485
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4485::
    call Func_0E2_6854
    call Func_0E2_6773
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_449B
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_449B::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_449C:: ; heuristic: follows a terminator; C0
    farcall Func_005_724F
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_44B5
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_44B5::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_44C9
    and a, a
    jr nz, Jump_0E2_44C9
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_44C9::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_44DD
    and a, a
    jr nz, Jump_0E2_44DD
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_44DD::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_44F3
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_44F3::
    call Func_0E2_6854
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_450A
    and a, a
    jr nz, Jump_0E2_450A
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_450A::
    call Func_0E2_678C
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4521
    and a, a
    jr nz, Jump_0E2_4521
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4521::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4535
    and a, a
    jr nz, Jump_0E2_4535
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4535::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4536:: ; heuristic: follows a terminator; C0
    farcall Func_005_727A
    ld a, c
    and a, a
    ret z
    farcall Func_005_4B97
    ld a, c
    and a, a
    jr nz, Jump_0E2_454F
    ld bc, $002D
    call AccumulateBank6WordToDA70

Jump_0E2_454F::
    farcall Func_005_50B7
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4563
    and a, a
    jr nz, Jump_0E2_4563
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_4563::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4567:: ; heuristic: follows a terminator; C0
    farcall Func_005_7293
    ld a, c
    and a, a
    ret z
    farcall Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4584
    and a, a
    jr nz, Jump_0E2_4584
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_4584::
    farcall Func_005_4B97
    ld a, c
    and a, a
    jr nz, Jump_0E2_4594
    ld bc, $002D
    call AccumulateBank6WordToDA70

Jump_0E2_4594::
    farcall Func_005_50B7
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45A8
    and a, a
    jr nz, Jump_0E2_45A8
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_45A8::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_45BE
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_45BE::
    call Func_0E2_6854
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45D5
    and a, a
    jr nz, Jump_0E2_45D5
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_45D5::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45E9
    and a, a
    jr nz, Jump_0E2_45E9
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_45E9::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45FD
    and a, a
    jr nz, Jump_0E2_45FD
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_45FD::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_45FE:: ; heuristic: follows a terminator; C0
    call Func_0E2_4619
    ld a, c
    and a, a
    ret z
    farcall Func_005_5F3D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4618
    and a, a
    jr nz, Jump_0E2_4618
    ld bc, $00B3
    call AccumulateBank6WordToDA6E

Jump_0E2_4618::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_45FE)
Func_0E2_4619::
    farcall Func_005_72AC
    ld a, c
    and a, a
    ret z
    farcall Func_005_51EA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4636
    and a, a
    jr nz, Jump_0E2_4636
    ld bc, $002F
    call AccumulateBank6WordToDA6E

Jump_0E2_4636::
    farcall Func_005_5228
    ld a, c
    cp a, $01
    jr z, Jump_0E2_464A
    and a, a
    jr nz, Jump_0E2_464A
    ld bc, $0030
    call AccumulateBank6WordToDA6E

Jump_0E2_464A::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_465A
    ld bc, $00BA
    call AccumulateBank6WordToDA6E

Jump_0E2_465A::
    call Func_0E2_6854
    farcall Func_005_5F3D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4671
    and a, a
    jr nz, Jump_0E2_4671
    ld bc, $00B3
    call AccumulateBank6WordToDA6E

Jump_0E2_4671::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4674:: ; heuristic: follows a terminator; C0
    farcall Func_005_72BE
    ld a, c
    and a, a
    ret z
    farcall Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4691
    and a, a
    jr nz, Jump_0E2_4691
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_4691::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_46A1
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_46A1::
    farcall Func_005_5275
    ld a, c
    cp a, $01
    jr z, Jump_0E2_46B5
    and a, a
    jr nz, Jump_0E2_46B5
    ld bc, $0031
    call AccumulateBank6WordToDA6E

Jump_0E2_46B5::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_46D1
    ld bc, $00BA
    call AccumulateBank6WordToDA70
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_46D1::
    call Func_0E2_6854
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_46E4
    ld bc, $0032
    call AccumulateBank6WordToDA6E

Jump_0E2_46E4::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_46F8
    and a, a
    jr nz, Jump_0E2_46F8
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_46F8::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_470C
    and a, a
    jr nz, Jump_0E2_470C
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_470C::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4720
    and a, a
    jr nz, Jump_0E2_4720
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4720::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4721:: ; heuristic: follows a terminator; C0
    farcall Func_005_72DE
    ld a, c
    and a, a
    ret z
    farcall Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_0E2_473E
    and a, a
    jr nz, Jump_0E2_473E
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_473E::
    farcall Func_005_50B7
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4752
    and a, a
    jr nz, Jump_0E2_4752
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_4752::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4762
    ld bc, $00BC
    call AccumulateBank6WordToDA70

Jump_0E2_4762::
    call Func_0E2_6854
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4779
    and a, a
    jr nz, Jump_0E2_4779
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4779::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_478D
    and a, a
    jr nz, Jump_0E2_478D
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_478D::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_478E:: ; heuristic: follows a terminator; C0
    farcall Func_005_72F7
    ld a, c
    and a, a
    ret z
    farcall Func_005_558B
    ld a, c
    and a, a
    jr nz, Jump_0E2_47A7
    ld bc, $0034
    call AccumulateBank6WordToDA70

Jump_0E2_47A7::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_47AB:: ; heuristic: follows a terminator; C0
    farcall Func_005_7322
    ld a, c
    and a, a
    ret z
    ld bc, $0035
    call AccumulateBank6WordToDA6E
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_47CA
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_47CA::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_47CE:: ; heuristic: follows a terminator; C0
    farcall Func_005_7345
    ld a, c
    and a, a
    ret z
    farcall Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_0E2_47EB
    and a, a
    jr nz, Jump_0E2_47EB
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_47EB::
    call Func_0E2_6854
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4804
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_4804::
    farcall Func_005_57A1
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4818
    and a, a
    jr nz, Jump_0E2_4818
    ld bc, $0036
    call AccumulateBank6WordToDA6E

Jump_0E2_4818::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_482C
    and a, a
    jr nz, Jump_0E2_482C
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_482C::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4840
    and a, a
    jr nz, Jump_0E2_4840
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4840::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4854
    and a, a
    jr nz, Jump_0E2_4854
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4854::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4855:: ; heuristic: follows a terminator; C0
    farcall Func_005_7370
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_486E
    ld bc, $00CA
    call AccumulateBank6WordToDA6E

Jump_0E2_486E::
    call Func_0E2_6854
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4885
    and a, a
    jr nz, Jump_0E2_4885
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4885::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4899
    and a, a
    jr nz, Jump_0E2_4899
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4899::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_48AD
    and a, a
    jr nz, Jump_0E2_48AD
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_48AD::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_48AE:: ; heuristic: follows a terminator; C0
    farcall Func_005_7397
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_48CB
    ld bc, $00D0
    call AccumulateBank6WordToDA6E

Jump_0E2_48CB::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_48CF:: ; heuristic: follows a terminator; C0
    farcall Func_005_73D7
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_48E8
    ld bc, $00C0
    call AccumulateBank6WordToDA70

Jump_0E2_48E8::
    farcall Func_005_57A1
    ld a, c
    cp a, $01
    jr z, Jump_0E2_48FC
    and a, a
    jr nz, Jump_0E2_48FC
    ld bc, $0036
    call AccumulateBank6WordToDA6E

Jump_0E2_48FC::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_48FD:: ; heuristic: follows a terminator; C0
    farcall Func_005_7410
    ld a, c
    and a, a
    ret z
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_491A
    and a, a
    jr nz, Jump_0E2_491A
    ld bc, $003A
    call AccumulateBank6WordToDA6E

Jump_0E2_491A::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_491E:: ; heuristic: follows a terminator; C0
    farcall Func_005_7449
    ld a, c
    and a, a
    ret z
    call Func_0E2_6854
    farcall Func_005_57A1
    ld a, c
    cp a, $01
    jr z, Jump_0E2_493E
    and a, a
    jr nz, Jump_0E2_493E
    ld bc, $0036
    call AccumulateBank6WordToDA6E

Jump_0E2_493E::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_493F:: ; heuristic: follows a terminator; C0
    farcall Func_005_7482
    ld a, c
    and a, a
    ret z
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_495C
    and a, a
    jr nz, Jump_0E2_495C
    ld bc, $003B
    call AccumulateBank6WordToDA6E

Jump_0E2_495C::
    farcall Func_005_544F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4970
    and a, a
    jr nz, Jump_0E2_4970
    ld bc, $003C
    call AccumulateBank6WordToDA6E

Jump_0E2_4970::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4980
    ld bc, $00CE
    call AccumulateBank6WordToDA6E

Jump_0E2_4980::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4984:: ; heuristic: follows a terminator; C0
    farcall Func_005_7482
    ld a, c
    and a, a
    ret z
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_49A1
    and a, a
    jr nz, Jump_0E2_49A1
    ld bc, $003A
    call AccumulateBank6WordToDA6E

Jump_0E2_49A1::
    call Func_0E2_6854
    farcall Func_005_5BBC
    ld a, c
    and a, a
    jr nz, Jump_0E2_49B4
    ld bc, $003D
    call AccumulateBank6WordToDA6E

Jump_0E2_49B4::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_49B5:: ; heuristic: follows a terminator; C0
    farcall CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_49CE
    ld bc, $003F
    call AccumulateBank6WordToDA6E

Jump_0E2_49CE::
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_49DE
    ld bc, $0040
    call AccumulateBank6WordToDA6E

Jump_0E2_49DE::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_49F4
    ld bc, $00BF
    call AccumulateBank6WordToDA6E
    ld bc, $00C5
    call AccumulateBank6WordToDA70

Jump_0E2_49F4::
    call Func_0E2_6854
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A07
    ld bc, $0042
    call AccumulateBank6WordToDA6E

Jump_0E2_4A07::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4A08:: ; heuristic: follows a terminator; C0
    farcall Func_005_74B5
    ld a, c
    and a, a
    ret z
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A21
    ld bc, $0043
    call AccumulateBank6WordToDA6E

Jump_0E2_4A21::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A31
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4A31::
    farcall Func_005_4D1A
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A41
    ld bc, $0044
    call AccumulateBank6WordToDA70

Jump_0E2_4A41::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A51
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4A51::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A61
    ld bc, $0045
    call AccumulateBank6WordToDA6E

Jump_0E2_4A61::
    farcall Func_005_56FC
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A71
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_4A71::
    farcall Func_005_5731
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A81
    ld bc, $0046
    call AccumulateBank6WordToDA6E

Jump_0E2_4A81::
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A91
    ld bc, $0047
    call AccumulateBank6WordToDA6E

Jump_0E2_4A91::
    farcall Func_005_5CE1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AA1
    ld bc, $0048
    call AccumulateBank6WordToDA6E

Jump_0E2_4AA1::
    farcall Func_005_6392
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4AB5
    or a, a
    jr nz, Jump_0E2_4AB5
    ld bc, $003E
    call AccumulateBank6WordToDA70

Jump_0E2_4AB5::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4AB6:: ; heuristic: follows a terminator; C0
    farcall Func_005_74D1
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ACF
    ld bc, $0049
    call AccumulateBank6WordToDA6E

Jump_0E2_4ACF::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ADF
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4ADF::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AEF
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4AEF::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AFF
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4AFF::
    call Func_0E2_6898
    farcall Func_005_5731
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B12
    ld bc, $0046
    call AccumulateBank6WordToDA6E

Jump_0E2_4B12::
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B22
    ld bc, $0047
    call AccumulateBank6WordToDA6E

Jump_0E2_4B22::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B32
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4B32::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4B46
    and a, a
    jr nz, Jump_0E2_4B46
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4B46::
    farcall Func_005_5CCE
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B56
    ld bc, $004B
    call AccumulateBank6WordToDA6E

Jump_0E2_4B56::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4B6A
    and a, a
    jr nz, Jump_0E2_4B6A
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4B6A::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4B6B:: ; heuristic: follows a terminator; C0
    farcall Func_005_74F9
    ld a, c
    and a, a
    ret z
    farcall Func_005_46B4
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B84
    ld bc, $004C
    call AccumulateBank6WordToDA70

Jump_0E2_4B84::
    farcall Func_005_4B3D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B94
    ld bc, $0011
    call AccumulateBank6WordToDA70

Jump_0E2_4B94::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BA4
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4BA4::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BB4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4BB4::
    farcall Func_005_53E6
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BC4
    ld bc, $004D
    call AccumulateBank6WordToDA6E

Jump_0E2_4BC4::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BD4
    ld bc, $006A
    call AccumulateBank6WordToDA6E

Jump_0E2_4BD4::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BE4
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4BE4::
    call Func_0E2_6876
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BF7
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4BF7::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4C0B
    and a, a
    jr nz, Jump_0E2_4C0B
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4C0B::
    farcall Func_005_5D31
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C1B
    ld bc, $004E
    call AccumulateBank6WordToDA70

Jump_0E2_4C1B::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4C2F
    and a, a
    jr nz, Jump_0E2_4C2F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4C2F::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4C30:: ; heuristic: follows a terminator; C0
    farcall Func_005_74D1
    ld a, c
    and a, a
    ret z
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Func_0E2_4C49
    ld bc, $0010
    call AccumulateBank6WordToDA70

; 1 call site from 1 routine (e.g. Func_0E2_4CA1)
Func_0E2_4C49::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C59
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4C59::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C69
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4C69::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C79
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4C79::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C89
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4C89::
    call Func_0E2_6898
    farcall Func_005_5D44
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CA0
    and a, a
    jr nz, Jump_0E2_4CA0
    ld bc, $004F
    call AccumulateBank6WordToDA6E

Jump_0E2_4CA0::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4CA1:: ; heuristic: follows a terminator; C0
    farcall Func_005_74D1
    ld a, c
    and a, a
    ret z
    call Func_0E2_4C49
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4CBD
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4CBD::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CD1
    and a, a
    jr nz, Jump_0E2_4CD1
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4CD1::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CE5
    and a, a
    jr nz, Jump_0E2_4CE5
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4CE5::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4CE6:: ; heuristic: follows a terminator; C0
    farcall Func_005_7512
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4CFF
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4CFF::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D0F
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4D0F::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D1F
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4D1F::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D2F
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4D2F::
    call Func_0E2_6898
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D42
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4D42::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4D56
    and a, a
    jr nz, Jump_0E2_4D56
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4D56::
    farcall Func_005_64CC
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D66
    ld bc, $006B
    call AccumulateBank6WordToDA70

Jump_0E2_4D66::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4D7A
    and a, a
    jr nz, Jump_0E2_4D7A
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4D7A::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4D7B:: ; heuristic: follows a terminator; C0
    farcall Func_005_7512
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D94
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4D94::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DA4
    ld bc, $000D
    call AccumulateBank6WordToDA70

Jump_0E2_4DA4::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DB4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4DB4::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DC4
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4DC4::
    call Func_0E2_6898
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DD7
    ld bc, $0010
    call AccumulateBank6WordToDA70

Jump_0E2_4DD7::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4DEB
    and a, a
    jr nz, Jump_0E2_4DEB
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4DEB::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4DEC:: ; heuristic: follows a terminator; C0
    farcall Func_005_7512
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E05
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4E05::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E15
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4E15::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E25
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4E25::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E35
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4E35::
    call Func_0E2_6898
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E48
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4E48::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4E5C
    and a, a
    jr nz, Jump_0E2_4E5C
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4E5C::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4E70
    and a, a
    jr nz, Jump_0E2_4E70
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4E70::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4E71:: ; heuristic: follows a terminator; C0
    farcall Func_005_7512
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E8A
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4E8A::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E9A
    ld bc, $0008
    call AccumulateBank6WordToDA70

Jump_0E2_4E9A::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EAA
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4EAA::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EBA
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4EBA::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ED0
    ld bc, $00BE
    call AccumulateBank6WordToDA70
    ld bc, $00C5
    call AccumulateBank6WordToDA6E

Jump_0E2_4ED0::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EE0
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4EE0::
    call Func_0E2_6898
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EF3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4EF3::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F07
    and a, a
    jr nz, Jump_0E2_4F07
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4F07::
    farcall Func_005_5D44
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F1B
    and a, a
    jr nz, Jump_0E2_4F1B
    ld bc, $004F
    call AccumulateBank6WordToDA6E

Jump_0E2_4F1B::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F2F
    and a, a
    jr nz, Jump_0E2_4F2F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4F2F::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4F30:: ; heuristic: follows a terminator; C0
    farcall Func_005_7512
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F49
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4F49::
    farcall Func_005_4CE5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F5D
    and a, a
    jr nz, Jump_0E2_4F5D
    ld bc, $0003
    call AccumulateBank6WordToDA70

Jump_0E2_4F5D::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F6D
    ld bc, $0008
    call AccumulateBank6WordToDA70

Jump_0E2_4F6D::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F7D
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4F7D::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F8D
    ld bc, $0055
    call AccumulateBank6WordToDA6E

Jump_0E2_4F8D::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F9D
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4F9D::
    call Func_0E2_6898
    farcall Func_005_6481
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FB0
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_4FB0::
    farcall Func_005_6494
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FC0
    ld bc, $0067
    call AccumulateBank6WordToDA6E

Jump_0E2_4FC0::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FD0
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_4FD0::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FE0
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_4FE0::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_4FE1:: ; heuristic: follows a terminator; C0
    farcall Func_005_7524
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E

Jump_0E2_4FF0::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5000
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5000::
    farcall Func_005_4CE5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5014
    and a, a
    jr nz, Jump_0E2_5014
    ld bc, $0003
    call AccumulateBank6WordToDA70

Jump_0E2_5014::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5024
    ld bc, $0053
    call AccumulateBank6WordToDA6E

Jump_0E2_5024::
    call Func_0E2_6898
    farcall Func_005_6481
    ld a, c
    and a, a
    jr nz, Jump_0E2_5037
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_5037::
    farcall Func_005_6494
    ld a, c
    and a, a
    jr nz, Jump_0E2_5067
    ld bc, $0067
    call AccumulateBank6WordToDA6E
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_5057
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5057::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5067
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5067::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5068:: ; heuristic: follows a terminator; C0
    farcall Func_005_753A
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_507A:: ; heuristic: follows a terminator; C0
    farcall Func_005_7550
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_508C:: ; heuristic: follows a terminator; C0
    farcall Func_005_7566
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_509E:: ; heuristic: follows a terminator; C0
    farcall Func_005_757C
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_50B0:: ; heuristic: follows a terminator; C0
    farcall Func_005_7592
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_50C2:: ; heuristic: follows a terminator; C0
    farcall Func_005_75A8
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_50D4:: ; heuristic: follows a terminator; C0
    farcall Func_005_75BE
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_50E6:: ; heuristic: follows a terminator; C0
    farcall Func_005_75D4
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_50F8:: ; heuristic: follows a terminator; C0
    farcall Func_005_75EA
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_510A:: ; heuristic: follows a terminator; C0
    farcall Func_005_7600
    ld a, c
    and a, a
    ret z
    ld bc, $0053
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; no direct call (reached through a table, a jump or a vector)
Func_0E2_511C:: ; heuristic: follows a terminator; C0
    farcall Func_005_763E
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E

Jump_0E2_512B::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_513B
    ld bc, $0055
    call AccumulateBank6WordToDA6E

Jump_0E2_513B::
    call Func_0E2_6898
    farcall Func_005_6481
    ld a, c
    and a, a
    jr nz, Jump_0E2_514E
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_514E::
    farcall Func_005_6494
    ld a, c
    and a, a
    jr nz, Jump_0E2_515E
    ld bc, $0067
    call AccumulateBank6WordToDA6E

Jump_0E2_515E::
    farcall Func_005_64CC
    ld a, c
    and a, a
    jr nz, Jump_0E2_516E
    ld bc, $0039
    call AccumulateBank6WordToDA70

Jump_0E2_516E::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_517E
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_517E::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_518E
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_518E::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51A2
    and a, a
    jr nz, Jump_0E2_51A2
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_51A2::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51B6
    and a, a
    jr nz, Jump_0E2_51B6
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_51B6::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_51B7:: ; heuristic: follows a terminator; C0
    farcall Func_005_765B
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_512B

; no direct call (reached through a table, a jump or a vector)
Func_0E2_51C9:: ; heuristic: follows a terminator; C0
    farcall Func_005_7671
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_512B

; no direct call (reached through a table, a jump or a vector)
Func_0E2_51DB:: ; heuristic: follows a terminator; C0
    call Func_0E2_51F6
    ld a, c
    and a, a
    ret z
    farcall Func_005_604C
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51F5
    and a, a
    jr nz, Jump_0E2_51F5
    ld bc, $00B4
    call AccumulateBank6WordToDA6E

Jump_0E2_51F5::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_51DB)
Func_0E2_51F6::
    farcall Func_005_76A3
    ld a, c
    and a, a
    ret z
    call Func_0E2_67A5
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5213
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5213::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5223
    ld bc, $00C8
    call AccumulateBank6WordToDA70

Jump_0E2_5223::
    call Func_0E2_6898
    farcall Func_005_5C8C
    ld a, c
    and a, a
    jr nz, Jump_0E2_5236
    ld bc, $0056
    call AccumulateBank6WordToDA6E

Jump_0E2_5236::
    farcall Func_005_604C
    ld a, c
    cp a, $01
    jr z, Jump_0E2_524A
    and a, a
    jr nz, Jump_0E2_524A
    ld bc, $00B4
    call AccumulateBank6WordToDA6E

Jump_0E2_524A::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_525A
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_525A::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_526A
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_526A::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_526D:: ; heuristic: follows a terminator; C0
    farcall Func_005_76CE
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5286
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5286::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5296
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5296::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_52A6
    ld bc, $00C8
    call AccumulateBank6WordToDA70

Jump_0E2_52A6::
    call Func_0E2_6898
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_52B9
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_52B9::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_52CD
    and a, a
    jr nz, Jump_0E2_52CD
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_52CD::
    farcall Func_005_5C8C
    ld a, c
    and a, a
    jr nz, Jump_0E2_52DD
    ld bc, $0056
    call AccumulateBank6WordToDA6E

Jump_0E2_52DD::
    farcall Func_005_676E
    ld a, c
    and a, a
    jr nz, Jump_0E2_52ED
    ld bc, $0056
    call AccumulateBank6WordToDA6E

Jump_0E2_52ED::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_52FD
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_52FD::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_530D
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_530D::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_530E:: ; heuristic: follows a terminator; C0
    farcall Func_005_76E2
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5327
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5327::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_533D
    ld bc, $00C3
    call AccumulateBank6WordToDA6E
    ld bc, $00CB
    call AccumulateBank6WordToDA70

Jump_0E2_533D::
    call Func_0E2_6898
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5350
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5350::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5364
    and a, a
    jr nz, Jump_0E2_5364
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_5364::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_5374
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5374::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5384
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5384::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5385:: ; heuristic: follows a terminator; C0
    farcall Func_005_76F8
    ld a, c
    and a, a
    ret z
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_53A2
    and a, a
    jr nz, Jump_0E2_53A2
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_53A2::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_53B2
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_53B2::
    farcall Func_005_4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_53C2
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_53C2::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_53D2
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_53D2::
    farcall Func_005_557E
    ld a, c
    and a, a
    jr nz, Jump_0E2_53E2
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_53E2::
    call Func_0E2_6898
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_53F5
    ld bc, $0057
    call AccumulateBank6WordToDA6E

Jump_0E2_53F5::
    farcall Func_005_57CF
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5409
    and a, a
    jr nz, Jump_0E2_5409
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_5409::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_540A:: ; heuristic: follows a terminator; C0
    farcall Func_005_7512
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5423
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5423::
    jp Jump_0E2_53A2

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5426:: ; heuristic: follows a terminator; C0
    farcall Func_005_772B
    ld a, c
    and a, a
    ret z
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5443
    and a, a
    jr nz, Jump_0E2_5443
    ld bc, $0058
    call AccumulateBank6WordToDA6E

Jump_0E2_5443::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5459
    ld bc, $00BA
    call AccumulateBank6WordToDA6E
    ld bc, $00BF
    call AccumulateBank6WordToDA70

Jump_0E2_5459::
    call Func_0E2_6898
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_545D:: ; heuristic: follows a terminator; C0
    farcall Func_005_774F
    ld a, c
    and a, a
    ret z
    farcall Func_005_4B97
    ld a, c
    and a, a
    jr nz, Jump_0E2_5476
    ld bc, $002D
    call AccumulateBank6WordToDA70

Jump_0E2_5476::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5486
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5486::
    farcall Func_005_50B7
    ld a, c
    cp a, $01
    jr z, Jump_0E2_549A
    and a, a
    jr nz, Jump_0E2_549A
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_549A::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_54AA
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_54AA::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_54C0
    ld bc, $00BA
    call AccumulateBank6WordToDA6E
    ld bc, $00BF
    call AccumulateBank6WordToDA70

Jump_0E2_54C0::
    call Func_0E2_6898
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_54C4:: ; heuristic: follows a terminator; C0
    farcall Func_005_7777
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_54DD
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_54DD::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_54F1
    and a, a
    jr nz, Jump_0E2_54F1
    ld bc, $0058
    call AccumulateBank6WordToDA70

Jump_0E2_54F1::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5505
    and a, a
    jr nz, Jump_0E2_5505
    ld bc, $0059
    call AccumulateBank6WordToDA70

Jump_0E2_5505::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5515
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_5515::
    call Func_0E2_6898
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5528
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5528::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5529:: ; heuristic: follows a terminator; C0
    farcall CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a, a
    jr nz, Jump_0E2_5542
    ld bc, $005A
    call AccumulateBank6WordToDA6E

Jump_0E2_5542::
    farcall Func_005_4664
    ld a, c
    and a, a
    jr nz, Jump_0E2_5552
    ld bc, $005B
    call AccumulateBank6WordToDA6E

Jump_0E2_5552::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5562
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5562::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5576
    and a, a
    jr nz, Jump_0E2_5576
    ld bc, $0058
    call AccumulateBank6WordToDA6E

Jump_0E2_5576::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_558A
    and a, a
    jr nz, Jump_0E2_558A
    ld bc, $0059
    call AccumulateBank6WordToDA6E

Jump_0E2_558A::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_559A
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_559A::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_55AA
    ld bc, $00BD
    call AccumulateBank6WordToDA6E

Jump_0E2_55AA::
    call Func_0E2_6898
    farcall Func_005_5EA1
    ld a, c
    and a, a
    jr nz, Jump_0E2_55BD
    ld bc, $00B0
    call AccumulateBank6WordToDA6E

Jump_0E2_55BD::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_55CD
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_55CD::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_55CE:: ; heuristic: follows a terminator; C0
    farcall CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    farcall Func_005_4B3D
    ld a, c
    and a, a
    jr nz, Jump_0E2_55E7
    ld bc, $0011
    call AccumulateBank6WordToDA70

Jump_0E2_55E7::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_55F7
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_55F7::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5607
    ld bc, $00C4
    call AccumulateBank6WordToDA6E

Jump_0E2_5607::
    call Func_0E2_6898
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_561A
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_561A::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_561B:: ; heuristic: follows a terminator; C0
    farcall Func_005_7786
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_5634
    ld bc, $005E
    call AccumulateBank6WordToDA70

Jump_0E2_5634::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5644
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5644::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5658
    and a, a
    jr nz, Jump_0E2_5658
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5658::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_566C
    and a, a
    jr nz, Jump_0E2_566C
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_566C::
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_567C
    ld bc, $0060
    call AccumulateBank6WordToDA70

Jump_0E2_567C::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_568C
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_568C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_56A2
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

Jump_0E2_56A2::
    call Func_0E2_6898
    farcall Func_005_6452
    ld a, c
    and a, a
    jr nz, Jump_0E2_56B5
    ld bc, $0062
    call AccumulateBank6WordToDA70

Jump_0E2_56B5::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_56C5
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_56C5::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_56C6:: ; heuristic: follows a terminator; C0
    farcall Func_005_779F
    ld a, c
    and a, a
    ret z
    call Func_0E2_67A5
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a, a
    jr nz, Jump_0E2_56E3
    ld bc, $005A
    call AccumulateBank6WordToDA6E

Jump_0E2_56E3::
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_56F3
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_56F3::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5703
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5703::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5717
    and a, a
    jr nz, Jump_0E2_5717
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5717::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_572B
    and a, a
    jr nz, Jump_0E2_572B
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_572B::
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_573B
    ld bc, $0060
    call AccumulateBank6WordToDA70

Jump_0E2_573B::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_574B
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_574B::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5761
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

Jump_0E2_5761::
    call Func_0E2_6898
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_5774
    ld bc, $0063
    call AccumulateBank6WordToDA70

Jump_0E2_5774::
    farcall Func_005_6452
    ld a, c
    and a, a
    jr nz, Jump_0E2_5784
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5784::
    farcall Func_005_67B2
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5798
    and a, a
    jr nz, Jump_0E2_5798
    ld bc, $0064
    call AccumulateBank6WordToDA6E

Jump_0E2_5798::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_57A8
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_57A8::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_57A9:: ; heuristic: follows a terminator; C0
    farcall Func_005_77C7
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_57C2
    ld bc, $005E
    call AccumulateBank6WordToDA70

Jump_0E2_57C2::
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_57D2
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_57D2::
    farcall Func_005_6820
    ld a, c
    cp a, $01
    jr z, Jump_0E2_57E6
    and a, a
    jr nz, Jump_0E2_57E6
    ld bc, $0064
    call AccumulateBank6WordToDA6E

Jump_0E2_57E6::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_57F6
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_57F6::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_5806
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5806::
    ld a, [wBattleActor]
    call Func_0E2_670B
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_581C
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_581C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5832
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

Jump_0E2_5832::
    call Func_0E2_6898
    farcall Func_005_6452
    ld a, c
    and a, a
    jr nz, Jump_0E2_5845
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5845::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5855
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5855::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_5856:: ; heuristic: follows a terminator; C0
    farcall Func_005_77E0
    ld a, c
    and a, a
    ret z
    farcall Func_005_689C
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5873
    and a, a
    jr nz, Jump_0E2_5873
    ld bc, $0064
    call AccumulateBank6WordToDA6E

Jump_0E2_5873::
    jp Jump_0E2_57E6

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5876:: ; heuristic: follows a terminator; C0
    farcall Func_005_77F9
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_588F
    ld bc, $00BC
    call AccumulateBank6WordToDA70

Jump_0E2_588F::
    call Func_0E2_6876

Jump_0E2_5892::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_58A2
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_58A2::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58B6
    and a, a
    jr nz, Jump_0E2_58B6
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_58B6::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58CA
    and a, a
    jr nz, Jump_0E2_58CA
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_58CA::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58DE
    and a, a
    jr nz, Jump_0E2_58DE
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_58DE::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_58DF:: ; heuristic: follows a terminator; C0
    farcall Func_005_7824
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

; no direct call (reached through a table, a jump or a vector)
Func_0E2_58EA:: ; heuristic: follows a terminator; C0
    farcall Func_005_7847
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

; no direct call (reached through a table, a jump or a vector)
Func_0E2_58F5:: ; heuristic: follows a terminator; C0
    farcall Func_005_7860
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5900:: ; heuristic: follows a terminator; C0
    farcall Func_005_7879
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5919
    ld bc, $00BD
    call AccumulateBank6WordToDA70

Jump_0E2_5919::
    call Func_0E2_6854
    jp Jump_0E2_5892

; no direct call (reached through a table, a jump or a vector)
Func_0E2_591F:: ; heuristic: follows a terminator; C0
    farcall Func_005_78A8
    ld a, c
    and a, a
    ret z
    ld bc, $0009
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5944
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

Jump_0E2_5944::
    call Func_0E2_6887
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_595B
    and a, a
    jr nz, Jump_0E2_595B
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_595B::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_596F
    and a, a
    jr nz, Jump_0E2_596F
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_596F::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5970:: ; heuristic: follows a terminator; C0
    farcall Func_005_78CC
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5995
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00CA
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

Jump_0E2_5995::
    call Func_0E2_6887
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_59A8
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_59A8::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59BC
    and a, a
    jr nz, Jump_0E2_59BC
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_59BC::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59D0
    and a, a
    jr nz, Jump_0E2_59D0
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_59D0::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59E4
    and a, a
    jr nz, Jump_0E2_59E4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_59E4::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_59E5:: ; heuristic: follows a terminator; C0
    farcall Func_005_790D
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A04
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

Jump_0E2_5A04::
    call Func_0E2_6887
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A17
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5A17::
    farcall Func_005_6153
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A2B
    and a, a
    jr nz, Jump_0E2_5A2B
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

Jump_0E2_5A2B::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A3F
    and a, a
    jr nz, Jump_0E2_5A3F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5A3F::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A53
    and a, a
    jr nz, Jump_0E2_5A53
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5A53::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A67
    and a, a
    jr nz, Jump_0E2_5A67
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5A67::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5A68:: ; heuristic: follows a terminator; C0
    call Func_0E2_5A72
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5A68)
Func_0E2_5A72::
    farcall Func_005_791F
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A91
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

Jump_0E2_5A91::
    call Func_0E2_6887
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5AA4
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5AA4::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5AB8
    and a, a
    jr nz, Jump_0E2_5AB8
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5AB8::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5ACC
    and a, a
    jr nz, Jump_0E2_5ACC
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5ACC::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5AE0
    and a, a
    jr nz, Jump_0E2_5AE0
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5AE0::
    call Func_0E2_67F9
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5AE6:: ; heuristic: follows a terminator; C0
    farcall Func_005_7946
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B05
    ld bc, $00BC
    call AccumulateBank6WordToDA6E
    ld bc, $00C4
    call AccumulateBank6WordToDA70

Jump_0E2_5B05::
    call Func_0E2_6887
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B18
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_5B18::
    farcall Func_005_5CF1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B28
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_5B28::
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5B3C
    and a, a
    jr nz, Jump_0E2_5B3C
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_5B3C::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_5B3D:: ; heuristic: follows a terminator; C0
    farcall Func_005_7975
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call Func_0E2_66C5
    farcall Func_005_44CF
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B5C
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_5B5C::
    farcall Func_005_4664
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B6C
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_5B6C::
    farcall Func_005_4BE1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B7C
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_5B7C::
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B8C
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_5B8C::
    farcall Func_005_53A5
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B9C
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_5B9C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BAC
    ld bc, $0024
    call AccumulateBank6WordToDA6E

Jump_0E2_5BAC::
    call Func_0E2_6887
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5BC3
    and a, a
    jr nz, Jump_0E2_5BC3
    ld bc, $0069
    call AccumulateBank6WordToDA6E

Jump_0E2_5BC3::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5BC4:: ; heuristic: follows a terminator; C0
    farcall Func_005_7996
    ld a, c
    and a, a
    ret z
    farcall Func_005_459D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BDD
    ld bc, $006C
    call AccumulateBank6WordToDA70

Jump_0E2_5BDD::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BED
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5BED::
    farcall Func_005_5275
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C01
    and a, a
    jr nz, Jump_0E2_5C01
    ld bc, $006D
    call AccumulateBank6WordToDA6E

Jump_0E2_5C01::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C11
    ld bc, $00BE
    call AccumulateBank6WordToDA6E

Jump_0E2_5C11::
    call Func_0E2_6887
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C24
    ld bc, $0032
    call AccumulateBank6WordToDA6E

Jump_0E2_5C24::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5C25:: ; heuristic: follows a terminator; C0
    farcall Func_005_79C5
    ld a, c
    and a, a
    ret z

Jump_0E2_5C2E::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C3E
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5C3E::
    farcall Func_005_5275
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C52
    and a, a
    jr nz, Jump_0E2_5C52
    ld bc, $006D
    call AccumulateBank6WordToDA6E

Jump_0E2_5C52::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C62
    ld bc, $00BA
    call AccumulateBank6WordToDA70

Jump_0E2_5C62::
    call Func_0E2_6854
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C75
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5C75::
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C85
    ld bc, $0032
    call AccumulateBank6WordToDA6E

Jump_0E2_5C85::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C99
    and a, a
    jr nz, Jump_0E2_5C99
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5C99::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5CAD
    and a, a
    jr nz, Jump_0E2_5CAD
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5CAD::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5CC1
    and a, a
    jr nz, Jump_0E2_5CC1
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5CC1::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5CC2:: ; heuristic: follows a terminator; C0
    farcall Func_005_79E5
    ld a, c
    and a, a
    ret z
    jp Jump_0E2_5C2E

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5CCE:: ; heuristic: follows a terminator; C0
    farcall Func_005_7A0D
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5CED
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_5CED::
    call Func_0E2_6854
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D00
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5D00::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D14
    and a, a
    jr nz, Jump_0E2_5D14
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5D14::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D28
    and a, a
    jr nz, Jump_0E2_5D28
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5D28::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D3C
    and a, a
    jr nz, Jump_0E2_5D3C
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5D3C::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5D3D:: ; heuristic: follows a terminator; C0
    farcall Func_005_7A27
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D5C
    ld bc, $00CA
    call AccumulateBank6WordToDA70

Jump_0E2_5D5C::
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5D60:: ; heuristic: follows a terminator; C0
    farcall Func_005_7A3E
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D7F
    ld bc, $00CC
    call AccumulateBank6WordToDA6E

Jump_0E2_5D7F::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5D83:: ; heuristic: follows a terminator; C0
    farcall Func_005_7A55
    ld a, c
    and a, a
    ret z
    ld bc, $0071
    call AccumulateBank6WordToDA6E
    farcall AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DA2
    ld bc, $0070
    call AccumulateBank6WordToDA6E

Jump_0E2_5DA2::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DB8
    ld bc, $00C9
    call AccumulateBank6WordToDA70
    ld bc, $00CB
    call AccumulateBank6WordToDA6E

Jump_0E2_5DB8::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5DBC:: ; heuristic: follows a terminator; C0
    farcall Func_005_7A6C
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DD5
    ld bc, $00C9
    call AccumulateBank6WordToDA6E

Jump_0E2_5DD5::
    call Func_0E2_6854
    farcall Func_005_57A1
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5DEC
    and a, a
    jr nz, Jump_0E2_5DEC
    ld bc, $0072
    call AccumulateBank6WordToDA6E

Jump_0E2_5DEC::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5DED:: ; heuristic: follows a terminator; C0
    farcall Func_005_7A91
    ld a, c
    and a, a
    ret z
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E06
    ld bc, $0073
    call AccumulateBank6WordToDA6E

Jump_0E2_5E06::
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E16
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5E16::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E32
    ld bc, $0074
    call AccumulateBank6WordToDA6E
    ld bc, $00BB
    call AccumulateBank6WordToDA6E
    ld bc, $00C7
    call AccumulateBank6WordToDA70

Jump_0E2_5E32::
    call Func_0E2_6854
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E45
    ld bc, $0075
    call AccumulateBank6WordToDA6E

Jump_0E2_5E45::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5E46:: ; heuristic: follows a terminator; C0
    farcall Func_005_7AA4
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E5F
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5E5F::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E6F
    ld bc, $0076
    call AccumulateBank6WordToDA6E

Jump_0E2_5E6F::
    call Func_0E2_6876
    farcall Func_005_5D31
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E82
    ld bc, $0077
    call AccumulateBank6WordToDA70

Jump_0E2_5E82::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5E83:: ; heuristic: follows a terminator; C0
    farcall Func_005_7ACC
    ld a, c
    and a, a
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E9C
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5E9C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5EB2
    ld bc, $00C2
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA70

Jump_0E2_5EB2::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5EB6:: ; heuristic: follows a terminator; C0
    call Func_0E2_5EC0
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5EB6)
Func_0E2_5EC0::
    farcall Func_005_7AD8
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5ED9
    ld bc, $0078
    call AccumulateBank6WordToDA6E

Jump_0E2_5ED9::
    call Func_0E2_6854
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5EF0
    and a, a
    jr nz, Jump_0E2_5EF0
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5EF0::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F04
    and a, a
    jr nz, Jump_0E2_5F04
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5F04::
    call Func_0E2_67F9
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5F0A:: ; heuristic: follows a terminator; C0
    farcall Func_005_7B11
    ld a, c
    and a, a
    ret z
    farcall Func_005_443B
    ld a, c
    and a, a
    jr nz, Jump_0E2_5F23
    ld bc, $0079
    call AccumulateBank6WordToDA70

Jump_0E2_5F23::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F37
    and a, a
    jr nz, Jump_0E2_5F37
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_5F37::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F4B
    and a, a
    jr nz, Jump_0E2_5F4B
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_5F4B::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5F5B
    ld bc, $0078
    call AccumulateBank6WordToDA6E

Jump_0E2_5F5B::
    call Func_0E2_6854
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F72
    and a, a
    jr nz, Jump_0E2_5F72
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5F72::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F86
    and a, a
    jr nz, Jump_0E2_5F86
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5F86::
    call Func_0E2_67F9
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5F8A:: ; heuristic: follows a terminator; C0
    call Func_0E2_5F94
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5F8A)
Func_0E2_5F94::
    farcall Func_005_7B40
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5FAD
    ld bc, $007B
    call AccumulateBank6WordToDA6E

Jump_0E2_5FAD::
    call Func_0E2_6854
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5FC4
    and a, a
    jr nz, Jump_0E2_5FC4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5FC4::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5FD8
    and a, a
    jr nz, Jump_0E2_5FD8
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5FD8::
    call Func_0E2_67F9
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_5FDE:: ; heuristic: follows a terminator; C0
    call Func_0E2_5FE8
    ld a, c
    and a, a
    ret z
    call Func_0E2_67F9
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5FDE)
Func_0E2_5FE8::
    farcall Func_005_7AD8
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6013
    ld bc, $00C0
    call AccumulateBank6WordToDA6E
    ld bc, $00C3
    call AccumulateBank6WordToDA70
    ld bc, $00CE
    call AccumulateBank6WordToDA70
    ld bc, $00D3
    call AccumulateBank6WordToDA6E

Jump_0E2_6013::
    call Func_0E2_6854
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_602A
    and a, a
    jr nz, Jump_0E2_602A
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_602A::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_603E
    and a, a
    jr nz, Jump_0E2_603E
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_603E::
    call Func_0E2_67F9
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6044:: ; heuristic: follows a terminator; C0
    farcall Func_005_7B5C
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_605D
    ld bc, $007D
    call AccumulateBank6WordToDA6E

Jump_0E2_605D::
    call Func_0E2_6854
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6074
    and a, a
    jr nz, Jump_0E2_6074
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_6074::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6088
    and a, a
    jr nz, Jump_0E2_6088
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_6088::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6089:: ; heuristic: follows a terminator; C0
    farcall Func_005_7B84
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_60A2
    ld bc, $007E
    call AccumulateBank6WordToDA6E

Jump_0E2_60A2::
    call Func_0E2_6887
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_60A6:: ; heuristic: follows a terminator; C0
    farcall Func_005_7BBE
    ld a, c
    and a, a
    ret z
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_60C3
    and a, a
    jr nz, Jump_0E2_60C3
    ld bc, $007F
    call AccumulateBank6WordToDA6E

Jump_0E2_60C3::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_60D3
    ld bc, $0080
    call AccumulateBank6WordToDA6E

Jump_0E2_60D3::
    call Func_0E2_6876
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_60D7:: ; heuristic: follows a terminator; C0
    farcall Func_005_7BE6
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld a, [wBattleActor]
    call Func_0E2_656D
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_60FA
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_60FA::
    farcall Func_005_5500
    ld a, c
    cp a, $01
    jr z, Jump_0E2_610E
    and a, a
    jr nz, Jump_0E2_610E
    ld bc, $0000
    call AccumulateBank6WordToDA6E

Jump_0E2_610E::
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6112:: ; heuristic: follows a terminator; C0
    farcall Func_005_7C12
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6135
    ld bc, $0088
    call AccumulateBank6WordToDA6E
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_6135::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6139:: ; heuristic: follows a terminator; C0
    farcall Func_005_7C45
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_615C
    ld bc, $008A
    call AccumulateBank6WordToDA6E
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_615C::
    call Func_0E2_6865
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_6160:: ; heuristic: follows a terminator; C0
    farcall Func_005_7C69
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    ld a, [wBattleActor]
    call Func_0E2_672D
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6189
    ld bc, $00CD
    call AccumulateBank6WordToDA70
    ld bc, $00D1
    call AccumulateBank6WordToDA6E

Jump_0E2_6189::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_618D:: ; heuristic: follows a terminator; C0
    farcall Func_005_7C82
    ld a, c
    and a, a
    ret z
    call Func_0E2_67C0
    ret z

Jump_0E2_619A::
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_61AE
    and a, a
    jr nz, Jump_0E2_61BE
    ld bc, $003A
    call AccumulateBank6WordToDA6E

Jump_0E2_61AE::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_61BE
    ld bc, $008C
    call AccumulateBank6WordToDA6E

Jump_0E2_61BE::
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_61C2:: ; heuristic: follows a terminator; C0
    farcall Func_005_7CA2
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_619A

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_61CD:: ; heuristic: follows a terminator; C0
    farcall Func_005_7CC2
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call Func_0E2_65B8
    call Func_0E2_6854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_61E0:: ; heuristic: follows a terminator; C0
    farcall Func_005_7CE7
    ld a, c
    and a, a
    ret z
    farcall Func_005_4E20
    ld a, c
    and a, a
    jr nz, Jump_0E2_61F9
    ld bc, $008D
    call AccumulateBank6WordToDA70

Jump_0E2_61F9::
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_620D
    and a, a
    jr nz, Jump_0E2_620D
    ld bc, $008E
    call AccumulateBank6WordToDA6E

Jump_0E2_620D::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_621D
    ld bc, $00CB
    call AccumulateBank6WordToDA6E

Jump_0E2_621D::
    farcall Func_005_5500
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6231
    and a, a
    jr nz, Jump_0E2_6231
    ld bc, $008F
    call AccumulateBank6WordToDA6E

Jump_0E2_6231::
    call Func_0E2_6854
    farcall Func_005_57A1
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6248
    and a, a
    jr nz, Jump_0E2_6248
    ld bc, $0090
    call AccumulateBank6WordToDA6E

Jump_0E2_6248::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_6249:: ; heuristic: follows a terminator; C0
    farcall Func_005_7CF3
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_6266
    ld bc, $0091
    call AccumulateBank6WordToDA6E

Jump_0E2_6266::
    farcall Func_005_4BE1
    ld a, c
    and a, a
    jr nz, Jump_0E2_6276
    ld bc, $0092
    call AccumulateBank6WordToDA70

Jump_0E2_6276::
    ld a, [wBattleActor]
    call Func_0E2_6603
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6290
    and a, a
    jr nz, Jump_0E2_6290
    ld bc, $008E
    call AccumulateBank6WordToDA6E

Jump_0E2_6290::
    call Func_0E2_6876
    farcall Func_005_5D20
    ld a, c
    and a, a
    jr nz, Jump_0E2_62A3
    ld bc, $0097
    call AccumulateBank6WordToDA70

Jump_0E2_62A3::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_62A4:: ; heuristic: follows a terminator; C0
    farcall Func_005_7D5B
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    farcall Func_005_4C5D
    ld a, c
    and a, a
    jr nz, Jump_0E2_62C1
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_62C1::
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_62D5
    and a, a
    jr nz, Jump_0E2_62D5
    ld bc, $0098
    call AccumulateBank6WordToDA6E

Jump_0E2_62D5::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_62EB
    ld bc, $00BB
    call AccumulateBank6WordToDA70
    ld bc, $00C6
    call AccumulateBank6WordToDA6E

Jump_0E2_62EB::
    call Func_0E2_6854
    farcall Func_005_57A1
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6302
    and a, a
    jr nz, Jump_0E2_6302
    ld bc, $009A
    call AccumulateBank6WordToDA6E

Jump_0E2_6302::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_6303:: ; heuristic: follows a terminator; C0
    farcall Func_005_7D95
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call Func_0E2_6634
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_6322
    ld bc, $00A1
    call AccumulateBank6WordToDA6E

Jump_0E2_6322::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6338
    ld bc, $00C2
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA70

Jump_0E2_6338::
    call Func_0E2_6865
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_634F
    and a, a
    jr nz, Jump_0E2_634F
    ld bc, $0069
    call AccumulateBank6WordToDA70

Jump_0E2_634F::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6350:: ; heuristic: follows a terminator; C0
    farcall Func_005_7DA8
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_636F
    ld bc, $00CC
    call AccumulateBank6WordToDA70
    ld bc, $00D3
    call AccumulateBank6WordToDA70

Jump_0E2_636F::
    call Func_0E2_6865
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6386
    and a, a
    jr nz, Jump_0E2_6386
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_6386::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_0E2_6387:: ; heuristic: follows a terminator; C0
    farcall Func_005_7DC2
    ld a, c
    and a, a
    ret z
    farcall Func_005_4BE1
    ld a, c
    and a, a
    jr nz, Jump_0E2_63A0
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_63A0::
    ld a, [wBattleActor]
    call Func_0E2_66C5
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_63B6
    ld bc, $00A3
    call AccumulateBank6WordToDA6E

Jump_0E2_63B6::
    farcall Func_005_53A5
    ld a, c
    and a, a
    jr nz, Jump_0E2_63C6
    ld bc, $00A4
    call AccumulateBank6WordToDA6E

Jump_0E2_63C6::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_63E2
    ld bc, $00CC
    call AccumulateBank6WordToDA70
    ld bc, $00CF
    call AccumulateBank6WordToDA6E
    ld bc, $00D3
    call AccumulateBank6WordToDA70

Jump_0E2_63E2::
    call Func_0E2_6865
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_63F9
    and a, a
    jr nz, Jump_0E2_63F9
    ld bc, $0069
    call AccumulateBank6WordToDA6E

Jump_0E2_63F9::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_63FA:: ; heuristic: follows a terminator; C0
    farcall Func_005_7DDC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6401:: ; heuristic: follows a terminator; C0
    farcall Func_005_7B11
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_641A
    ld bc, $00A5
    call AccumulateBank6WordToDA6E

Jump_0E2_641A::
    call Func_0E2_6898
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_641E:: ; heuristic: follows a terminator; C0
    farcall Func_005_7DDC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6425:: ; heuristic: follows a terminator; C0
    call Func_0E2_67A5
    ret z
    farcall Func_005_7DE8
    ld a, c
    and a, a
    ret z
    farcall Func_005_459D
    ld a, c
    and a, a
    jr nz, Jump_0E2_6442
    ld bc, $00A6
    call AccumulateBank6WordToDA70

Jump_0E2_6442::
    farcall Func_005_4777
    ld a, c
    and a, a
    jr nz, Jump_0E2_6452
    ld bc, $00A7
    call AccumulateBank6WordToDA70

Jump_0E2_6452::
    farcall Func_005_5397
    ld a, c
    and a, a
    jr nz, Jump_0E2_6462
    ld bc, $00A8
    call AccumulateBank6WordToDA70

Jump_0E2_6462::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6472
    ld bc, $00A9
    call AccumulateBank6WordToDA6E

Jump_0E2_6472::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_6473:: ; heuristic: follows a terminator; C0
    farcall Func_005_7370
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_648C
    ld bc, $0037
    call AccumulateBank6WordToDA6E

Jump_0E2_648C::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E2_648D:: ; heuristic: follows a terminator; C0
    farcall Func_005_7397
    ld a, c
    and a, a
    ret z
    call Func_0E2_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_64AA
    ld bc, $0038
    call AccumulateBank6WordToDA6E

Jump_0E2_64AA::
    farcall Func_005_57A1
    ld a, c
    cp a, $01
    jr z, Jump_0E2_64BE
    and a, a
    jr nz, Jump_0E2_64BE
    ld bc, $0039
    call AccumulateBank6WordToDA6E

Jump_0E2_64BE::
    ret
    db $C9, $C9, $CD, $D4, $3E, $FA, $E7, $C5, $CB, $7F, $CC, $40, $65, $C9, $C9

; word = ReadBank6TableWord; if its low byte is $FF the value is 5000, which is added to wDA6E; a positive word is added to wDA6E; a negative word's magnitude is added to wDA70
; 304 call sites from 118 routines (e.g. Func_0E2_4001, Func_0E2_656D, Func_0E2_40BF, Func_0E2_6822, ...)
; points at: wDA6E, wDA70
AccumulateBank6WordToDA6E::
Func_0E2_64CE:: ; address name
    call ReadBank6TableWord
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
    ld hl, wDA70
    call AddBCToWordAtHL
    jr Jump_0E2_64F4

Jump_0E2_64EE::
    ld hl, wDA6E
    call AddBCToWordAtHL

Jump_0E2_64F4::
    ret

; the mirror of AccumulateBank6WordToDA6E: $FF (5000) and positive words go to wDA70, negative words' magnitude goes to wDA6E
; 223 call sites from 89 routines (e.g. Func_0E2_4001, Func_0E2_656D, Func_0E2_40BF, Func_0E2_6822, ...)
; points at: wDA70, wDA6E
AccumulateBank6WordToDA70::
Func_0E2_64F5:: ; address name
    call ReadBank6TableWord
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
    ld hl, wDA6E
    call AddBCToWordAtHL
    jr Jump_0E2_651B

Jump_0E2_6515::
    ld hl, wDA70
    call AddBCToWordAtHL

Jump_0E2_651B::
    ret

; the 16-bit word at [HL] += BC; HL is unchanged
; 4 call sites from 2 routines (e.g. AccumulateBank6WordToDA70, AccumulateBank6WordToDA6E)
AddBCToWordAtHL::
Func_0E2_651C:: ; address name
    push hl
    deref_hl
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

; BC = the 16-bit word at ROM bank 6, $4001 + $36 * BC + 2 * wD2C7 (rows of 27 words); A = its low byte; clobbers HL, E
; 2 call sites from 2 routines (e.g. AccumulateBank6WordToDA70, AccumulateBank6WordToDA6E)
; reads: wPersonalityIndex
; writes: wDataBank
ReadBank6TableWord::
Func_0E2_654B:: ; address name
    ld a, $36
    call Multiply8By16
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld a, [wPersonalityIndex]
    add a, a
    add_a_to_hl
    ld a, $06
    ld [wDataBank], a
    call ReadWordFromDataBank
    ld a, b
    ld b, c
    ld c, a
    ret

; 1 call site from 1 routine (e.g. Func_0E2_60D7)
; writes: hFFC6
Func_0E2_656D:: ; heuristic: follows a terminator; C0
    ldh [hFFC6], a
    farcall Func_005_5317
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
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_65B7

Jump_0E2_6591::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_6599::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_65A1::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_65A9::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_65B1::
    ld bc, $0084
    call AccumulateBank6WordToDA6E

Jump_0E2_65B7::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_61CD)
; writes: hFFC6
Func_0E2_65B8:: ; heuristic: follows a terminator; C0
    ldh [hFFC6], a
    farcall Func_005_5317
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
    call AccumulateBank6WordToDA70
    jr Jump_0E2_6602

Jump_0E2_65DC::
    ld bc, $0081
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_6602

Jump_0E2_65E4::
    ld bc, $0082
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_6602

Jump_0E2_65EC::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_6602

Jump_0E2_65F4::
    ld bc, $0084
    call AccumulateBank6WordToDA70
    jr Jump_0E2_6602

Jump_0E2_65FC::
    ld bc, $0085
    call AccumulateBank6WordToDA70

Jump_0E2_6602::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6249)
; writes: hFFC6
Func_0E2_6603:: ; heuristic: follows a terminator; C0
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6608::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_6615
    ldh [hFFC6], a
    push bc
    call Func_0E2_661A
    pop bc

Jump_0E2_6615::
    inc c
    dec b
    jr nz, Jump_0E2_6608
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6603)
Func_0E2_661A::
    farcall Func_005_5317
    ld a, c
    cp a, $02
    jr nc, Jump_0E2_662D
    ld bc, $0093
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_6633

Jump_0E2_662D::
    ld bc, $0094
    call AccumulateBank6WordToDA70

Jump_0E2_6633::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6303)
; writes: hFFC6
Func_0E2_6634:: ; heuristic: follows a terminator; C0
    ldh [hFFC6], a
    farcall Func_005_5317
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
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_667E

Jump_0E2_6658::
    ld bc, $009B
    call AccumulateBank6WordToDA70
    jr Jump_0E2_667E

Jump_0E2_6660::
    ld bc, $009C
    call AccumulateBank6WordToDA70
    jr Jump_0E2_667E

Jump_0E2_6668::
    ld bc, $009D
    call AccumulateBank6WordToDA70
    jr Jump_0E2_667E

Jump_0E2_6670::
    ld bc, $009E
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_667E

Jump_0E2_6678::
    ld bc, $009F
    call AccumulateBank6WordToDA6E

Jump_0E2_667E::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_432D)
; writes: hFFC6
Func_0E2_667F:: ; heuristic: follows a terminator; C0
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6684::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_6691
    ldh [hFFC6], a
    push bc
    call Func_0E2_6696
    pop bc

Jump_0E2_6691::
    inc c
    dec b
    jr nz, Jump_0E2_6684
    ret

; 1 call site from 1 routine (e.g. Func_0E2_667F)
; reads: wBattleActor
Func_0E2_6696::
    push bc
    farcall Func_005_5317
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
    ld hl, Data_0E2_66B9
    jr z, Jump_0E2_66AC
    ld hl, Data_0E2_66BF

Jump_0E2_66AC::
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

Data_0E2_66B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1E, $1F, $20, $21, $22, $22

Data_0E2_66BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AB, $AC, $AD, $AE, $AF, $AF

; 2 call sites from 2 routines (e.g. Func_0E2_5B3D, Func_0E2_6387)
; writes: hFFC6
Func_0E2_66C5::
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_66CA::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_66D7
    ldh [hFFC6], a
    push bc
    call Func_0E2_66DC
    pop bc

Jump_0E2_66D7::
    inc c
    dec b
    jr nz, Jump_0E2_66CA
    ret

; 1 call site from 1 routine (e.g. Func_0E2_66C5)
; reads: wBattleActor
Func_0E2_66DC::
    push bc
    farcall Func_005_5317
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
    ld hl, Data_0E2_66FF
    jr z, Jump_0E2_66F2
    ld hl, Data_0E2_6705

Jump_0E2_66F2::
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

Data_0E2_66FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1D, $1E, $1F, $20, $21, $22

Data_0E2_6705:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $AB, $AC, $AD, $AE, $AF

; 1 call site from 1 routine (e.g. Func_0E2_57A9)
; writes: hFFC6
Func_0E2_670B::
    ldh [hFFC6], a
    push bc
    farcall Func_005_5317
    ld a, c
    pop bc
    ld b, a
    ld hl, Func_0E2_6727
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: hFFC6
Func_0E2_6727:: ; heuristic: follows a terminator; C0
    dec e
    ld e, $1F
    jr nz, Jump_0E2_674D
    ld [hl+], a

; 1 call site from 1 routine (e.g. Func_0E2_6160)
; writes: hFFC6
Func_0E2_672D::
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6732::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_673F
    ldh [hFFC6], a
    push bc
    call Func_0E2_6744
    pop bc

Jump_0E2_673F::
    inc c
    dec b
    jr nz, Jump_0E2_6732
    ret

; 1 call site from 1 routine (e.g. Func_0E2_672D)
; reads: wBattleActor
Func_0E2_6744::
    push bc
    farcall Func_005_5317
    ld a, c
    pop bc

Jump_0E2_674D::
    ld b, a
    ld a, [wBattleActor]
    cp a, c
    ld hl, Data_0E2_6767
    jr z, Jump_0E2_675A
    ld hl, Data_0E2_676D

Jump_0E2_675A::
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

Data_0E2_6767:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $20, $1F, $1E, $1D, $1D

Data_0E2_676D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $AA, $AB, $AC, $AD, $AE

; 1 call site from 1 routine (e.g. Func_0E2_446C)
Func_0E2_6773::
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_6785
    ld bc, $002B
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_678B

Jump_0E2_6785::
    ld bc, $0013
    call AccumulateBank6WordToDA70

Jump_0E2_678B::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_449C)
Func_0E2_678C:: ; heuristic: follows a terminator; C0
    farcall Func_005_65C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_679E
    ld bc, $0013
    call AccumulateBank6WordToDA70
    jr Jump_0E2_67A4

Jump_0E2_679E::
    ld bc, $002B
    call AccumulateBank6WordToDA6E

Jump_0E2_67A4::
    ret

; 4 call sites from 4 routines (e.g. Func_0E2_67CF, Func_0E2_51F6, Func_0E2_56C6, Func_0E2_6425)
; reads: wD2CC
; writes: wDA6E, wDA6F, wDA70, wDA71
Func_0E2_67A5:: ; heuristic: follows a terminator; C0
    ld a, [wD2CC]
    and a, $01
    xor a, $01
    ld c, a
    ret nz
    xor a, a
    ld [wDA6E], a
    ld [wDA6F], a
    ld a, $FF
    ld [wDA70], a
    ld [wDA71], a
    xor a, a
    ld c, a
    ret

; 1 call site from 1 routine (e.g. Func_0E2_618D)
; reads: wD891
Func_0E2_67C0:: ; heuristic: follows a terminator; C0
    ld a, [wD891]
    ld c, a
    or a, a
    ret nz
    ld bc, $00B6
    call AccumulateBank6WordToDA70
    ld c, $FF
    ret

; 8 call sites from 8 routines (e.g. Func_0E2_48AE, Func_0E2_60D7, Func_0E2_6112, Func_0E2_6139, ...)
; reads: wD891
Func_0E2_67CF::
    call Func_0E2_67A5
    ret z
    jr Func_0E2_67C0

; 2 call sites from 2 routines (e.g. Func_0E2_43C8, Func_0E2_43E9)
Func_0E2_67D5::
    call Func_0E2_6865
    farcall Func_005_5758
    ld a, c
    and a, a
    jr nz, Jump_0E2_67E8
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_67E8::
    farcall Func_005_5CF1
    ld a, c
    and a, a
    jr nz, Jump_0E2_67F8
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_67F8::
    ret

; 9 call sites from 9 routines (e.g. Func_0E2_5A68, Func_0E2_5A72, Func_0E2_5EB6, Func_0E2_5EC0, ...)
Func_0E2_67F9:: ; heuristic: follows a terminator; C0
    farcall Func_005_5ECE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_680D
    and a, a
    jr nz, Jump_0E2_680D
    ld bc, $00B1
    call AccumulateBank6WordToDA6E

Jump_0E2_680D::
    farcall Func_005_5FC7
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6821
    and a, a
    jr nz, Jump_0E2_6821
    ld bc, $00B2
    call AccumulateBank6WordToDA6E

Jump_0E2_6821::
    ret

; 3 call sites from 3 routines (e.g. Func_0E2_40BF, Func_0E2_411C, Func_0E2_41E0)
Func_0E2_6822::
    farcall Func_005_55BE
    ld a, c
    and a, a
    jr nz, Jump_0E2_6832
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6832::
    farcall Func_005_5731
    ld a, c
    and a, a
    jr nz, Jump_0E2_6842
    ld bc, $000F
    call AccumulateBank6WordToDA6E

Jump_0E2_6842::
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4279)
Func_0E2_6843:: ; heuristic: follows a terminator; C0
    farcall Func_005_55BE
    ld a, c
    and a, a
    jr nz, Jump_0E2_6853
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6853::
    ret

; 36 call sites from 36 routines (e.g. Func_0E2_446C, Func_0E2_449C, Func_0E2_4536, Func_0E2_4567, ...)
Func_0E2_6854:: ; heuristic: follows a terminator; C0
    farcall Func_005_55F3
    ld a, c
    and a, a
    jr nz, Jump_0E2_6864
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6864::
    ret

; 12 call sites from 12 routines (e.g. Func_0E2_432D, Func_0E2_67D5, Func_0E2_4420, Func_0E2_4433, ...)
Func_0E2_6865:: ; heuristic: follows a terminator; C0
    farcall Func_005_5628
    ld a, c
    and a, a
    jr nz, Jump_0E2_6875
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6875::
    ret

; 5 call sites from 5 routines (e.g. Func_0E2_4B6B, Func_0E2_5876, Func_0E2_5E46, Func_0E2_60A6, ...)
Func_0E2_6876:: ; heuristic: follows a terminator; C0
    farcall Func_005_565D
    ld a, c
    and a, a
    jr nz, Jump_0E2_6886
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6886::
    ret

; 8 call sites from 8 routines (e.g. Func_0E2_591F, Func_0E2_5970, Func_0E2_59E5, Func_0E2_5A72, ...)
Func_0E2_6887:: ; heuristic: follows a terminator; C0
    farcall Func_005_5692
    ld a, c
    and a, a
    jr nz, Jump_0E2_6897
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6897::
    ret

; 22 call sites from 22 routines (e.g. Func_0E2_4AB6, Func_0E2_4C49, Func_0E2_4CE6, Func_0E2_4D7B, ...)
Func_0E2_6898:: ; heuristic: follows a terminator; C0
    farcall Func_005_56C7
    ld a, c
    and a, a
    jr nz, Jump_0E2_68A8
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_68A8::
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68A9:: ; address name
    ld hl, wBattleATK
    jr Jump_0E2_68D6
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0E2_68D6::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68E0:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68E7:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0E2_68FC
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0E2_68FC
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_0E2_68FC::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_6902:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0E2_6917
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0E2_6917
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_0E2_6917::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $38A91D, $CA
    ds $1619, $00
