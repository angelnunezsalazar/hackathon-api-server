require 'sinatra'

post '/obtenerdatoscontactocliente' do
    payload = JSON.parse(request.body.read)
    nrodocumento=payload["MessageRequest"]["Body"]["obtenerdatoscontactocliente"]["numeroDocumento"]
    resp = File.read("apis/obtenerdatoscliente/response-nrodocumento-#{nrodocumento}.json")
end

post '/crearcliente' do
    #payload = JSON.parse(request.body.read)    
    resp = File.read("apis/crearcliente/response.json")
end

post '/crearcuenta' do
    #payload = JSON.parse(request.body.read)    
    resp = File.read("apis/crearcuenta/response.json")
end

post '/consultarsaldos' do
    #payload = JSON.parse(request.body.read)    
    resp = File.read("apis/consultarsaldos/response.json")
end