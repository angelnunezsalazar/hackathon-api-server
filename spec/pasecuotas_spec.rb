require 'airborne'

describe 'API PaseCuotas' do

  it 'simula un pase a cuotas' do
    request = JSON.parse(File.read('payloads/simulacionpasecuotas_request.json'))
    post '/pasecuotas/simulacion', request
    expect_json_keys([:importeCuota])
  end

  it 'genera nuevos movimientos' do
    tarjeta_response=crear_tarjeta
    request = JSON.parse(File.read('payloads/pasecuotas_request.json'))
    request[:numeroTarjeta] = tarjeta_response[:numeroTarjeta]
    request[:cuotas] = 3
    post '/pasecuotas', request
    movimientos_response = consultar_movimientos(request[:numeroTarjeta])
    expect(json_body.length).to eql(3)
  end

  #it elimina el movimiento anterior

  #it datos de retorno

  it 'retorna 404 si la tarjeta no existe' do
    request = JSON.parse(File.read('payloads/pasecuotas_request.json'))
    post '/pasecuotas', request
    expect_status(404)
    expect_json_keys([:message])
  end 

  def crear_tarjeta
    request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
    post '/tarjetas', request
    return json_body
  end
  
  def consultar_movimientos(numero_tarjeta)
    get "/pasecuotas/#{numero_tarjeta}/cuotas"
    return json_body
  end
end