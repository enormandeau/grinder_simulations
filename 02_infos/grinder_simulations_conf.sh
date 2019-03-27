# This file is sourced by a bash script
# Do not add spaces around the equal signs `=`

# Simulation name
SIMULATION_NAME="grinder_run_01"    # Do not use spaces

# Input files
FASTA_FILE="03_inputs/sequence_pool.fasta"
TAGS_fILE="03_inputs/tags.fasta"

# Grinder Simulations parameters
NUM_CPUS=10                 # Number of CPUs to use
NUM_GROUPS=2                # Number of groups of samples
NUM_SAMPLES_PER_GROUP=2     # Number of samples per group
NUM_SPECIES_POOL=50         # Total number of sequences to choose from
NUM_SPECIES_PER_GROUP=40    # Number of to include in each group
NUM_SPECIES_PER_SAMPLE=30   # Number of to include in each sample
NUM_PERMUTATIONS=20         # Number of adjacent sequences to permutate
POWERLAW_EXPONENT=1.0       # Exponent of power law sample abundancy distribution
