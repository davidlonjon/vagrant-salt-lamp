capistrano:
  cmd:
    - run
    - name: gem install capistrano
    - unless: test -e /usr/local/rvm/gems/ruby-1.9.3-p448/bin/cap
    - require:
      - rvm: mygemset
