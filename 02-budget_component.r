#!/usr/bin/Rscript --vanilla
library(ggplot2)
library(reshape2)
library(scales)
library(plyr)
library(quantmod)

# Inflation
getSymbols("CPIAUCSL", src='FRED')
inflation.xts <- CPIAUCSL[paste(2006:2012, '-05-01', sep = '')]
inflation <- data.frame(
  year = paste(2006:2012, 2007:2013, sep = '-'),
  CPIAUCSL.2012 = as.vector(inflation.xts[,1] / CPIAUCSL['2012-05-01'][[1]]),
  CPIAUCSL.2009 = as.vector(inflation.xts[,1] / CPIAUCSL['2009-05-01'][[1]])
)

# Load budget data
funds <- read.csv('budget/appendix_a1-funds.csv')
tax <- read.csv('budget/appendix_a1-tax.csv')

# Use the adopted budget if available; otherwise, use the tentative budget.
tax <- ddply(tax, 'year', function(df){df[order(df$budget),][1,]})

# Join
tax <- join(tax, inflation)
tax$tax.rate.adj.2009 <- tax$tax.rate/tax$CPIAUCSL.2009
budget <- join(tax, funds)


