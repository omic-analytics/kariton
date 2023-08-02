process usherDL {
	cpus 1

	container 'pathogengenomics/usher:latest'

	tag "Downloading latest global lineages"

	publishDir (
	path: "${params.out_dir}/usherDL",
	mode: "copy",
	overwrite: "true"
	)


	output:
	path "public-latest.all.masked.pb", emit: pb



	script:
	"""
    wget -O - $params.usherGlobalLineages | \
    gunzip -c > public-latest.all.masked.pb

	"""
}