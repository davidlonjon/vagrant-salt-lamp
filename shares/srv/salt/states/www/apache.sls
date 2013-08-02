apache2:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: apache2

apache2-php-packages:
    pkg:
        - installed
        - names:
            - libapache2-mod-php5

a2enmod rewrite:
    cmd:
        - run
        - require:
            - service: apache2
