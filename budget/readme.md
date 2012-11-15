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

`assessed.valuation` is the sum of the values of all Scarsdale houses, as
valued by the assessor. The unit is dollars. This was originally "Assessed
Valuation (000)" in the budget, and the budget uses thousand-dollars as the
unit.

`tax.rate` (originally "Property Tax Rate") is something about property tax;
dunno what.

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
