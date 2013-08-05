mysql-client:
  pkg:
    - installed
    - name: {{ "mysql-client" if pillar["mysql-version"] is not defined else "mysql-client-%s" % pillar["mysql-version"] }}
