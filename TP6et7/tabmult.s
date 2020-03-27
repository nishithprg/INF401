@ Programme tabmult : Affiche les tables de multiplication de de 1 a 10
N_MAX= 10
   .data
barre :  .byte '|'
         .byte 0
espace : .byte ' '
         .byte 0
tirets : .asciz "---"

N_MAX :  .byte 10

debutTab:    .skip 400            @ adresse du debut du tableau and size N_MAX*N_MAX*4

   .text
   .global main
main: 
    push {lr}

    mov r2, #0          @ nlig in r2 and initialised with 0
    mov r3, #0          @ ncol in r3 et initialised with 0

    ldr r10, adr_N_MAX  @ Load the address of N_MAX to r10
    ldrb r4, [r10]      @ Load the value at the address r10 to r4
    @mov r5, r4         @ r5 = N_MAX
    sub r4, r4, #1      @ r5 = r5 - 1 (N_MAX - 1)
      
    ldr r10, ptr_debutTab   @ Load the address of debutTab to r10

    @ remplissage du tableau

    lp_line_r:                    @ Loop nlin
        cmp r2, r4                @ Compare nlin to N_MAX - 1
        bgt end_lp_line_r         @ If nlin >= N_MAX break loop nlin

        mov r3, #0                @ ncol in r3 et initialised with 0

        lp_colm_r:                @ Loop ncol, nested loop
            cmp r3, r4            @ Compare ncol to N_MAX -1
            bgt end_lp_colm_r     @ If ncol >= N_MAX break loop ncol 

            add r8, r2, #1        @ r8 = nlin + 1
            add r9, r3, #1        @ r9 = ncol + 1
            
            mul r7, r8, r9        @ mult = (nlin + 1) * (ncol + 1), mult in r7
            mul r8, r7, #4        @ r9 = mult * 4

            str r7, [r10, r8]     @ [r1, r8] où r8 est le decalage par rapport a r1

            add r3, r3, #1        @ ncol += 1

            b   lp_colm_r         @ Return to loop ncol for next iteration
    end_lp_colm_r :
        add r2, r2, #1            @ nlin += 1      

        b lp_line_r               @ Return to loop nlin for next iteration

    end_lp_line_r:

    @ affichage du tableau
        @ Dans cette partie on incremente le compteur du tableau par 4
        mov r2, #0          @ nlig in r2 and initialised with 0
        mov r3, #0          @ ncol in r3 et initialised with 0

    lp_line:                @ Loop nlin
        cmp r2, r4          @ Compare nlin to N_MAX - 1
        bgt end_lp_line     @ If nlin >= N_MAX break loop nlin

        mov r3, #0          @ Reset ncol to 0 when new line

        lp_colm:                @ Loop ncol, nested loop
            cmp r3, r4          @ Compare ncol to N_MAX -1
            bgt end_lp_colm     @ If ncol >= N_MAX break loop ncol 

            ldr r1, adr_barre   @ Load the address of barre in r1
            bl EcrChn           @ Print |

            ldr r7, [r10]       @ mult = valeur at addresse r10

            add r10, r10, #4    @ Calculate de addresse of the next cell

            cmp r7, #100        @ Compare mult and 100
            bge end_100         @ If mult >= 100, go to end_100

            ldr r1, adr_espace  @ Load the address of espace to r1
            bl EcrChn           @ Print ' '

        end_100 : 
            cmp r7, #10         @ Compare mult and 10
            bge end_10          @ If mult >= 10, go to end_10

            ldr r1, adr_espace  @ Load the address of espace to r1
            bl EcrChn           @ Print ' '

        end_10:
            mov r1, r7          @ r1 = 0
            bl EcrNdecim32      @ Print 0

            add r3, r3, #1      @ ncol += 1

            b lp_colm           @ Return to loop ncol for next iteration

    end_lp_colm :
        ldr r1, adr_barre   @ Load the address of barre in r1
        bl EcrChn           @ Print |

        bl AlaLigne         @ Print \n

        mov r6, #0          @ i = 0

        lp_border:
            cmp r6, r4          @ Compare i and N_MAX - 1
            bgt end_lp_border

            ldr r1, adr_barre   @ Load the address of barre in r1
            bl EcrChn           @ Print |

            ldr r1, adr_tirets  @ Load the address of barre in r1
            bl EcrChn           @ Print |

            add r6, r6, #1      @ i += 1

            b lp_border         @ Return to loop border for next iteration

    end_lp_border:
        ldr r1, adr_barre   @ Load the address of barre in r1
        bl EcrChn           @ Print |

        bl AlaLigne         @ Print \n

        add r2, r2, #1      @ nlin += 1      

        b lp_line           @ Return to loop nlin for next iteration

    end_lp_line:
    
fin: pop {lr}
     bx lr

ptr_debutTab : .word debutTab
adr_barre :    .word barre
adr_espace :   .word espace
adr_tirets :   .word tirets
adr_N_MAX:     .word N_MAX
