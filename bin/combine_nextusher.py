#!/usr/bin/env python

import argparse
import pandas as pd

def combine_tsv_files(file1_path, file2_path, output_path):
    # Read the TSV files into pandas DataFrames
    df1 = pd.read_csv(file1_path, sep='\t')
    df2 = pd.read_csv(file2_path, sep='\t')

    # Merge the DataFrames based on the 'seqName' column
    merged_df = pd.merge(df1, df2, on='seqName', how='inner')

    # Write the merged DataFrame to a new TSV file
    merged_df.to_csv(output_path, sep='\t', index=False)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Combine two TSV files based on 'seqName' column.")
    parser.add_argument("--nextclade", help="Path to the nextclade output TSV file")
    parser.add_argument("--usher", help="Path to the usher output TSV file")
    parser.add_argument("--output", help="Path to the final combined output TSV file")

    args = parser.parse_args()

    if args.nextclade and args.usher:
        combine_tsv_files(args.nextclade, args.usher, args.output)
    else:
        print("Error: Both --nextclade and --usher options are required.")

