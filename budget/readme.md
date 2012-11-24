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
Call the Treasurer at (914) 722-1170. The person who answers the phone doesn't
know about the preparation of these documents, so she transferred me to the
treasurer, and I left a message.

I left a message to explain that I've been looking at the village budget to understand, for fun,
the inner-workings of the village government, and I asked if I could have the
tables as the Word or Excel files that were used to generate the budget PDF
documents

Eventually, I want to ask "Do you have any particular set of documents that you would like the public to know more about?"

## Reduction in expenditures following the 2008 crash
The village substantially reduced expenditures after the 2008 crash, mainly in
the capital projects fund.

(I have a graph.)

What exactly was cut? The fund's appropriation typically increases by a couple
million dollars each year, but the appropriation was decreased by about
$20 million in 2009-2010. More specifically, public building costs were
decreased by about $11.5 million, and highway improvement costs were decreased
by about $8.5 million. (See page 109 of the [2009-2010 budget](2009-2010_adopted_budget.pdf))
