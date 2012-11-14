#!/usr/bin/env python
'Download budget stuff from the scarsdale treasurer, and name it decently.'
from urllib import urlretrieve
from urlparse import urljoin
from lxml.html import parse

HOME_URL = 'http://www.scarsdale.com/Home/Departments/VillageTreasurer.aspx'

def rough_save(url, filename):
    urlretrieve(url, filename = filename)
    f = open(filename + '.url', 'w')
    f.write(url)
    f.close

def homepage():
    rough_save(HOME_URL, 'treasurer-homepage.html')
    html = parse('treasurer-homepage.html')
    return html

def main():
    html = homepage()
    for a in html.xpath('id("dnn_LeftPane")/descendant::a'):
        if a.xpath('string()') != '':
            url = urljoin(HOME_URL, a.xpath('@href')[0])
            name = a.xpath('string()')
            rough_save(url, name)

if __name__ == '__main__':
    main()
