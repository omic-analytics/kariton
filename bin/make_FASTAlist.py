#!/usr/bin/env python

import csv
import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--in', dest='input_filename', help='Input CSV filename')
parser.add_argument('--out', dest='output_filename', help='Output CSV filename')
parser.add_argument('--dir', dest='directory', help='directory')
parser.add_argument('--prefix', dest='prfx', help='filename of the prefix text file')
parser.add_argument('--suffix', dest='sfx', help='suffix of the fasta file')
parser.add_argument('--sampleType', dest='typ', help='positive/negative')

args = parser.parse_args()

input_filename = args.input_filename
output_filename = args.output_filename
string_to_concatenate = args.directory
prefix_filename = args.prfx
suffix = args.sfx
samp_type = args.typ

 

# Open the prefix file and save the first line in prefix
with open(prefix_filename, 'r') as prefix_file:
    prefix = prefix_file.readline().strip()

with open(input_filename, 'r') as input_file:
    reader = csv.DictReader(input_file)
    fieldnames = ['central_id', 'type']  # Add 'type' to the fieldnames
    data = [{field: row[field] for field in fieldnames} for row in reader if row['type'] == samp_type]

for row in data:
    #row['path'] = string_to_concatenate + '/' + prefix + row['central_id'] + suffix
    row['path'] = string_to_concatenate + prefix + row['central_id'] + suffix

with open(output_filename, 'w', newline='') as output_file:
    fieldnames = ['central_id', 'type', 'path']  # Include 'type' in the fieldnames
    writer = csv.DictWriter(output_file, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(data)
