#!/usr/bin/env python

import pandas as pd
import argparse

def combine_tsv_files(filepaths):
    all_data = pd.DataFrame()
    for filepath in filepaths:
        data = pd.read_csv(filepath, delimiter='\t')
        all_data = pd.concat([all_data, data], ignore_index=True)
    return all_data

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Combine TSV files as rows based on column names.")
    parser.add_argument("files", nargs='+', help="Input TSV files to combine")
    parser.add_argument("--output", "-o", default="combined.nextclade.tsv", help="Output TSV file name")
    args = parser.parse_args()

    tsv_files = args.files
    combined_data = combine_tsv_files(tsv_files)

    # Save the combined data to the specified output TSV file
    combined_output_file = args.output
    combined_data.to_csv(combined_output_file, sep='\t', index=False)


