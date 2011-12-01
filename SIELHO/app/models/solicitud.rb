class Solicitud < ActiveRecord::Base



	def crear(doc,fechaM,solicitante,usuario)
		self.descripcion = doc["descripcion"]
		self.lugar = doc["lugar"]
		self.institucion_id = doc["institucion_id"]
		self.fecha = fechaM
		self.solicitante_id = solicitante
		self.usuarioMod = usuario
        self.usuarioRes = usuario
        self.fechaCrear = DateTime.now
        self.fechaMod = DateTime.now

		cad = (Solicitud.all.size() +1).to_s
		while cad.size < 6 do
			cad = "0" + cad
		end
		self.numero = Time.now.strftime("%d%m%Y") +cad
		self.save	
	end
end
