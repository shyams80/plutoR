library(tidyverse)
library(odbc)
library(plutoR)
options("scipen"=999)
source("../R/config.R")

iflows <- InvestmentFlowsIndia()

# get daily DII and FII flows for the last 20 days for the cash market

print("daily DII and FII flows for the last 20 days for the cash market:")

stDate <- Sys.Date() - 30

diiCash <- iflows$DiiCashMarket() %>%
  group_by(TIME_STAMP, SECURITY_TYPE) %>%
  summarize(BUY = sum(BUY_VALUE),
            SELL = sum(SELL_VALUE),
            NET = sum(BUY_VALUE - SELL_VALUE)) %>%
  filter(TIME_STAMP >= stDate) %>%
  select(TIME_STAMP, SECURITY_TYPE, BUY, SELL, NET)

fiiCash <- iflows$FiiCashMarket() %>%
  group_by(TIME_STAMP, SECURITY_TYPE) %>%
  summarize(BUY = sum(BUY_VALUE),
            SELL = sum(SELL_VALUE),
            NET = sum(BUY_VALUE - SELL_VALUE)) %>%
  filter(TIME_STAMP >= stDate) %>%
  select(TIME_STAMP, SECURITY_TYPE, BUY, SELL, NET)

diiCash %>%
  full_join(fiiCash, by=c('TIME_STAMP', 'SECURITY_TYPE')) %>%
  collect() %>%
  mutate(BUY = replace_na(BUY.x, 0) + replace_na(BUY.y, 0),
         SELL = replace_na(SELL.x, 0) + replace_na(SELL.y,0),
         NET = replace_na(NET.x,0) + replace_na(NET.y,0)) %>%
  select(TIME_STAMP, SECURITY_TYPE, BUY, SELL, NET) %>%
  print(n=Inf)

# get instruments traced for DIIs in the derivative market

print("instruments traced for DIIs in the derivative market")

iflows$DiiDerivativesMarket() %>%
  group_by(SECURITY_TYPE) %>%
  summarize(ST_DT = min(TIME_STAMP), ED_DT = max(TIME_STAMP)) %>%
  arrange(ST_DT) %>%
  print(n = Inf)

# get instruments traced for FIIs in the derivative market

print("instruments traced for FIIs in the derivative market")

iflows$FiiDerivativesMarket() %>%
  group_by(SECURITY_TYPE) %>%
  summarize(ST_DT = min(TIME_STAMP), ED_DT = max(TIME_STAMP)) %>%
  arrange(ST_DT) %>%
  print(n = Inf)
