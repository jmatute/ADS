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
		temp = Mensaje.find(params[:mensaje_id]).parsear
		Mensaje.find(params[:mensaje_id]).update_attributes(:borrado=>true)

		doc = Documento.new
		solicitante = Solicitante.new
		solicitud = Solicitud.new
		expediente = Expediente.new
		
		doc.crear(temp["documento"],current_user.id)
		solicitante.crear(temp["solicitante"],current_user.id,doc.id)	
		solicitud.crear(temp["solicitud"],Mensaje.find(params[:mensaje_id]).fecha,solicitante.id,current_user.id)
		expediente.crear(solicitud.id,current_user.id)
		solicitud.expediente_id = expediente.id
		solicitud.save	
		temp = Mensaje.find(params[:mensaje_id])
		temp.expediente_id = expediente.id
		
		@clasificaciones = Clasificacion.all
		@leyes= LeyAcuerdo.all
		@justificacion = Justificacion.new
	end

	def pendiente
		@solicitudes = Solicitud.all
	end

	def justificar
		@justificacion = Justificacion.new(params[:justificacion])
		@justificacion.leyAcuerdos << LeyAcuerdo.find(params[:ley])
		@justificacion.expediente_id = Mensaje.find(params[:mensaje_id]).expediente_id
		p @justificacion
		@justificacion.save		
	end	
end
