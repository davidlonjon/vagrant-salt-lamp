# This include and extend statement below should only exists if
# using apache
include:
  - states.www.apache2

default_vhost_apache:
  file:
    - managed
    - source: salt://states/virtualhosts/etc/apache2/sites-available/default_vhost.conf
    - name: /etc/apache2/sites-available/default_vhost.conf
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - defaults:
       server_admin: {{ "admin@project.dev" if pillar['default_vhost']['server_admin'] is not defined else pillar['default_vhost']['server_admin'] }}
       server_name: {{ "project.dev" if pillar['default_vhost']['server_name'] is not defined else pillar['default_vhost']['server_name'] }}
       doc_root: {{ "/home/vagrant/projects/project.dev/public" if pillar['default_vhost']['doc_root'] is not defined else pillar['default_vhost']['doc_root'] }}
       allow_override: {{ "None" if pillar['default_vhost']['allow_override'] is not defined else pillar['default_vhost']['allow_override'] }}
       allow_from: {{ "All" if pillar['default_vhost']['allow_from'] is not defined else pillar['default_vhost']['allow_from'] }}
       logs_dir: {{ "/home/vagrant" if pillar['default_vhost']['logs_dir'] is not defined else pillar['default_vhost']['logs_dir'] }}
    - require:
      - pkg: apache2
      - file: vhost_doc_root

vhost_doc_root:
  file:
    - directory
    - makedirs: True
    - name: {{ "/home/vagrant/projects/project.dev/public" if pillar['default_vhost']['doc_root'] is not defined else pillar['default_vhost']['doc_root'] }}
    - dir_mode: 0755
    - mode: 0644

default_vhost_index:
  file:
    - managed
    - source: salt://files/default_vhost_index.php
    - name: {{ "/home/vagrant/projects/project.dev/public" if pillar['default_vhost']['doc_root'] is not defined else pillar['default_vhost']['doc_root'] }}/index.php
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
      - file: default_vhost_apache
      - file: vhost_doc_root

default_host_apache_enable:
  file:
    - symlink
    - name: /etc/apache2/sites-enabled/default_vhost.conf
    - target: /etc/apache2/sites-available/default_vhost.conf
    - require:
      - file: default_vhost_apache

extend:
  apache2:
    service:
      - running
      - watch:
        - file: /etc/apache2/sites-available/default_vhost.conf
