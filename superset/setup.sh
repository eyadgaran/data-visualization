# Base script to set up superset
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# (OPTIONAL) Step 0 - Download latest conda (swap out link for different systems)
cd /tmp
curl -O https://repo.continuum.io/miniconda/Miniconda2-latest-MacOSX-x86_64.sh
bash Miniconda2-latest-MacOSX-x86_64.sh -f

# Step 1 - Create python env
cd $CURRENT_DIR
conda create -n superset -f conda_requirements.yaml
source activate superset

# Step 2 - update Superset to latest version
pip install superset --upgrade

# Step 3 - add config file to python path
PYTHON_PATH="$(dirname `which python`)"
ENV_PATH="$(dirname $PYTHON_PATH)"
echo $CURRENT_DIR > $ENV_PATH/lib/python2.7/site-packages/superset.pth

# Step 4 - Save Credentials
CNF_FILE=$CURRENT_DIR/secrets.cnf
echo [superset] >> $CNF_FILE
echo host = localhost >> $CNF_FILE
echo user = superset >> $CNF_FILE
read -p "Enter Password: " pswd
echo password = $pswd >> $CNF_FILE
echo database = caravel >> $CNF_FILE
echo port = 5432 >> $CNF_FILE

# Step 5 - Set up database
psql -c "CREATE USER superset WITH PASSWORD '$pswd';"
createdb -O superset superset

# Step 6 - Configure superset
fabmanager create-admin --app superset
superset db upgrade
superset init
