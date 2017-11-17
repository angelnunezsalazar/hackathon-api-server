require 'airborne'

describe 'obtener datos cliente' do
  it 'retorna los datos del cliente de acuerdo a su nrodocumento' do
    request = File.read('apis/obtenerdatoscliente/request.json')
    post 'http://localhost:9292/obtenerdatoscontactocliente', request
    expect(json_body).not_to be_empty
  end

  it 'retorna error si el nrodocumento no existe'
end

describe 'crear cliente' do
  it 'retorna siempre la misma respuesta' do
    request = File.read('apis/crearcliente/request.json')
    post 'http://localhost:9292/crearcliente', request
    expect(json_body).not_to be_empty
  end
end

describe 'crear cuenta' do
  it 'retorna siempre la misma respuesta' do
    request = File.read('apis/crearcuenta/request.json')
    post 'http://localhost:9292/crearcuenta', request
    expect(json_body).not_to be_empty
  end

  it 'crear una cuenta y la persiste basado en los datos de la petición'
end

describe 'consultar saldos' do
  it 'retorna siempre la misma respuesta' do
    request = File.read('apis/consultarsaldos/request.json')
    post 'http://localhost:9292/consultarsaldos', request
    expect(json_body).not_to be_empty
  end

end