#!/usr/bin/env python3
"""Prepare Barque input from grinder_simulations output

Usage:
    <program> input_folder output_folder tag_length
"""

# Modules
import gzip
import sys
import os

# Classes
class Fastq(object):
    """Fastq object with name, sequence, name2, and quality string
    """

    def __init__(self, name, sequence, name2, quality):
        self.name = name
        self.sequence = sequence
        self.name2 = name2
        self.quality = quality

    def write_to_file(self, handle):
        handle.write(self.name + "\n")
        handle.write(self.sequence + "\n")
        handle.write(self.name2 + "\n")
        handle.write(self.quality + "\n")

    def __repr__(self):
        return self.name + " " + self.sequence[:31]

# Defining functions
def myopen(_file, mode="rt"):
    if _file.endswith(".gz"):
        return gzip.open(_file, mode=mode)

    else:
        return open(_file, mode=mode)

def fastq_iterator(infile):
    """Takes a fastq file infile and returns a fastq object iterator

    Requires fastq file with four lines per sequence and no blank lines.
    """
    
    with myopen(infile) as f:
        while True:
            name = f.readline().strip()

            if not name:
                break

            seq = f.readline().strip()
            name2 = f.readline().strip()
            qual = f.readline().strip()
            yield Fastq(name, seq, name2, qual)

# Parsing user input
try:
    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    tag_length = int(sys.argv[3])
except:
    print(__doc__)
    sys.exit(1)

# Find files to treat
print("Preparing input files for Obitools")
samples = sorted([x for x in os.listdir(input_folder) if x.endswith("-reads.fastq.gz")])

# Write output
for sample_file in samples:

    # Create read iterator
    sample_path = os.path.join(input_folder, sample_file)
    sequences = fastq_iterator(sample_path)

    # Open R1 and R2 file handles
    file_forward = myopen(
            os.path.join(
                output_folder,
                sample_file.replace("-reads.fastq.gz", "_R1_001.fastq.gz")),
            mode="wt")

    file_reverse = myopen(
            os.path.join(
                output_folder,
                sample_file.replace("-reads.fastq.gz", "_R2_001.fastq.gz")),
            mode="wt")


    # Iterate over sequences and write in forward and reverse files
    for seq in sequences:
        # Remove tag from sequence
        seq.sequence = seq.sequence[tag_length: ]
        seq.quality = seq.quality[tag_length: ]

        output_path = file_forward if seq.name.strip().split(" ")[0].split("/")[1] == "1" else file_reverse
        seq.write_to_file(output_path)

    # Close R1 and R2 file handles
    file_forward.close()
    file_reverse.close()
