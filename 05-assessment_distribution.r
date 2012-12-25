library(reshape2)
library(ggplot2)
library(scales)

assess <- read.csv('assessor/distribution.csv')

# Check ordering for considering row grouping
if (sum(assess$TAX != c('COUNTY', 'VILLAGE', 'SCHOOL')) > 0) {
  print('The tax types don\'t seem to be ordered exactly the same, so rows might not be grouped properly.')
}

# Combine by row.
assess$PARCEL <- rep(1:(nrow(assess)/3), each = 3)

p.distributions <- aaply(levels(assess$TAX), 1, function(tax){
  ggplot(subset(assess, TAX == tax)) + aes(x = ASSESSED) +
    scale_x_log10('Assessed value', labels = dollar) +
    scale_y_continuous('Count') +
    labs(title = paste('Distribution of assessed values for', tax, 'taxes')) +
    geom_histogram(position = 'dodge')
})

assess.cast <- ddply(assess, 'PARCEL', function(df){data.frame(
  mean = mean(df$ASSESSED),
  sd = sd(df$ASSESSED),
  label = paste(df$ASSESSED, collapse = '; ')
)})
mu <- mean(assess.cast$mean)
p.variation <- ggplot(subset(assess.cast, sd > 0)) +
  scale_x_continuous('Mean tax amount', labels = dollar) +
  scale_y_continuous('Standard deviation of tax amount', labels = dollar) +
  aes(x = mean, y = sd, label = label) +
  geom_text()
