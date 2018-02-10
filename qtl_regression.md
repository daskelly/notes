This mini doc shows equivalence between mapping QTL in `qtl2` and
doing linear regression.

Modified from the `qtl2` manual, especially the section on 
[QTL mapping in Diversity Outbred mice](http://kbroman.org/qtl2/assets/vignettes/user_guide.html#qtl_analysis_in_diversity_outbred_mice)

```R
library(qtl2)
library(tidyverse)

file <- "https://raw.githubusercontent.com/rqtl/qtl2data/master/DOex/DOex.zip"
DOex <- read_cross2(file)
pr <- calc_genoprob(DOex, error_prob=0.002)
apr <- genoprob_to_alleleprob(pr)
sex <- select(DOex$covar, Sex) %>% rownames_to_column("id") %>%
    mutate(sex2=ifelse(Sex == "male", 1, 0)) %>%
    select(-Sex) %>% deframe()

out <- scan1(apr, DOex$pheno, addcovar=sex)
plot(out, DOex$gmap)
```

Now let's reconstruct this result via regression to convince ourselves that 
this is what `qtl2` is doing under the hood:
```R
markers <- lapply(DOex$geno, colnames) %>% 
    enframe("chrom", "marker") %>% unnest()

# Do the linear regressions for genotypes at each marker
# this is the slow(er) way
# Note that apr is a list with names=chroms and values=n.ind*n.hap matrix of probs
lods <- numeric()
lm0 <- lm(DOex$pheno ~ sex)
for (i in 1:nrow(markers)) {
    haps <- LETTERS[1:7]   # leave off H which is just 1 minus the others 
    probs <- apr[[markers$chrom[i]]][, haps, markers$marker[i]]
    lm1 <- lm(DOex$pheno ~ probs + sex)
    lods[i] <- (logLik(lm1) - logLik(lm0))/log(10)
}
all.equal(lods, out[,1], check.names=F)

# this is the fast(er) way
library(abind)
probs <- abind(apr, along=3)  # DOQTL-like format - a single array
lods2 <- map(array_branch(probs[, haps, ], 3), function(p) 
    (logLik(lm(DOex$pheno ~ p + sex)) - logLik(lm0))/log(10)) %>% as.numeric()

cor(cbind(out[,1], lods, lods2))
```



