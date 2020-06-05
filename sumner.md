# Running a compute job with `slurm`

Interactive job
```bash
srun -p compute -q batch -t 8:00 -c 1 --pty $SHELL
srun --pty bash
```

Examples
```bash
#!/bin/bash
#SBATCH --job-name=test
#SBATCH --partition=compute  # ==queue
#SBATCH --nodes=1            # number of nodes
#SBATCH --ntasks=2           # number of cores
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:05:00      # time (HH:MM:SS)
#SBATCH --output=%x.o%j      # stdout and stderr
###SBATCH --mail-user=<USER_ID>@jax.org
###SBATCH --mail-type=END,FAIL
module list

CWD=$(pwd)
echo "Current dir is $CWD"

echo "STDERR here" 1>&2
echo "STDOUT here"

# run this script by calling sbatch test.slurm
```
 
```bash
#!/bin/bash
#SBATCH --qos=batch
#SBATCH --partition=compute
#SBATCH --job-name=test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16gb
#SBATCH --time=23:59:59
#SBATCH --array=1-5

module load singularity

# Run your R script that uses an R singularity container
ARRAY_ID=`printf %05d $SLURM_ARRAY_TASK_ID`
singularity run --app Rscript ${CONTAINER} ${RFILE} ${CORES} ${SEED}
```

```
    #!/bin/bash
#SBATCH --job-name=run_program
#SBATCH --partition=compute  # ==queue
#SBATCH --nodes=1            # number of nodes
#SBATCH --ntasks=20          # number of cores
#SBATCH --mem-per-cpu=30G
#SBATCH --time=48:00:00      # time (HH:MM:SS)
#SBATCH --output=%x.o%j      # stdout and stderr

module load singularity
module list

CWD=$(pwd)
echo "Current dir is $CWD"

K=4
OUTDIR=/path/to/fast/disk/
mkdir -p $OUTDIR

date
singularity exec container.sif scriptname.py arg1 arg2 arg3
RETCODE=$?
echo "Return code was $RETCODE"
date

# run this script by calling sbatch filename.slurm
```

Array job
```
#!/bin/bash
#SBATCH --job-name=test
#SBATCH --partition=compute  # ==queue
#SBATCH --nodes=1            # number of nodes
#SBATCH --ntasks=2           # number of cores
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:05:00      # time (HH:MM:SS)
#SBATCH --output=%x.o%A_%a      # stdout and stderr
#SBATCH --array=1,3,4,5
module list

CWD=$(pwd)
echo "Current dir is $CWD"

echo "STDERR here" 1>&2
echo "STDOUT here"

# run this script by calling sbatch test.slurm
```
