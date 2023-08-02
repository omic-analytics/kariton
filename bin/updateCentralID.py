#!/usr/bin/env python

import csv
import argparse

def update_csv1(csv1_file, csv2_file):
    # Read csv1 and store "ont_barcode" values in a set for quick lookup
    csv1_ont_barcodes = set()
    with open(csv1_file, 'r', newline='') as file:
        csv_reader = csv.DictReader(file, delimiter='\t')
        for row in csv_reader:
            if 'ont_barcode' in row:
                csv1_ont_barcodes.add(row['ont_barcode'])

    # Read csv2 and update csv1 if "ont_barcode" is missing
    updated_rows = 0
    with open(csv2_file, 'r', newline='') as file:
        csv_reader = csv.DictReader(file)
        rows = list(csv_reader)  # Store all rows of csv2 in memory

        with open(csv1_file, 'a', newline='') as csvfile:
            fieldnames = ['barcode', 'positions', 'base_prop', 'ont_barcode', 'central_id']
            csv_writer = csv.DictWriter(csvfile, fieldnames=fieldnames, delimiter='\t')

            for row in rows:
                if 'ont_barcode' in row and row['ont_barcode'] not in csv1_ont_barcodes:
                    # Copy over "ont_barcode" and "central_id" from csv2 to csv1
                    csv_writer.writerow({
                        'barcode': 'NA',
                        'positions': '[]',
                        'base_prop': '[]',
                        'ont_barcode': row['ont_barcode'],
                        'central_id': row['central_id']
                    })
                    updated_rows += 1

    return updated_rows

# Parse command-line arguments
parser = argparse.ArgumentParser(description='Update CSV1 with missing ont_barcode values from CSV2')
parser.add_argument('--processed', metavar='csv1', help='Path to CSV1 file')
parser.add_argument('--barcode', metavar='csv2', help='Path to CSV2 file')
args = parser.parse_args()

# Validate arguments
if not args.processed or not args.barcode:
    parser.error('Both --processed and --barcode arguments are required.')

updated_rows_count = update_csv1(args.processed, args.barcode)
print(f"Updated {updated_rows_count} rows in csv1.")

