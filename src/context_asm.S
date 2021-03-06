/*
    This file is part of RIBS2.0 (Robust Infrastructure for Backend Systems).
    RIBS is an infrastructure for building great SaaS applications (but not
    limited to).

    Copyright (C) 2012 Adap.tv, Inc.

    RIBS is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, version 2.1 of the License.

    RIBS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with RIBS.  If not, see <http://www.gnu.org/licenses/>.
*/
.extern current_ctx
.globl ribs_swapcurcontext
.globl __ribs_context_exit

ribs_swapcurcontext:

#ifdef __x86_64__
        movq    current_ctx, %rsi
        /* Save the preserved registers. */
        movq    %rsp, 0(%rsi)
        movq    %rbx, 8(%rsi)
        movq    %rbp, 16(%rsi)
        movq    %r12, 24(%rsi)
        movq    %r13, 32(%rsi)
        movq    %r14, 40(%rsi)
        movq    %r15, 48(%rsi)

ribs_setcontext:
        movq    %rdi, current_ctx
        /* Load the new stack pointer and the preserved registers.  */
        movq    0(%rdi), %rsp
        movq    8(%rdi), %rbx
        movq    16(%rdi), %rbp
        movq    24(%rdi), %r12
        movq    32(%rdi), %r13
        movq    40(%rdi), %r14
        movq    48(%rdi), %r15
        ret

__ribs_context_exit:
        movq    %rbx, %rdi
        jmp     ribs_setcontext
#endif

#ifdef __i386__
        movl    current_ctx, %eax
        /* Save the preserved registers. */
        movl    %esp, 0(%eax)
        movl    %ebx, 4(%eax)
        movl    %ebp, 8(%eax)
        movl    %esi, 12(%eax)
        movl    %edi, 16(%eax)

        movl    4(%esp), %eax
ribs_setcontext:
        movl    %eax, current_ctx
        /* Load the new stack pointer and the preserved registers.  */
        movl    0(%eax), %esp
        movl    4(%eax), %ebx
        movl    8(%eax), %ebp
        movl    12(%eax), %esi
        movl    16(%eax), %edi
        ret

__ribs_context_exit:
        movl    %ebx, %eax
        jmp     ribs_setcontext
#endif

#ifdef __arm__
        ldr     r1, =current_ctx
        ldr     r2, [r1]
        stmia   r2, {r4-r14}
        str     r0, [r1]
        ldmia   r0, {r4-r14}
        mov     pc, lr

.global __ribs_context_start
__ribs_context_start:
        ldr     lr, =__ribs_context_exit
        mov     pc, r5

__ribs_context_exit:
        ldr     r1, =current_ctx
        str     r4, [r1]
        ldmia   r4, {r4-r14}
        mov     pc, lr
#endif
