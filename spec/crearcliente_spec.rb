require 'airborne'

describe 'API CrearCliente' do
  it 'crea un cliente y retorna su código único' do
    request = JSON.parse(File.read('payloads/crearcliente_request.json'))
    numero_documento=rand.to_s[2..9]
    request["numeroDocumento"]=numero_documento
    post 'http://localhost:9292/crearcliente', request
    expect_json(codigoUnicoCliente: "00#{numero_documento}")
  end
end