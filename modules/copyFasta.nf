process copyFasta {
	cpus 1

	tag "Copying initial fasta of sample $central_id"


	publishDir (
	path: "${params.out_dir}/maskedMixsites",
	mode: "copy",
	overwrite: "true"
	)

    errorStrategy 'ignore'

	input:
	tuple val(central_id), path(fasta)


	output:
	tuple val(central_id), path("*maskedMix.fasta"), emit: prepared_fasta


	script:
	"""
    cp $fasta $params.prefix_fasta${central_id}.maskedMix.fasta
	"""

}