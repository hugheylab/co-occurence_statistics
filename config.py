"""Application-specific settings and configuration to
dictate the behavior of the API.
"""

import os

cache = {
  "front_page": 600,
  "simple": 7200
}


# Information about how to connect to a postgres database will
# all the Drug Monitor data
db = {
  "host": "hl-drug-monitor.choxmvghdfxg.us-east-2.rds.amazonaws.com",
  "db": "HugheyLabDrugMonitor",
  "user": "postgres",
  "password": "mysecretpassword",
  "schema": 'prod', # Each environment has a schema, theoretically
  "connection": {
    "timeout": 3,
    "max_attempts": 10,
    "attempt_pause": 3, # how long to wait between connection attempts
  },
}

# Hostname (and protocol) where users will find your site.
# This is needed to build redirect URLs that don't
# break when the web server is behind a reverse proxy.
host = "https://api.url_goes_in_here.org"

# Whether to launch the application with gunicorn as the web server, or
# with Bottle's default. The default can be handy for development because
# it includes the option to reload the application any time there is a
# code change.
use_prod_webserver = False

# how many search results are returned at a time
default_page_size = 20

# the most results an API user can request at one time
max_page_size = 250
