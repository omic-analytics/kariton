#!/usr/bin/env python

import pandas as pd
import argparse


parser = argparse.ArgumentParser(description='Flagging primer pairs')
parser.add_argument("--csv", required=True, type=str, help="csv file")
parser.add_argument("--bed", required=True, type=str, help="bed file")
parser.add_argument("--out", required=True, type=str, help="output bed file")


args = parser.parse_args()


file_csv = args.csv
file_bed = args.bed
file_out = args.out

# Read the flagged barcodes positions proportions file into a DataFrame
flag = pd.read_csv(file_csv, header=None, names=['flagged'])
print(flag)
# Read the primers file into a DataFrame
primers = pd.read_csv(file_bed, sep="\t", header=None)

# Sort the primers DataFrame by the second column
primers_sorted = primers.sort_values(by=1)

# Create an empty DataFrame to store the primer pairs
primerPairs = pd.DataFrame()

# Iterate through each position in the sorted list
for index, row in flag.iterrows():
	i = row['flagged']
	print(i)
	# Select the primers that flank the current position
	c = primers[(primers[1] < i) & (primers[2] > i)]
	print(c)

 	# Add the primer pairs to the DataFrame
	# primerPairs = primerPairs.append(c)
	primerPairs = pd.concat([primerPairs, c], ignore_index=True)
	print(primerPairs)
# Remove duplicate primer pairs
primerPairs_uniq = primerPairs.drop_duplicates()

# Write the primer pairs to a file
primerPairs_uniq.to_csv(file_out, sep="\t", header=False, index=False)


