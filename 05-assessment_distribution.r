library(reshape2)
library(ggplot2)
library(scales)
library(plyr)

assess <- read.csv('05-assessment_distribution.csv')

# Check ordering for considering row grouping
if (sum(assess$TAX != c('COUNTY', 'VILLAGE', 'SCHOOL')) > 0) {
  print('The tax types don\'t seem to be ordered exactly the same, so rows might not be grouped properly.')
}

# Combine by row.
assess$PARCEL <- rep(1:(nrow(assess)/3), each = 3)

p.distributions <- alply(c('COUNTY', 'VILLAGE', 'SCHOOL'), 1, function(tax){
  ggplot(subset(assess, TAX == tax)) + aes(x = ASSESSED) +
    scale_y_continuous('Count') +
    labs(title = paste('Distribution of assessed values for', tax, 'taxes')) +
    geom_histogram(position = 'dodge')
})

#p.distribution.mean <- ggplot(assess.cast) + aes(x = mean) +
#    scale_x_continuous('Mean of assessed value for county, village and school taxes') +
#    scale_y_continuous('Count') +
#    labs(title = paste('Assessed values of Scarsdale property') +
#    geom_histogram(position = 'dodge')
#)

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
  scale_x_log10('Mean assessed value across county, village or school taxes', labels = dollar) +
  scale_y_log10('Standard deviation of tax amount', labels = dollar) +
  labs(title = 'Effective assessed values for different taxes by property') +
  aes(x = mean, y = sd)
  
p.variation.explore <- p.variation.base + aes(label = label) + geom_text()
p.variation.present <- p.variation.base + geom_point() +
  annotate('text', 200000, 12000, label = 'Chateaux and\n50 Popham Road\n(apartments)')

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

p <- function() {
  print(paste(sum(assess.cast$mean == 0), 'of', nrow(assess.cast), 'properties are effectively assessed at $0 and thus pay no taxes.'))

  scale.log <- scale_x_log10('Assessed value', labels = dollar)
  scale.simple <- scale_x_continuous('Assessed value', labels = dollar)

  png('plots/05-distribution-county-simple.png', width = 840, height = 600)
  print(p.distributions[[1]] + scale.simple)
  dev.off()

  png('plots/05-distribution-county-log.png', width = 840, height = 600)
  print(p.distributions[[1]] + scale.log)
  dev.off()

  png('plots/05-distribution-village-simple.png', width = 840, height = 600)
  print(p.distributions[[2]] + scale.simple)
  dev.off()

  png('plots/05-distribution-village-log.png', width = 840, height = 600)
  print(p.distributions[[2]] + scale.log)
  dev.off()

  png('plots/05-distribution-school-simple.png', width = 840, height = 600)
  print(p.distributions[[3]] + scale.simple)
  dev.off()

  png('plots/05-distribution-school-log.png', width = 840, height = 600)
  print(p.distributions[[3]] + scale.log)
  dev.off()

  png('plots/05-apartments.png', width = 840, height = 600)
  print(p.variation.present)
  dev.off()
  png('plots/05-school.png', width = 840, height = 600)
  print(p.school)
  dev.off()
}
#p()


find.exemptions <- function() {
  print(sort(table(assess.cast$sd)))
  sd1057 <- assess.cast[round(assess.cast$sd) == 1057,][,c('county','village','school')]
  # Random sample
  set.seed(324)
  print(sd1057[sample.int(nrow(sd1057), 1) + 1:10,]) 
}
