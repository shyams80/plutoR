library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)

options("scipen"=999)
source("../R/config.R")

famaFrench<-FamaFrench()

# show data-ranges for Fama-french factors

famaFrench$FiveFactor3x2Daily() %>%
  group_by(KEY_ID) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  arrange(KEY_ID) %>%
  print(n=Inf)


# show data-ranges for Fama-french industry daily returns

famaFrench$Industry49Daily() %>%
  group_by(KEY_ID, RET_TYPE) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  arrange(ST) %>%
  print(n=Inf)

# show data-ranges for Fama-french momentum daily returns

famaFrench$MomentumDaily() %>%
  group_by(KEY_ID, RET_TYPE) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  arrange(ST) %>%
  print(n=Inf)

# show data-ranges for Fama-french momentum monthly returns

famaFrench$MomentumMonthly() %>%
  group_by(KEY_ID, RET_TYPE) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  arrange(ST) %>%
  print(n=Inf)
