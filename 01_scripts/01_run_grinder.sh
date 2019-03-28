#!/bin/bash
# Create all Grinder datasets

# Global variables
CONFIG_FILE="$1"
OUTPUT_FOLDER="$2"

# Source config file
source "$CONFIG_FILE"

# Report number of samples to create
NUM_SAMPLES=$[ $NUM_GROUPS * $NUM_SAMPLES_PER_GROUP ]
echo "Creating $NUM_SAMPLES samples ($NUM_GROUPS groups with $NUM_SAMPLES_PER_GROUP samples)"

# Create template sequence files for each sample
./01_scripts/utility_scripts/create_sequences_for_each_sample.py \
    "$FASTA_FILE" "$TAGS_fILE" "$NUM_GROUPS" "$NUM_SPECIES_POOL" \
    "$NUM_SPECIES_PER_GROUP" "$NUM_SAMPLES_PER_GROUP" "$NUM_SPECIES_PER_SAMPLE" \
    "$NUM_PERMUTATIONS" "$OUTPUT_FOLDER"/01_sample_templates

# Run one Grinder instance per sample
ls -1 "$OUTPUT_FOLDER"/01_sample_templates/*.fasta |
    parallel -j "$NUM_CPUS" \
        ./01_scripts/utility_scripts/run_one_grinder_sample.sh \
        "$CONFIG_FILE" {} "$OUTPUT_FOLDER"/02_simulated_samples {/.}
