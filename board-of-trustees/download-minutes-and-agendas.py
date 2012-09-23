#!/usr/bin/env python
import os
import datetime
import re
from time import sleep
from lxml.html import fromstring

def main():
    html = fromstring(open(os.path.join('downloads', 'index.html')).read())
    html.make_links_absolute('http://www.scarsdale.com/Home/BoardofTrustees/BoardofTrusteesAgendasMinutes.aspx')

    minutes = html.cssselect('#dnn_LeftPane td.TitleCell > a')
    agendas = html.cssselect('#dnn_RightPane td.TitleCell > a')

    # Make directories
    for thing in ['minutes', 'agendas']:
        path = os.path.join('downloads', thing)
        if not os.path.exists(path):
            os.mkdir(path)

    for link in minutes:
        out = os.path.join('downloads', 'minutes', choose_filename(link))
        wget(out, link)

    for link in agendas:
        out = os.path.join('downloads', 'agendas', choose_filename(link))
        wget(out, link)

def wget(out, link):
    os.system('[ -e "%(out)s" ] || ( wget -O %(out)s "%(href)s" && sleep 5s)' %
        {"out": out, "href": link.attrib['href']})

SPECIAL_CASES = {
    '10-11--2011 Board of Trustees Agenda': '10-11-2011 Board of Trustees Agenda',
    '09-27--2011 Board of Trustees Agenda': '09-27-2011 Board of Trustees Agenda',
    '09-13--2011 Board of Trustees Agenda': '09-13-2011 Board of Trustees Agenda',
    '3-23-10- Board of Trustees Agenda ': '3-23-10 Board of Trustees Agenda',
}
def choose_filename(link):
    'Given a link, choose a filename for the link to be saved to.'
    title = unicode(link.text)

    if title in SPECIAL_CASES:
        title = SPECIAL_CASES[title]

    if '-' in title:
        rawdate = title.split(' ')[0]
        try:
            fancydate = datetime.datetime.strptime(rawdate, '%m-%d-%Y')
        except ValueError:
            fancydate = datetime.datetime.strptime(rawdate, '%m-%d-%y')
    else:
        rawdate = ''.join(re.split(r'(20[0-9]{2})', title)[:-1]).strip()
        fancydate = datetime.datetime.strptime(rawdate, '%B %d, %Y')

    return fancydate.date().isoformat()

if __name__ == '__main__':
    main()
