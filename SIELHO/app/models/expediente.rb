class Expediente < ActiveRecord::Base

	def crear(solicitud,usuario)
#Expediente(id: integer, estado_id: integer, solicitud_id: integer, creador: integer, fechaEntrega: datetime, fechaEmision: datetime, fechaCrear: datetime, fechaMod: datetime, usuarioRes: integer, usuarioMod: integer, created_at: datetime, updated_at: datetime)
		self.estado_id = 1
		self.solicitud_id = solicitud
		self.creador = usuario
		self.fechaEmision = DateTime.now
		self.usuarioMod = usuario
        self.usuarioRes = usuario
        self.fechaCrear = DateTime.now
        self.fechaMod = DateTime.now
		self.save
		
	end

	def logC
#Expediente(id: integer, estado_id: integer, solicitud_id: integer, creador: integer, fechaEntrega: datetime, fechaEmision: datetime, fechaCrear: datetime, fechaMod: datetime, usuarioRes: integer, usuarioMod: integer, created_at: datetime, updated_at: datetime)

		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de solicitud"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" + "\t" + "estado_id" + "\t" + "N/A" + "\t" + self.estado_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" + "\t" + "solicitud_id" + "\t" + "N/A" + "\t" + self.solicitud_id.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "creador" + "\t" + "N/A" + "\t" + self.creador.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "fechaEntrega" + "\t" + "N/A" + "\t" + self.fechaEntrega.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "fechaEmision" + "\t" + "N/A" + "\t" + self.fechaEmision.to_s + "\t" + descripcion + "\n")



		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "solicitud" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


	end	
	
    


	def cambiadaClasificacion(id)
		clasificacion = Clasificacion.find(id).nombre
		if clasificacion.eql?"publica"		
			self.estado_id = Estado.find_by_nombre("En tramite").id
			self.save
		end
		if clasificacion.eql?"incompleta"
			self.estado_id = Estado.find_by_nombre("Finalizada por incompletitud").id
			self.save
			justificacion = Justificacion.find_by_expediente_id(self.id)
			solicitud = Solicitud.find(self.solicitud_id)
			solicitud.update_attributes(:finalizada=>true)
			instituto = Institucion.find(solicitud.institucion_id)
			solicitante = Solicitante.find(solicitud.solicitante_id)
			ley= justificacion.leyAcuerdos[0]
			AplicationMailer.incompleta(solicitante.nombre,justificacion.descripcion,ley,instituto.nombre,solicitante.email ).deliver
		
		end
		if clasificacion.eql?"no competente"
			self.estado_id = Estado.find_by_nombre("Finalizada por que no compete a la institucion").id
			self.save
			justificacion = Justificacion.find_by_expediente_id(self.id)
			solicitud = Solicitud.find(self.solicitud_id)
			solicitud.update_attributes(:finalizada=>true)
			instituto = Institucion.find(solicitud.institucion_id)
			solicitante = Solicitante.find(solicitud.solicitante_id)
			ley= justificacion.leyAcuerdos[0]
			AplicationMailer.incompetente(solicitante.nombre,justificacion.descripcion,ley,instituto.nombre,solicitante.email ).deliver
		
		end

		if clasificacion.eql? "clasificada"
			self.estado_id = Estado.find_by_nombre("Finalizado Informacion Clasificada").id
			self.save
			justificacion = Justificacion.find_by_expediente_id(self.id)
			solicitud = Solicitud.find(self.solicitud_id)
			solicitud.update_attributes(:finalizada=>true)
			instituto = Institucion.find(solicitud.institucion_id)
			solicitante = Solicitante.find(solicitud.solicitante_id)
			ley= justificacion.leyAcuerdos[0]
			AplicationMailer.clasificada(solicitante.nombre,justificacion.descripcion,ley,instituto.nombre,solicitante.email ).deliver
		
		end

		if clasificacion.eql? "tramite de reservacion"
			self.estado_id = Estado.find_by_nombre("Suspendida").id
			self.save
			justificacion = Justificacion.find_by_expediente_id(self.id)
			solicitud = Solicitud.find(self.solicitud_id)
			instituto = Institucion.find(solicitud.institucion_id)
			solicitante = Solicitante.find(solicitud.solicitante_id)
			ley= justificacion.leyAcuerdos[0]
			AplicationMailer.reservacion(solicitante.nombre,justificacion.descripcion,ley,instituto.nombre,solicitante.email ).deliver
		
		end




	end
end
