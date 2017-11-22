require 'airborne'

describe 'API Reclamos' do
    it 'crea un reclamo y retorna su nro de reclamos' do
        codigo_unico = rand.to_s[2..9]
        request = generar_request(codigo_unico)
        post '/reclamos', request
        expect_json_keys([:numeroReclamo])
    end

    it 'retorna los datos del reclamo dado su nro reclamo' do
        codigo_unico = rand.to_s[2..9]
        request = generar_request(codigo_unico)
        response=crear_reclamo(request)
        get "/reclamos/#{response[:numeroReclamo]}"
        expect(json_body).not_to be_empty
    end

    it 'retorna todas las cuentas del cliente' do
        codigo_unico=rand.to_s[2..9]
        request = generar_request(codigo_unico)
        crear_reclamo(request)
        crear_reclamo(request)
        get "/clientes/#{codigo_unico}/reclamos"
        expect(json_body.length).to eql(2)
    end

    it 'retorna 404 si el reclamo no existe' do
        get "/reclamos/0011223344"
        expect_status(404)
        expect_json_keys([:error])
    end
end
  
def generar_request(codigo_unico)
    request = JSON.parse(File.read('payloads/fichareclamo_request.json'))
    request["codigoUnicoCliente"]=codigo_unico
    return request
  end

def crear_reclamo(request)
    post '/reclamos', request
    return json_body
end