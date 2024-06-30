| PC   | inst                 |
| :--: | :--:                 |
| 0    | add     t0,zero,a0   |
| 1    | li      t1,0         |
| 2    | add     t2,zero,a1   |
| 3    | bge     t1,t2, 8     |
| 4    | sw      t1,0(t0)     |
| 5    | addi    t1,t1,1      |
| 6    | addi    t0,t0,4      |
| 7    | j       3            |
| 8    | ret
