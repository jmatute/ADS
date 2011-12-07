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
		self.responsable = usuario
		self.finalizada = false
		cad = (Solicitud.all.size() +1).to_s
		while cad.size < 6 do
			cad = "0" + cad
		end
		self.numero = Time.now.strftime("%d%m%Y") +cad
		self.save	
	end


	def self.posibles(institucion)
		a = Oip.where(:institucion_id=>institucion)
		x = []
		a.each do |o|
			if User.find(o.usuario_id).activo
				x << ["#{o.pnombre} #{o.papellido}",o.usuario_id]
			end
		end
		return x
	end
	def self.solicitudes(usuario)

		x =  User.find(usuario)
		arreglo = []
		if x.rol.nombre.eql? "admin"
			todas = Solicitud.all
			todas.each do |t|
				arreglo << t
			end
		end

		if x.rol.nombre.eql? "oip"
			todas = Solicitud.all
			todas.each do |t|
				if t.institucion_id.eql? Oip.find_by_usuario_id(x.id).institucion_id
					arreglo << t
				end
			end
		end

		if x.rol.nombre.eql? "enlace"
			todas = Asignacion.where(:enlace_id =>usuario)
		
			todas.each do |t|
				s =	Solicitud.find_by_expediente_id(t.expediente_id)
				arreglo  << s
			end

		end


		return arreglo
	end
end
