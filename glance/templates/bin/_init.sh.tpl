#!/bin/bash
set -ex
export HOME=/tmp

ansible localhost -vvv -m mysql_db -a "login_host='{{ .Values.database.address }}' \
login_port='{{ .Values.database.port }}' \
login_user='{{ .Values.database.root_user }}' \
login_password='{{ .Values.database.root_password }}' \
name='{{ .Values.database.glance_database_name }}'"

ansible localhost -vvv -m mysql_user -a "login_host='{{ .Values.database.address }}' \
login_port='{{ .Values.database.port }}' \
login_user='{{ .Values.database.root_user }}' \
login_password='{{ .Values.database.root_password }}' \
name='{{ .Values.database.glance_user }}' \
password='{{ .Values.database.glance_password }}' \
host='%' priv='{{ .Values.database.glance_database_name }}.*:ALL' append_privs='yes'"
