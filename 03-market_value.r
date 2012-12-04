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

# Munge
market.value <- read.csv('grandma/market-value.csv')
market.value$value.10000 <- 10000 / (market.value$percent.to.market / 100)
market.value <- join(market.value, inflation)

#
# Plot
#

# Label position
.text.y <- market.value$value.10000 - 30000
names(.text.y) <- market.value$year
.text.y['2008'] <- .text.y['2008'] + 70000

# Plot
market.value.plot <- ggplot(market.value) +
  aes(x = CPIAUCSL.2012, y = value.10000) +
  aes(label = paste(year, '\n(', percent.to.market, '%)', sep = '')) +
  scale_x_continuous('Value of a dollar in 2012 dollars', labels = dollar) +
  scale_y_continuous('Nominal market value of a house assessed at $10,000
($10,000 divided by the adjustment factor in parantheses)',
    labels = dollar, limits = c(0, 700000)) +
  labs(title = 'How is the uniform market value adjustment on Scarsdale tax bills determined?
Well it\'s apparently not just an inflation adjustment.') +
  geom_text(y = .text.y) +
  geom_path()
