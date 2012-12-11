library(ggplot2)

cp <- read.csv('budget/capital_projects-adopted_estimated-sum.csv',
  sep = ',', strip.white = T
)[-4]

# Combine adopted and requested
levels(cp$figure)[3] <- levels(cp$figure)[1]

p <- ggplot(cp) + aes(x = year, y = amount_sum, group = paste(capital_project, figure), linetype = figure, color = capital_project) + geom_line()
