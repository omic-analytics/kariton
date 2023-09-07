process maskNegative {
	container 'ufuomababatunde/biopython:v1.2.0'
	
    tag "masking flagged positions in $central_id"

	publishDir (
	path: "${params.out_dir}/maskedMixNegative",
	mode: "copy",
	overwrite: "true"
	)

	input:
	tuple val(central_id), path(fasta)
	each file(flaggedPrimer)


	output:
	tuple val(central_id), path("*.maskedMixNegative.fasta"), emit: maskedNeg
	
	script:
	"""
	sed -i 's/MN908947.3/${params.prefix_fasta}${central_id}/g' $flaggedPrimer

	if [ -s "./$flaggedPrimer" ]; then
		fa-mask.py --regions $flaggedPrimer --fasta $fasta --out $params.prefix_fasta${central_id}.maskedMixNegative.fasta
	else
		cat $fasta > $params.prefix_fasta${central_id}.maskedMixNegative.fasta
	fi



	"""
}
