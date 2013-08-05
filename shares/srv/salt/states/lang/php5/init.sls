include:
  - states.www.apache

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
    - php5-xdebug
  - require:
    - pkg: apache2
    - pkg: mysql-server

/etc/php5/conf.d/xdebug.ini:
  file:
    - managed
    - source: salt://states/lang/php5/etc/php5/conf.d/xdebug.ini
    - template: jinja
    - mode: 644
    - require:
      - pkg: php5

extend:
  apache2:
    service:
      - running
      - watch:
        - file: /etc/php5/conf.d/xdebug.ini
