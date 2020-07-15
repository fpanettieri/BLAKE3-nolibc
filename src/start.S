.intel_syntax noprefix

.global _syscall
_syscall:
  mov r10, rcx    # user -> kernel
  syscall         # exec
  ret             # return

#define sys(x, n) .global x; x:; mov rax, n; jmp _syscall
sys(read, 0)      # __NR_read
sys(write, 1)     # __NR_write
sys(exit, 60)     # __NR_exit

.global _start
_start:
  xor   rbp, rbp  # mark deepest stack frame
  pop   rdi       # argc
  mov   rsi, rsp  # argv
  call  main
  mov   rdi, rax  # copy return value
  mov   rax, 60   # __NR_exit
  syscall
