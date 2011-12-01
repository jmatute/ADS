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
end
