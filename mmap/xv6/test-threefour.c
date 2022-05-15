#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(void)
{
  printf(1, "\nTest cases for questions 3 and 4\n\n");

  int ret=fork();
  if (ret==0){
      int ret2=fork();
      if (ret2==0){
          printf(1, "\nGrandchild (Child of C1)\n");
      }
      else{
          wait();
          printf(1, "\nChild C1\n");
      }
  }
  else{
      wait();
      int ret2=fork();
      if (ret2==0){
          printf(1, "\nChild C2\n");
      }
      else{
          wait();
          printf(1, "\nParent P\n");
      }
  }

  printf(1, "getNumProc() returned %d\n\n",getNumProc());
  printf(1, "Calling showAncestry()\n----------\n");
  showAncestry();
  exit();
}
