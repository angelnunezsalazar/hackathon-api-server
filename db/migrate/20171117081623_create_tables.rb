class CreateTables < ActiveRecord::Migration[5.1]
	def change
		create_table "clientes", :force => true do |t|
			t.string  "numero_documento"
			t.string  "codigo_unico"
		    t.string  "json"
		end
		  
		create_table "cuentas", :force => true do |t|
			t.string  "codigo_unico_cliente"
			t.string  "numero_cuenta"
			t.decimal  "saldo", precision: 10, scale: 3
			t.string  "json"
	  end
	end
end
