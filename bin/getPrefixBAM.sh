#!/bin/bash
#remove the last backslash if found on the last name of the directory
dir_corrected=$(echo $1 | sed 's/\/$//')

PRFX=$(ls $dir_corrected | head -n 1 | sed 's/barcode.*//')

printf $PRFX > prefixBAM.txt
