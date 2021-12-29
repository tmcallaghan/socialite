#! /bin/bash

source config-blog-small.config

java -jar ./target/socialite-0.0.1-SNAPSHOT.jar timeline-read-follower-ramp --out $SOCIALITE_CSV_DIRECTORY --start $SOCIALITE_START --stop $SOCIALITE_STOP $SOCIALITE_YML

#usage: java -jar socialite-0.0.1-SNAPSHOT.jar
#       timeline-read-follower-ramp [-h] [--out OUT] [--start START] [--stop STOP] [file]
#
#Measure timeline read latency as we ramp up follow count
#
#positional arguments:
#  file                   service configuration file
#
#optional arguments:
#  -h, --help             show this help message and exit
#  --out OUT
#  --start START          (default: 1)
#  --stop STOP            (default: 1024)
