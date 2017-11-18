class Cliente < ActiveRecord::Base

    def auto_generar_codigo_unico
        self.codigo_unico=self.numero_documento.rjust(10, '0')
    end
end