import pyodbc

def get_sql_server_connection():
    DRIVER='{ODBC Driver 17 for SQL Server}'
    SERVER=' ' # Specify your SQL Server name here 
    DATABASE='GITHUB_HEALTHCARE_ETL_PROJECT'
    TRUSTED_CONNECTION='yes'

    conn_str = f"""
        DRIVER={DRIVER};
        SERVER={SERVER};
        DATABASE={DATABASE};
        Trusted_Connection={TRUSTED_CONNECTION};
    """
    try:
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        print("❌ Failed to connect to SQL Server:", e)
        raise
