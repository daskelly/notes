# Building and running singularity containers

## Overall advice

Always make sure to try finding a pre-built container first.
This is the easiest path forward.

Try to keep things simple. It is best to build off of a 
pre-built container. E.g. for a `vcflib` container I 
built off of `continuumio/miniconda3:4.8.2-alpine` and
my whole `%post` section is
```bash
%post
    . /opt/conda/etc/profile.d/conda.sh
    conda install -c conda-forge -c bioconda -c defaults vcflib
```

## Steps to build a more complicated container when needed.
E.g. building a container holding R and the Seurat package

 * Build a sandbox minimal container [example def file](sandbox.def). 
Build using e.g. `singularity build --remote --sandbox sandbox.sif sandbox.def`
 * Fire up this container as writable `singularity shell --writable sandbox.sif` 
 * Test things, e.g. installing `R` packages

