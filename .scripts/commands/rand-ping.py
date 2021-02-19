#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# randomly choose a site and ping it (to test networking)
# dependencies: python iputils-ping

import random
import subprocess

sites = [
    "google.com",
    "facebook.com",
    "en.wikipedia.org",
    "amazon.com",
    "nih.gov",
    "yelp.com",
    "reddit.com",
    "imdb.com",
    "craigslist.org",
]
# https://stackoverflow.com/a/306417
rand = random.choice(sites)

print("Pinging {}".format(rand))
subprocess.run(['ping', rand])
