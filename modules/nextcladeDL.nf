process nextcladeDL {
	cpus 1

	container 'nextstrain/nextclade:2.14.0'

	tag "Downloading latest SARS-CoV-2 dataset"


	publishDir (
	path: "${params.out_dir}",
	mode: "copy",
	overwrite: "true"
	)



	output:
	path "nextclade", emit: nextclade_all
    path "nextclade/reference.fasta", emit: nextclade_ref
    path "nextclade/genemap.gff", emit: nextclade_genemap


	script:
	"""
    mkdir nextclade

    nextclade dataset get \
    --name "sars-cov-2" \
    --output-dir "nextclade"

	"""
}