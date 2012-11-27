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
