#! /bin/bash

tail csv/*.csv -n1 -q | cut -d ',' -f 14 | awk '{sum += $1} END {print sum}'
