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