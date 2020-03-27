.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
three: .word 3  /* variable 1 in memory */
four: .word 4  /* variable 2 in memory */

.text          /* start of the text (code) section */ 
.global main

main:
    ldr r0, ld_three  @ load the memory address of var1 via label adr_var1 into R0
    ldr r1, ld_four  @ load the memory address of var2 via label adr_var2 into R1
    ldr r2, [r0]      @ load the value (0x03) at memory address found in R0 to register R2 
    str r2, [r1, #2]  @ address mode: offset. Store the value found in R2 (0x03) to the memory address found in R1 plus 2. Base register (R1) unmodified. 
    str r2, [r1, #4]! @ address mode: pre-indexed. Store the value found in R2 (0x03) to the memory address found in R1 plus 4. Base register (R1) modified: R1 = R1+4 
    ldr r3, [r1], #4  @ address mode: post-indexed. Load the value at memory address found in R1 to register R3. Base register (R1) modified: R1 = R1+4 
    
fin :
    b exit

ld_three: .word three
ld_four: .word four
