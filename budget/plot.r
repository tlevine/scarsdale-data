funds <- read.csv('appendix_a1-funds.csv')

p1 <- ggplot(funds) + aes(x=year, y = appropriation, group = fund, color = fund) + geom_line()

p2 <- ggplot(subset(melt(funds), variable == 'appropriation' | variable == 'Non.Prop.Tax.Revenue')) + aes(x=year, y = value, group = paste(variable, fund), color = fund) + geom_line() + scale_y_log10()

