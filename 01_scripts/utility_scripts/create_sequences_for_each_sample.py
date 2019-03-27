#!/usr/bin/env python3
"""Create random but hierarchichaly similar groups of sequences ordered by abundancy

Usage:
    <program> input_sequences num_groups num_sample_per_group output_directory
"""

# Modules
import sys

# Classes
class Fasta(object):
    """Fasta object with name and sequence
    """

    def __init__(self, name, sequence):
        self.name = name
        self.sequence = sequence

    def write_to_file(self, handle):
        handle.write(">" + self.name + "\n")
        handle.write(self.sequence + "\n")

    def __repr__(self):
        return self.name + " " + self.sequence[:31]

# Functions
def myopen(_file, mode="r"):
    if _file.endswith(".gz"):
        return gzip.open(_file, mode=mode)

    else:
        return open(_file, mode=mode)

def fasta_iterator(input_file):
    """Takes a fasta file input_file and returns a fasta iterator
    """
    with myopen(input_file) as f:
        sequence = ""
        name = ""
        begun = False

        for line in f:
            line = line.strip()

            if line.startswith(">"):
                if begun:
                    yield Fasta(name, sequence)

                name = line[1:]
                sequence = ""
                begun = True

            else:
                sequence += line

        if name != "":
            yield Fasta(name, sequence)

# Parsing user input
try:
    input_sequences = sys.argv[1]
    num_groups = int(sys.argv[2])
    num_sample_per_group = int(sys.argv[3])
    output_directory = sys.argv[4]
except:
    print(__doc__)
    sys.exit(1)

# Load fasta sequences in list of Fasta objects
original_sequences = list(fasta_iterator(input_sequences))
print(original_sequences)

for group in range(num_groups):
    # TODO pick N random sequences
    group_sequences = original_sequences[:40]

    for sample in range(num_sample_per_group):
        # TODO pick n random sequences from the group ones
        sample_sequences = group_sequences[:30]

        # TODO do p permutations
        # TODO write to file
