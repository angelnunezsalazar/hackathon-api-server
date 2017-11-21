require 'rest-client'
require 'json'
require 'factory-helper'

Faker::Config.locale = 'es'
FactoryHelper::Config.locale = 'es'

def crear_cliente(replace_data)
    default_data = JSON.parse(File.read('payloads/crearcliente_request.json'))
    request=default_data.merge!(replace_data)
    puts "Creando Cliente..."
    puts "#{request}"
    response=RestClient.post 'http://localhost:9292/crearcliente', request.to_json
    puts response.body
    puts "...Cliente Creado"
end

crear_cliente({'numeroDocumento'=> '75849346',
'apellidoPaterno'=> Faker::Name.last_name,'apellidoMaterno'=> Faker::Name.last_name,
'primerNombre'=> FactoryHelper::Name.male_first_name,'segundoNombre'=> FactoryHelper::Name.male_first_name,'sexo'=> 'M'})

crear_cliente({'numeroDocumento'=> '56457634',
'apellidoPaterno'=> Faker::Name.last_name,'apellidoMaterno'=> Faker::Name.last_name,
'primerNombre'=> FactoryHelper::Name.male_first_name,'segundoNombre'=> FactoryHelper::Name.male_first_name,'sexo'=> 'M'})

crear_cliente({'numeroDocumento'=> '45348767',
'apellidoPaterno'=> Faker::Name.last_name,'apellidoMaterno'=> Faker::Name.last_name,
'primerNombre'=> FactoryHelper::Name.female_first_name,'segundoNombre'=> FactoryHelper::Name.female_first_name,'sexo'=> 'F'})

crear_cliente({'numeroDocumento'=> '34567456',
'apellidoPaterno'=> Faker::Name.last_name,'apellidoMaterno'=> Faker::Name.last_name,
'primerNombre'=> FactoryHelper::Name.male_first_name,'segundoNombre'=> FactoryHelper::Name.male_first_name,'sexo'=> 'M'})

crear_cliente({'numeroDocumento'=> '34758595',
'apellidoPaterno'=> Faker::Name.last_name,'apellidoMaterno'=> Faker::Name.last_name,
'primerNombre'=> FactoryHelper::Name.female_first_name,'segundoNombre'=> FactoryHelper::Name.female_first_name,'sexo'=> 'F'})