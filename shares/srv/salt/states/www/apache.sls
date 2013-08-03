apache2:
  pkg:
    - installed
  service:
    - name: apache2
    - running
    - require:
      - pkg: apache2

apache2-php-packages:
    pkg:
        - installed
        - names:
            - libapache2-mod-php5

a2enmod_rewrite:
    cmd:
        - name: a2enmod rewrite
        - run
        - require:
            - pkg: apache2
        - require_in:
            - service: apache2
