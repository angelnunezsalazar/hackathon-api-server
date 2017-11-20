# hackathon-api-server

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
	$ heroku run rake db:migrate VERSION=0 --app hackathon-api-server
	$ heroku run rake db:migrate --app hackathon-api-server
	$ heroku run rake db:seed --app hackathon-api-server

- Ver los logs

	$ heroku logs --app hackathon-api-server