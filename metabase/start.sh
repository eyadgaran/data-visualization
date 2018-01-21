# Base script to startup metabase instance
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOGFILE=$CURRENT_DIR/metabase.log

# Startup
nohup java -jar metabase.jar > $LOGFILE 2>&1 &
