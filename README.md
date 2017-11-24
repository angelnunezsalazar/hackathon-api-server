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

	$ heroku pg:psql

Consultar todas las tablas

	$ SELECT table_name FROM information_schema.tables WHERE table_schema='public';

Consultar todas las columnas de una tabla

	$ select column_name from information_schema.columns where table_name = 'TABLA';
