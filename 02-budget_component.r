#!/usr/bin/Rscript --vanilla
library(ggplot2)
library(reshape2)
library(scales)
library(plyr)
library(quantmod)
library(sqldf)

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

# Join
tax <- join(tax, inflation)
tax$tax.rate.adj.2009 <- tax$tax.rate/tax$CPIAUCSL_2009
budget <- join(tax, funds)

# Use the adopted budget if available; otherwise, use the tentative budget.
budget <- ddply(budget, c('year', 'fund'), function(df){df[order(df$budget),][1,]})


budget.1 <- sqldf('select year, fund, CPIAUCSL_2012, appropriation from budget join inflation on budget.year = inflation.year')
budget.1$appropriation.2012 <- budget.1$appropriation / budget.1$CPIAUCSL_2012

.melt.vars <- c(
   "year",
   "budget",
   "assessed",
   "tax.rate",
   "CPIAUCSL_2012",
   "CPIAUCSL_2009",
   "tax.rate.adj.2009",
   "fund",
#  "appropriation",
   "Non.Prop.Tax.Revenue",
   "Approp.Fund.Balance",
   "Amount.To.Be.Raised.By.Taxes"
)
appropriations <- ggplot(melt(budget, .melt.vars)) +
  aes(x=year, y = value, lty = variable, color = fund, group = paste(variable, fund), color = fund) + geom_line()
