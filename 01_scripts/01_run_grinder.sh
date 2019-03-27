#!/bin/bash
# Create one Grinder dataset

# Global variables
CONFIG_FILE="$1"
TIMESTAMP="$2"

source "$CONFIG_FILE"

# Create output directory
OUTPUT_FOLDER="04_outputs/""$TIMESTAMP"_"$SIMULATION_NAME"
mkdir "$OUTPUT_FOLDER"

NUM_SAMPLES=$[ $NUM_GROUPS * $NUM_SAMPLES_PER_GROUP ]
echo "Need to create $NUM_SAMPLES samples"

seq -w "$NUM_SAMPLES" |
    parallel -j "$NUM_CPUS" touch "$OUTPUT_FOLDER"/sample_{}

exit

# Run grinder
srun -c 1 grinder -rf "$INPUT" \
    -tr 1000 -am powerlaw 0.8 -id 70 -rd 50 -fq 1 -ql 30 20 -mo FR \
    -dc '-' -md poly4 3e-3 3.3e-8 -mr 98.2 1.8 -hd Balzer -cp 1 -ck 0 -nl 12 \
    -mi tags.fasta \
    -di 30 -sp 90 -pp 90 -bn "$PROJECT" -od "$OUTPUT_FOLDER"
