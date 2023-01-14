#!/bin/bash
#The script is designed to iteratively optimize the structure for vasp 
#lixin, University of science & technology Beijing
#xinli@xs.ustb.edu.cn
#Copyright © 2019, lixin.fun. All rights reserved.
j=1
echo "running $j optimization."
mpirun -n $1 vasp > $2
while true
do
i=$(grep 'reached required accuracy' OUTCAR)
if [ "$i" = " reached required accuracy - stopping structural energy minimisation" ] 
then
echo "Congratulation! your calculation has been finised!"
break
else
let j=j+1
echo "running $j optimizations."
mv CONTCAR POSCAR -f
rm -rf CHG  CHGCAR  CONTCAR  DOSCAR  EIGENVAL  IBZKPT  OSZICAR  OUTCAR  PCDAT  REPORT  vasprun.xml  WAVECAR  XDATCAR
mpirun -n $1 vasp > $2
fi
done
