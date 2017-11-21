require 'airborne'

describe 'API Movimientos' do

  it 'retorna todas las cuentas del cliente dado su codigo unico' do
    get "/tarjetas/123456789/movimientos"
    expect(json_body.length).to eql(8)
  end

end
