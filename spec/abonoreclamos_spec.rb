require 'airborne'

describe 'API Abono Reclamos' do
    it 'retorna numero de operacion, saldo de tarjeta y estado del reclamo' do
        tarjeta_response=crear_tarjeta
        reclamo_response=crear_reclamo
        request = JSON.parse(File.read('payloads/abonoreclamo_request.json'))
        request[:numeroTarjetaAbono]=tarjeta_response[:numeroTarjeta]
        post "/reclamos/#{reclamo_response[:numeroReclamo]}/abonos", request
        expect_json_keys([:numOperacion,:tarjeta,:reclamo])
            
    end
    it 'retorna 404 el reclamo no existe' do
        request = JSON.parse(File.read('payloads/abonoreclamo_request.json'))
        post "/reclamos/1234567890/abonos", request
        expect_status(404)
        expect_json_keys([:message])    
    end
    it 'retorna 404 si la tarjeta no existe' do
        reclamo_response=crear_reclamo
        request = JSON.parse(File.read('payloads/abonoreclamo_request.json'))
        request['numeroTarjetaAbono']='112211221122'
        post "/reclamos/#{reclamo_response[:numeroReclamo]}/abonos", request
        expect_status(404)
        expect_json_keys([:message])    
    end

    def crear_reclamo
        request = JSON.parse(File.read('payloads/fichareclamo_request.json'))
        post '/reclamos', request
        return json_body
    end
    
    def crear_tarjeta
        request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
        post '/tarjetas', request
        return json_body
    end
end

