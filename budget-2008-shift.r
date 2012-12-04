#!/usr/bin/Rscript --vanilla
library(ggplot2)
library(reshape2)
library(scales)

tax <- read.csv(
  'grandma/tax-rates.csv',
  colClasses = c('numeric', 'factor', 'factor', 'numeric')
)
tax$rate <- tax$rate/1000

rates.over.time <- ggplot(na.omit(tax)) +
  aes(x = year, y = rate, group = paste(bill, tax), color = paste(bill, tax)) +
  scale_x_continuous('Year', breaks=unique(tax$year)) +
  scale_y_continuous('Tax rate (percent of assessed value)', labels = percent) +
  geom_line()
