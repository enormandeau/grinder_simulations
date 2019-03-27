# Grinder Simulations

Framework to create in silico eDNA metabarcoding experiments

## Description

Wrapper framework around the
[Grinder](https://sourceforge.net/projects/biogrinder/) program that creates
simulated omic shotgun and amplicon sequence libraries.

## Objective

The goal of this project is to create experiements with multiple samples at
relative abundances that behave more like what is observed in real eDNA
metabarcoding projects.

### Assumptions

- Groups of samples share similair species and relative abundances
- An experiment has a few of these groups of samples

## Dependencies

- UNIX-like system (Linux, BSD, MacOS...)
- Grinder
- Gnu Parallel
- Python3

## Running

### Copy and fill config file

A config file template can be found in:
```
02_infos/grinder_simulations.conf
```

It defines values for the following variables:

- numGroups
- numSamplesPerGroup
- numSpeciesPool
- numSpeciesPerGroup
- powerlawExponent

### Run

```
./01_scripts/01_grinder_simulations.sh <PATH_TO_CONFIG_FILE> <NUM_CPUS>
```

On a server with SLURM, you may need to do more, for example:

```bash
NUM_CPUS=10
module load grinder
srun -c "$NUM_CPUS" --mem 1G --time 0-01:00 -J grinderSimul -o grinder_simul_%j.log \
    ./01_scripts/01_grinder_simulations.sh 02_infos/grinder_simul.conf "$NUM_CPUS"
```

## Output

- Folder with multiple samples with their names
- Files describing each sample (species, abundances, errors, chimeras...)

## License

CC share-alike

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Grinder Simulations</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Eric Normandeau</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/enormandeau/grinder_simulations" rel="dct:source">https://github.com/enormandeau/grinder_simulations</a>.
