#!/bin/bash

echo -e "Resolution of plot? "
read n

# Feed res to fortran main

#if [[ $ques -eq 1 ]]
#then
#    gfortran q1.f90 -o q1
#    ./q1
#elif [[ $ques -eq 4 ]]
#then
#    gfortran q4.f90 -o q4
#    ./q4
#else
#    echo "Invalid question number"
#fi

rm main *.dat *.mod

gfortran vector.f90 main.f90 -o main
./main $n

# eval "$(conda shell.bash hook)"
# conda activate usual
python3 plot.py
# conda deactivate