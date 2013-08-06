include:
  - states.www.apache2

php-apc:
  pkg:
    - installed
  require:
    - pkg: php5

apc.ini:
  file:
    - managed
    - source: salt://states/caches/apc/etc/php5/conf.d/apc.ini
    - name: /etc/php5/conf.d/apc.ini
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - defaults:
       memory: {{ "32"  if pillar['apc']['memory'] is not defined else pillar['apc']['memory'] }}
    - require:
      - pkg: php-apc

extend:
  apache2:
    service:
      - running
      - watch:
        - pkg: php-apc
        - file: apc.ini
