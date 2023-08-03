process nextcladeCombine {
	cpus 1
	container 'ufuomababatunde/biopython:v1.2.0'

	
	tag "Combining results"

	publishDir (
	path: "${params.out_dir}/combined",
	mode: "copy",
	overwrite: "true"
	)


	input:
	path tsvFile


	output:
	path "combined.nextclade.tsv", emit:nextclade


	script:
	"""
	combine_tsv.py \
    $tsvFile \
    --output combined.nextclade.tsv

	"""
}