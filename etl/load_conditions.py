import pandas as pd
from sql_connection import get_sql_server_connection
from logging_util import setup_logger
import os

# Set up logger specific to this module
logger = setup_logger("load_conditions")

def load_conditions(csv_path):
    try:
        logger.info("Reading CSV file...")
        # Read the CSV into a DataFrame
        df = pd.read_csv(csv_path)

        # Rename columns to match SQL schema
        df.rename(columns={
            'PATIENT': 'PatientID',
            'ENCOUNTER': 'EncounterID',
            'CODE': 'Code',
            'DESCRIPTION': 'Description',
            'START': 'OnsetDate'
        }, inplace=True)

        # Fill missing values if needed
        df.fillna('', inplace=True)

        # Connect to SQL Server
        logger.info("Connecting to SQL Server...")
        conn = get_sql_server_connection()
        cursor = conn.cursor()

        # Insert rows one-by-one (batching or bulk load can be added later)
        insert_sql = '''
        INSERT INTO mil.Conditions (PatientID, EncounterID, Code, Description, OnsetDate)
        VALUES (?, ?, ?, ?, ?)
        '''

        inserted_rows = 0

        for _, row in df.iterrows():
            try:
                cursor.execute(insert_sql, (
                    row['PatientID'],
                    row['EncounterID'],
                    row['Code'],
                    row['Description'],
                    row['OnsetDate']
                ))
                inserted_rows += 1
            except Exception as e:
                logger.error(f"❌ Error inserting Condition: {e}")

        conn.commit()
        logger.info(f"✅ Successfully inserted {inserted_rows} rows.")
        cursor.close()
        conn.close()
        logger.info("Connection closed.")

    except Exception as e:
        logger.critical(f"🛑 ETL process failed: {e}")
        print(f"❌ Critical error: {e}")

if __name__ == '__main__':
    load_conditions('../data/raw/conditions.csv')
