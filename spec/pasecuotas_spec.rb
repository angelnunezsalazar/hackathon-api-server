require 'airborne'

describe 'API PaseCuotas' do

  it 'retorna si las cuotas pudieron ser generadas' do
    request = JSON.parse(File.read('payloads/pasecuotas_request.json'))
    post '/pasecuotas', request

    expect(json_body).not_to be_empty
  end

  it 'retorna 404 si la tarjeta no existe' do
    request = JSON.parse(File.read('payloads/pasecuotas_request.json'))
    #puts request
    request['tarjeta'] = "123456"
    post '/pasecuotas', request

    expect_status(404)
    expect_json_keys([:message])
  end

  it 'retorna lista de movimientos de pase a cuotas' do
    get '/pasecuotas/4244575205448683/lista'
    expect(json_body).not_to be_empty
  end


end
