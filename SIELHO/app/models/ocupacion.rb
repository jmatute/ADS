class Ocupacion < ActiveRecord::Base
	validates_presence_of :nombre , :format => {:message => " Ocupacion no puede ser en blanco "}
	validates_uniqueness_of :nombre, :format => { :message => "  - Ocupacion con ese nombre ya existe" }
    validates :nombre, :format => { :with => /\A[a-zA-Z]+\z/, :message => " - Solo se permiten letras" } 
	

     def self.ocupaciones()
		x = []
		todos =Ocupacion.all
		todos.each do |i|
			x << [ i.nombre, i.id]
		end
		return x
	end
	
	def logC
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de ocupacion"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "ocupacion" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.nombre + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "ocupacion" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "ocupacion" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "ocupacion" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "ocupacion" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


	end	


end
