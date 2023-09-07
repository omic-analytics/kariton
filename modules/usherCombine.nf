process usherCombine {
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
	path "combined.usher.tsv", emit:usher


	script:
	"""
	combine_tsv.py \
    $tsvFile \
    --output combined.usher.tsv

	"""
}