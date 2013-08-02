# This include and extend statement below should only exists if
# using apache

include:
  - states.www.apache

phpmyadmin:
  pkg.installed:
    - name: phpmyadmin
    - require:
      - pkg: php5
      - pkg: apache2


phpmyadmin_apache:
  file.managed:
    - source: salt://states/tools/phpmyadmin/etc/apache2/sites-available/phpmyadmin
    - name: /etc/apache2/sites-available/phpmyadmin
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - defaults:
       server_name: {{ "phpmyadmin.dev" if pillar['phpmyadmin']['server_name'] is not defined else pillar['phpmyadmin']['server_name'] }}
       server_admin: {{ "admin@server.dev" if pillar['phpmyadmin']['server_admin'] is not defined else pillar['phpmyadmin']['server_admin'] }}
       allow_from: {{ "127.0.0.1" if pillar['phpmyadmin']['allow_from'] is not defined else pillar['phpmyadmin']['allow_from'] }}
       logs_dir: {{ "/home/vagrant" if pillar['phpmyadmin']['logs_dir'] is not defined else pillar['phpmyadmin']['logs_dir'] }}
    - require:
      - pkg: phpmyadmin

phpmyadmin_apache-enable:
  file.symlink:
    - name: /etc/apache2/sites-enabled/phpmyadmin
    - target: /etc/apache2/sites-available/phpmyadmin
    - require:
      - file: phpmyadmin_apache

extend:
  apache2:
    service:
      - running
      - watch:
        - file: /etc/apache2/sites-available/phpmyadmin
        - pkg: phpmyadmin
