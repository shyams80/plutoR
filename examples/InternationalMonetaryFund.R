library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

imf<-InternationalMonetaryFund()

# get meta-data about monthly indicators pertaining to India currently maintained

imf$Meta() %>%
  filter(AREA == "India" & END_YEAR == 2019 & FREQ == 'M') %>%
  print(n=Inf)

# get Indian IIP index (-2147472396)

imf$TimeSeries() %>%
  filter(ID == -2147472396) %>%
  arrange(YEAR, MONTH) %>%
  print(n=Inf)
