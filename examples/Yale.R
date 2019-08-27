library(dbplyr)
library(dplyr)
library(odbc)
library(lubridate)
library(plutoR)
options("scipen"=999)
source("../R/config.R")

yale<-Yale()

# start and end dates of confidence indices

yale$Confidence() %>%
  group_by(NAME) %>%
  summarize(ST = min(TIME_STAMP), ET = max(TIME_STAMP)) %>%
  print()

# SP500 close and CAPE at the end of each year since 1995

yale$SP500() %>%
  filter(TIME_STAMP >= '1995-12-01' & month(TIME_STAMP) == 12) %>%
  mutate(Y = year(TIME_STAMP)) %>%
  select(Y, CLOSE, CAPE) %>%
  arrange(Y) %>%
  print(n=Inf)
