process blast {
    label 'blast'
    echo true
    //publishDir "${params.output}/", mode: 'copy', pattern: "${fasta.baseName}.blast"

    input:
        set val(name), file(fasta) 
        file db
    
    output:
	    set val(name), file("${name}.blast") 
    
    script:
    """
    ls -la
    makeblastdb -in ${db} -dbtype nucl
    blastn -task blastn -num_threads 4 -query ${fasta} -db ${db} -evalue 1e-10 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend qlen sstart send evalue bitscore slen" > ${name}.blast
    """
}

/* Comments:
I removed the -parse_seqids parameter from the makeblastdb command because of an error with fasta IDs that are longer than 50 chars. strange.
*/