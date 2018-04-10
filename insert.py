#!/bin/python
import os
import psycopg2

match_id = os.environ['MATCH_ID']
connection_string = os.environ['CONNECTION_STRING']

with open('export.json') as f:
    match_data = f.read()
    conn = psycopg2.connect(connection_string)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO results (match_id, match_data) VALUES (%(match_id)s, %(match_data)s)", {"match_data": match_data, "match_id": match_id})
    conn.commit()

