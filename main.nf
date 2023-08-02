// Main workflow for masking

// enable dsl2
nextflow.enable.dsl=2


// import subworkflows
include {melonmask} from './workflows/melonmask.nf'
include {AntArtic} from './workflows/AntArtic.nf'





workflow {

	Channel
		.fromPath(params.bammix)
		.set{ch_bammix}

	Channel
		.fromPath(params.ref)
		.set{ch_ref}



	main:
		melonmask(ch_bammix, ch_ref)
		AntArtic(melonmask.out.melon)

}


