Scarsdale School Buses
=====
Scarsdale High School bus schedules are
[here](http://www.scarsdaleschools.org/cms/lib5/NY01001205/Centricity/Domain/13/SHSBusSchedule.pdf).

Let's make a map of them!

I doubt the Scarsdale High School bus schedule has changed in decades, so I
imagine that work on this will remain useful for a while.

## Data entry
I'm manually transcribing the file because it's a small messy scan.
Here are some checks of the data:

* The `stop.id` should be "2" or one greater than the previous.
* The number of students for a given trip should sum to zero.
* The time for a stop should be greater than or equal to the previous stop's time.
* Different trips (by name) with the same route (by number) should have the same stops in reversed ourder.

Here are some funny things I noticed:

    HS 25 AM,           157,    10, 7:27 am,      0,ROCK CREEK LN & SYCAMORE RD
    HS 25 AM,           157,    11, 7:27 am,      6,ROCK CREEK LN & SYCAMORE RD
    ...
    HS 28 AM,           155,     3, 7:02 am,      2,OLD WHITE PLAINS RD & WELLHOUSE CLOSE & OLD WHITE PLAINS RD
    ...
    HS 28 AM,           155,    15, 7:21 am,      1,WEAVER ST & HWY 125 & CO HWY 129 & WEAVER ST & HWY 125 & CO HWY 129 & HILLANDALE DR &  HILLANDDALE DR & HILLANDALE CLOSE
    ...
    HS 70 PM(3:10),     157,    12, 3:40 pm,      0,GRIFFEN AVENUE & BRITTANY CLOSE & GRIFFEN AVENUE
    ...
    HS 74 PM(4:15),      95,     3, 4:19 pm,      0,WHITE RD & SPRAGUE RD & SPRAGUE AVE & SPRAGUE RD & SPRAGUE AVE & WHITE RD
    ...
    HS 74 PM(4:15),      95,    18, 4:45 pm,      0,MAMARONECK RD & MAMARONECK RD & CARTHAGE RD
    HS 74 PM(4:15),      95,    19, 4:47 pm,      0,INNES RD & HEATHCOTE RD & HEATHCOTE RD
    HS 74 PM(4:15),      95,    20, 4:50 pm,      0,HAVERFORD AVE & WEAVER ST & HWY 125 & WEAVER ST & HWY 125
    HS 74 PM(4:15),      95,    21, 4:51 pm,      0,BRADFORD RD & WEAVER ST & HWY 125 & CO HWY 129 & WEAVER ST & HWY 125 & CO HWY 129
    ...

## Maps
Here are some ideas.

* At a given time, where are all of the buses, and how many students are in them?
* Plot all bus routes on top of each other, with width being the number of students in the bus.
* Figure out how the bus routes are chosen and how students are assigned.
* Consider whether the bus routes could be improved. (Even if they are, it doesn't necessarily make sense to do so because the stability of bus routes is good too.)

## To do
1. Enter the locations.
2. Make maps.
3. Ask for middle school schedules.
