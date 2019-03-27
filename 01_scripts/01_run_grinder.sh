#!/bin/bash
# Create one Grinder dataset

# Global variables
CONFIG_FILE="$1"
OUTPUT_FOLDER="$2"

source "$CONFIG_FILE"

NUM_SAMPLES=$[ $NUM_GROUPS * $NUM_SAMPLES_PER_GROUP ]
echo "Creating $NUM_SAMPLES samples ($NUM_GROUPS groups with $NUM_SAMPLES_PER_GROUP samples)"

# TODO Create sequence files for each sample
./01_scripts/utility_scripts/create_sequences_for_each_sample.py \
    "$FASTA_FILE" "$NUM_GROUPS" "$NUM_SAMPLES_PER_GROUP" "$OUTPUT_FOLDER"/02_simulated_samples

# TODO Run Grinder for each sample

## Run grinder
#srun -c 1 grinder -rf "$INPUT" \
#    -tr 1000 -am powerlaw 0.8 -id 70 -rd 50 -fq 1 -ql 30 20 -mo FR \
#    -dc '-' -md poly4 3e-3 3.3e-8 -mr 98.2 1.8 -hd Balzer -cp 1 -ck 0 -nl 12 \
#    -mi tags.fasta \
#    -di 30 -sp 90 -pp 90 -bn "$PROJECT" -od "$OUTPUT_FOLDER"
