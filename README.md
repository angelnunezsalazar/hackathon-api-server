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

- Ejecutar Migraciones

	$ heroku run rake db:migrate --app hackathon-api-server

- Limpiar la data
	$ heroku run rake db:clear --app hackathon-api-server
	$ heroku run rake db:migrate --app hackathon-api-server



Logs
-----------------
- Ver los logs
	$ heroku logs --app hackathon-api-server

Postgresql
------------------
Consultar todas las tablas

	"SELECT table_name FROM information_schema.tables WHERE table_schema='public'"