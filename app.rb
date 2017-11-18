require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
Dir[File.join(File.dirname(__FILE__), 'model', '*.rb')].each {|file| require file }

get '/' do
    return "Bienvenido"
end

get '/obtenerdatoscliente' do
    numero_documento = params['numeroDocumento']
    cliente = Cliente.find_by(numero_documento: numero_documento)
    return cliente.json
end

post '/crearcliente' do
    payload = JSON.parse(request.body.read)
    cliente=Cliente.new
    cliente.numero_documento=payload['numeroDocumento']
    cliente.codigo_unico=payload['numeroDocumento'].rjust(10, '0')
    cliente.json=payload.to_json
    cliente.save  
    return {:codigoUnicoCliente => cliente.codigo_unico}.to_json
end

get '/consultarsaldos' do
    codigo_unico_cliente = params['codigoUnicoCliente']
    cuentas = Cuenta.where(codigo_unico_cliente: codigo_unico_cliente)
    cuentas_hash = cuentas.map { |c| 
        cuenta=JSON.parse(c.json)
        cuenta["numeroCuenta"]=c.numero_cuenta
        cuenta
    }
    return cuentas_hash.to_json
end

post '/crearcuenta' do
    payload = JSON.parse(request.body.read)  
    cuenta=Cuenta.new
    cuenta.codigo_unico_cliente=payload['codigoUnicoCliente']
    cuenta.numero_cuenta=rand.to_s[2..11]
    cuenta.json=payload.to_json
    cuenta.save
    return {"numeroCuenta" => cuenta.numero_cuenta}.to_json
end

post '/transferencia' do
    resp = File.read("apis/transferencia/response.json")
end 

