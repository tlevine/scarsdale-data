#!/usr/bin/Rscript --vanilla
library(ggplot2)
library(reshape2)
library(scales)

tax <- read.csv(
  'grandma/tax-rates.csv',
  strip.white = T,
  colClasses = c('numeric', 'factor', 'factor', 'numeric')
)
tax$rate <- tax$rate/1000

# rates.over.time <- ggplot(na.omit(tax)) +
rates.over.time <- ggplot(tax) +
  aes(x = year, y = rate, group = paste(bill, tax), color = paste(bill, 'bill,', tax, 'tax')) +
  scale_x_continuous('Year', breaks=unique(tax$year)) +
  scale_y_continuous('Tax rate (percent of assessed value)', labels = percent) +
  labs(title = 'Scarsdale tax rates over time') +
  geom_line()
