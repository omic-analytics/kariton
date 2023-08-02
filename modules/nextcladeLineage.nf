process nextcladeLineage {
	cpus 1

	container 'nextstrain/nextclade:2.14.0'

	tag "Assigning lineage on sample $central_id"


	publishDir (
	path: "${params.out_dir}/nextcladeLineage",
	mode: "copy",
	overwrite: "true"
	)

	input:
	tuple val(central_id), path(fasta)
	path nextclade

	output:
	tuple val(central_id), path("nextclade*tsv"), emit: nextclade_TSV
    tuple val(central_id), path("nextcladetree*.json"), emit: nextclade_JSON


	script:
	"""
	nextclade run \
	--input-dataset $nextclade \
	--output-tsv nextclade.${central_id}.tsv \
	--output-tree "nextcladetree.${central_id}.json" \
	$fasta

	"""
}