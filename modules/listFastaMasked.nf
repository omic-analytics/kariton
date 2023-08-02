process listFastaMasked {
	cpus 1

	container 'ufuomababatunde/biopython:v1.2.0'

	tag "listing initial fasta files"

	publishDir (
	path: "${params.out_dir}",
	mode: "copy",
	overwrite: "true"
	)

	input:
	path list_out


	output:
	path "listFastaMasked.csv", emit:list_out


	script:
	"""
	sed 's/$params.out_dir/"maskedMixsites"/g' $list_out > listFastaMasked.csv


	"""
}