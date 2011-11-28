class Departamento < ActiveRecord::Base
	validates_presence_of :nombre	


	def agregar(usuario)
		 self.usuarioMod = usuario
         self.usuarioRes = usuario
         self.fechaCrear = DateTime.now
         self.fechaMod = DateTime.now
	end

end
