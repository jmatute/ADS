		class Institucion < ActiveRecord::Base
			validates_presence_of :nombre, :tipo_institucion
			validates_uniqueness_of :nombre
			validates :nombre, :format => { :with => /\A[a-zA-Z ]+\z/, :message => " - Solo se permiten letras" } 

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
	
	def logC
#Institucion(id: integer, descripcion: text, nombre: string, tipo_institucion: string, fechaCrear: datetime, fechaMod: datetime, usuarioRes: integer, usuarioMod: integer, created_at: datetime, updated_at: datetime)	
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de institucion"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "institucion" + "\t" + "descripcion" + "\t" + "N/A" + "\t" + self.descripcion + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "institucion" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.nombre + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "institucion" +  "\t" + "tipoInstitucion" + "\t" + "N/A" + "\t" + self.tipo_institucion + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "institucion" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "institucion" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "institucion" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "institucion" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


	end	


end
