mysql:
  pkg.installed:
    - name: mysql-server

file.managed:
  - name: /vagrant/site/db/db_setup.sql
  - source: salt://site/db/db_setup.sql

cmd.run:
  - name: mysql --default-character-set=utf8 -u root < /vagrant/site/db/db_setup.sql
  - require:
    - file: /vagrant/site/db/db_setup.sql
    - pkg: mysql