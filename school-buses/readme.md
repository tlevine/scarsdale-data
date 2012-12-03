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

* Trip `HS 25 AM` (157) has two stops at the same time and place,
   7:27 am at "ROCK CREEK LN & SYCAMORE RD".
* Trip `HS 28 AM` (155) lists "OLD WHITE PLAINS RD" twice in the second stop (7:02 am).

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
