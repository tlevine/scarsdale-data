Here is information that I obtained from my grandmother, who has lived in
Scarsdale for quite a while.

## Tax bills
I looked at her village, school and county tax bills from 2003 until 2013.
(The county uses the calendar year as the fiscal year, but the village
uses July to June as the fiscal year.) I recorded some relevant data that
are explained below.

For village and school taxes, whose fiscal year is two calendar years,
the first of those years is used to identify the fiscal year. For example,
taxes for 2008-2009 are recorded as year "2008". This makes them line up
with the year of county taxes that gets paid at the same time.

### Tax rates

The assessed value of her house didn't change during this time, so this
is almost enough informamtion to calculate her tax rate. All that's
missing is her exemptions.

### Estimated market value
Each year, a figure is provided to estimate the market value of a house
given the assessed value of a house; it is called the "percent to estimate
market value". This figure is provided on the tax bill, and it is the same
for the county, village and school taxes.

I record this figure in `market-value.csv`. To estimate the market value,
divide the assessed value by this figure. For example, if the assessed
value is 10,000 and the figure is 2%, then

    Estimated      $10,000       $10,000
    market     =   -------   =   ------- = $500,000
    value             2%           .02
