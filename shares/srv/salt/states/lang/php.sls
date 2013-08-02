php5:
  pkg.installed:
    - pkgs:
      - php5
      - php5-mysql
      - php5-cli
      - php5-dev
      - php5-gd
      - php5-curl
      - php-pear
      - php5-mcrypt
      - php5-intl
    - require:
      - pkg: apache2
      - pkg: mysql-server
