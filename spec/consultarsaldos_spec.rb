require 'airborne'

describe 'API ConsultarSaldos' do
  it 'retorna todas las cuentas del cliente dado su codigo unico' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    crear_cuenta(cuenta_request)
    crear_cuenta(cuenta_request)

    get "/consultarsaldos?codigoUnicoCliente=#{codigo_unico}"
    expect(json_body.length).to eql(2)
  end

  it 'retorna una cuenta dado su codigo unico y numero de cuenta' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    cuenta_a_buscar=crear_cuenta(cuenta_request)
    crear_cuenta(cuenta_request)
    get "/consultarsaldos?codigoUnicoCliente=#{codigo_unico}&numeroCuenta=#{cuenta_a_buscar[:numeroCuenta]}"
    expect(json_body.length).to eql(1)
  end

  it 'retorna el saldo contable y disponible' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    cuenta_a_buscar=crear_cuenta(cuenta_request)
    crear_cuenta(cuenta_request)
    get "/consultarsaldos?codigoUnicoCliente=#{codigo_unico}&numeroCuenta=#{cuenta_a_buscar[:numeroCuenta]}"
    expect(json_body[0][:saldoDisponible]).to eql('0.0')
    expect(json_body[0][:saldoContable]).to eql('0.0')
  end
end

def generar_request_cuenta(codigo_unico)
  request = JSON.parse(File.read('payloads/crearcuenta_request.json'))
  request["codigoUnicoCliente"]=codigo_unico
  return request
end

def crear_cuenta(request)
  post '/crearcuenta', request
  return json_body
end