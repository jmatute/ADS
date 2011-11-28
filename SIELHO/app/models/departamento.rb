class Departamento < ActiveRecord::Base
	validates_presence_of :nombre	


	def agregar(institucion,usuario)
		 self.institucion_id = institucion
		 self.usuarioMod = usuario
         self.usuarioRes = usuario
         self.fechaCrear = DateTime.now
         self.fechaMod = DateTime.now
	end
	
	def self.departamentos(id)
		x = []
		todos =Departamento.all
		o = Oip.find_by_usuario_id(id)
		if !o.blank? 
			todos.each do |i|
				if o.institucion_id.eql? i.institucion_id
			     x << [ i.nombre, i.id]
				end
			end
		end
		return x
	end

end
