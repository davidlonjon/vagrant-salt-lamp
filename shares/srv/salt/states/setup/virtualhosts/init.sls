# This include and extend statement below should only exists if
# using apache
include:
  - states.www.apache2

default_vhost_apache:
  file:
    - managed
    - source: salt://states/setup/virtualhosts/etc/apache2/sites-available/vhost_template
    - name: /etc/apache2/sites-available/{{ "myproject.dev" if pillar['default_vhost']['server_name'] is not defined else pillar['default_vhost']['server_name'] }}
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - defaults:
       server_admin: {{ "admin@myproject.dev" if pillar['default_vhost']['server_admin'] is not defined else pillar['default_vhost']['server_admin'] }}
       server_name: {{ "myproject.dev" if pillar['default_vhost']['server_name'] is not defined else pillar['default_vhost']['server_name'] }}
       doc_root: {{ "/home/vagrant/projects/myproject.dev/public" if pillar['default_vhost']['doc_root'] is not defined else pillar['default_vhost']['doc_root'] }}
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
    - name: {{ "/home/vagrant/projects/myproject.dev/public" if pillar['default_vhost']['doc_root'] is not defined else pillar['default_vhost']['doc_root'] }}
    - dir_mode: 0755
    - mode: 0644

default_vhost_index:
  file:
    - managed
    - replace: False
    - source: salt://states/setup/virtualhosts/files/index.php
    - name: {{ "/home/vagrant/projects/myproject.dev/public" if pillar['default_vhost']['doc_root'] is not defined else pillar['default_vhost']['doc_root'] }}/index.php
    - makedirs: True
    - mode: 644
    - require:
      - file: default_vhost_apache
      - file: vhost_doc_root

default_host_apache_enable:
  file:
    - symlink
    - name: /etc/apache2/sites-enabled/{{ "myproject.dev" if pillar['default_vhost']['server_name'] is not defined else pillar['default_vhost']['server_name'] }}
    - target: /etc/apache2/sites-available/{{ "myproject.dev" if pillar['default_vhost']['server_name'] is not defined else pillar['default_vhost']['server_name'] }}
    - require:
      - file: default_vhost_apache

extend:
  apache2:
    service:
      - running
      - watch:
        - file: /etc/apache2/sites-available/{{ "myproject.dev" if pillar['default_vhost']['server_name'] is not defined else pillar['default_vhost']['server_name'] }}
