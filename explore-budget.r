#!/usr/bin/env Rscript
library(reshape2)
library(ggplot2)
library(plyr)
library(quantmod)
getSymbols("CPIAUCSL", src='FRED')
inflation.xts <- CPIAUCSL[paste(2006:2012, '-05-01', sep = '')] / CPIAUCSL['2012-05-01'][[1]]
inflation <- data.frame(
  year = paste(2006:2012, 2007:2013, sep = '-'),
  inflation.xts[,1]
)

funds <- read.csv('budget/appendix_a1-funds.csv')
tax <- read.csv('budget/appendix_a1-tax.csv')
tax <- join(tax, inflation)
budget <- join(tax, funds)

# Funds
funds.p1 <- ggplot(funds) + aes(x=year, y = appropriation, group = fund, color = fund) + geom_line()

funds.p2 <- ggplot(subset(melt(funds), variable == 'appropriation' | variable == 'Non.Prop.Tax.Revenue')) + aes(x=year, y = value, group = paste(variable, fund), color = fund) + geom_line() + scale_y_log10()

# Tax
tax.p1 <- ggplot(tax) + aes(x = assessed, y = tax.rate, label = year) + geom_text() +
  labs(title = 'Scarsdale property tax rate as a function of total assessed value of Scarsdale houses') +
  ylim(0, 1/2)

tax.p2 <- tax.p1 + geom_point()

tax.p3 <- tax.p1 +
  scale_x_continuous('Total village assessment (dollars)', breaks = (138:144) * 10^6, labels = paste(138:144, ' million'))

# Do another one like this but with Lange's sandwiches as the x unit.
tax$assessed.2012 <- tax$assessed * tax$CPIAUCSL
tax.p4 <- ggplot(tax) + aes(x = assessed.2012, y = tax.rate, label = year) + geom_text() +
  scale_x_continuous('Total village assessment in May 2012 dollars') + ylim(0, .3)


### Budget stuff


# Combined
ggplot(budget)
