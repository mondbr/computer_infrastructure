#! /bin/bash

wget -O data/weather/`date +'%Y%m%d_%H%M%S'.json` https://prodapi.metweb.ie/observations/athenry/today