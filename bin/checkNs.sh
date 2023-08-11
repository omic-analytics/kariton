#!/bin/bash

# counts the number of Ns in the fasta file
ambigbases=$(tail -n +2 $1 | grep -o "N" | wc -l)

if [ "$ambigbases" -gt 14905 ]
then
    cp $1 failed.fasta
else
    cp $1 passed.fasta
fi