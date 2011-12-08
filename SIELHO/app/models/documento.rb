class Documento < ActiveRecord::Base
	def crear(doc,usuario)
		self.tipoDocumento_id = doc["tipoDocumento_id"]
		self.numero = doc["numero"]
		self.usuarioMod = usuario
        self.usuarioRes = usuario
        self.fechaCrear = DateTime.now
        self.fechaMod = DateTime.now
		self.save
	end

end
