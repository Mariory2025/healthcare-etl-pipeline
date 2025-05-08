import pandas as pd
from sql_connection import get_sql_server_connection
from logging_util import setup_logger
import os

# Set up logger specific to this module
logger = setup_logger("load_medications")

def load_medications(csv_path):
    try:
        logger.info("Reading CSV file...")
        df = pd.read_csv(csv_path)

        df.rename(columns={
            'PATIENT': 'PatientID',
            'ENCOUNTER': 'EncounterID',
            'DESCRIPTION': 'MedicationName',
            'BASE_COST': 'Dosage',
            'START': 'StartDate',
            'STOP': 'EndDate'
        }, inplace=True)

        df.fillna('', inplace=True)

        logger.info("Connecting to SQL Server...")
        conn = get_sql_server_connection()
        cursor = conn.cursor()

        insert_sql = '''
        INSERT INTO mil.Medications (PatientID, EncounterID, MedicationName, Dosage, StartDate, EndDate)
        VALUES (?, ?, ?, ?, ?, ?)
        '''

        inserted_rows = 0

        for _, row in df.iterrows():
            try:
                cursor.execute(insert_sql, (
                    row['PatientID'],
                    row['EncounterID'],
                    row['MedicationName'],
                    str(row['Dosage']),
                    row['StartDate'],
                    row['EndDate']
                ))
                inserted_rows += 1
            except Exception as e:
                logger.error(f"❌ Error inserting MedicationID: {e}")

        conn.commit()
        logger.info(f"✅ Successfully inserted {inserted_rows} rows.")
        cursor.close()
        conn.close()
        logger.info("Connection closed.")

    except Exception as e:
        logger.critical(f"🛑 ETL process failed: {e}")
        print(f"❌ Critical error: {e}")

if __name__ == '__main__':
    load_medications('../data/raw/medications.csv')
