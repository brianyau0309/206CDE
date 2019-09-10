import cx_Oracle
conn = cx_Oracle.connect('')

print('Start')
print('Oracle Version', conn.version)
cur = conn.cursor()

cur.execute('SELECT * FROM staff')

for row in cur.fetchall():
    print(row)

print('Finsih')

conn.close;
