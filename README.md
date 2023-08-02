<img src="https://github.com/mbl-bdmu/kariton/blob/d17d8cbdb348a7e357ba09c1df30d4a6ab9e0d69/assets/kariton_word.png" width="150">





Masking of flagged regions and lineage assignment

This pipeline masked regions with mix sites flagged by Bammix and regions with more than 4x depth in the Negative Control samples.
Nextclade is used to flag samples for private mutations and genome coverage among others. Lineage assignment is done using Usher.

### Sample command
```
nextflow run kariton \
--bammix flagged_barcodes_positions_proportions.csv \
--ref Barcode_Batch_08.csv \
--bam_dir /path/to/articNcovNanopore_sequenceAnalysisNanopolish_articMinIONNanopolish/ \
--fasta_dir /path/to/articNcovNanopore_prepRedcap_renameFasta/ \
--out_dir result
```
</br>


| Parameter | Argument |
| -------- | ------- |
| `--bammix` | output csv file of the Bammix tool |
| `--ref` | barcode file. See example in *assets* |
| `--bam_dir` | directory containing the *bam* files; must have **/** on the last |
| `--fasta_dir` | directory containing the consensus sequences; must have **/** on the last |
| `--out_dir` | output directory |
