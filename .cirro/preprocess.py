#!/usr/bin/env python3

from cirro.helpers.preprocess_dataset import PreprocessDataset


def main():
    ds = PreprocessDataset.from_running()

    # Write out the list of files to process
    ds.logger.info(ds.files.to_csv(index=None))
    ds.files.to_csv("samplesheet.csv", index=None)
    ds.add_param("samplesheet", "samplesheet.csv")


if __name__ == "__main__":
    main()
