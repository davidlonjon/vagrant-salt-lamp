# compass:
#   cmd:
#     - run
#     - name: gem install compass
#     - unless: test -e /usr/local/rvm/gems/ruby-1.9.3-p448/bin/compass
#     - require:
#       - rvm: mygemset

compass:
  gem:
    - installed
    - ruby: ruby-1.9.3
    - require:
      - rvm: ruby-1.9.3
