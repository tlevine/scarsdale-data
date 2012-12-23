library(ggplot2)
library(reshape2)
library(scales)

cp <- read.csv('budget/capital_projects-adopted_estimated-sum.csv',
  sep = ',', strip.white = T
)[-4]

# Combine adopted and requested
levels(cp$figure)[3] <- levels(cp$figure)[1]
cp$capital_project <- factor(cp$capital_project, levels = c('popham road bridge', 'public_safety'))
levels(cp$capital_project) <- c('Popham Road Bridge', 'Public Safety Headquarters')

p.public.safety <- ggplot(subset(cp, capital_project == 'Public Safety Headquarters')) + aes(x = year, y = amount_sum, group = figure, color = figure) +
  scale_y_continuous('Amount', labels = dollar) + geom_line() +
  labs(title = 'Adopted (planned) and estimated (near-actual) appropriations for the Public Safety Headquarters')

p.popham.road.bridge <- ggplot(subset(cp, capital_project == 'Popham Road Bridge')) + aes(x = year, y = amount_sum, group = figure, color = figure) +
  scale_y_continuous('Amount', labels = dollar) + geom_line() +
  labs(title = 'Adopted (planned) and estimated (near-actual) appropriations for the Popham Road Bridge')

p.difference <- ggplot(dcast(cp, year + capital_project ~ figure)) +
  aes(x = year, y = (adopted - estimated), group = capital_project, color = capital_project) +
  scale_x_discrete('Year') + labs(title = 'Appropriations for two capital projects didn\'t quite follow the plan.') +
  scale_y_continuous(
    'Difference with respect to the plan for each year:\nAdopted (planned) appropriations minus estimated (near-actual) appropriations',
    labels = dollar, limits = c(-2e7, 2e7)
  ) +
  geom_line() + 
  annotate('text', x = '2005-2006', y =  1.5e7, label = "For several years, projects\nwere adopted (planned) but\n not built.") +
  annotate('text', x = '2009-2010', y =  8e6, label = "In 2008-2009, the projects\nwere finally undertaken.") +
  annotate('text', x = '2011-2012', y = -1.1e7, label = "For a few years,\nmore was spent\non the bridge than\nhad been planned.") +
  labs(color = 'Capital Project')

p <- function() {
  png('plots/04-public_safety.png', width = 900, height = 600)
  print(p.public.safety)
  dev.off()

  png('plots/04-popham_road_bridge.png', width = 900, height = 600)
  print(p.popham.road.bridge)
  dev.off()

  png('plots/04-difference.png', width = 900, height = 600)
  print(p.difference)
  dev.off()
}

