install_webgrind:
    cmd:
        - run
        - name: 'wget -qO- -O webgrind.zip https://webgrind.googlecode.com/files/webgrind-release-1.0.zip && unzip webgrind.zip && rm webgrind.zip'
        - cwd: /home/vagrant
        - unless: test -e /var/www/webgrind
        - require:
            - pkg: wget
            - pkg: unzip

mv_webgrind:
    cmd:
        - run
        - name: 'mv webgrind /var/www/'
        - cwd: /home/vagrant
        - unless: test -e /var/www/webgrind
        - require:
            - cmd: install_webgrind

webgrind_config.php:
  file:
    - managed
    - source: salt://states/tools/webgrind/var/www/webgrind/config.php
    - name: /var/www/webgrind/config.php
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - defaults:
       timezone: {{ "Europe/Copenhagen" if pillar['timezone'] is not defined else pillar['timezone'] }}
    - require:
      - cmd: install_webgrind
      - cmd: mv_webgrind
