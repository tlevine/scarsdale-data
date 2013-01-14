#!/usr/bin/env python2
import sys
import re

SNIP = re.compile(r"(FULL MKT VAL|COUNTY TAXABLE|VILLAGE TAXABLE|SCHOOL TAXABLE) ([0-9,]+)")
snips = re.findall(SNIP, sys.stdin.read().replace('\n', ' '))
print 'TAX,ASSESSED'
for tax, assessed in snips:
    print('%s,%d' % (tax, int(assessed.replace(',', ''))))
