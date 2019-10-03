# A simple nextflow that performs blastn with Docker support

## Usage

````
nextflow run main.nf --help
````

````
nextflow run main.nf --fasta 'data/*.fa' --db data/db.fasta --cores 4 --outdir results -profile conda
````

You can switch between execution using docker containers and conda environments via 

````
-profile [docker|conda]
````

Use the ``--chunk n`` parameter to automatically split a Fasta file into multiple Fasta files each containing ``n`` 
sequences. The chunked Fasta files will processed separately and, if possible, in parallel. The final output will be merged and is the same like no chunk parameter was used. 