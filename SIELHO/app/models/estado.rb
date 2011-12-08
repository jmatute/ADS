class Estado < ActiveRecord::Base
	validates_presence_of :nombre,:descripcion,:anterior_id
    validates :nombre, :format => { :with => /\A[a-zA-Z ]+\z/, :message => " - Solo se permiten letras" } 
	
	def self.estados()
		x = []
		todos =Estado.all
		todos.each do |i|
			x << [ i.nombre, i.id]
		end
		x << ["ninguno",0]
		return x
	end
	
	def logC
		#tado(id: integer, nombre: string, descripcion: text, fechaCrear: datetime, fechaMod: datetime, usuarioRes: integer, usuarioMod: integer, created_at: datetime, updated_at: datetime, anterior_id: integer)
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de estado"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "estado" + "\t" + "descripcion" + "\t" + "N/A" + "\t" + self.descripcion + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "estado" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.nombre + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "estado" +  "\t" + "anteriorId" + "\t" + "N/A" + "\t" + self.anterior_id.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "estado" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "estado" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "estado" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "estado" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


	end	

end
