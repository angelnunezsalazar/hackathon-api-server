require 'airborne'

describe 'API ObtenerDatosCliente' do
  it 'retorna los datos del cliente dado un numero documento' do
    numero_documento=rand.to_s[2..9]
    datos_cliente=generar_request_crearcliente(numero_documento)
    crear_cliente(datos_cliente)
    get "http://localhost:9292/obtenerdatoscliente?numeroDocumento=#{numero_documento}"
    expect(json_body).not_to be_empty
  end

  #it 'retorna error cliente no existe'
  #it 'consultar con código unico'
  #it 'consultar con tipo documento'

  #it 'retorna el codigo del cliente'
end

def generar_request_crearcliente(numero_documento)
  request = JSON.parse(File.read('payloads/crearcliente_request.json'))
  request["numeroDocumento"]=numero_documento
  return request
end

def crear_cliente(request)
  post 'http://localhost:9292/crearcliente', request
end