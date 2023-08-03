process barcodeTocentralID {
	cpus 1

	container 'ufuomababatunde/biopython:v1.2.0'

	tag "Extracting from flagged samples"


	publishDir (
	path: "${params.out_dir}/misc",
	mode: "copy",
	overwrite: "true"
	)


	input:
	path bammixCSV
	path refCSV
	

	output:
	path "barcodeCentralID.tsv", emit: barcodeCentralID
	path "prefixBAM.txt", emit:prefixBAM
	path "prefixFASTA.txt", emit:prefixFASTA


	script:
	"""
	getPrefixBAM.sh $params.bam_dir
	getPrefixFASTA.sh $params.fasta_dir

	extract_barcode.py \
	--bammix ${bammixCSV} \
	--reference ${refCSV} \
	--out barcodeCentralID.tsv

	updateCentralID.py \
	--processed barcodeCentralID.tsv \
	--barcode ${refCSV}

	"""
}
