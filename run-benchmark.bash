#! /bin/bash

resultsFile="socialite-results.csv"
rm -f $resultsFile

CSVLIST="follow.csv friends_of_friends_agg.csv friends_of_friends_query.csv get_follower_count.csv get_followers.csv read_timeline.csv scroll_timeline.csv send_content.csv unfollow.csv"

source config-blog-small.config

rm -f ${SOCIALITE_CSV_DIRECTORY}/*.csv

java -jar ./target/socialite-0.0.1-SNAPSHOT.jar benchmark --session_duration $SOCIALITE_SESSION_DURATION --total_users $SOCIALITE_USERS --active_users $SOCIALITE_ACTIVE_USERS --concurrency $SOCIALITE_CONCURRENCY \
  --follow_pct $SOCIALITE_FOLLOW_PCT --unfollow_pct $SOCIALITE_UNFOLLOW_PCT --read_timeline_pct $SOCIALITE_READ_TIMELINE_PCT --scroll_timeline_pct $SOCIALITE_SCROLL_TIMELINE_PCT \
  --target_rate $SOCIALITE_TARGET_RATE --duration $SOCIALITE_DURATION --send_content_pct $SOCIALITE_SEND_CONTENT_PCT --fof_agg_pct $SOCIALITE_FOF_AGG_PCT --fof_query_pct $SOCIALITE_FOF_QUERY_PCT --csv $SOCIALITE_CSV_DIRECTORY $SOCIALITE_YML

echo "creating results file $resultsFile"
for thisCsv in $CSVLIST; do
    #echo $thisCsv
    # create a header
    if [ $thisCsv == "follow.csv" ]; then
        thisLine=`head -n1 ${SOCIALITE_CSV_DIRECTORY}/${thisCsv}`
	echo "test,${thisLine}" >> $resultsFile
    fi

    thisLine=`tail -n5 ${SOCIALITE_CSV_DIRECTORY}/${thisCsv} | head -n1`
    echo "${thisCsv},${thisLine}" >> $resultsFile
done

cat $resultsFile

#echo $SOCIALITE_YML

# --target_rate

# transaction mixes
# -----------------
# --follow_pct [0..1]
# --unfollow_pct [0..1]
# --read_own_timeline_pct [0..1]
# --read_timeline_pct [0..1]
# --scroll_timeline_pct [0..1]
# --send_content_pct [0..1]

#usage: java -jar socialite-0.0.1-SNAPSHOT.jar
#       benchmark [-h] --total_users TOTAL_USERS --active_users ACTIVE_USERS --session_duration SESSION_DURATION [--concurrency CONCURRENCY] [--target_rate TARGET_RATE] [--follow_pct FOLLOW_PCT] [--unfollow_pct UNFOLLOW_PCT] [--read_timeline_pct READ_TIMELINE_PCT]
#       [--scroll_timeline_pct SCROLL_TIMELINE_PCT] [--send_content_pct SEND_CONTENT_PCT] [--fof_agg_pct FOF_AGG_PCT] [--fof_query_pct FOF_QUERY_PCT] [--duration DURATION] [--csv CSV] [file]
#
#Runs a synthetic workload benchmark
#
#positional arguments:
#  file                   service configuration file
#
#optional arguments:
#  -h, --help             show this help message and exit
#  --total_users TOTAL_USERS
#                         Total number of users that exist
#  --active_users ACTIVE_USERS
#                         Number of concurrently active users
#  --session_duration SESSION_DURATION
#                         The number of operations a user performs during a session (default: 25)
#  --concurrency CONCURRENCY
#                         The number of simultaneous requests that can be sent at a time (default: 16)
#  --target_rate TARGET_RATE
#                         The number of operations per second the workload should generate (default: 0)
#  --follow_pct FOLLOW_PCT
#                         Follow transaction percent (default: 0.0)
#  --unfollow_pct UNFOLLOW_PCT
#                         Unfollow transaction percent (default: 0.0)
#  --read_timeline_pct READ_TIMELINE_PCT
#                         Read timeline transaction percent (default: 0.0)
#  --scroll_timeline_pct SCROLL_TIMELINE_PCT
#                         Scroll timeline transaction percent (default: 0.0)
#  --send_content_pct SEND_CONTENT_PCT
#                         Send content percent (default: 0.0)
#  --fof_agg_pct FOF_AGG_PCT
#                         Percent of operations which gather the friends of friends using aggregation (default: 0.0)
#  --fof_query_pct FOF_QUERY_PCT
#                         Percent of operations which gather the friends of friends using queries (default: 0.0)
#  --duration DURATION    How long the test should run for in seconds (default: 10)
#  --csv CSV              A directory where CSV files will be output, 1 per transaction type

