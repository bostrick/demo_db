#!/bin/bash
set -x

sleep 5
psql -U postgres -h db < create.sql

F=development.ini

if [ "$CONTAINER_DEBUG"x != x ]; then
    sleep 999999999
fi

if [ "$POSTGRESQL_SERVICE_HOST"x != x ]; then
    export PYRAMID_SQLALCHEMY_URL="postgresql+psycopg2://bowe:$DEMODB_password@$POSTGRESQL_SERVICE_HOST/demo_db"
fi

if [ "$PYRAMID_SQLALCHEMY_URL"x != x ]; then
  sed "/^sqlalchemy/s;=.*;= $PYRAMID_SQLALCHEMY_URL;" $F > $F.run.ini 
else
  cp $F $F.run.ini
fi

initialize_demo_db_db $F.run.ini

pserve $F.run.ini
