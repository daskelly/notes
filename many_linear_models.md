# This note shows how to quickly fit many linear models in R

Let's imagine we want to get residuals of lm(y ~ condition)

```R
library(tidyverse)
set.seed(1)

# Simulate 1000 phenotypes each measured in 200 individuals
y <- matrix(rnorm(200000), nrow=200)
covar=tibble(condition=c(rep("A", 100), rep("B", 100)))
```

The simplest way to do this is to write a loop but this 
may be slow for big datasets:
```R
results <- list()
for (i in 1:1000) {
    results[[i]] <- residuals(lm(y[, i] ~ ., data=covar))
}
results1 <- do.call("cbind", results)
```

But we can take advantage that if the response specified in the 
call to `lm()` is a matrix, it fits an lm to each column:
```R
results2 <- residuals(lm(y ~ ., data=covar))
are_equal(results1, results2)
```

This is great if the covariates are the same for every linear
model that we fit, but what if they are not?
```R
grp2 <- do.call("rbind", lapply(1:1000, function(i) sample(covar$condition)))

# the loop way:
results3 <- list()
for (i in 1:1000) {
    results3[[i]] <- residuals(lm(y[, i] ~ grp2[i, ]))
}
results3 <- do.call("rbind", results3)

# the more elegant way using tidyverse
results4 <- map2(array_tree(y, 2), array_tree(grp2, 1),
    function(x, y) residuals(lm(x ~ y)))
results4 <- do.call("rbind", results4)
are_equal(results3, results4)
```
