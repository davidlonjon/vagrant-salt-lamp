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
       host: {{ "127.0.0.1"  if pillar['memcached']['host'] is not defined else pillar['memcached']['host'] }}
       port: {{ "11211"  if pillar['memcached']['port'] is not defined else pillar['memcached']['port'] }}
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
