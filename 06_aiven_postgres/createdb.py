import os
import json
import psycopg2

# Connect to the PostgreSQL database
host = os.environ['POSTGRES_HOST']
database = os.environ['POSTGRES_DATABASE']
user = os.environ['POSTGRES_USER']
password = os.environ['POSTGRES_PASSWORD']
port = os.environ['POSTGRES_PORT']

conn = psycopg2.connect(
    host=host,
    database=database,
    user=user,
    password=password,
    port=port
)

cur = conn.cursor()
#cur.execute("INSERT INTO public.transcrips (filename) VALUES (%s)", ("myfilename"))
cur.execute("INSERT INTO public.transcripts (filename) VALUES ('myfilename')")
conn.commit()



cur = conn.cursor()
# Open the JSONL file and insert each record into the PostgreSQL table
with open('./data/LNL201_5sec_aac_10segments_truncated.json', 'r') as f:
    for line in f:
        record = json.loads(line)
        cur.execute("INSERT INTO public.words (name, age) VALUES (%s, %s)",
                    (record['wordType'], record['age']))
        conn.commit()
conn.commit()



# Close the database connection
cur.close()
conn.close()
