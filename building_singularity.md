# Building and running singularity containers

## Overall advice

Always make sure to try finding a pre-built container first.
This is the easiest path forward.

Next, try to keep things simple. It is best to build off of a 
pre-built container. 

You can find documentation on building a singularity definition
file (the "recipe" for the container)
[here](https://docs.sylabs.io/guides/3.5/user-guide/definition_files.html#sections).

Here is a simple example of building a container to 
install python with the `opencv` package. We will use mamba which is
[here](https://hub.docker.com/r/mambaorg/micromamba/tags).

We can work off the basic recipe
[here](opencv_4.8.1.78.def).

Make an account at https://cloud.sylabs.io/. 
I log in using my github credentials.
You can use this to 
take advantage of their remote container builder.
On `sumner`, execute `singularity remote list`. If you have no
remote endpoints listed you may need to add the sylabs site
using a command like
`singularity remote add SylabsCloud https://cloud.sylabs.io/`.
Then `singularity remote use SylabsCloud`.
Then login using 
`singularity remote login SylabsCloud` and follow the 
instructions. 

Finally, build the container using a command like:
`singularity build --remote lolcow.sif lolcow.def`

