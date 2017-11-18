require 'airborne'

describe 'API ConsultarSaldos' do
  it 'retorna las cuentas del cliente dado su codigo unico' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    cuenta1_response=crear_cuenta(cuenta_request)
    cuenta2_response=crear_cuenta(cuenta_request)

    get "http://localhost:9292/consultarsaldos?codigoUnicoCliente=#{codigo_unico}"
    expect(json_body.length).to eql(2)
  end

  #retorna los numeros de cuenta generados

  #(opcional) quita el codigoUnicoCliente de las cuentas
end

def generar_request_cuenta(codigo_unico)
  request = JSON.parse(File.read('payloads/crearcuenta_request.json'))
  request["codigoUnicoCliente"]=codigo_unico
  return request
end

def crear_cuenta(request)
  post 'http://localhost:9292/crearcuenta', request
  return json_body
end