#! /bin/bash

cp generic-docdb.yml config.yml
sed -i "s/<username>/${DOCDB_USERNAME}/g" config.yml
sed -i "s/<password>/${DOCDB_PASSWORD}/g" config.yml
sed -i "s/<host>/${DOCDB_HOST}/g" config.yml

cat config.yml
