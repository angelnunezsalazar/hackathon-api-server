require 'airborne'

describe 'API Cliente' do
  it 'crea un cliente y retorna su código único' do
    request = JSON.parse(File.read('payloads/crearcliente_request.json'))
    numero_documento=rand.to_s[2..9]
    request["numeroDocumento"]=numero_documento
    post '/clientes', request
    expect_json(codigoUnicoCliente: "00#{numero_documento}")
  end

  it 'retorna los datos del cliente dado su código único' do
    numero_documento=rand.to_s[2..9]
    request=generar_request_crearcliente({'numeroDocumento'=> numero_documento})
    response=crear_cliente(request)
    get "/clientes/#{response[:codigoUnicoCliente]}"
    expect(json_body).not_to be_empty
  end

  it 'retorna los datos del cliente dado un numero documento' do
    numero_documento=rand.to_s[2..9]
    request=generar_request_crearcliente({'numeroDocumento'=> numero_documento})
    crear_cliente(request)
    get "/clientes?numeroDocumento=#{numero_documento}"
    expect(json_body).not_to be_empty
  end

  it 'retorna 404 si el cliente no existe' do
    get "/clientes/0011223344"
    expect_status(404)
    expect_json_keys([:message])

    get "/clientes?numeroDocumento=11223344"
    expect_status(404)
    expect_json_keys([:message])
  end
end

def generar_request_crearcliente(data)
  default_data = JSON.parse(File.read('payloads/crearcliente_request.json'))
  request = default_data.merge!(data)
  return request
end

def crear_cliente(request)
  post '/clientes', request
  return json_body
end