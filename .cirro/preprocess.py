#!/usr/bin/env python3

from cirro.helpers.preprocess_dataset import PreprocessDataset


def main():
    ds = PreprocessDataset.from_running()

    # Only use the files from the list which are BAM files
    samplesheet = ds.files[ds.files["file"].str.endswith(".bam")].copy()

    # Write out the list of files to process
    ds.logger.info(samplesheet)
    samplesheet.to_csv("samplesheet.csv", index=None)
    ds.add_param("samplesheet", "samplesheet.csv")


if __name__ == "__main__":
    main()
