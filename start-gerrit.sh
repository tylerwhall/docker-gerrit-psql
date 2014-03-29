#!/bin/bash

set -x
set -e

if [ ! -e $GERRIT_HOME/initialized ]; then
    mkdir -p $GERRIT_HOME/etc
    git config --file $GERRIT_HOME/etc/gerrit.config database.type 'Postgresql'
    git config --file $GERRIT_HOME/etc/gerrit.config database.hostname $DB_PORT_5432_TCP_ADDR
    git config --file $GERRIT_HOME/etc/gerrit.config database.port $DB_PORT_5432_TCP_PORT
    git config --file $GERRIT_HOME/etc/gerrit.config database.database $POSTGRESQL_DB
    git config --file $GERRIT_HOME/etc/gerrit.config database.username $POSTGRESQL_USER
    git config --file $GERRIT_HOME/etc/gerrit.config database.password $POSTGRESQL_PASS
    git config --file $GERRIT_HOME/etc/gerrit.config gitweb.cgi /usr/lib/cgi-bin/gitweb.cgi
    git config --file $GERRIT_HOME/etc/gerrit.config --unset gitweb.url || true
    java -jar $GERRIT_HOME/gerrit.war init --batch -d $GERRIT_HOME
    touch $GERRIT_HOME/initialized
fi
exec $GERRIT_HOME/bin/gerrit.sh run
