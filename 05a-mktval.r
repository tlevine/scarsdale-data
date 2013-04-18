library(ggplot2)
library(scales)

assess <- read.csv('05a-assessment_distribution.csv')

assess.1 <- subset(assess, TAX == 'FULL MKT VAL')
assess.1$TOTAL <- 0.0187 * assess.1$ASSESSED

p.base <- ggplot(assess.1) + aes(x = TOTAL) +
  scale_y_continuous('Count') +
  labs(title = 'Total assessed values of Scarsdale property') +
  geom_histogram(position = 'dodge')

.xlab <- 'Mean of assessed value for county, village and school taxes'
p.simple <- p.base + scale_x_continuous(.xlab, labels = dollar)
p.log <- p.base + scale_x_log10(.xlab, labels = dollar)

png('plots/05-total-assessed-simple.png', width = 840, height = 600)
print(p.simple)
dev.off()

png('plots/05-total-assessed-log.png', width = 840, height = 600)
print(p.log)
dev.off()

