# This file is sourced by a bash script
# Do not add spaces around the equal signs `=`

# Simulation name
SIMULATION_NAME="grinder_run_01"    # Do not use spaces

# Input files
FASTA_FILE="03_inputs/sequence_pool.fasta"
TAGS_fILE="03_inputs/tags.fasta"

# Grinder Simulations parameters
NUM_CPUS=20                 # Number of CPUs to use (require that many from SLURM)

NUM_GROUPS=5                # Number of groups of samples
NUM_SAMPLES_PER_GROUP=4     # Number of samples per group

NUM_SEQUENCES=50000         # Number of sequences to generate per sample
INSERT_DIST=70              # Insert length for paired-end library
READ_LENGTHS=50             # Length of reads to generate
MUTATION_RATIO="98.2 1.8"   # Proportions of substitutions and indels (2 numbers)
CHIMERA_PERCENT=1           # Percent of chimeras in output

NUM_SPECIES_POOL=50         # Total number of sequences to choose from
NUM_SPECIES_PER_GROUP=35    # Number of to include in each group
NUM_SPECIES_PER_SAMPLE=30   # Number of to include in each sample

NUM_PERMUTATIONS=10         # Number of adjacent sequences to permutate
POWERLAW_EXPONENT=1.0       # Exponent of power law sample abundancy distribution
