require 'airborne'

describe 'API AltaTarjeta' do
  it 'crea una tarjeta y retorna el numero de tarjeta' do
    request = JSON.parse(File.read('payloads/crearcliente_request.json'))
    request["numeroDocumento"]=rand.to_s[2..9]
    request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
    post '/tarjetas', request
    expect_json_keys([:numeroCuenta])
    expect_json_keys([:numeroTarjeta])
    expect_json_keys([:fechaAlta])
    expect_json_keys([:fechaVencimiento])
    expect_json_keys([:saldo])
  end

  it 'crea una tarjeta y retorna el saldo igual al importeLinea' do
    request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
    request["importeLinea"] = "8000.55"
    post '/tarjetas', request
    expect(json_body[:saldo]).to eql("8000.55")
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

  it 'retorna 404 si la tarjeta no existe' do
    get "/tarjetas/0011223344"
    expect_status(404)
    expect_json_keys([:message])
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