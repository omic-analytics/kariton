#!/usr/bin/env python

import csv
import argparse
import re


# Function to extract the string after the pattern "barcode"
def extract_barcode(string):
    match = re.search(r'barcode(.+)', string, flags=re.IGNORECASE)
    if match:
        return match.group(1).strip()
    return ""



# Create an argument parser
parser = argparse.ArgumentParser(description='Extract the barcode and central ID')

# Add the list argument
parser.add_argument('--bammix', type=str, help='output csv file from bammix')
parser.add_argument('--reference', type=str, help='csv file containing ONT barcodes and central IDs')
parser.add_argument('--out', type=str, help='Output CSV file')

# Parse the command-line arguments
args = parser.parse_args()



input_file = args.bammix
reference_file = args.reference
output_file = args.out



# Open the reference CSV file and create a dictionary of ont_barcode -> row
reference_data = {}
with open(reference_file, "r") as reference:
    reader = csv.DictReader(reference)
    for row in reader:
        ont_barcode = row.get("ont_barcode", "")

        reference_data[ont_barcode] = row




# Open the input CSV file for reading
with open(input_file, "r") as file:
    reader = csv.DictReader(file)
    headers = reader.fieldnames + ["ont_barcode", "central_id"]

    # Open the output CSV file for writing
    with open(output_file, "w", newline="") as output:
        writer = csv.DictWriter(output, fieldnames=headers, delimiter='\t')
        writer.writeheader()

        # Process each row in the input file
        for row in reader:
            barcode_column = row.get("barcode", "")
            # For barcodes < 10, it is treated as string, i.e., 02, 01, 05
            # Change to integer first to remove the 0 before the number
            # i.e., 02 -> 2; 05 -> 5
            # Then change back to string since the dictionary uses string 
            extracted_barcode = str(int(extract_barcode(barcode_column)))

            # Lookup central_id in the reference data
            central_id_row = reference_data.get(extracted_barcode, {})
            central_id = central_id_row.get("central_id", "")

            # Create a new row with the ont_barcode and central_id
            new_row = {**row, "ont_barcode": extracted_barcode, "central_id": central_id}
            writer.writerow(new_row)
