library(ggplot2)
library(scales)

cp <- read.csv('budget/capital_projects-adopted_estimated-sum.csv',
  sep = ',', strip.white = T
)[-4]

# Combine adopted and requested
levels(cp$figure)[3] <- levels(cp$figure)[1]
cp$capital_project <- factor(cp$capital_project, levels = c('popham road bridge', 'public_safety'))
levels(cp$capital_project) <- c('Popham Road Bridge', 'Public Safety Headquarters')

p.public_safety <- ggplot(subset(cp, capital_project == 'Public Safety Headquarters')) + aes(x = year, y = amount_sum, group = figure, color = figure) +
  scale_y_continuous('Amount', labels = dollar) + geom_line() +
  labs(title = 'Adopted (planned) and estimated (near-actual) appropriations for the Public Safety Headquarters')

p.popham.road.bridge <- ggplot(subset(cp, capital_project == 'Popham Road Bridge')) + aes(x = year, y = amount_sum, group = figure, color = figure) +
  scale_y_continuous('Amount', labels = dollar) + geom_line() +
  labs(title = 'Adopted (planned) and estimated (near-actual) appropriations for the Popham Road Bridge')

p.difference <- ggplot(dcast(cp, year + capital_project ~ figure)) +
  aes(x = year, y = (adopted - estimated), group = capital_project, color = capital_project) +
  scale_x_discrete('Year') + labs(title = 'Appropriations for two capital projects didn\'t quite follow the plan.') +
  scale_y_continuous('Difference with respect to the plan for each year:\nAdopted (planned) appropriations minus estimated (near-actual) appropriations', labels = dollar) +
  geom_line() +
  annotate('text', x = '2005-2006', y =  1e7, label = "For several years, projects were\nadopted (planned) but not built.") +
  annotate('text', x = '2007-2008', y = -3e6, label = "In 2008-2009, the projects\nwere finally undertaken.") +
  annotate('text', x = '2011-2012', y = -1e7, label = "For a few years, more was spent on\nthe bridge than had been planned.") +
  labs(color = 'Capital Project')
