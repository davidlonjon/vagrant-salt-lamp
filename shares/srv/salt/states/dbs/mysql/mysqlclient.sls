mysqlclient:
  pkg.installed:
    - name: {{ "mysqlclient" if pillar["mysql-version"] is not defined else "mysql-client-%s" % pillar["mysql-version"] }}
