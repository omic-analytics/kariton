process flaggedMixsite {
	cpus 1

	container 'ufuomababatunde/biopython:v1.2.0'

	tag "Extracting from sample $central_id"


	publishDir (
	path: "${params.out_dir}/positionsFlaggedBAMMIX",
	mode: "copy",
	overwrite: "true"
	)


	input:
	tuple val(central_id), val(positions)


	output:
	tuple val(central_id), path("position_bammix_*.csv"), emit: bammix_extract


	script:
	"""
	extract_bammix.py \
	--list "$positions" \
	--out position_bammix_${central_id}.csv
	"""

}