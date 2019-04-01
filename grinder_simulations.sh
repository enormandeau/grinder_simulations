#!/bin/bash
# Run Grinder Simulation

# Input parameters
CONFIG_FILE="$1"

# Global variables
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SCRIPT=$0
SCRIPT_NAME=$(basename "$SCRIPT")
CONFIG_FILENAME=$(basename "$CONFIG_FILE")

# Import config file and keep copy in 99_logfiles
if [ -e "$CONFIG_FILE" -a -s "$CONFIG_FILE" ]
then
    # Source config file
    source "$CONFIG_FILE"

    # Create output directory and subdirectories
    OUTPUT_FOLDER="04_outputs/""$TIMESTAMP"_"$SIMULATION_NAME"
    SEQUENCE_FOLDER="$OUTPUT_FOLDER"/01_sample_templates
    SAMPLE_FOLDER="$OUTPUT_FOLDER"/02_simulated_samples
    OUTPUT_OBITOOLS_FOLDER="$OUTPUT_FOLDER"/03_obitools_input
    OUTPUT_BARQUE_FOLDER="$OUTPUT_FOLDER"/04_barque_input
    LOG_FOLDER="$OUTPUT_FOLDER"/99_logfiles
    mkdir "$OUTPUT_FOLDER"
    mkdir "$SEQUENCE_FOLDER"
    mkdir "$SAMPLE_FOLDER"
    mkdir "$OUTPUT_OBITOOLS_FOLDER"
    mkdir "$OUTPUT_BARQUE_FOLDER"
    mkdir "$LOG_FOLDER"

    # Log all output
    exec > >(tee "$LOG_FOLDER"/"$TIMESTAMP"_grinder_simulation.log) 2>&1
    echo "Grinder Simulations v0.1.0"
    cp "$CONFIG_FILE" "$LOG_FOLDER"/"$TIMESTAMP"_"$CONFIG_FILENAME"

else
    echo "Error: Config file does not exist or is empty."
    exit 1
fi

# Test if user specified a number of CPUs
if [ -z "$NUM_CPUS" ]
then
    NUM_CPUS=1
fi

# Validate that the sequence file exists
if [ -e "$FASTA_FILE" ]
then
    cp "$FASTA_FILE" "$LOG_FOLDER"/"$TIMESTAMP"_"$(basename $FASTA_FILE)"
else
    echo "Error: Sequence file specified in config file does not exit:"
    echo "    $FASTA_FILE"
    exit 1
fi

# Validate that the tags file exists
if [ -e "$TAGS_fILE" ]
then
    cp "$TAGS_fILE" "$LOG_FOLDER"/"$TIMESTAMP"_"$(basename $TAGS_fILE)"
else
    echo "Error: Tags file specified in config file does not exit:"
    echo "    $TAGS_fILE"
    exit 1
fi

# Run grinder
./01_scripts/01_run_grinder.sh "$CONFIG_FILE" "$OUTPUT_FOLDER"

# Generate input files for Obitools
./01_scripts/utility_scripts/grinder_to_obitools.py "$SAMPLE_FOLDER" "$OUTPUT_OBITOOLS_FOLDER"

# Generate input files for Barque
./01_scripts/utility_scripts/grinder_to_barque.py "$SAMPLE_FOLDER" "$OUTPUT_BARQUE_FOLDER" "$TAGS_LENGTH"
