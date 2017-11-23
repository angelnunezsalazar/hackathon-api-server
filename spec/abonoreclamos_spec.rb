require 'airborne'

describe 'API Abono Reclamos' do
    it 'retorna numero de operacion, saldo de tarjeta ' do
        tarjeta_response=crear_tarjeta('1122334455')
        request = JSON.parse(File.read('payloads/abonoreclamo_request.json'))
        post "/tarjetas/#{tarjeta_response[:numeroTarjeta]}/abonos", request
        expect_json_keys([:numOperacion,:saldoTarjetaAbono])
            
    end

    it 'retorna 404 si la tarjeta no existe' do
        request = JSON.parse(File.read('payloads/abonoreclamo_request.json'))
        post "/tarjetas/112211221122/abonos", request
        expect_status(404)
        expect_json_keys([:message])    
    end
    
    def crear_tarjeta(numero_tarjeta)
        request = JSON.parse(File.read('payloads/altatarjeta_request.json'))
        post '/tarjetas', request
        return json_body
    end
end

