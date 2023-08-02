#!/bin/bash
#remove the last backslash if found on the last name of the directory
dir_corrected=$(echo $1 | sed 's/\/$//')

PRFX=$(ls $dir_corrected/*fasta | head -n 1 | awk -F '/' '{print $NF}' | awk -F '-' '{print $1"-"$2"-"}')

printf $PRFX > prefixFASTA.txt
