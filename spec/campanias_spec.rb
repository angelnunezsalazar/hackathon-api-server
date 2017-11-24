require 'airborne'

describe 'API Campañias' do
    describe 'tarjetas' do
        it 'carga campañas que se pueden consultar' do
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
            expect(json_body[:tarjetas].length).to eql(2)
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
        it 'carga campañas que se pueden consultar' do
            request_cliente = JSON.parse(File.read('payloads/crearcliente_request.json'))
            request_cliente["numeroDocumento"] = rand.to_s[2..9]
            post '/clientes', request_cliente
            codigo_unico_cliente = json_body[:codigoUnicoCliente]
            request = JSON.parse(File.read('payloads/crearcampañaprestamo_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/prestamos", request
            request = JSON.parse(File.read('payloads/crearcampañaprestamo_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/prestamos", request
            get "/clientes/#{request["codigoUnicoCliente"]}/campanias"
            expect(json_body[:prestamos].length).to eql(2)
        end

        it 'retorna numero de operacion' do
            request_cliente = JSON.parse(File.read('payloads/crearcliente_request.json'))
            request_cliente["numeroDocumento"] = rand.to_s[2..9]
            post '/clientes', request_cliente
            request = JSON.parse(File.read('payloads/crearcampañaprestamo_request.json'))
            request["codigoUnicoCliente"] = json_body[:codigoUnicoCliente]
            post "/campanias/prestamos", request
            expect_json_keys([:codigoCampania])
        end

        it 'retorna 404 si el cliente no existe' do
            request = JSON.parse(File.read('payloads/crearcampañaprestamo_request.json'))
            request["codigoUnicoCliente"] = rand.to_s[2..11]
            post "/campanias/prestamos", request
            expect_status(404)
            expect_json_keys([:message])
        end
    end
    describe 'consultar campañas' do
        it 'retorna campañas de diferentes tipos' do
            request_cliente = JSON.parse(File.read('payloads/crearcliente_request.json'))
            request_cliente["numeroDocumento"] = rand.to_s[2..9]
            post '/clientes', request_cliente
            codigo_unico_cliente = json_body[:codigoUnicoCliente]
            request = JSON.parse(File.read('payloads/crearcampañatc_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/tarjetas", request
            request = JSON.parse(File.read('payloads/crearcampañaprestamo_request.json'))
            request["codigoUnicoCliente"] = codigo_unico_cliente
            post "/campanias/prestamos", request
            get "/clientes/#{codigo_unico_cliente}/campanias"
            expect(json_body[:tarjetas].length).to eql(1)
            expect(json_body[:prestamos].length).to eql(1)
        end
    end
end

