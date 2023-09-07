process listFasta {
	cpus 1

	container 'ufuomababatunde/biopython:v1.2.0'

	tag "listing initial fasta files"

	publishDir (
	path: "${params.out_dir}/misc",
	mode: "copy",
	overwrite: "true"
	)

	input:
	path refCSV
	path prfxFASTA_txtfile


	output:
	path "listFasta.csv", emit:list_out


	script:
	"""
	make_FASTAlist.py \
	--in ${refCSV} \
	--out listFasta.csv \
	--dir $params.fasta_dir \
	--prefix ${prfxFASTA_txtfile} \
	--suffix .fasta \
	--sampleType positive
	"""
}