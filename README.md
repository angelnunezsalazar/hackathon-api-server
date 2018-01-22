# hackathon-api-server

Ambiente de Trabajo Windows
---------------------------

- Descargar Ruby para Windows: ruby-2.3.3 o ruby-2.3.4

- Descargar el código fuente
https://github.com/snahider/hackathon-api-server

- Descargar Heroku CLI

- Descargar 'bundler' (gestor de paquetes de ruby)
	gem install bundler

Instrucciones
-----------------
- Levantar localmente el web server

	$ rackup

- Desplegar a Heroku

	$ git push origin master

	Heroku extraerá automáticamente los cambios y los desplegará en su plataforma

Actualizar BD
----------------

- Ejecutar Migraciones

	$ heroku run rake db:migrate --app hackathon-api-server

- Reinicializar toda la BD

	$ db/drop_all_tables.sh
	$ heroku run rake db:migrate --app hackathon-api-server

Logs
-----------------
- Logs de la aplicación

	$ heroku logs --app hackathon-api-server

- Logs de la BD

	$ heroku logs --tail --ps postgres --app hackathon-api-server

Postgresql
------------------
Conectarse

	$ heroku pg:psql --app hackathon-api-server

Consultar todas las tablas

	$ SELECT table_name FROM information_schema.tables WHERE table_schema='public';

Consultar todas las columnas de una tabla

	$ select column_name from information_schema.columns where table_name = 'TABLA';

Postgresql Upgrate Heroku
--------------------------
Info de las BD

	$ heroku pg:info --app hackathon-api-server

Mantenimiento

	$ heroku maintenance:on --app hackathon-api-server

Copiar Data

	$ heroku pg:copy DATABASE_URL HEROKU_POSTGRESQL_GRAY_URL --app hackathon-api-server --confirm hackathon-api-server

Promover

	$ heroku pg:promote HEROKU_POSTGRESQL_GRAY_URL --app hackathon-api-server

Exit Mantenimiento

	$ heroku maintenance:off --app hackathon-api-server