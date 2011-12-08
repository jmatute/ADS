class Asignacion < ActiveRecord::Base
	validates_presence_of :expediente_id,:enlace_id,:descripcion
	
	def logC

	#enlace_id: integer, descripcion: text, fechaInic: datetime, expediente_id: integer, fechaCrear: datetime, fechaMod: datetime, usuarioRes: integer, usuarioMod: integer, created_at: datetime, updated_at: datetime, plazo: integer, completada: boolean
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de asignacion"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" + "\t" + "descripcion" + "\t" + "N/A" + "\t" + self.descripcion + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" + "\t" + "enlace_id" + "\t" + "N/A" + "\t" + self.enlace_id.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" +  "\t" + "fechaInic" + "\t" + "N/A" + "\t" + self.fechaInic.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" +  "\t" + "expediente_id" + "\t" + "N/A" + "\t" + self.expediente_id.to_s + "\t" + descripcion + "\n")


		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" + "\t" + "plazo" + "\t" + "N/A" + "\t" + self.plazo.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "asignacion" + "\t" + "completada" + "\t" + "N/A" + "\t" + "false" + "\t" + descripcion + "\n")

		file.close()


	end	

end
