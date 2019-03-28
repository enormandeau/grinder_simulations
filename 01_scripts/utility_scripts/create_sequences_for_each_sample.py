#!/usr/bin/env python3
"""Create hierarchichaly similar groups samples in terms of
sequence composition and abundancy

Usage:
    <program>
        input_sequences
        num_groups
        num_sequences_per_group
        num_sample_per_group
        num_sequences_per_sample
        num_permutations
        output_directory
"""

# Modules
from os import path
import random
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
    """Transparently open normal and gz compressed files
    """
    if _file.endswith(".gz"):
        return gzip.open(_file, mode=mode)

    else:
        return open(_file, mode=mode)

def swap_random(seq):
    """Swap two random elements of a list
    """
    indexes = range(len(seq))
    i1, i2 = random.sample(indexes, 2)
    seq[i1], seq[i2] = seq[i2], seq[i1]

def swap_random_neighbors(seq):
    """Swap two random neighbor elements of a list
    """
    indexes = range(len(seq) - 1)
    i1 = random.sample(indexes, 1)[0]
    i2 = i1 + 1
    seq[i1], seq[i2] = seq[i2], seq[i1]

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
    num_sequences_per_group = int(sys.argv[3])
    num_sample_per_group = int(sys.argv[4])
    num_sequences_per_sample = int(sys.argv[5])
    num_permutations = int(sys.argv[6])
    output_directory = sys.argv[7]
except:
    print(__doc__)
    sys.exit(1)

# Load fasta sequences in list of Fasta objects
original_sequences = list(fasta_iterator(input_sequences))

# Annotate sequences with ordered integers to reorder later
original_sequences = list(zip(
    range(len(original_sequences)), original_sequences))

# Create groups of similar samples
for group in range(1, num_groups+1):

    # Pick N random sequences
    group_number = f"{group:02d}"
    group_sequences = sorted(
            random.sample(original_sequences, num_sequences_per_group))

    # Groups are more dissimilar
    # Do num_permutations random permutations and correct annotations
    for _ in range(num_permutations):
        swap_random(group_sequences)

    group_sequences = list(zip(
        range(len(group_sequences)),
        [s[1] for s in group_sequences]))

    # Create samples
    for sample in range(1, num_sample_per_group+1):
        sample_number = f"{sample:02d}"

        # Pick n random sequences from the group ones
        sample_sequences = sorted(
                random.sample(group_sequences, num_sequences_per_sample))

        # Samples within groups are more similar
        # Do num_permutations neighbor permutations
        for _ in range(num_permutations):
            swap_random_neighbors(sample_sequences)

        # write to file
        file_path = path.join(output_directory,
                f"group_{group_number}_sample_{sample_number}.fasta")

        with open(file_path, "wt") as outfile:
            for s in sample_sequences:

                # De annotate sequence and write
                s[1].write_to_file(outfile)
