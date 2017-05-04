https://www.postgresql.org/download/

http://www.postgresqltutorial.com/postgresql-sample-database/

Yukarıdaki adresten database indirilten sonra powershell'de aşağıdaki komutlar çalıştırılır.

Windows Path'de Postgres Bin klasörü tanımlı olmalı. (C:\Program Files\PostgreSQL\9.6\bin)

createdb dvdrental

pg_restore -d dvdrental C:\dvdrental.tar

psql dvdrental

\dt