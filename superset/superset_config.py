#---------------------------------------------------------
# Custom Code
#---------------------------------------------------------
import ConfigParser


def parse_cnf(cnf_section):
    '''
    Uses cnf file in current directory with sections and parameters
    :param cnf_section: section title
    :returns: parameter dictionary (None defaults to empty string)
    '''
    config = ConfigParser.SafeConfigParser(allow_no_value=True)
    config.read("secrets.cnf")
    parameter_dict = dict(config.items(cnf_section))

    return parameter_dict


def create_connection(cnf_section):
    '''
    Creates sqlalchemy connection url
    :param cnf_section: section title
    :returns: sqlalchemy connection url
    '''
    parameter_dict = parse_cnf(cnf_section)

    url = 'postgresql://{user}:{password}@{host}:{port}/{database}'.format(
        **parameter_dict
    )

    return url


#---------------------------------------------------------
# Superset specific config
#---------------------------------------------------------
ROW_LIMIT = 5000
SUPERSET_WORKERS = 4

SUPERSET_WEBSERVER_PORT = 2088
#---------------------------------------------------------

#---------------------------------------------------------
# Flask App Builder configuration
#---------------------------------------------------------
# Your App secret key
SECRET_KEY = '\2\1shhdonttell\1\2\e\y\y\h'

# The SQLAlchemy connection string to your database backend
# This connection defines the path to the database that stores your
# superset metadata (slices, connections, tables, dashboards, ...).
# Note that the connection information to connect to the datasources
# you want to explore are managed directly in the web UI
# SQLALCHEMY_DATABASE_URI = 'sqlite:////path/to/superset.db'
SQLALCHEMY_DATABASE_URI = create_connection('superset')

# Flask-WTF flag for CSRF
CSRF_ENABLED = True

# Set this API key to enable Mapbox visualizations
MAPBOX_API_KEY = ''
