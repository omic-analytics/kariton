process usherLineage {
	cpus 1

	container 'pathogengenomics/usher:latest'

	tag "Assigning lineage on sample $central_id"

	publishDir (
	path: "${params.out_dir}/usherLineage",
	mode: "copy",
	overwrite: "true"
	)

	input:
	tuple val(central_id), path(vcf)
    path usher_pb

	output:
	path "*.usher.tsv", emit: tsv



	script:
	"""
    usher -i $usher_pb \
    -v $vcf -k 50 -K 2000 -T 1 -d $central_id

	mv ${central_id}/clades.txt ${central_id}.usher.tsv

	sed -i '1i seqName\tusherClade\tusherPango' ${central_id}.usher.tsv

	"""
}