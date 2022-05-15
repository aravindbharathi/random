#include "syscall.h"
#include "traps.h"

#define SYSCALL(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(fstat)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
//-------------
// Source code files - these interface user program to invoke system call
// Basically, grants permissions to specific user functions to invoke system calls
// PA1
SYSCALL(hello)
SYSCALL(helloYou)
SYSCALL(getNumProc)
SYSCALL(showAncestry)
//PA2
SYSCALL(numvp)
SYSCALL(numpp)
SYSCALL(mmap)