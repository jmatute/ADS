class Departamento < ActiveRecord::Base
	validates_presence_of :nombre	
    validates :nombre, :format => { :with => /\A[a-zA-Z ]+\z/, :message => " Solo se permiten letras" } 
	

	def agregar(institucion,usuario)
		 self.institucion_id = institucion
		 self.usuarioMod = usuario
         self.usuarioRes = usuario
         self.fechaCrear = DateTime.now
         self.fechaMod = DateTime.now
	end


	def logC
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de departamento"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" + "\t" + "descripcion" + "\t" + "N/A" + "\t" + self.descripcion + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.nombre + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" + "\t" + "institucion" + "\t" + "N/A" + "\t" + self.institucion_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "departamento" + "\t" + "enlace_id" + "\t" + "N/A" + "\t" + self.enlace_id.to_s + "\t" + descripcion + "\n")

		file.close()


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
