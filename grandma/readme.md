Here is information that I obtained from my grandmother, who has lived in
Scarsdale for quite a while.

## Tax bills
I looked at her village, school and county tax bills from 2003 until 2013.
(The county uses the calendar year as the fiscal year, but the village
uses July to June as the fiscal year.) I recorded some relevant data that
are explained below.

These taxes are all property taxes, and the amount is simply a portion of the
assessed value of a house. I suspect that the method for assessing value hasn't
changed since the beginning of time; the value is on the order of ten-thousand
dollars. (This is another analysis that uses the assessor data.)

For village and school taxes, whose fiscal year is two calendar years,
the first of those years is used to identify the fiscal year. For example,
taxes for 2008-2009 are recorded as year "2008". This makes them line up
with the year of county taxes that gets paid at the same time.

### Tax rates
My grandmother had saved both her bills, her receipts and the information
plamphlet that came with the bill. This information pamphlet summarizes the
budget that corresponds to the bill and presents the tax rates for all of the
different parts of the town/village or county. The bill states the tax rate for
my grandmother's specific area, adjusts for exemptions and computes the dollar
tax amount.

I collected tax rate by year for the following taxes in the file `tax-rates.csv`.

* Village tax
* School tax
  * Town of Mamaroneck
  * Town of Scarsdale
* County?
  * County...
  * Bronx...
  * Hutchinson...
  * Mamaroneck...
  * Refuse...

The budget and the tax bills express this rate in permil (dollars per
one-thousand dollars of assessed value), so that is the manner in which I have
recorded them. I recommend converting them to ordinary fractions for analysis.

The assessed value of her house didn't change during this time, so this
is almost enough informamtion to calculate the tax she paid; all that's
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
