process usherAlign {
	cpus 1

	container 'pathogengenomics/usher:latest'

	tag "Aligning sample $central_id"


	publishDir (
	path: "${params.out_dir}/usherAlignment",
	mode: "copy",
	overwrite: "true"
	)

	input:
	tuple val(central_id), path(fasta)
	path usherDB
	path usherProblemSites

	output:
	path "usherAligned*fasta"
	tuple val(central_id), path("usherAligned*vcf"), emit: vcf

	script:
	"""
	mafft --thread 20 --auto --keeplength --addfragments \
	$fasta \
	$usherDB > usherAligned.${central_id}.fasta


	faToVcf -includeNoAltN -maskSites=$usherProblemSites \
	usherAligned.${central_id}.fasta \
	usherAligned.${central_id}.vcf

	"""
}

