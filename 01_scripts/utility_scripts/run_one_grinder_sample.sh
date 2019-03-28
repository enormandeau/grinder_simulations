#!/bin/bash
# Create one sample with Grinder

# Input parameters
CONFIG_FILE="$1"
INPUT_SEQUENCES="$2"
TAG_SEQUENCE="${INPUT_SEQUENCES%.fasta}.tag"
OUTPUT_FOLDER="$3"
SAMPLE_NAME="$4"

# Source config file
source "$CONFIG_FILE"

# Loading modules
# TODO remove this part
module load grinder

# Running one instance of Grinder on SLURM
# TODO Bug with tags... need to create tag fasta file for each sample...
# TODO remove srun
srun -c 1 --mem 1G \
    grinder -rf "$INPUT_SEQUENCES" \
    -tr "$NUM_SEQUENCES" -am powerlaw "$POWERLAW_EXPONENT" \
    -id "$INSERT_DIST" -rd "$READ_LENGTHS" -fq 1 -ql 30 20 -mo FR \
    -dc '-' -md poly4 3e-3 3.3e-8 -mr "$MUTATION_RATIO" \
    -hd Balzer -cp "$CHIMERA_PERCENT" -ck 0 -mi "$TAG_SEQUENCE" \
    -bn "$SAMPLE_NAME" -od "$OUTPUT_FOLDER"

# Compress output file
gzip "$OUTPUT_FOLDER"/"$SAMPLE_NAME"-reads.fastq
