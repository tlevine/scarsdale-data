#!/usr/bin/env python
import re
from dumptruck import DumpTruck

def main():
    raw = open('2012.txt').read()
    dt = DumpTruck(dbname = 'assessor.db')

KEYS = [
    ('ACREAGE', float),
    ('FRNT', float),
    ('DPTH', float),
    ('FULL MKT VAL', float),
]
def acct(text):
    data = {}
    lines = text.split('\n')

    data['TAX MAP PARCEL ID'] = re.match(r'^\*+([ 0-9.]{8,10})\*+$', lines[0]).group(1).strip()
    data['ACCT'] = int(re.findall(r'ACCT\: ([0-9]+)', text)[0])
    data['CD'] = re.findall(r'\n([A-Z]{2})\n', text)[0]
    
#   data['CURRENT OWNERS NAME'] = 
#   data['CURRENT OWNERS ADDRESS'] 

    for k, t in KEYS:
        data[k] = t(re.findall(k + ' ([0-9,.]+)', text)[0].replace(',', ''))

    return data
