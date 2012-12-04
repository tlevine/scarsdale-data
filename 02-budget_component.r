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
tax$tax.rate.adj.2009 <- tax$tax.rate/tax$CPIAUCSL.2009
budget <- join(tax, funds)

# Use the adopted budget if available; otherwise, use the tentative budget.
budget <- ddply(budget, c('year', 'fund'), function(df){df[order(df$budget),][1,]})
budget$appropriation.2012 <- budget$appropriation / budget$CPIAUCSL.2012

#
# Plot sub-fund appropriations over the years.
#
.melt.vars <- c(
   "year",
   "fund",
   "tax.rate",
   "CPIAUCSL.2012",
   "tax.rate.adj.2009"
)
.molten <- melt(
  budget[c(.melt.vars, 'appropriation', 'appropriation.2012')],
  .melt.vars, variable.name = 'Appropriation'
)
names(.molten)[2] <- 'Fund'
.molten$Appropriation <- factor(.molten$Appropriation,
  levels = c('appropriation', 'appropriation.2012')
)
levels(.molten$Appropriation) <- c('Raw amount', 'In 2012 dollars')
appropriations <- ggplot(.molten) +
  aes(x = year, y = value, group = paste(Appropriation, Fund)) +
  aes(lty = Appropriation, color = Fund) +
  scale_x_discrete('Year') +
  scale_y_continuous('Appropriation', labels = dollar) +
  labs(title = 'Village appropriations by fund over the past few years') +
  geom_line()

#
# Appropriations relative 2006-2007
#
.budget.rel <- sqldf("
SELECT
  budget.year AS 'Year',
  budget.fund AS 'Fund',
  budget.appropriation,
  1.0 * budget.appropriation/budget_2006.appropriation AS 'Change.in.appropriation'
FROM budget
JOIN (SELECT * FROM budget WHERE year = '2006-2007') AS budget_2006
WHERE budget.fund = budget_2006.fund
") 
appropriation.changes <- ggplot(.budget.rel) +
  aes(x = Year, y = Change.in.appropriation, group = Fund, color = Fund) +
  scale_y_continuous('Change in appropriation (relative 2006-2007)', labels = percent) +
  labs(title = 'Change in village fund appropriations since 2006') +
  geom_line()
