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
tax <- read.csv('budget/appendix_a1-tax.csv')

# Use the adopted budget if available; otherwise, use the tentative budget.
tax <- ddply(tax, 'year', function(df){df[order(df$budget),][1,]})

# Join
tax <- join(tax, inflation)
tax$tax.rate.adj.2009 <- tax$tax.rate/tax$CPIAUCSL.2009

# Tax rate over time
tax.by.year <- ggplot(tax) + aes(x = year, y = tax.rate) + geom_point() +
  labs(title = 'Village tax rate increases steadily.', labels = percent) + 
  scale_x_discrete('Year') +
  scale_y_continuous('Village tax rate (percent of assessed value)', labels = percent)

# Tax rate by value of a dollar in 2012 dollars
tax.by.inflation <- ggplot(tax) + aes(x = CPIAUCSL.2012, y = tax.rate, label = year) + geom_text() +
  labs(title = 'Village tax rate and inflation increase somewhat proportionately.') +
  scale_x_continuous('Value of a dollar in May 2012 dollars', labels = dollar) +
  scale_y_continuous('Village tax rate (percent of assessed value)', labels = percent)

# Inflation-adjusted tax rate by value of a dollar
tax.molten <- melt(tax, c('year', 'budget', 'CPIAUCSL.2009', 'CPIAUCSL.2012', 'assessed'))
levels(tax.molten$variable) <- c('Raw', 'Adjusted (using 2009 dollars)')
adj.tax.by.inflation <- ggplot(tax.molten) +
  aes(x = year, y = value, group = variable, linetype = variable) +
  labs(title = 'Does village tax rate increase faster than inflation?\n(If it does not, the dotted line should be flat.)') +
  scale_x_discrete('Year') +
  scale_y_continuous('Inflation-adjusted village tax rate (percent of assessed value)', labels = percent) +
  geom_line()

p <- function() {
  pdf('plots/01-tax_rate.pdf', width = 11, height = 8.5)
  print(tax.by.year)
  print(tax.by.inflation)
  print(adj.tax.by.inflation)
  dev.off()
}
#p()
