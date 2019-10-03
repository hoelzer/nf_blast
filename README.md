# A simple nextflow that performs blastn with Docker support

## Usage

````
nextflow run main.nf --help
````

````
nextflow run main.nf --fasta 'data/*.fa' --db data/db.fasta --cores 4 --outdir results
````

To disable the docker support change 

````
docker { enabled = false }
````

In the nextflow.config file. 
