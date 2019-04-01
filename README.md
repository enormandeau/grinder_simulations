# Grinder Simulations

Framework to create in silico eDNA metabarcoding experiments

## Description

Wrapper framework around
[Grinder](https://sourceforge.net/projects/biogrinder/), a program that creates
simulated omic shotgun and amplicon sequence libraries.

Developed by [Eric Normandeau](https://github.com/enormandeau) in [Louis
Bernatchez](http://www.bio.ulaval.ca/louisbernatchez/presentation.htm)'s
laboratory.

## Objective

The goal of this project is to create experiments with multiple samples at
relative abundances that behave more like what is observed in real eDNA
metabarcoding projects.

### Assumptions

- Groups of samples share similair species composition and relative abundances
- Samples from a given group are more similar to other samples of that same group
- An experiment has one or more of these groups of samples

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

You can edit this one in place or make yourself a copy and edit that copy.

### Create input files

- Fasta file with all the species sequences by decreasing order of abundancy
- Tags file with at least as many tags as the desired number of samples

### Run

```
./grinder_simulations.sh <PATH_TO_CONFIG_FILE>
```

For examples:

```
./grinder_simulations.sh 02_infos/grinder_simulations.conf
```

On a server with SLURM, you may need to do more, for example:

```bash
module load grinder
srun -c 10 --mem 1G -J grinderSimul -o grinder_simul_%j.log \
    ./01_grinder_simulations.sh 02_infos/grinder_simulations.conf
```

## Output

A project folder will be created in the output folder (`04_outputs`). Its name
will start by the time of the run (`YYYYMMDD_HHMMSS_`) followed by the name of
the run (example: `grinder_run_01`). This folder will contain three subfolders:

- `01_samples_templates`: Fastq sequences used to generate each sample
- `02_simulated_samples`: The simulate samples and info files
- `03_obitools_input`: Grinder output formatted for [obitools](https://git.metabarcoding.org/obitools/obitools/wikis/home)
- `04_barque_input`: Grinder output formatted for [Barque](https://github.com/enormandeau/barque)
- `99_logfiles`: Copies of files used for this run and reports

## License

CC share-alike

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Grinder Simulations</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Eric Normandeau</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
