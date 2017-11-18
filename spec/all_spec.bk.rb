require 'airborne'

describe 'consultar saldos' do
  it 'retorna siempre la misma respuesta' do
    request = File.read('apis/consultarsaldos/request.json')
    post 'http://localhost:9292/consultarsaldos', request
    expect(json_body).not_to be_empty
  end

end

describe 'transferencias' do
  it 'retorna siempre la misma respuesta' do
    request = File.read('apis/consultarsaldos/request.json')
    post 'http://localhost:9292/transferencia', request
    expect(json_body).not_to be_empty
  end

end