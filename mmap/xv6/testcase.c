#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "mmu.h"

int main(void)
{
  printf(1, "# Virtual Pages: %d\n", numvp());
  printf(1, "# Physical Pages: %d\n", numpp());

  printf(1, "Hello, world!\n");
  
  printf(1, "# Processes: %d\n", getNumProc());
  printf(1, "Calling sbrk: %d\n", sbrk(1*PGSIZE));
  printf(1, "Calling sbrk: %d\n", sbrk(1));
  printf(1, "Calling mmap: %d\n", mmap(1*PGSIZE));
  printf(1, "Calling mmap: %d\n", mmap(-1*PGSIZE));
  printf(1, "# Virtual Pages: %d\n", numvp());
  printf(1, "# Physical Pages: %d\n", numpp());
  exit();
}
