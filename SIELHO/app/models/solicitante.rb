class Solicitante < ActiveRecord::Base
	def crear(doc,usuario,id)
		self.nombre = doc["nombre"]
		self.documento_id = id
		self.tipo_solicitante = TipoDocumento.find(Documento.find(id).tipoDocumento_id).tipoPersona
		cadena = ""
		unless doc["telefono"].blank?
			cadena = cadena + "telefono,"
			self.telefono = doc["telefono"]
		end
		unless doc["email"].blank?
			cadena = cadena + "email,"
			self.email = doc["email"]
		end
		unless doc["fax"].blank?
			cadena = cadena + "fax,"
			self.fax = doc["fax"]
		end
		unless doc["direccion_postal"].blank?
			cadena = cadena + "postal,"
			self.direccion_postal = doc["direccion_postal"]
		end
		
		if cadena.eql? ""
			self.modo_contacto = "N\\A"
		else 
			self.modo_contacto = cadena
		end
		
		unless doc["genero"].blank?
			self.genero = doc["genero"]
		end
		unless doc["ocupacion_id"].blank?
			self.ocupacion_id = doc["ocupacion_id"]
		end
		unless doc["nivel_educativo"].blank?
			self.nivel_educativo = doc["nivel_educativo"]
		end
		unless doc["poder"].blank?
			self.poder = doc["poder"]
		else
			self.poder = "N\\A"
		end

		

		self.usuarioMod = usuario
        self.usuarioRes = usuario
        self.fechaCrear = DateTime.now
        self.fechaMod = DateTime.now
		self.save
		
	end
end
