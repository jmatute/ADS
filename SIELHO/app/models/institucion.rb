		class Institucion < ActiveRecord::Base
			validates_presence_of :nombre, :tipo_institucion
			validates_uniqueness_of :nombre
			validates :nombre, :format => { :with => /\A[a-zA-Z]+\z/, :message => " - Solo se permiten letras" } 
    validates :descripcion, :format => { :with => /\A[a-zA-Z]+\z/, :message => " - Solo se permiten letras" } 

	def agregar(usuario)
		 self.usuarioMod = usuario
         self.usuarioRes = usuario
         self.fechaCrear = DateTime.now
         self.fechaMod = DateTime.now
	end
	
	def self.instituciones()
		x = []
		todos =Institucion.all
		todos.each do |i|
			x << [ i.nombre, i.id]
		end
		return x
	end


end
