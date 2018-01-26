# Example qtl mapping using `r/qtl2`

First load probs, covar, and phenotype data

```R
library(tidyverse)
library(qtl2)

# qtl2geno::calc_kinship
kinship_loco <- calc_kinship(probs, "loco", cores=n.cores)

# qtl2scan::scan1(probs, pheno, kinship_loco, ...)
out <- scan1(probs, phenodf[, phenotype, drop=FALSE], 
  kinship_loco, addcovar=covar.mat, cores=n.cores)
plot(out, gmap)

# qtl2scan::find_peaks()
# drop returns 1.5 LOD support intervals
# leave default peakdrop=Inf which will only report one peak per chrom
# function returns a long & tidy dataset
peaks <- find_peaks(out, gmap, drop=1.5,
  threshold=thrA, thresholdX=thrX) %>% as_tibble() %>%
  rename(phenotype=lodcolumn, peak_chr=chr, peak_cM=pos)
```
