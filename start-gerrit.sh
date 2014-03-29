#!/bin/sh

git config --file $GERRIT_HOME/etc/gerrit.config database.type 'Postgresql'
git config --file $GERRIT_HOME/etc/gerrit.config database.hostname $DB_PORT_5432_TCP_ADDR
git config --file $GERRIT_HOME/etc/gerrit.config database.port $DB_PORT_5432_TCP_PORT
git config --file $GERRIT_HOME/etc/gerrit.config database.database $POSTGRESQL_DB
git config --file $GERRIT_HOME/etc/gerrit.config database.username $POSTGRESQL_USER
git config --file $GERRIT_HOME/etc/gerrit.config database.password $POSTGRESQL_PASS
java -jar $GERRIT_HOME/bin/gerrit.war init -d $GERRIT_HOME
exec $GERRIT_HOME/bin/gerrit.sh run
