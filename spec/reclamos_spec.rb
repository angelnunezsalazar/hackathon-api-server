require 'airborne'

describe 'API Reclamos' do
    it 'crea un reclamo y retorna su nro de reclamos' do
        request = JSON.parse(File.read('payloads/fichareclamo_request.json'))
        post '/reclamos', request
        expect_json_keys([:numeroReclamo])
    end

    it 'retorna los datos del reclamo dado su nro reclamo' do
        request = JSON.parse(File.read('payloads/fichareclamo_request.json'))
        response=crear_reclamo(request)
        get "/reclamos/#{response[:numeroReclamo]}"
        expect(json_body).not_to be_empty
    end
end
  
def crear_reclamo(request)
    post '/reclamos', request
    return json_body
end