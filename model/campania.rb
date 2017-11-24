class Campania < ActiveRecord::Base
    self.table_name = "campanias"

    PRESTAMO = 'PRESTAMO EFECTIVO'
    TARJETA = 'TARJETA DE CREDITO'
end