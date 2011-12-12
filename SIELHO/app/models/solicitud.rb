class Solicitud < ActiveRecord::Base
	require 'fastercsv'

	

	def self.buscar(codigo,institucion,incio,final)
		solicitudes = []		
		unless codigo.nil? || codigo.blank?
			solicitudes = []
			todas = Solicitud.all
			todas.each do |t|	
				if t.numero == codigo.to_s
					solicitudes << t				
				end
			end		
	
		else
				if institucion.blank? == false  ||  institucion.nil? == false
					solicitudes = []
					todas = Solicitud.all
					todas.each do |t|
						if t.institucion_id == institucion.to_i
							solicitudes << t
						end		
					end
				end

				unless incio.blank? && final.blank?
					solicitudes2 = []
					solicitudes.each do |y|
					temp = y.fecha.strftime("%m-%d-%Y")
					  if temp >= final.to_s && temp <= incio.to_s
					      solicitudes2 << y
					  end
					end
				
				end
	      solicitudes = solicitudes2
	end
		
	      	return	solicitudes	    	
	end

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

	def logC
		#Solicitud(id: integer, solicitante_id: integer, descripcion: text, lugar: string, institucion_id: integer, fecha: datetime, clasificacion_id: integer, expediente_id: integer, fechaCrear: datetime, fechaMod: datetime, usuarioRes: integer, usuarioMod: integer, responsable: integer, numero: string, finalizada: boolean)

		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de solicitud"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" + "\t" + "descripcion" + "\t" + "N/A" + "\t" + self.descripcion + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" + "\t" + "solicitante_id" + "\t" + "N/A" + "\t" + self.solicitante_id.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "lugar" + "\t" + "N/A" + "\t" + self.lugar + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "institucion_id" + "\t" + "N/A" + "\t" + self.institucion_id.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "fecha" + "\t" + "N/A" + "\t" + self.fecha.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "clasificacion_id" + "\t" + "N/A" + "\t" + self.clasificacion_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "expediente_id" + "\t" + "N/A" + "\t" + self.expediente_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "responsable" + "\t" + "N/A" + "\t" + self.responsable.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "numero" + "\t" + "N/A" + "\t" + self.numero + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "finalizada" + "\t" + "N/A" + "\t" + "false" + "\t" + descripcion + "\n")



		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


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
