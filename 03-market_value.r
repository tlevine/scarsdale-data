#!/usr/bin/Rscript --vanilla
library(ggplot2)
library(reshape2)
library(scales)
library(plyr)
library(quantmod)

# Inflation
getSymbols("CPIAUCSL", src='FRED')
inflation.xts <- CPIAUCSL[paste(2003:2012, '-05-01', sep = '')]
inflation <- data.frame(
  year = 2003:2012,
  CPIAUCSL.2012 = as.vector(inflation.xts[,1] / CPIAUCSL['2012-05-01'][[1]])
)

market.value <- read.csv('grandma/market-value.csv')
market.value$value.10000 <- 10000 / (market.value$percent.to.market / 100)
market.value <- join(market.value, inflation)
market.value.plot <- ggplot(market.value) +
  aes(x = CPIAUCSL.2012, y = value.10000) +
  aes(label = paste(year, '\n(', percent.to.market, '%)', sep = '')) +
  scale_x_continuous('Value of a dollar in 2012 dollars', labels = dollar) +
  scale_y_continuous('Nominal market value of a house assessed at $10,000',
    labels = dollar, limits = c(0, max(market.value$value.10000))) +
  geom_text(y = market.value$value.10000 - 30000) +
  geom_line()
