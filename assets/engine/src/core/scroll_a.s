.include "global.s"

.area _CODE

_GetWinAddr::
        ldh     a,(.LCDC)
        bit     LCDCF_B_WIN9C00,a
        jr      Z,.is98
        jr      .is9c

_GetBkgAddr::
        ldh     a,(.LCDC)
        bit     LCDCF_B_BG9C00,a
        jr      NZ,.is9c
.is98:
        ld      de,#0x9800      ; DE = origin
        ret
.is9c:
        ld      de,#0x9C00      ; DE = origin
        ret

.area _CODE_255

; void scroll_rect(UBYTE * base_addr, UBYTE w, UBYTE h, UBYTE fill) BANKED; 
.globl b_scroll_rect
b_scroll_rect = 255

_scroll_rect::
    ldhl    SP, #9
    ld      A, (HL-)
    or      A
    ret     Z

    ld      D, A
    ld      A, (HL-)
    ld      E, A
    ld      A, (HL-)
    ld      L, (HL)
    ld      H, A

    push    BC

    dec     D
    jr      Z, 1$

2$:
    ld      B, H
    ld      C, L

    ld      A, #0x20
    add     L
    ld      L, A
    adc     H
    sub     L
    ld      H, A

    push    HL
    push    DE
3$:
    WAIT_STAT
    ld      A, (HL+)
    ld      (BC), A
    inc     BC
    dec     E
    jr      NZ, 3$

    pop     DE
    pop     HL

    dec     D
    jr      NZ, 2$

1$:
    push    HL
    ldhl    SP, #14
    ld      D, (HL)
    pop     HL

4$:
    WAIT_STAT
    ld      A, D
    ld      (HL+), A
    dec     E
    jr      NZ, 4$

    pop     BC
    ret
