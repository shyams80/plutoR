library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

#initialize
nasdaqOmx <- NasdaqOmx()

# fetch all "India" TR NASDAQOMX indices

nasdaqOmx$Meta() %>%
  inner_join(nasdaqOmx$TimeSeries()) %>%
  group_by(ID, NAME) %>%
  filter(NAME %like% '% india %') %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  print(n = Inf)

