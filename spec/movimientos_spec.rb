require 'airborne'

describe 'API Movimientos' do

  it 'siempe retorna el mismo conjunto de cuentas' do
    get "/tarjetas/123456789/movimientos"
    expect(json_body.length).to eql(8)
  end

end
