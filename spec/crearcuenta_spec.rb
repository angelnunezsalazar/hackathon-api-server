require 'airborne'

describe 'API CrearCuenta' do
  it 'crea una cuenta y retorna su nro de cuenta' do
    request = JSON.parse(File.read('payloads/crearcuenta_request.json'))
    post '/crearcuenta', request
    expect_json_keys([:numeroCuenta])
  end
end