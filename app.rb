require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
Dir[File.join(File.dirname(__FILE__), 'model', '*.rb')].each {|file| require file }

get '/' do
    return "Hackathon API Server running!"
end

get '/clientes/:codigoUnico' do
    cliente = Cliente.find_by(codigo_unico: params['codigoUnico'])
    halt 404, { :message => "Cliente no existe" }.to_json unless cliente.present?
    return cliente.json
end

get '/clientes' do
    cliente = Cliente.find_by(numero_documento: params['numeroDocumento'])
    halt 404, { :message => "Cliente no existe" }.to_json unless cliente.present?
    return cliente.json
end

post '/clientes' do
    payload = JSON.parse(request.body.read)
    cliente=Cliente.new
    cliente.numero_documento=payload['numeroDocumento']
    cliente.codigo_unico=payload['numeroDocumento'].rjust(10, '0')
    cliente.json=payload.to_json
    cliente.save  
    return {:codigoUnicoCliente => cliente.codigo_unico}.to_json
end

get '/cuentas/:numeroCuenta' do
    cuenta = Cuenta.find_by(numero_cuenta: params['numeroCuenta'])
    halt 404, { :message => "Cuenta no existe" }.to_json unless cuenta.present?
    cuenta_hash=JSON.parse(cuenta.json)
    cuenta_hash["numeroCuenta"]=cuenta.numero_cuenta
    cuenta_hash["saldoContable"]=cuenta.saldo
    cuenta_hash["saldoDisponible"]=cuenta.saldo
    return cuenta_hash.to_json
end

get '/clientes/:codigoUnicoCliente/cuentas' do
    cuentas = Cuenta.where(codigo_unico_cliente: params['codigoUnicoCliente'])
    puts cuentas
    cuentas_hash = cuentas.map { |c| 
        cuenta=JSON.parse(c.json)
        cuenta["numeroCuenta"]=c.numero_cuenta
        cuenta["saldoContable"]=c.saldo
        cuenta["saldoDisponible"]=c.saldo
        cuenta
    }
    return cuentas_hash.to_json
end

post '/cuentas' do
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
    return {"numOperacion" => rand.to_s[1..10]}.to_json
end 

get '/tarjetas/:numeroTarjeta' do
    tarjeta = Tarjeta.find_by(numero_tarjeta: params['numeroTarjeta'])
    halt 404, { :message => "Tarjeta no existe" }.to_json unless tarjeta.present?
    tarjeta_hash=JSON.parse(tarjeta.json)
    tarjeta_hash["numeroTarjeta"]=tarjeta.numero_tarjeta
    tarjeta_hash["numeroCuenta"]=tarjeta.numero_cuenta
    tarjeta_hash["fechaAlta"]=tarjeta.fecha_alta
    tarjeta_hash["fechaVencimiento"]=tarjeta.fecha_vencimiento
    return tarjeta_hash.to_json
end

get '/clientes/:codigoUnicoCliente/tarjetas' do
    tarjeta = Tarjeta.where(codigo_unico_cliente: params['codigoUnicoCliente'])
    tarjeta_hash = tarjeta.map { |t| 
        tarjeta=JSON.parse(t.json)
        tarjeta["numeroTarjeta"]=t.numero_tarjeta
        tarjeta["numeroCuenta"]=t.numero_cuenta
        tarjeta["fechaAlta"]=t.fecha_alta
        tarjeta["fechaVencimiento"]=t.fecha_vencimiento
        tarjeta
    }
    return tarjeta_hash.to_json
end

post '/tarjetas' do
    payload = JSON.parse(request.body.read)  
    tarjeta=Tarjeta.new
    tarjeta.codigo_unico_cliente=payload['codigoUnicoCliente']
    tarjeta.numero_tarjeta=rand.to_s[2..17]
    tarjeta.numero_cuenta=rand.to_s[2..14]
    tarjeta.fecha_alta=Time.now.strftime("%Y-%m-%d")
    tarjeta.fecha_vencimiento=(Time.now+5.years).strftime("%Y-%m-%d")
    tarjeta.saldo=payload['importeLinea'].to_i
    tarjeta.json=payload.to_json
    tarjeta.save
    return {"numeroTarjeta" => tarjeta.numero_tarjeta,
            "numeroCuenta" => tarjeta.numero_cuenta,
            "fechaAlta" => tarjeta.fecha_alta,
            "fechaVencimiento" => tarjeta.fecha_vencimiento,
            "saldoDisponible" => tarjeta.saldo}.to_json
end

get '/clientes/:codigoUnicoCliente/reclamos' do
    reclamos = Reclamo.where(codigo_unico_cliente: params['codigoUnicoCliente'])
    hash = reclamos.map { |r| 
        reclamo=JSON.parse(r.json)
        reclamo["numeroReclamo"]=r.numero_reclamo
        reclamo
    }
    return hash.to_json
end

get '/reclamos/:numeroReclamo' do
    reclamo = Reclamo.find_by(numero_reclamo: params['numeroReclamo'])
    halt 404, { :message => "Reclamo no existe" }.to_json unless reclamo.present?
    reclamo_hash=JSON.parse(reclamo.json)
    reclamo_hash["numeroReclamo"]=reclamo.numero_reclamo
    reclamo_hash["numeroReclamo"]=reclamo.numero_reclamo
    return reclamo_hash.to_json
end

post '/reclamos' do
    payload = JSON.parse(request.body.read)  
    reclamo = Reclamo.new
    reclamo.codigo_unico_cliente=payload['codigoUnicoCliente']
    reclamo.numero_reclamo = rand.to_s[1..15]
    reclamo.json=payload.to_json
    reclamo.save
    return {"numeroReclamo" => reclamo.numero_reclamo}.to_json
end

get '/tarjetas/:numeroTarjeta/movimientos' do
    request = JSON.parse(File.read('payloads/consultarmovimientos_response.json'))
    return request.to_json
end

post '/reclamos/:numeroReclamo/abonar' do
    #ABONO: tarjetaAbono, importeAbono
    payload = JSON.parse(request.body.read)
    puts payload
    # obtengo el reclamo y actualizo a PAGADO
    reclamo = Reclamo.find_by(numero_reclamo: params['numeroReclamo'])
    halt 404, { :message => "Reclamo no existe" }.to_json unless reclamo.present?
    reclamo_hash=JSON.parse(reclamo.json)
    reclamo_hash["estado"]="PAGADO"
    # obtengo la tarjeta y actualizo SALDO disponible de la TC 
    tarjeta_abono = Tarjeta.find_by(numero_tarjeta: payload['tarjetaAbono'])
    halt 404, { :message => "Tarjeta no existe" }.to_json unless tarjeta_abono.present?
    tarjeta_abono.saldo=tarjeta_abono.saldo + payload['importeAbono'].to_i

    tarjeta_abono.transaction do
        tarjeta_abono.save
        reclamo.save
    end
    return {"resultado" => "monto abonado"}.to_json
end
