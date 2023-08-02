process listBam {
	cpus 1

	container 'ufuomababatunde/biopython:v1.2.0'

	tag "listing BAM files of negative control"

	publishDir (
	path: "${params.out_dir}",
	mode: "copy",
	overwrite: "true"
	)

	input:
	path refCSV
	path prfxBAM_txtfile


	output:
	path "listBam.csv", emit:list_out


	script:
	"""
	make_BAMlist.py \
	--in ${refCSV} \
	--out listBam.csv \
	--dir $params.bam_dir \
	--prefix ${prfxBAM_txtfile} \
	--suffix .primertrimmed.rg.sorted.bam \
	--sampleType negative
	"""
}