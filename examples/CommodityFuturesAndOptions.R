library(DBI)
library(plutoDbR)
library(plutoR)
library(tidyverse)
options("scipen"=999)
source("../R/config.R")

commodityFO <- CommodityFuturesAndOptions()

# get all the commodities that are being traded in COMEX and NYMEX

print("commodity futures that are being traded in COMEX and NYMEX")

maxDt <- (commodityFO$CmeEod() %>%
            summarize(MAX_DT = max(TIME_STAMP)) %>%
            collect())$MAX_DT[[1]]

t1 <- commodityFO$CmeEod() %>%
  filter(TIME_STAMP == maxDt) %>%
  group_by(PRODUCT_SYMBOL, PRODUCT_DESCRIPTION) %>%
  summarize(TOTAL_VOLUME = sum(VOLUME)) %>%
  select(PRODUCT_SYMBOL, PRODUCT_DESCRIPTION, TOTAL_VOLUME) %>%
  collect()

t2 <- commodityFO$CmeEod() %>%
  group_by(PRODUCT_SYMBOL) %>%
  summarize(START_DT = min(TIME_STAMP)) %>%
  select(PRODUCT_SYMBOL, START_DT) %>%
  collect()

t1 %>%
  inner_join(t2, by=c('PRODUCT_SYMBOL')) %>%
  filter(TOTAL_VOLUME > 0) %>%
  arrange(desc(TOTAL_VOLUME)) %>%
  print()

# get all the commodity futures that are being traded in MCX

print("commodity futures that are being traded in MCX")

maxDt <- (commodityFO$McxEod() %>%
            summarize(MAX_DT = max(TIME_STAMP)) %>%
            collect())$MAX_DT[[1]]

t1 <- commodityFO$McxEod() %>%
  filter(TIME_STAMP == maxDt & (OTYPE == 'XX' | OTYPE == 'FUTCOM')) %>%
  group_by(CONTRACT) %>%
  summarize(TOTAL_OI = sum(OI)) %>%
  select(CONTRACT, TOTAL_OI) %>%
  collect()

t2 <- commodityFO$McxEod() %>%
  group_by(CONTRACT) %>%
  summarize(START_DT = min(TIME_STAMP)) %>%
  select(CONTRACT, START_DT) %>%
  collect()

t1 %>%
  inner_join(t2, by=c('CONTRACT')) %>%
  filter(TOTAL_OI > 0) %>%
  arrange(desc(TOTAL_OI)) %>%
  print()

# get all the commodity futures that are being traded in NCDEX

print("commodity futures that are being traded in NCDEX")

maxDt <- (commodityFO$NcdexEod() %>%
            summarize(MAX_DT = max(TIME_STAMP)) %>%
            collect())$MAX_DT[[1]]

t1 <- commodityFO$NcdexEod() %>%
  filter(TIME_STAMP == maxDt) %>%
  group_by(COMMODITY) %>%
  summarize(TOTAL_OI = sum(OI)) %>%
  select(COMMODITY, TOTAL_OI) %>%
  collect()

t2 <- commodityFO$NcdexEod() %>%
  group_by(COMMODITY) %>%
  summarize(START_DT = min(TIME_STAMP)) %>%
  select(COMMODITY, START_DT) %>%
  collect()

t1 %>%
  inner_join(t2, by=c('COMMODITY')) %>%
  filter(TOTAL_OI > 0) %>%
  arrange(desc(TOTAL_OI)) %>%
  print()
