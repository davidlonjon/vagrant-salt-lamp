phpmyadmin:
  server_name: phpmyadmin.project.dev
  server_admin: admin@project.dev
  allow_from: 20.20.20.0/24
  logs_dir: /home/vagrant/www_logs

mysql_server:
  root_username: root
  root_password: root
  bind_address: 127.0.0.1
  version: 5.5
