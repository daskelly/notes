library(Seurat)
myenv <- new.env()
source(paste0('https://raw.githubusercontent.com/daskelly/seurat/refs/heads/',
              'umap-approx-pow/R/dimensional_reduction.R'), local = myenv)
RunUMAP.Seurat <- get("RunUMAP.Seurat", env = myenv)
