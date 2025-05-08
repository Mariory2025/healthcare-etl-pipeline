import pandas as pd
from sql_connection import get_sql_server_connection
from logging_util import setup_logger
import os

# Set up logger specific to this module
logger = setup_logger("load_encounters")

def load_encounters(csv_path):
    try:
        logger.info("Reading csv file...")
    
        # Read the CSV into a DataFrame
        df = pd.read_csv(csv_path)

        # Rename columns to match SQL schema
        df.rename(columns={
            'Id': 'EncounterID',
            'PATIENT': 'PatientID',
            'START': 'EncounterDate',
            'ENCOUNTERCLASS': 'EncounterType',
            'PROVIDER': 'Provider'
        }, inplace=True)

        # Fill missing values if needed
        df.fillna('', inplace=True)

        # Connect to SQL Server
        logger.info("Connecting to SQL Server...")
        conn = get_sql_server_connection()
        cursor = conn.cursor()

        # Insert rows one-by-one (batching or bulk load can be added later)
        insert_sql = '''
        INSERT INTO mil.Encounters (EncounterID, PatientID, EncounterDate, EncounterType, Provider)
        VALUES (?, ?, ?, ?, ?)
        '''

        inserted_rows = 0

        for _, row in df.iterrows():
            try:
                cursor.execute(insert_sql, (
                    row['EncounterID'],
                    row['PatientID'],
                    row['EncounterDate'],
                    row['EncounterType'],
                    row['Provider']
                ))
                inserted_rows += 1
            except Exception as e:
                logger.error(f"Error inserting EncounterID {row['EncounterID']}: {e}")
        conn.commit()
        logger.info(f"Succesfully inserted {inserted_rows} rows into the Encounters table.")
        print(f"\u2705 Successfully inserted {inserted_rows} rows into the Encounters table.")
        cursor.close()
        conn.close()
        logger.info("Database connection closed.")
    except Exception as e:
        logger.critical(f"ETL process failed: {e}")
        print(f"\u274C Critical error:. {e}")

# Example usage
if __name__ == '__main__':
    load_encounters('../data/raw/encounters.csv')
