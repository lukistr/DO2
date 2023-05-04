apache:
  pkg.installed:
    - name: 
      - apache2
      - php
      - php-mysql

#apache-conf:
#  apache.configfile:
#    - config:
#      - VirtualHost:
#          this: '*:80'
#          DocumentRoot: /vagrant/site/web
#          Directory:
#            this: /vagrant/site/web
#            Order: Deny,Allow
#            Deny from: all
#            Allow from: all
#            AllowOverride: All

file.managed:
  - name: /var/www/html/index.php
  - source: salt://site/web/index.php
  - require:
    - pkg: apache
    - pkg: php