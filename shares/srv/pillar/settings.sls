phpmyadmin:
  server_name: phpmyadmin.project.dev
  server_admin: admin@project.dev
  allow_from: 20.20.20.0/24
  logs_dir: /home/vagrant/www_logs

default_vhost:
  server_name: project.dev
  doc_rot:  /home/vagrant/projects/project.dev/public
  server_admin: admin@project.dev
  allow_override: All
  allow_from: All
  logs_dir: /home/vagrant/www_logs

mysql_server:
  root_username: root
  root_password: root
  bind_address: 127.0.0.1
  version: 5.5

memcached:
  memory: 128
  host: 127.0.0.1
  port: 11211

apc:
  memory: 64
