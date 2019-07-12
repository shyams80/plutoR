library(dbplyr)
library(dplyr)
library(odbc)
library(plutoR)
options("scipen"=999)
source("../R/config.R")

#initialize
mfi <- MutualFundsIndia()

#who are the biggest 5 mutual fund managers?
lastAumDate <- (mfi$AumFundwise() %>%
                  summarize(MAX_TS = max(PERIOD)) %>%
                  collect())$MAX_TS[1]

mfi$AumFundwise() %>%
  filter(PERIOD == lastAumDate) %>%
  select(FUND) %>%
  mutate(AUM = AVG_AUM_WO_FOFD + AVG_AUM_FOFD) %>%
  arrange(desc(AUM)) %>%
  print(n=5)

#what are the largest 10 mid-cap funds by AUM?

# Meta to filter for the 'Mid-Cap' category
# AumSchemewise to sort funds by AUM - largest first
# NavTimeSeries to get the start and end dates for which NAVs are available

lastMetaDate <- (mfi$Meta() %>%
                   summarize(MAX_TS = max(AS_OF)) %>%
                   collect())$MAX_TS[1]

lastSwDate <- (mfi$AumSchemewise() %>%
                 summarize(MAX_TS = max(PERIOD)) %>%
                 collect())$MAX_TS[1]

print(lastMetaDate)
print(lastSwDate)

mfAum <- mfi$Meta() %>%
  inner_join(mfi$NavTimeSeries(), by="SCHEME_CODE") %>%
  rename(SN = SCHEME_NAME) %>% #rename to avoid conflict in the group_by
  inner_join(mfi$AumSchemewise(), by="SCHEME_CODE") %>%
  group_by(SCHEME_CODE, SCHEME_NAME, AVG_AUM_WO_FOFD) %>%
  filter(PERIOD == lastSwDate & AS_OF == lastMetaDate & CATEGORY == 'Mid-Cap') %>%
  summarize(start_dt = min(TIME_STAMP), end_dt = max(TIME_STAMP)) %>%
  arrange(desc(AVG_AUM_WO_FOFD))

mfAum %>% print(n=10)

#get the NAV time-series

scode <- as.numeric(data.frame(mfAum)[1,1])
print(scode)

navTs <- mfi$NavTimeSeries() %>%
  filter(SCHEME_CODE == scode) %>%
  select(TIME_STAMP, NAV)

#print the first 5 and the last 5 NAVs
navTs %>%
  arrange(TIME_STAMP) %>%
  print(n=5)

navTs %>%
  arrange(desc(TIME_STAMP)) %>%
  print(n=5)
