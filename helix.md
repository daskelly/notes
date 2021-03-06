# Running a compute job with `torque`

Check if packages installed in CentOS:
```bash
rpm -qa | grep -e pcre -e readline -e lzma
```

Useful commands:
```bash
rg probs   # ripgrep, recursive search of dir to find lines in files containing "probs"
```

System checks:
```bash
quotas   # /usr/local/bin/quotas
qcheck   # based on /usr/local/bin/motd
```

An interactive node
```bash
qsub -I -l procs=1,mem=12gb,walltime=4:00:00 -q interactive
```

Modules
```bash
module -l avail 2>&1 | grep -i samtools
# Seurat on helix
module load R/3.6.0
module unload gcc/4.9.2
module load gcc/7.1.0
```

Dependencies
```bash
qsub -W depend=afterok:2268893 submit.pbs
qsub -W depend=afterok:2268893:2268894:2268895 submit.pbs
qsub -W depend=afterokarray:2269864[] submit.pbs
```

Variables
```
$PBS_O_WORKDIR
$PBS_ARRAYID
```

Understanding maintenance reservations:
```bash
showres
checkjob 2219420[1]   # gives info on a job
showstart 2219420[1]  #  tells you when a job is predicted to start and finish
checkjob -v -v -v 3077840[1] 2>&1 | less
```

Altering an array job to run only up to 100 simultaneously. 
(This does not seem to work on cadillac).
```bash
qalter 2291024[] -t %100
```

Transferring files using an rsync job
```bash
qsub -v IN=/source/dir,OUT=/target/dir ~/repos/rsync.pbs
```

Illustration of how to run a complex
job that depends on multiple components:
```bash
# Submitting everything to run at once:
JOB1=$(qsub pcs_for_harmony.pbs)
ID1=$(echo $JOB1 | awk -F. '{ print $1; }')
JOB2=$(qsub -W depend=afterok:$ID1 run_harmony.pbs)
ID2=$(echo $JOB2 | awk -F. '{ print $1; }')
qsub -W depend=afterokarray:$ID2 analyze_harmony.pbs
qsub -W depend=afterokarray:$ID2 specific_markers_harmony.pbs
qsub -W depend=afterokarray:$ID2 find_markers_harmony.pbs
```
