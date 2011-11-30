class SolicitudController < ApplicationController

	def solicitud_natural
		@solicitante = Solicitante.new
		@instituciones = Institucion.instituciones()
		@ocupaciones = Ocupacion.ocupaciones()
		@solicitud = Solicitud.new
		@documento = Documento.new
		@tipoDocumentos = TipoDocumento.documentos(1)
	end

	def solicitud_juridica
		@solicitante = Solicitante.new
		@solicitud = Solicitud.new
		@ocupaciones = Ocupacion.ocupaciones()
		@instituciones = Institucion.instituciones()
		@tipoDocumentos = TipoDocumento.documentos 2
		@documento = Documento.new
	end

	def create
		if Mensaje.solicitudValida(params) == []
			Mensaje.NuevaSolicitud(params)
		else
			@errores = Mensaje.solicitudValida(params)
			unless params[:documento][:tipoDocumento_id].blank?
				if TipoDocumento.find(params[:documento][:tipoDocumento_id]).tipoPersona == 1
					@solicitante = Solicitante.new
					@instituciones = Institucion.instituciones()
					@ocupaciones = Ocupacion.ocupaciones()
					@solicitud = Solicitud.new
					@documento = Documento.new
					@tipoDocumentos = TipoDocumento.documentos(1)
					render :action => "solicitud_natural"
					return
				else
			
					render :action => "solicitud_juridica"
					return
				end
			end
		end
		redirect_to root_path	
	end

	def clasificar

	end
	
end
