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
    cuentas = Cuenta.where(codigo_unico_cliente: params['codigoUnicoCliente']) if params.has_key?('codigoUnicoCliente')
    cuentas = Cuenta.where(numero_cuenta: params['numeroCuenta']) if params.has_key?('numeroCuenta')
    cuentas_hash = cuentas.map { |c| 
        cuenta=JSON.parse(c.json)
        cuenta["numeroCuenta"]=c.numero_cuenta
        cuenta["saldoContable"]=c.saldo
        cuenta["saldoDisponible"]=c.saldo
        cuenta
    }
    return cuentas_hash.to_json
end

post '/crearcuenta' do
    payload = JSON.parse(request.body.read)  
    cuenta=Cuenta.new
    cuenta.codigo_unico_cliente=payload['codigoUnicoCliente']
    cuenta.numero_cuenta=rand.to_s[2..14]
    cuenta.saldo=0
    cuenta.json=payload.to_json
    cuenta.save
    return {"numeroCuenta" => cuenta.numero_cuenta}.to_json
end

post '/transferencia' do
    payload = JSON.parse(request.body.read)
    puts payload
    cuenta_cargo = Cuenta.find_by(numero_cuenta: payload['numeroCuentaCargo'])
    cuenta_cargo.saldo = cuenta_cargo.saldo - payload['importeCargo'].to_i
    cuenta_abono = Cuenta.find_by(numero_cuenta: payload['numeroCuentaAbono'])
    cuenta_abono.saldo=cuenta_abono.saldo + payload['importeAbono'].to_i
    cuenta_cargo.transaction do
        cuenta_cargo.save
        cuenta_abono.save
    end
    return {"numOperacion" => rand.to_s[2..8]}.to_json
end 

post '/altatarjeta' do
    payload = JSON.parse(request.body.read)  
    tarjeta=Tarjeta.new
    tarjeta.codigo_unico_cliente=payload['codigoUnicoCliente']
    tarjeta.numero_tarjeta=rand.to_s[2..17]
    tarjeta.numero_cuenta=rand.to_s[2..14]
    tarjeta.fecha_alta=Time.now.strftime("%Y-%m-%d")
    tarjeta.fecha_vencimiento=(Time.now+5.years).strftime("%Y-%m-%d")
    tarjeta.json=payload.to_json
    tarjeta.save
    return {"numeroTarjeta" => tarjeta.numero_cuenta,
            "numeroCuenta" => tarjeta.numero_tarjeta,
            "fechaAlta" => tarjeta.fecha_alta,
            "fechaVencimiento" => tarjeta.fecha_vencimiento}.to_json
end
