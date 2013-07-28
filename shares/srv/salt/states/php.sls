php5:
  pkg.installed:
    - pkgs:
      - php5
      - php5-mysql
      - php5-cli
      - php5-dev
      - libapache2-mod-php5
      - php5-mysql
      - php5-gd
      - php5-curl
      - php-pear
      - php5-memcache
    - require:
      - pkg: mysqlclient
      - pkg: apache2
