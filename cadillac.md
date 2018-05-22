# Running a compute job with `torque`

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
```

Dependencies
```bash
qsub -W depend=afterok:2268893 submit.pbs
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
