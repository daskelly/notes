library(tidyverse)
library(biomaRt)

ens <- useMart("ensembl")
human <- useDataset("hsapiens_gene_ensembl", mart=ens)
mouse <- useDataset("mmusculus_gene_ensembl", mart=ens)

# Get human orthologs of mouse genes:
mmgenes <- c("Ptprc", "Adgre1", "Acta2")
geneshs <- getLDS(attributes="mgi_symbol", filters="mgi_symbol",
    values=mmgenes, mart=mouse, attributesL="hgnc_symbol",
    martL=human, uniqueRows=TRUE)
# Do not include any gene without 1:1 orthology
geneshs_1to1 <- rename(geneshs, human=HGNC.symbol, mouse=MGI.symbol) %>%
    group_by(human) %>% mutate(nmouse=n()) %>%
    group_by(mouse) %>% mutate(nhuman=n()) %>%
    filter(nmouse==1, nhuman==1) %>%
    dplyr::select(-nmouse, -nhuman)

# Get mouse orthologs of human genes:
hsgenes <- c("CLCN6", "MDM4", "SDCCAG8")
genesmm <- getLDS(attributes="hgnc_symbol", filters="hgnc_symbol",
    values=hsgenes, mart=human, attributesL="mgi_symbol", martL=mouse, 
    uniqueRows=TRUE)
# Do not include any gene without 1:1 orthology
genesmm_1to1 <- rename(genesmm, human=HGNC.symbol, mouse=MGI.symbol) %>% 
    group_by(human) %>% mutate(nmouse=n()) %>% 
    group_by(mouse) %>% mutate(nhuman=n()) %>% 
    filter(nmouse==1, nhuman==1) %>%
    dplyr::select(-nmouse, -nhuman)
 