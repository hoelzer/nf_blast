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
