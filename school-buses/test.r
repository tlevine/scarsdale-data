#!/usr/bin/env Rscript
library(testthat)
library(plyr)
library(sqldf)

stops <- read.csv('bus_stops.csv')

compare.trips <- function(a, b){
  # Compare a set of morning and afternoon trips.

  expect_equal(
    nrow(a), nrow(b),
    info = 'The two trips have different number of stops.'
  )

  expect_equal(
    a$n.students, -rev(b$n.students),
    info = 'The student counts are different.'
  )

  expect_equal(
    a$location, rev(b$location),
    info = 'The stop locations are different.'
  )

}

validate.trip <- function(trip){
  r <- paste(as.character(trip[1,'route.name']), ':', sep = '')
  expect_equal(sum(trip$n.students), 0,
    info = paste(r, 'n.students does not sum to zero.')
  )

  expect_true(
    'SENIOR HIGH SCHOOL (007)' %in% trip[c(1, nrow(trip)),'location'],
    info = paste(r, 'The high school is listed neither as the first nor the last stop.')
  )

  expect_equal(
    trip$stop.id, sort(trip$stop.id),
    info = paste(r, 'The bus stops are not sorted by stop id.')
  )

  expect_equal(
    trip$time, sort(trip$time),
    info = paste(r, 'The bus stops are not sorted by time.')
  )

}

a <- subset(stops, route.number == 142 & route.name == 'HS 68 PM(3:10)')
b <- subset(stops, route.number == 142 & route.name == 'HS 31 AM')

sqldf('select route_name, route_number, sum(abs(n_students)) from stops group by route_name, route_number order by 3')

# Check individual trips.
d_ply(stops, 'route.name', validate.trip)

# "","route.name","route.number"
# "HS 74 PM(4:15)",95
# "HS 31 AM",142
# "HS 68 PM(3:10)",142
# "HS 24 AM",144
# "HS 57 PM",144
# "HS 66 PM(3:10)",144
# "HS 22 AM",145
# "HS 59 PM",145
# "HS 26 AM",147
# "HS 29 AM",148
# "HS 62 PM",148
# "HS 27 AM",149
# "HS 23 AM",150
# "HS 69 PM(3:10)",152
# "HS 58 PM",154
# "HS 28 AM",155
# "HS 60 PM",155
# "HS 30 AM",156
# "HS 63 PM",156
# "HS 64/72 PM(3:10)",156
# "HS 25 AM",157
# "HS 61 PM",157
# "HS 70 PM(3:10)",157
