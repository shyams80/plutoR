library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

etfs<-ETFsUs()

# biggest 20 ETFs

etfs$Meta() %>%
  arrange(desc(AUM)) %>%
  head(20) %>%
  print(n=Inf)

# oldest 20 ETFs

etfs$Meta() %>%
  arrange(LAUNCH_DATE) %>%
  head(20) %>%
  print(n=Inf)

