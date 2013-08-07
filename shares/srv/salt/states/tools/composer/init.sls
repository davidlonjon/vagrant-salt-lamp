install_composer:
    cmd:
        - run
        - name: 'curl -sS https://getcomposer.org/installer | php'
        - cwd: /home/vagrant
        - unless: test -e /usr/local/bin/composer
        - require:
            - pkg: php5
            - pkg: curl

mv_composer:
    cmd:
        - run
        - name: 'mv composer.phar /usr/local/bin/composer'
        - cwd: /home/vagrant
        - unless: test -e /usr/local/bin/composer
        - require:
            - cmd: install_composer
