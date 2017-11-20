require 'airborne'

describe 'API AltaTarjeta' do
  it 'crea una tarjeta y retorna el numero de tarjeta' do
    request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
    post '/altatarjeta', request
    expect_json_keys([:numeroCuenta])
    expect_json_keys([:numeroTarjeta])
    expect_json_keys([:fechaAlta])
    expect_json_keys([:fechaVencimiento])
  end
end