/*
Obsolete: Due to the collectFiles(storeDir: params.outdir) function this is not needed as a separate process. 
*/
process publish {
    label 'publish'
    publishDir "${params.output}/${params.blastdir}", mode: 'copy', pattern: "${blast.baseName}.blast"

    input:
        file blast

    output:
	    file "${blast.baseName}.blast" 
    
    script:
    """
    """
}