class Solicitante < ActiveRecord::Base

#validates_presence_of :email, :nombre

	def crear(doc,usuario,id)
		self.nombre = doc["nombre"]
		self.documento_id = id
		self.tipo_solicitante = TipoDocumento.find(Documento.find(id).tipoDocumento_id).tipoPersona
		cadena = ""
		unless doc["telefono"].blank?
			cadena = cadena + "telefono,"
			self.telefono = doc["telefono"]
		else
			self.telefono = "N/A"
		end
		unless doc["email"].blank?
			cadena = cadena + "email,"
			self.email = doc["email"]
		else
			self.email = "N/A"
		end
		unless doc["fax"].blank?
			cadena = cadena + "fax,"
			self.fax = doc["fax"]
		else
			self.fax = "N/A"
		end
		unless doc["direccion_postal"].blank?
			cadena = cadena + "postal,"
			self.direccion_postal = doc["direccion_postal"]
		else
			self.direccion_postal = "N/A"
		end
		
		
		unless doc["genero"].blank?
			self.genero = doc["genero"]
		else
			self.genero = "N/A"
		end

		unless doc["ocupacion_id"].blank?
			self.ocupacion_id = doc["ocupacion_id"]
		else
			self.ocupacion_id = 0
		end
		unless doc["nivel_educativo"].blank?
			self.nivel_educativo = doc["nivel_educativo"]
		else
			self.nivel_educativo = "N/A"
		end
		unless doc["poder"].blank?
			self.poder = doc["poder"]
		else
			self.poder = "N/A"
		end

		

		self.usuarioMod = usuario
        self.usuarioRes = usuario
        self.fechaCrear = DateTime.now
        self.fechaMod = DateTime.now
		self.save
		
	end

	def logC
		
#Solicitante(id: integer, nombre: string, documento_id: integer, tipo_solicitante: integer, ocupacion_id: integer, genero: string, nivel_educativo: string, telefono: string, email: string, direccion_postal: text, fax: string, poder: string, fechaCrear: datetime, fechaMod: datetime, usuarioRes: integer, usuarioMod: integer, responsable: integer)
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de solicitante"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" + "\t" + "documento_id" + "\t" + "N/A" + "\t" + self.documento_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.nombre + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "tipo_solicitante" + "\t" + "N/A" + "\t" + self.tipo_solicitante.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "ocupacion_id" + "\t" + "N/A" + "\t" + self.ocupacion_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "genero" + "\t" + "N/A" + "\t" + self.genero + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "nivel educativo" + "\t" + "N/A" + "\t" + self.nivel_educativo + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "telefono" + "\t" + "N/A" + "\t" + self.telefono + "\t" + descripcion + "\n")
		
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "email" + "\t" + "N/A" + "\t" + self.email + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "direccion_postal" + "\t" + "N/A" + "\t" + self.direccion_postal + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "fax" + "\t" + "N/A" + "\t" + self.fax + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "poder" + "\t" + "N/A" + "\t" + self.poder + "\t" + descripcion + "\n")


		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitante" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


	end	


end
