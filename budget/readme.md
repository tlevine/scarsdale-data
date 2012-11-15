Scarsdale Budget
=====

## Documents
### Budget documents
The budget documents are divided into sections by government body. Within each
body are three or four tables

1. **Department Summary** seems to be the overall summary for the body; it
    combines the figures from the other two tables.
2. **Position Summary** seems to be salaries.
3. **Division Summary** seems to be all expenses other than salaries.
4. **Revenue Summary** seems to contain all revenue. It is present only if the
    body has revenue.


### Statement documents
The statements contain more detailed information, but I haven't yet figured out
what.

## Ideas
It might be fun to pick out the information from these tables. I could look at
information over time, compare adopted to estimated, and so on.

The appendices have loads of interesting information, like the cost of leaf
removal and a schedule of debt. Appendix A1 is a summary of the year's budget.
I think that's a decent analysis to start with.

## Extracted datasets
My understanding these datasets suddenly clicked when I realized that property
tax might be the only sort of tax that the village collects; thus, "tax" and
"property tax" mean the same thing.

### Property tax
`appendix_a1-tax.csv` contains the "Assessed Valuation (000)" and "Property
Tax Rate" fields from appendix A1. These fields are not documented in the
budget, but here are my guesses as to their meaning.

`assessed` is the sum of the values of all Scarsdale houses, as
valued by the assessor. The unit is dollars. This was originally "Assessed
Valuation (000)" in the budget, and the budget uses thousand-dollars as the
unit.

`tax.rate` (originally "Property Tax Rate") is the proportion of the assessed
value of a house that is taken as tax; you can think of this as the amount of
tax in dollars that you must pay for every dollar valuation of the house.
The original figure is rate per thousand-dollars. The village treasurer page
([original](http://www.scarsdale.com/Home/Departments/VillageTreasurer.aspx),
[mirror](treasurer-homepage.html)) was helpful for figuring this out.

### Funds
`appendix_a1-tax.csv` contains majority of the A1 tables' data. This table
contains the amount of money set aside for each fund (`appropriations`,
originally "APPROPRIATIONS"), which you can think of as its expenses for the
coming year.

It also contains two sources of income for the coming year; these are the
property tax income (`tax.revenue`, originally "Amount To Be Raised By Taxes)
and all other sources of income (`other.revenue`, originally "Non Prop Tax
Revenue".

Finally, it contains the balance from the previous year (`balance`, originally
"Approp Fund Balance").

## Call the Treasurer
Call the Treasurer. Explain that I live in Scarsdale, I work as a data
scientist at a web startup and that separately of that I want to visualize
the inner-workings of the village government so I and other people can better
understand how it all works. (This introduction of myself is a bit more buzzy
than I would ordinarily give.) Then ask these.

1. I'm starting with the budgets, mainly because they were easy to find on the
    internet. I've managed to understand most of them, but I'm wondering what
    the "Assessed Valuation (000)" and "Property Tax Rate" fields from appendix
    A1 are.
2. I'd like to combine the data from the various tables in the budget. Could
    you send me whatever Word or Excel files were used to generate the budget
    PDF document?
3. Do you have any particular set of documents that you would like the public
    to know more about?
