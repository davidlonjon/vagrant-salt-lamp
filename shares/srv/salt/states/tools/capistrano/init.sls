compass:
  cmd:
    - run
    - name: gem install compass
    - unless: test -e /usr/local/rvm/gems/ruby-1.9.3-p448/bin/compass
    - require:
      - rvm: mygemset
