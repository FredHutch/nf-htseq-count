# nf-htseq-count

Goal: Run htseq-count on a set of input BAMs

Implementation: Nextflow workflow

Inputs:

- One or more BAM files
- A single GTF

Parameters:

- `samplesheet`: CSV with columns `sample` and `file`, with each being an aligned BAM
- `gtf`: A single GTF file
- `out_dir`: Output directory

Dependencies:

The BioContainers Docker container is being used for htseq-count