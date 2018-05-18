# Managing environment in conda

```bash
conda create -n $NAME scipy=0.15.0 numpy
source activate $NAME
```

Installing a package that is not available via conda
```bash
cd /path/to/package
source activate $NAME
conda install pip
pip install .
```

What are your environments?
```bash
conda info --envs
source activate $NAME
conda list
```

Cleaning up to reclaim disk space
```bash
conda clean -a -y
```

Removing an environment
```bash
conda remove --name $NAME --all
```
