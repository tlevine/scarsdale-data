#!/usr/bin/Rscript --vanilla
library(ggplot2)
library(reshape2)
library(scales)

tax <- read.csv(
  'grandma/tax-rates.csv',
  strip.white = T,
  colClasses = c('numeric', 'factor', 'factor', 'numeric')
)

# Convert to percents
tax$rate <- tax$rate/1000

# Add rates relative 2003
tax <- sqldf("select tax.year as 'year', tax.bill as 'bill', tax.tax as 'tax', tax.rate as 'rate', tax.rate/tax_2003.rate as 'rate.rel' from tax join (select * from tax where year = 2003) as tax_2003 where tax.bill = tax_2003.bill and tax.tax = tax_2003.tax") 

#
# The raw rates over time
#
rates.over.time <- ggplot(tax) +
# rates.over.time <- ggplot(na.omit(tax)) +
  aes(x = year, y = rate, group = paste(bill, tax), color = paste(bill, 'bill,', tax, 'tax')) +
  scale_x_continuous('Year', breaks=unique(tax$year)) +
  scale_y_continuous('Tax rate (percent of assessed value)', labels = percent) +
  labs(title = 'Scarsdale tax rates over time') +
  geom_line()

#
# The rates relative the 2003 rates
#
change.over.time <- ggplot(tax) +
  aes(x = year, y = rate.rel, group = paste(bill, tax), color = paste(bill, 'bill,', tax, 'tax')) +
  scale_x_continuous('Year', breaks=unique(tax$year)) +
  scale_y_continuous('Change in tax rate (percent of 2003 tax rate)', labels = percent) +
  labs(title = 'Scarsdale tax rates over time relative the 2003 rates') +
  geom_line()
