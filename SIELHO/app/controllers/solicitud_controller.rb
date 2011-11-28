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
		redirect_to root_path
	end
end
