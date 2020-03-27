    .text
    .global main

main : 
    push {lr}

    @ Algo intermediaire de la multiplication
        @ nlin est dans le registre r2
        @ ncol et dans le registre r3
        @ supposons que a -> nlin et b -> ncol

        mov r7, #0      @ mult = 0
        mov r6, #0      @ i = 0, compteur de la boucle
    tq:
        cmp r6, r2
        bgt fin             @ Si i > a, branchement vers fin ici par exemple
        add r7, r7, r2      @ mult += b
        add r6, r6, #1      @ i += 1
        b tq                @ Branchement vers tq

    @ Le code ARM correspondant a : table[x][y] <-- valeur
        @ Soit x dans r2 (comme nlin) et y dans r3 (comme ncol)
        @ Soit valeur dans r7 (comme mult)
        @ Soit r1 l'adresse de table

        add r8, r2, #1
        add r9, r3, #1
        mul r8, r8, r9
        mul r9, r9, #4
        str r7, [r1, r8]

fin: 
    pop {lr}
    bx lr 