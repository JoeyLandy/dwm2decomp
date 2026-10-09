# Assembly learning plan

For a technical partner who is new to assembly. Baseline: **2026-09-12**. Learn only enough machinery to answer the next useful project question, then extend that understanding through evidence.

## Reference shelf

- [GB assembly tutorial](https://gbdev.io/gb-asm-tutorial/) and its [source repository](https://github.com/gbdev/gb-asm-tutorial): guided exercises. The repository was inspected; the hosted tutorial denied direct retrieval during this survey.
- [Pan Docs registers and flags](https://github.com/gbdev/pandocs/blob/master/src/CPU_Registers_and_Flags.md) and [memory map](https://github.com/gbdev/pandocs/blob/master/src/Memory_Map.md): platform concepts.
- [RGBDS instruction reference](https://github.com/gbdev/rgbds/blob/master/man/gbz80.7): authoritative syntax, encoding, instruction effects, and timing. Use the manual for the tool version eventually pinned by the project.
- [BGB debugger features](https://bgb.bircd.org/): stepping, watchpoints, symbols, and memory inspection. Learn the features through one recorded scenario after setup.

These resources explain the platform. They do not establish what a DWM routine does.

## A working vocabulary

The Game Boy instruction set is often called SM83 or LR35902 assembly. Use a Game Boy-specific reference rather than assuming general Z80 or NES instructions apply. Registers are small CPU storage locations; the program counter selects the next instruction; the stack pointer identifies the current stack position. Instructions also affect flags that later branches can inspect. [RGBDS instruction reference](https://github.com/gbdev/rgbds/blob/master/man/gbz80.7), [Pan Docs registers](https://github.com/gbdev/pandocs/blob/master/src/CPU_Registers_and_Flags.md)

| Term | Meaning in our work |
| --- | --- |
| Byte / word | 8 bits / usually 16 bits here; always state a field's actual width |
| Hexadecimal | Base 16; `$10` or `0x10` means decimal 16 |
| Little endian | A multi-byte number stores its least-significant byte first |
| Disassembly | Interpreting instruction bytes as assembly; decoding alone cannot distinguish all code from data |
| Symbol | A readable name for an address or value; it can be wrong without changing the bytes |
| Bank | A memory region selected into a CPU address window; address and bank together identify the location |
| Pointer | An encoded reference interpreted by particular code; it may need bank/base context |
| Watchpoint | Pause execution on a selected memory access to find readers or writers |
| Calling convention | The routine's input/output locations, preserved/clobbered state, and bank assumptions |
| Round trip | Decode then encode data without changing its bytes |
| Binary identity | The entire output file equals the identified reference |

## Lessons tied to project milestones

| Lesson | Concepts | Small exercise | Demonstration of understanding |
| --- | --- | --- | --- |
| 1. Bytes and identity | Hex, widths, hashes, offsets | Inspect a synthetic byte array and explain one changed byte versus a changed checksum | Explain why a filename or successful boot does not identify the original ROM |
| 2. Registers and instruction effects | A, BC/DE/HL, PC/SP, flags, memory access | Step through the example below on paper, then in a tiny fixture once tools exist | Predict register, memory, and branch results without guessing a game purpose |
| 3. Control flow | Conditional jumps, calls/returns, stack, side effects | Draw a small routine's branches and identify its return values and clobbers | Explain a normal and boundary path, including flags used by the caller |
| 4. Banked addressing | File offset versus CPU address; ROM/WRAM banking | Convert an illustrative bank/address pair and inspect one real bank transition later | Explain why a bare `$D8BF` or `$4001` is incomplete context |
| 5. Data and consumers | Pointer tables, record strides, enum holes, endianness | Follow one monster-table reader into a bounded record | Show why the bytes represent a table and which fields remain unknown |
| 6. Runtime evidence | Breakpoints, watchpoints, controlled state | Trace a candidate HP field through damage and healing | Distinguish observation, causal support, and an untested explanation |
| 7. Hardware interactions | Interrupts, I/O, VRAM/OAM, timing | Annotate one input read or graphics transfer and its preconditions | Explain why a copy to VRAM can require timing conditions |
| 8. Mechanics | Fixed-width arithmetic, rounding, RNG state | Derive one narrow mechanic from its actual instructions | Match contrasting cases and state precisely what has not been established |

Lessons 1–2 can start with synthetic examples before a ROM exists. Lessons 3–8 use small pieces of the matching project as they become available. Plan roughly 20–40 minutes of explanation and one practical exercise within a work session; adjust to interest and difficulty rather than completing a textbook first.

## First example: useful mechanics, unknown purpose

This is **synthetic teaching code**, not extracted DWM source. It is not assembled or tested in this baseline. Assume HL points to ordinary writable RAM and B starts at 3.

```asm
    ld b, 3
.loop
    ld a, [hl]
    inc a
    ld [hli], a
    dec b
    jr nz, .loop
    ret
```

It reads a byte through HL, increments that value, stores it back while advancing HL, and decrements B. The conditional branch uses the zero flag from `dec b`, the last flag-changing instruction before the branch. After three iterations it returns. `inc a` wraps an 8-bit value: `$FF` becomes `$00`. These instruction effects are documented in the [RGBDS instruction reference](https://github.com/gbdev/rgbds/blob/master/man/gbz80.7).

For starting bytes `[0x10, 0xFF, 0x00]`, predict `[0x11, 0x00, 0x01]`, HL advanced by 3, B equal to 0, and A equal to 1. The snippet does not tell us whether the bytes represent levels, counters, tiles, or something else. In a real investigation, that purpose would remain C0 until caller/data evidence supported it.

Now suppose a caller supplies B instead of the initial `ld b, 3`. If B enters as zero and execution falls into the loop, the first decrement wraps B to `$FF`; the body executes 256 times before the decrement produces zero. This is why we examine boundary inputs and actual instruction order rather than translating the routine casually into a high-level counted loop.

For this lesson, explain both the three-iteration case and that zero-entry variant. Later, inspect a real routine's caller before deciding whether zero is even a reachable input.

## How explanations will be delivered

For each new routine, I will give you the player-visible question, the relevant bytes/addresses, a short annotated instruction sequence, a small diagram or pseudocode only when useful, the prediction we tested, and its confidence. You should be able to challenge the explanation without memorizing the instruction set.

We will record one new concept and one unresolved question in each [session handoff](WORKFLOW.md). When an explanation is uncertain, we will say exactly which observation would improve it. Becoming comfortable reading and testing small routines is the first objective; writing large amounts of assembly can come later.
