process primerFlaggingNEGATIVE {
	cpus 1
	container 'ufuomababatunde/biopython:v1.2.0'

	
	tag "flagging primer pairs"

	publishDir (
	path: "${params.out_dir}",
	mode: "copy",
	overwrite: "true"
	)


	input:
	path csvFile


	output:
	path "NEGATIVE.flagPrimer.bed", emit:flaggedPrimerNEGATIVE


	script:
	"""
	get_flag_primerPair.py \
	--csv $csvFile \
	--bed $params.bed \
	--out NEGATIVE.flagPrimer.bed
	"""
}