#!/bin/bash
set -x

F=development.ini

if [ "$CONTAINER_DEBUG"x != x ]; then
    sleep 999999999
fi

if [ "$PYRAMID_SQLALCHEMY_URL"x != x ]; then
  sed "/^sqlalchemy/s;=.*;= $PYRAMID_SQLALCHEMY_URL;" $F > $F.run.ini 
else
  cp $F $F.run.ini
fi

pserve $F.run.ini
