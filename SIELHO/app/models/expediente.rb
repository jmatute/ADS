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





	end
end
