# Inspired from https://github.com/tony/salt-states-configs

mysql-server:
  pkg.installed:
    - name: {{ "mysql-server" if pillar["mysql_server"]["version"] is not defined else "mysql-server-%s" % pillar["mysql_server"]["version"] }}
  service.running:
    - name: mysql
    - require:
      - pkg: mysql-server

# Note this work on the first time but after it fails.
# This is only a problem if you want to set up the password again via salt
mysql-db:
  mysql_user.present:
    - name: {{ "root" if pillar["mysql_server"]["root_username"] is not defined else pillar["mysql_server"]["root_username"] }}
    - password: {{ "root" if pillar["mysql_server"]["root_password"] is not defined else pillar["mysql_server"]["root_password"] }}
    - host: localhost
  mysql_grants.present:
    - database: mysql.*
    - user: {{ "root" if pillar["mysql_server"]["root_username"] is not defined else pillar["mysql_server"]["root_username"] }}
    - host: localhost
    - grant: ALL PRIVILEGES
  require:
    - pkg: python-mysqldb
    - service: mysql

python-mysqldb:
  pkg.installed

/etc/mysql/my.cnf:
    file:
        - managed
        - source: salt://states/dbs/mysql/etc/mysql/my.cnf
        - template: jinja
        - mode: 644
        - require:
            - pkg: mysql-server
        - defaults:
            port: {{ "3306" if pillar["mysql_server"]["port"] is not defined else pillar["mysql_server"]["port"] }}
            bind_address: {{ "127.0.0.1" if pillar["mysql_server"]["bind_address"] is not defined else pillar["mysql_server"]["bind_address"] }}

/etc/mysql/conf.d:
  file.directory:
    - dir_mode: 0755
    - mode: 0644

/etc/mysql/conf.d/server-encoding-and-collation.cnf:
  file.managed:
    - mode: 0644
    - source: salt://states/dbs/mysql/etc/mysql/conf.d/server-encoding-and-collation.cnf
    - require:
      - pkg: mysql-server
    - watch_in:
      - service: mysql-server
    - require_in:
      - file: /etc/mysql/conf.d

/etc/mysql/conf.d/default-table-engine.cnf:
  file.managed:
    - mode: 0644
    - source: salt://states/dbs/mysql/etc/mysql/conf.d/default-table-engine.cnf
    - require:
      - pkg: mysql-server
    - watch_in:
      - service: mysql-server
    - require_in:
      - file: /etc/mysql/conf.d
