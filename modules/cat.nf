process cat {
    label 'cat'
    publishDir "${params.output}/", mode: 'copy', pattern: "${name}.blast"

    input:
        set val(name), file(blast) 
    
    output:
	    set val(name), file("${name}.blast") 
    
    script:
    """
    cat *.blast > ${name}.blast
    """
}