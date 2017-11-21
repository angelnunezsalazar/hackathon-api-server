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

		create_table "tarjetas", :force => true do |t|
			t.string  "codigo_unico_cliente"
			t.string  "numero_cuenta"
			t.string  "numero_tarjeta"
			t.string  "fecha_alta"
			t.string  "fecha_vencimiento"
			t.string  "json"
		end

		create_table "reclamos", :force => true do |t|
			t.string  "numero_reclamo"
		    t.string  "json"
		end
	end
end
