% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model-EquitiesIndiaNse.R
\docType{class}
\name{EquitiesIndiaNse-class}
\alias{EquitiesIndiaNse-class}
\alias{EquitiesIndiaNse}
\title{Equities India NSE}
\description{
Equities India NSE
}
\section{Methods}{

\describe{
\item{\code{CorporateActions()}}{Query the corporate actions for listed stocks}

\item{\code{CorporateEvents()}}{Query the corporate events for listed stocks}

\item{\code{CorporateResults()}}{Query to CorporateResults for a specific period and stock}

\item{\code{CorporateResultsMeta()}}{Query to obtain the REF_ID to lookup CorporateResults for a specific period}

\item{\code{DailyReturns()}}{Query the percentage daily return (close-to-close) time-series for listed stocks}

\item{\code{EodAdjustedTimeSeries()}}{Query end-of-day price and volume time-series adjusted for splits, bonus and dividends for listed stocks}

\item{\code{EodTimeSeries()}}{Query unadjusted end-of-day price and volume time-series for listed stocks}

\item{\code{MarketCapDecile()}}{Query market-cap decile of of listed equity tickers}

\item{\code{MiscInfo()}}{Query miscellaneous information of listed equity tickers}

\item{\code{Tickers()}}{Query meta data of listed equity tickers}
}}

\references{
\url{https://nseindia.com/}

Read the python documentation for information on the data-attributes \url{https://plutopy.readthedocs.io/en/latest/EquitiesIndiaNse.html}

Sample notebook: \url{https://github.com/shyams80/plutons/blob/master/docs-R/EquitiesIndiaNse.ipynb}
}
