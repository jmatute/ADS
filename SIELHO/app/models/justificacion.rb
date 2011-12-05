class Justificacion < ActiveRecord::Base
	has_and_belongs_to_many :leyAcuerdos	
	validates_presence_of :descripcion
	def basics(usuario)
		 self.usuarioMod = usuario
         self.usuarioRes = usuario
         self.fechaCrear = DateTime.now
         self.fechaMod = DateTime.now
	end
end
