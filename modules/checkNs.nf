process checkNs {
	
    tag "masking flagged positions in $central_id"

	publishDir (
	path: "${params.out_dir}/checkedNs",
	mode: "copy",
	overwrite: "true"
	)

	input:
	tuple val(central_id), path(fasta)


	output:
	tuple val(central_id), path("passed/*.maskedMixNegative.fasta"), optional: true, emit: fin
	tuple val(central_id), path("failed/*.maskedMixNegative.fasta"), optional: true
	
	script:
	"""
	#This is to check if the number of ambiguous bases is greater than half of the 29811 bp genome (i.e., 14905)
	mkdir -p failed passed
	checkNs.sh $fasta

	if [ -e "passed.fasta" ]
	then
    	cp $fasta passed/$fasta
	elif [ -e "failed.fasta" ]
	then
		cp $fasta failed/$fasta
	else
		echo "Error, bro"
	fi


	"""
}
