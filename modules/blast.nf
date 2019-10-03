process blast {
    conda 'envs/blast.yaml'
    //conda 'bioconda::blast=2.6.0'
    //label 'blast'
    //publishDir "${params.output}/", mode: 'copy', pattern: "${fasta.baseName}.blast"

    //container = 'nanozoo/blast:2.9.0--cbbc56f'

    input:
        set val(name), file(fasta) 
        file db
    
    output:
	    set val("${name}.blast"), file("${fasta.baseName}.blast") 
    
    script:
    """
    makeblastdb -in ${db} -dbtype nucl
    blastn -task blastn -num_threads 6 -query ${fasta} -db ${db} -evalue 1e-10 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend qlen sstart send evalue bitscore slen" > ${fasta.baseName}.blast
    """
}

/* Comments:
I removed the -parse_seqids parameter from the makeblastdb command because of an error with fasta IDs that are longer than 50 chars. strange.
*/