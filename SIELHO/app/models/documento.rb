class Documento < ActiveRecord::Base
	def crear(doc,usuario)
		self.tipoDocumento_id = doc["tipoDocumento_id"]
		self.numero = doc["numero"]
		self.usuarioMod = usuario
        self.usuarioRes = usuario
        self.fechaCrear = DateTime.now
        self.fechaMod = DateTime.now

		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = usuario
		rol = User.find(usuario).rol.nombre
		descripcion = "creacion de documento"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "documento" + "\t" + "numero" + "\t" + "N/A" + "\t" + self.numero + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "documento" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "documento" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "documento" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "documento" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "documento" + "\t" + "tipoDocumento" + "\t" + "N/A" + "\t" + self.tipoDocumento_id.to_s + "\t" + descripcion + "\n")
		file.close()
		self.save
	end

end
