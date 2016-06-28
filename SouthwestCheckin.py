from splinter import Browser
import httplib2
from datetime import datetime
from dateutil import parser as dateparser
from time import sleep
from argparse import ArgumentParser
import IPython

# IF THIS IS FAILING MAKE SURE SPLINTER IS INSTALLED:
# [sudo] pip install splinter
# [sudo] pip install ipython
# [sudo] pip install httplib2

def use_browser_do_magic(browser, exec_time, offset_time):
    try:
        browser.visit('http://www.southwest.com/flight/retrieveCheckinDoc.html')
        browser.fill('confirmationNumber', conf_number)
        browser.fill('firstName', first_name)
        browser.fill('lastName', last_name)
	
        while ((datetime.now() - exec_time).total_seconds() < 0):
          sleep(.05)

        browser.find_by_id('submitButton')[0].click()
        browser.find_by_id('printDocumentsButton')[0].click()

        return True

    except:
        return False

# Parse Arguments on the Command Line
# Usage is python checkin.py first_name last_name confirmation_number year month day_to_checkin hour minute
ap = ArgumentParser()
ap.add_argument('stuff', nargs='*')
ns = ap.parse_args()

first_name = ns.stuff[0]
last_name = ns.stuff[1]
conf_number = ns.stuff[2]
t = datetime(int(ns.stuff[3]), int(ns.stuff[4]), int(ns.stuff[5]), int(ns.stuff[6]), int(ns.stuff[7]), 0)

# Wait for DNS to be able to resolve southwest
h1 = httplib2.Http('.cache')
is_conn = False
while not is_conn:
  try:
    resp, cont = h1.request('http://www.southwest.com')
    t_offset = datetime.utcnow() - dateparser.parse(resp['date']).replace(tzinfo=None)
    print t_offset
    is_conn = True
  except Exception as e:
    print "Can't do it... {}".format(e)
    is_conn = False

  # Go to the checkin page fill it out with argparse stuff, and hit the submit buttons
with Browser() as b:
  try:
    while not use_browser_do_magic(b, t, t_offset):
        print "Attempt failed, trying again..."
        sleep(.25)
  except:
    IPython.embed()
