#! /bin/bash

source config-blog-small.config

java -jar ./target/socialite-0.0.1-SNAPSHOT.jar load --users $SOCIALITE_USERS --maxfollows $SOCIALITE_MAX_FOLLOWS --messages $SOCIALITE_MESSAGES --threads $SOCIALITE_LOAD_THREADS $SOCIALITE_YML


#usage: java -jar socialite-0.0.1-SNAPSHOT.jar
#       load [-h] --users USERS --maxfollows MAXFOLLOWS --messages MESSAGES --threads THREADS [file]
#
#Loads synthetic data for testing
#
#positional arguments:
#  file                   service configuration file
#
#optional arguments:
#  -h, --help             show this help message and exit
#  --users USERS
#  --maxfollows MAXFOLLOWS
#  --messages MESSAGES
#  --threads THREADS
