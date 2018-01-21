# Base script to configure metabase
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Step 1 - Download latest version (update as needed)
cd $CURRENT_DIR
curl -O http://downloads.metabase.com/v0.27.2/metabase.jar
