library(tidyverse)
packages <- installed.packages() %>% 
    as_tibble() %>%
    filter(is.na(Priority)) %$%
    Package

save(packages, file="updating_R.RData")

# After updating:
load("updating_R.RData")
install.packages(packages)

# Will still need to reinstall all packages installed
# using devtools::install_github()
