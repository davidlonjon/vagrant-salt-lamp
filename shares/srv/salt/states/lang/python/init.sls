python:
  pkg:
  - installed
  - pkgs:
    - python
    - python-software-properties

python-pip:
  pkg.installed:
    - require:
      - pkg: python
