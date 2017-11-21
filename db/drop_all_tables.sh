#!/bin/zsh

RETRIEVE_TABLES_COMMAND="SELECT '#' || string_agg(table_name, ',') \
                         FROM information_schema.tables \
                         WHERE table_schema='public'"

TABLES=`heroku pg:psql --command $RETRIEVE_TABLES_COMMAND --app=hackathon-api-server \
        | sed -n 's/[^#]*#//p'`

# echo "Retrieved: $TABLES"

for t ("${(s/,/)TABLES}"); do
  echo "Dropping ${t}"
  heroku pg:psql --command "DROP TABLE IF EXISTS ${t} CASCADE" --app=hackathon-api-server
done