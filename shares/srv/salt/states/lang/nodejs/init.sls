nodejs-ppa:
  cmd:
    - run
    - name: add-apt-repository -y ppa:chris-lea/node.js
    - unless: test -f /etc/apt/sources.list.d/chris-lea-node_js-{{ grains['oscodename'] }}.list

apt-get-update:
  cmd:
    - run
    - name: apt-get update
    - require:
      - cmd: nodejs-ppa

nodejs:
  pkg:
    - installed
    - name: nodejs
    - require:
      - cmd: nodejs-ppa
      - cmd: apt-get-update
      - pkg: python
      - pkg: g++
      - pkg: make

# npm:
#   pkg:
#     - installed
#     - require:
#       - pkg: nodejs
