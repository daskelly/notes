library(tidyverse)
library(biomaRt)

ens <- useMart("ensembl")
human <- useDataset("hsapiens_gene_ensembl", mart=ens)
mouse <- useDataset("mmusculus_gene_ensembl", mart=ens)

hsgenes <- c("CLCN6", "MDM4", "SDCCAG8")
genesmus <- getLDS(attributes="hgnc_symbol", filters="hgnc_symbol",
    values=hsgenes, mart=human, attributesL="mgi_symbol", martL=mouse, 
    uniqueRows=TRUE)
# Add a column onto dat that gives mouse gene symbol,
# but do not include any gene without 1:1 orthology
genesmus2 <- rename(genesmus, "human"="HGNC.symbol",
  "mouse"="MGI.symbol") %>% group_by(human) %>%
  mutate(nmouse=n()) %>% group_by(mouse) %>% 
  mutate(nhuman=n()) %>% 
  filter(nmouse == 1, nhuman == 1) %>%
  dplyr::select(-nmouse, -nhuman)
 