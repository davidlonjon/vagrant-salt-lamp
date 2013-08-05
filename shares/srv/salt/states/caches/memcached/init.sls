include:
  - states.www.apache2

memcached:
  pkg:
    - installed
  require:
    - pkg: build-essential
  service:
    - name: memcached
    - running
    - require:
      - pkg: memcached
    - watch:
      - file: /etc/php5/conf.d/memcached.ini
      - file: /etc/memcached.conf

memcached.conf:
  file:
    - managed
    - source: salt://states/caches/memcached/etc/memcached.conf
    - name: /etc/memcached.conf
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - defaults:
       memory: {{ "64"  if pillar['memcached']['memory'] is not defined else pillar['memcached']['memory'] }}
    - require:
      - pkg: memcached

php5-memcached:
  pkg:
    - installed
  require:
    - pkg: memcached

memcached.ini:
  file:
    - managed
    - source: salt://states/caches/memcached/etc/php5/conf.d/memcached.ini
    - name: /etc/php5/conf.d/memcached.ini
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - require:
      - pkg: memcached
      - pkg: php5-memcached

extend:
  apache2:
    service:
      - running
      - watch:
        - file: /etc/php5/conf.d/memcached.ini
