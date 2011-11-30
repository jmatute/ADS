class SolicitudController < ApplicationController

	def solicitud_natural
		@solicitante = Solicitante.new
		@instituciones = Institucion.instituciones()
		@ocupaciones = Ocupacion.ocupaciones()
		@solicitud = Solicitud.new
		@documento = Documento.new
	end

	def solicitud_juridica
		@solicitante = Solicitante.new
		@solicitud = Solicitud.new
		@ocupaciones = Ocupacion.ocupaciones()
		@instituciones = Institucion.instituciones()
		@documento = Documento.new
	end

	def create
		if Mensaje.solicitudValida(params) == []
			Mensaje.NuevaSolicitud(params)
		else
			@errores = Mensaje.solicitudValida(params)
		end	
	end

	def clasificar

	end
	
end
