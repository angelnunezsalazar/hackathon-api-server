class CreateCampanias < ActiveRecord::Migration[5.1]
  def change
    create_table "campanias", :force => true do |t|
			t.string  "codigo_unico_cliente"
		  t.string  "json"
		end
  end
end
