require 'airborne'

describe 'API Transferencia' do
  it 'abona y carga montos sin considerar moneda' do
    codigo_unico=rand.to_s[2..9]
    cuenta_request=generar_request_cuenta(codigo_unico)
    cuenta_1=crear_cuenta(cuenta_request)
    cuenta_2=crear_cuenta(cuenta_request)

    request={
      "numeroCuentaAbono" => cuenta_1[:numeroCuenta],
      "importeAbono" => 100,
      "numeroCuentaCargo" => cuenta_2[:numeroCuenta],
      "importeCargo" => 100,
    }
    post "/transferencia", request
    expect_json_keys([:numOperacion])

    get "/consultarsaldos?codigoUnicoCliente=#{codigo_unico}"
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