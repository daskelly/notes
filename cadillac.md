# Running a compute job with `torque`

Example commands:
```bash
showres
checkjob 2458391
showstart 2219420
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
