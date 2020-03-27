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

        add r8, r2, #1      @ r8 = nlin + 1
        add r9, r3, #1      @ r9 = ncol + 1
        mul r7, r8, r9      @ mult = (nlin + 1) * (ncol + 1)
        mul r8, r7, #4      @ r9 = mult * 4
        str r7, [r10, r8]    @ [r1, r8] où r8 est le decalage par rapport a r1
fin: 
    pop {lr}
    bx lr 