/var/www/index.php:
  file:
    - managed
    - source: salt://states/setup/default_var_www/var/www/index.php
    - name: /var/www/index.php
    - template: jinja
    - makedirs: True
    - mode: 644
    - defaults:
        mysql_username: {{ "root" if pillar["mysql_server"]["root_username"] is not defined else pillar["mysql_server"]["root_username"] }}
        mysql_password: {{ "root" if pillar["mysql_server"]["root_password"] is not defined else pillar["mysql_server"]["root_password"] }}
        mysql_host: {{ "localhost" if pillar["mysql_server"]["bind_address"] is not defined else pillar["mysql_server"]["bind_address"] }}
        memcached_host: {{ "localhost" if pillar["memcached"]["host"] is not defined else pillar["memcached"]["host"] }}
        memcached_port: {{ "11211" if pillar["memcached"]["port"] is not defined else pillar["memcached"]["port"] }}
    - require:
      - pkg: apache2

/var/www/phpinfo.php:
  file:
    - managed
    - source: salt://states/setup/default_var_www/var/www/phpinfo.php
    - name: /var/www/phpinfo.php
    - makedirs: True
    - mode: 644
    - require:
      - pkg: apache2
