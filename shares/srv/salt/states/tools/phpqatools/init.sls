set_pear_auto_discover:
    cmd:
        - run
        - name: 'pear config-set auto_discover 1'
        - cwd: /home/vagrant
        - unless: test -e /usr/bin/phpunit
        - require:
            - pkg: php5

install_phpqatools:
    cmd:
        - run
        - name: 'pear install pear.phpqatools.org/phpqatools'
        - cwd: /home/vagrant
        - unless: test -e /usr/bin/phpunit
        - require:
            - cmd: set_pear_auto_discover
