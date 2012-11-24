#!/usr/bin/env Rscript

library(plyr)

funds <- read.csv('appendix_a1-funds.csv')
tax <- read.csv('appendix_a1-tax.csv')
budget <- join(tax, funds)

# Funds
funds.p1 <- ggplot(funds) + aes(x=year, y = appropriation, group = fund, color = fund) + geom_line()

funds.p2 <- ggplot(subset(melt(funds), variable == 'appropriation' | variable == 'Non.Prop.Tax.Revenue')) + aes(x=year, y = value, group = paste(variable, fund), color = fund) + geom_line() + scale_y_log10()

# Tax
tax.p1 <- ggplot(tax) + aes(y = tax.rate, x = assessed, label = year) + geom_text() +
  labs(title = 'Scarsdale property tax rate as a function of total assessed value of Scarsdale houses') +
  ylim(0, 1)

tax.p2 <- ggplot(tax) + aes(size = assessed, x = year, y = tax.rate, label = year) + geom_point() + geom_text() +
  labs(title = 'Scarsdale property tax rate as a function of total assessed value of Scarsdale houses') +
  ylim(0, 1)

# Do another one like this but with Lange's sandwiches as the x unit.
tax.p3 <- tax.p1 +
  scale_x_continuous('Total village assessment (dollars)', breaks = (138:144) * 10^6, labels = paste(138:144, ' million'))

# Combined
ggplot(budget)
