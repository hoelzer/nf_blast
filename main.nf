#!/usr/bin/env nextflow
nextflow.preview.dsl=2

// Author: hoelzer.martin@gmail.com

// terminal prints
println " "
println "\u001B[32mProfile: $workflow.profile\033[0m"
println " "
println "\033[2mCurrent User: $workflow.userName"
println "Nextflow-version: $nextflow.version"
println "Starting time: $nextflow.timestamp"
println "Workdir location:"
println "  $workflow.workDir\u001B[0m"
println " "
if (params.help) { exit 0, helpMSG() }
if (params.fasta == '') {exit 1, "input missing, use [--fasta]"}
if (params.db == '') {exit 1, "db in fasta format missing, use [--db]"}

input_ch = Channel
.fromPath(params.fasta, checkIfExists: true)
.map { file -> tuple(file.baseName, file) }
.view()

if (params.chunks.toInteger() > 0) {
    input_ch = input_ch.splitFasta(by: params.chunks, file: true).view()
}
//.splitFastq 
//.transpose

//input_ch = input_ch.groupTuple().view()
//thus I would only start two processes in the case of two inital fasta files, but split into chunks and order to their ID

db = file(params.db)

include 'modules/blast' params(output: params.output)
include 'modules/publish' params(output: params.output, blastdir: params.blastdir)

blast(input_ch, db)
blast.out.collectFile(storeDir: "${params.output}/${params.blastdir}")


/*************  
* --help
*************/
def helpMSG() {
    c_green = "\033[0;32m";
    c_reset = "\033[0m";
    c_yellow = "\033[0;33m";
    c_blue = "\033[0;34m";
    c_dim = "\033[2m";
    log.info """
    ____________________________________________________________________________________________
    
    Simple Blast test
    
    ${c_yellow}Usage example:${c_reset}
    nextflow run main.nf --fasta *.fasta --db db.fasta 

    ${c_yellow}Input:${c_reset}
    ${c_green} --fasta ${c_reset}               '*.fasta' or foo.fasta
    ${c_green} --db ${c_reset}                  db.fasta

    ${c_yellow}Options:${c_reset}
    --cores             max cores for local use [default: $params.cores]
    --memory            max memory for local use [default: $params.memory]
    --chunks            split input fasta file(s) in chunks of this size [default: $params.chunks]
    --output            name of the result folder [default: $params.output]

    ${c_dim}Nextflow options:
    -with-report rep.html    cpu / ram usage (may cause errors)
    -with-dag chart.html     generates a flowchart for the process tree
    -with-timeline time.html timeline (may cause errors)

    Profile:
    -profile                 standard, googlegenomics [default: standard] ${c_reset}
    """.stripIndent()
}