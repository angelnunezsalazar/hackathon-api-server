require 'airborne'

describe 'API Campanias' do
    describe 'tarjetas' do
        it 'retorna el numero de operacion' do
            request_cliente = JSON.parse(File.read('payloads/crearcliente_request.json'))
            request_cliente["numeroDocumento"] = rand.to_s[2..9]
            post '/clientes', request_cliente
            codigo_unico_cliente = json_body[:codigoUnicoCliente]
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/tarjetas", request
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/tarjetas", request
            get "/clientes/#{request["codigoUnicoCliente"]}/campanias"
            expect(json_body.length).to eql(2)
        end

        it 'retorna numero de operacion' do
            request_cliente = JSON.parse(File.read('payloads/crearcliente_request.json'))
            request_cliente["numeroDocumento"] = rand.to_s[2..9]
            post '/clientes', request_cliente
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = json_body[:codigoUnicoCliente]
            post "/campanias/tarjetas", request
            expect_json_keys([:codigoCampania])
        end

        it 'retorna 404 si el cliente no existe' do
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = rand.to_s[2..11]
            post "/campanias/tarjetas", request
            expect_status(404)
            expect_json_keys([:message])
        end
    end
    describe 'prestamos' do
        
        it 'retorna el numero de operacion' do
            request_cliente = JSON.parse(File.read('payloads/crearcliente_request.json'))
            request_cliente["numeroDocumento"] = rand.to_s[2..9]
            post '/clientes', request_cliente
            codigo_unico_cliente = json_body[:codigoUnicoCliente]
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/tarjetas", request
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/tarjetas", request
            get "/clientes/#{request["codigoUnicoCliente"]}/campanias"
            expect(json_body.length).to eql(2)
        end

        it 'retorna numero de operacion' do
            request_cliente = JSON.parse(File.read('payloads/crearcliente_request.json'))
            request_cliente["numeroDocumento"] = rand.to_s[2..9]
            post '/clientes', request_cliente
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = json_body[:codigoUnicoCliente]
            post "/campanias/tarjetas", request
            expect_json_keys([:codigoCampania])
        end

        it 'retorna 404 si el cliente no existe' do
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = rand.to_s[2..11]
            post "/campanias/tarjetas", request
            expect_status(404)
            expect_json_keys([:message])
        end
    end
end

