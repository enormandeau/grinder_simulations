#!/bin/bash
# Create one Grinder dataset

# Modules
module load grinder

# Global variables
INPUT="$1"
PROJECT="$2"
OUTPUT_FOLDER="03_outputs/""$PROJECT"

# Run grinder
srun -c 1 grinder -rf "$INPUT" \
    -tr 1000 -am powerlaw 0.8 -id 70 -rd 50 -fq 1 -ql 30 20 -mo FR \
    -dc '-' -md poly4 3e-3 3.3e-8 -mr 98.2 1.8 -hd Balzer -cp 1 -ck 0 -nl 12 \
    -mi tags.fasta \
    -di 30 -sp 90 -pp 90 -bn "$PROJECT" -od "$OUTPUT_FOLDER"
