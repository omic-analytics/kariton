#!/usr/bin/env python3

import os
import argparse

# Create the command-line argument parser
parser = argparse.ArgumentParser(description='Extract positions with >4x depth from bam files.')
parser.add_argument('--bam', help='Path to the bam file', required=True)
parser.add_argument('--out', help='Path to the output file', required=True)


# Parse the command-line arguments
args = parser.parse_args()



# Check BAM file for reads more than 4 by using samtools depth and generate a csv of the regions with more than 4 depth
os.system(f"samtools depth {args.bam} | awk '$3 > 4' | awk '{{print $2}}' > {args.out}")


# Convert into integer and write only the unique integers
with open(args.out, "r") as file:
    content = file.read()
    # Convert content to unique integers
    integer_values = list(set(map(int, content.strip().split())))
    
with open(args.out, "w") as file:
	# Write unique integers to the file
    file.write("\n".join(map(str, integer_values)))
    # Add a new line at the end
    file.write("\n")
