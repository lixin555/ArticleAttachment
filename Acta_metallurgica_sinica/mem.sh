#!/bin/bash
#The script is designed to release memory for vasp 
#lixin, University of science & technology Beijing
#xinli@xs.ustb.edu.cn
#Copyright © 2019, lixin.fun. All rights reserved.
while true
do
i=$(grep 'reached required accuracy' OUTCAR)
if [ "$i" = " reached required accuracy - stopping structural energy minimisation" ]
then
echo "Calculation has been finished!"
break
else
mem=$(awk '/MemTotal/{total=$2}/MemFree/{free=$2}/Buffers/{buffers=$2}/^Cached/{cached=$2}END{print (total-free-buffers-cached)/1024/1024}'  /proc/meminfo | cut -f1 -d".")
if [ "$mem" -gt "$1" ]
then
process_id=($(ps -ef | grep vasp | grep -v "grep" | awk '{print $2}'))
if [[ ! -z "$process_id" ]]
then
for proid in ${process_id[*]}
do
kill -9 $proid
done
sleep 10s
fi
fi
fi
sleep 2s
done
