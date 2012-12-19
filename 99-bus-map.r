library(ggplot2)

ggplot(b[1:139,]) + aes(x = lng, y = lat, size = cumsum(n.students), group = route.name, color = route.name) +geom_path()
