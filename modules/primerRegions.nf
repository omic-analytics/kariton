process primerFlagging {
	cpus 1
	container 'ufuomababatunde/biopython:v1.2.0'

	
	tag "Working on sample $central_id"

	publishDir (
	path: "${params.out_dir}/primersFlaggedBAMMIX",
	mode: "copy",
	overwrite: "true"
	)


	input:
	tuple val(central_id), path(csvFile)


	output:
	tuple val(central_id), path("*flagPrimer.bed"), emit:flaggedPrimer


	script:
	"""
	get_flag_primerPair.py \
	--csv $csvFile \
	--bed $params.bed \
	--out ${central_id}.flagPrimer.bed
	"""
}