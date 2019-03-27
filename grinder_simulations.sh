#!/bin/bash
# Run Grinder Simulation

# Input parameters
CONFIG_FILE="$1"

# Global variables
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SCRIPT=$0
SCRIPT_NAME=$(basename "$SCRIPT")
CONFIG_FILENAME=$(basename "$CONFIG_FILE")
LOG_FOLDER="99_logfiles/""$TIMESTAMP""_grinder_simulation"

# Log all output
mkdir "$LOG_FOLDER"
exec > >(tee "$LOG_FOLDER"/"$TIMESTAMP"_grinder_simulation.log) 2>&1

echo "Grinder Simulations v0.0.1"
echo ""

# Import config file and keep copy in 99_logfiles
if [ -e "$CONFIG_FILE" -a -s "$CONFIG_FILE" ]
then
    source "$CONFIG_FILE"
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

# Validate that the sequence and tags files exist
if [ -e "$FASTA_FILE" ]
then
    cp "$FASTA_FILE" "$LOG_FOLDER"/"$TIMESTAMP"_"$(basename $FASTA_FILE)"
else
    echo "Error: Sequence file specified in config file does not exit:"
    echo "    $FASTA_FILE"
    exit 1
fi

if [ -e "$TAGS_fILE" ]
then
    cp "$TAGS_fILE" "$LOG_FOLDER"/"$TIMESTAMP"_"$(basename $TAGS_fILE)"
else
    echo "Error: Tags file specified in config file does not exit:"
    echo "    $TAGS_fILE"
    exit 1
fi
# Create log folder for current run with date and keep info about run
## Full config, sequence, and tags files used
## Global variables (if needed)

# Run grinder
echo "Num CPUs:     $NUM_CPUS"
echo "Sequences:    $FASTA_FILE"
echo "Tags:         $TAGS_fILE"

./01_scripts/01_run_grinder.sh "$CONFIG_FILE" "$TIMESTAMP"
