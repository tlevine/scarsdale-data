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

assess.cast <- ddply(assess, 'PARCEL', function(df){
  rownames(df) <- df$TAX
  data.frame(
    county = df['COUNTY','ASSESSED'],
    village = df['VILLAGE','ASSESSED'],
    school = df['SCHOOL','ASSESSED'],
    mean = mean(df$ASSESSED),
    sd = sd(df$ASSESSED),
    label = paste(df$ASSESSED, collapse = '; ')
  )
})

p.variation.base <- ggplot(subset(assess.cast, sd > 0)) +
  scale_x_log10('Mean tax amount', labels = dollar) +
  scale_y_log10('Standard deviation of tax amount', labels = dollar) +
  labs(title = 'Which parcels have a different assessment for county, village or school taxes?') +
  aes(x = mean, y = sd)
  
p.variation.explore <- p.variation.base + aes(label = label) + geom_text()
p.variation.present <- p.variation.base + geom_point() +
  annotate('text', 300000, 12000, label = 'Chateaux and\n50 Popham Road\n(apartments)')

assess.cast$school.diff <- assess.cast$school - assess.cast$mean
p.school <- ggplot(assess.cast) +
  scale_x_continuous('Difference between mean assessment and school tax assessment\n(If the school assessment was lower, this number is negative.)', labels = dollar) +
  aes(x = school.diff) + geom_histogram()


assess.cast$school.diff.normalized <- (assess.cast$school - assess.cast$mean) / assess.cast$mean
p.school.normalized <- ggplot(assess.cast) +
  scale_x_continuous('Normalized difference between mean assessment and school tax assessment\n(If the school assessment was lower, this number is negative.)', labels = percent) +
  aes(x = school.diff.normalized) + stat_bin(breaks = seq(-.975, .975, .05)) +
  labs(title = 'Assessed values for school taxes tend to be slightly lower than for other taxes.') +
  geom_histogram()
