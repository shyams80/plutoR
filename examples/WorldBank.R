library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

wb <- WorldBank()

#fetch all India related meta data

wb$Meta() %>%
  filter(COUNTRY_NAME == "India") %>%
  print(n=Inf)

#fetch cpi inflation for India

wb$TimeSeries() %>%
  filter(COUNTRY_KEY == 135 & INDICATOR_KEY == 6) %>%
  arrange(YEAR) %>%
  print(n=Inf)
