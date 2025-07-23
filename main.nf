#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

process htseq_count {
    publishDir "${params.out_dir}", mode: 'copy', overwrite: true
    input:
    tuple val(sample), path(bam), val(strand)
    path gtf

    output:
    tuple val(sample), path("${sample}.${strand}.txt")

    script:
    """
    htseq-count \
        -f bam \
        -r name \
        -s ${strand} \
        -i gene_id \
        ${bam} \
        ${gtf} > ${sample}.${strand}.txt
    """

}

workflow {
    // Get the BAM files provided by the user
    Channel
        .fromPath(params.samplesheet, checkIfExists: true)
        .splitCsv(header: true, sep: ',')
        .map {
            it -> [
                it.sample,
                file(it.file, checkIfExists: true)
            ]
        }
        .combine(['yes', 'no', 'reverse'])
        .set { bams }

    // Get the GTF file provided by the user
    gtf = file(params.gtf, checkIfExists: true)

    htseq_count(bams, gtf)
}