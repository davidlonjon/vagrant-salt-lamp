install_composer:
    cmd:
        - run
        - name: 'curl -sS https://getcomposer.org/installer | php'
        - cwd: /home/vagrant
        - require:
            - pkg: php5

mv_composer:
    cmd:
        - run
        - name: 'mv composer.phar /usr/local/bin/composer'
        - cwd: /home/vagrant
        - require:
            - cmd: install_composer
