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
			AplicationMailer.enviarcorreo(params["solicitante"]["email"]).deliver
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
		
		if Solicitud.where(:fecha=>Mensaje.find(params[:mensaje_id]).fecha() ).blank?
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
	    	temp.save
		end	
		@clasificaciones = Clasificacion.all
		@leyes= LeyAcuerdo.all
		@justificacion = Justificacion.new
	end

	def pendiente
		@solicitudes = Solicitud.all
	
		if current_user.rol.nombre.eql? "enlace"
			@asignacion = Asignacion.where(:enlace_id => current_user.id )
		end
	end

	def justificar
		@justificacion = Justificacion.new(params[:justificacion])
		@justificacion.leyAcuerdos << LeyAcuerdo.find(params[:ley])
		e =Mensaje.find(params[:mensaje_id]).expediente_id
		@justificacion.expediente_id = e	
		@justificacion.save	
		Expediente.find(e).cambiadaClasificacion(params[:clasificacion])
		Solicitud.find_by_expediente_id(e).update_attributes(:clasificacion_id=>params[:clasificacion]	)
		redirect_to ver_expediente_path(Solicitud.find_by_expediente_id(@justificacion.expediente_id),Expediente.find( @justificacion.expediente_id) )
	end

	def	show
		@solicitud = Solicitud.find(params[:solicitud_id])
		@expediente = Expediente.find(params[:expediente_id])
		@mensajes = Mensaje.where(:expediente_id=>params[:expediente_id])
		@asignacion = Asignacion.where(:expediente_id=>params[:expediente_id])	
	end	

	def estado
		@estados = Estado.all
		@leyes= LeyAcuerdo.all
		@justificacion = Justificacion.new
		
	end

	def asignar
		temp = Enlace.where(:institucion_id=> Oip.find_by_usuario_id(current_user.id).institucion_id)
		@enlaces = []
		temp.each do |t|
			@enlaces << [t.nombre,t.usuario_id]
		end
		temp2 = Solicitud.where( :institucion_id=> Oip.find_by_usuario_id(current_user.id).institucion_id)
		@solicitudes = []
		temp2.each do |t|
			@solicitudes << [t.numero,t.expediente_id]
		end	
		@asignar = Asignacion.new
	end

	def asignaEnlace
		@asignacion = Asignacion.new(params[:asignacion])
		@asignacion.fechaInic = DateTime.now
		@asignacion.usuarioMod = current_user.id
		@asignacion.usuarioRes = current_user.id
		@asignacion.fechaCrear = DateTime.now
		@asignacion.fechaMod = DateTime.now
		@asignacion.save
		redirect_to root_path

	end
end
