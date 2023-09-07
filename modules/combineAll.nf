process combineAll {
	cpus 1

	container 'ufuomababatunde/biopython:v1.2.0'

	tag "Extracting from flagged samples"


	publishDir (
	path: "${params.out_dir}/combined",
	mode: "copy",
	overwrite: "true"
	)


	input:
	path nextclade
	path usher
	

	output:
	path "combinedNextUsher.tsv", emit: all


	script:
	"""
	combine_nextusher.py \
	--nextclade $nextclade \
	--usher $usher \
    --output combinedNextUsher.raw.tsv


    { head -n 1 combinedNextUsher.raw.tsv | tr '.' '_'; tail -n +2 combinedNextUsher.raw.tsv; } > combinedNextUsher.tsv


	"""
}
