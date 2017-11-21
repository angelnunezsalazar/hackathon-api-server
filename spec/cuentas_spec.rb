require 'airborne'

describe 'API CrearCuenta' do
  it 'crea una cuenta y retorna su nro de cuenta' do
    request = JSON.parse(File.read('payloads/crearcuenta_request.json'))
    post '/cuentas', request
    expect_json_keys([:numeroCuenta])
  end

  it 'retorna todas las cuentas del cliente dado su codigo unico' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    crear_cuenta(cuenta_request)
    crear_cuenta(cuenta_request)
    get "/clientes/#{codigo_unico}/cuentas"
    expect(json_body.length).to eql(2)
  end

  it 'retorna una cuenta dado su numero de cuenta' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    cuenta_a_buscar=crear_cuenta(cuenta_request)
    crear_cuenta(cuenta_request)
    get "/cuentas/#{cuenta_a_buscar[:numeroCuenta]}"
    expect(json_body).not_to be_empty
  end

  it 'retorna el saldo contable y disponible' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    cuenta_a_buscar=crear_cuenta(cuenta_request)
    crear_cuenta(cuenta_request)
    get "/cuentas/#{cuenta_a_buscar[:numeroCuenta]}"
    expect(json_body[:saldoDisponible]).to eql('0.0')
    expect(json_body[:saldoContable]).to eql('0.0')
  end
end

def generar_request_cuenta(codigo_unico)
  request = JSON.parse(File.read('payloads/crearcuenta_request.json'))
  request["codigoUnicoCliente"]=codigo_unico
  return request
end

def crear_cuenta(request)
  post '/cuentas', request
  return json_body
end