require 'airborne'

describe 'API AltaTarjeta' do
  it 'crea una tarjeta y retorna el numero de tarjeta' do
    request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
    post '/tarjetas', request
    expect_json_keys([:numeroCuenta])
    expect_json_keys([:numeroTarjeta])
    expect_json_keys([:fechaAlta])
    expect_json_keys([:fechaVencimiento])
  end

  it 'retorna todas las tarjetas del cliente dado su codigo unico' do
    codigo_unico=rand.to_s[2..9]
    tarjeta_request=generar_request_tarjeta(codigo_unico)
    crear_tarjeta(tarjeta_request)
    crear_tarjeta(tarjeta_request)
    get "/clientes/#{codigo_unico}/tarjetas"
    expect(json_body.length).to eql(2)
  end

  it 'retorna una tarjeta dado su numero de tarjeta' do
    codigo_unico=rand.to_s[2..9]
    tarjeta_request=generar_request_tarjeta(codigo_unico)
    tarjeta_a_buscar=crear_tarjeta(tarjeta_request)
    crear_tarjeta(tarjeta_request)
    get "/tarjetas/#{tarjeta_a_buscar[:numeroTarjeta]}"
    expect(json_body).not_to be_empty
  end

  it 'retorna numero de tarjeta y numero de cuenta' do
    codigo_unico=rand.to_s[2..9]
    tarjeta_request=generar_request_tarjeta(codigo_unico)
    tarjeta_a_buscar=crear_tarjeta(tarjeta_request)
    crear_tarjeta(tarjeta_request)
    get "/tarjetas/#{tarjeta_a_buscar[:numeroTarjeta]}"
    expect_json_keys([:numeroTarjeta])
    expect_json_keys([:numeroCuenta])
  end

end

def generar_request_tarjeta(codigo_unico)
  request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
  request["codigoUnicoCliente"]=codigo_unico
  return request
end

def crear_tarjeta(request)
  post '/tarjetas', request
  return json_body
end