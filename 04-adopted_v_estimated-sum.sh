#!/bin/sh

tmp=$(mktemp)

# Add the fourth column
cut -d, -f4 budget/capital_projects-adopted_estimated.csv |
  sed 's/\(NA\|^ *$\)/0/' | bc | sed s/^/,/ > $tmp

paste budget/capital_projects-adopted_estimated.csv $tmp |
  sed '1 s/0$/amount_sum/'
