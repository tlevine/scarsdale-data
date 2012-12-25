#!/usr/bin/env python2
import sys
import re

SNIP = re.compile(r"(COUNTY|VILLAGE|SCHOOL) TAXABLE ([0-9,]+)")
snips = re.findall(SNIP, sys.stdin.read().replace('\n', ' '))
for tax, assessed in snips:
    print('%s,%d' % tax, int(assessed.replace(',', '')))
