require 'airborne'

describe 'API Calificacion' do
  it 'Validar si un cliente califica o no por la edad > 30 años' do
    request = JSON.parse(File.read('payloads/calificacioncda_request.json'))
    post '/calificacion', request
    expect_json(codigoResultado: "2")
  end
end