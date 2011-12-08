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
			@errors = Mensaje.solicitudValida(params)
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
					@solicitante = Solicitante.new
					@instituciones = Institucion.instituciones()
					@ocupaciones = Ocupacion.ocupaciones()
					@solicitud = Solicitud.new
					@documento = Documento.new
					@tipoDocumentos = TipoDocumento.documentos(1)
			



					render :action => "solicitud_juridica"
					return
				end
			else
					@solicitante = Solicitante.new
					@instituciones = Institucion.instituciones()
					@ocupaciones = Ocupacion.ocupaciones()
					@solicitud = Solicitud.new
					@documento = Documento.new
					@tipoDocumentos = TipoDocumento.documentos(1)
				render :action => "solicitud_natural"
				return
			end
				
		end
		redirect_to root_path	
	end

	def clasificar
		temp = Mensaje.find(params[:mensaje_id]).parsear
		Mensaje.find(params[:mensaje_id]).update_attributes(:leido=>true,:borrado=>true)
		
		if Solicitud.where(:fecha=>Mensaje.find(params[:mensaje_id]).fecha() ).blank?
			doc = Documento.new
			solicitante = Solicitante.new
			solicitud = Solicitud.new
			expediente = Expediente.new		
			doc.crear(temp["documento"],current_user.id)
			solicitante.crear(temp["solicitante"],current_user.id,doc.id)	
			solicitante.logC
			solicitud.crear(temp["solicitud"],Mensaje.find(params[:mensaje_id]).fecha,solicitante.id,current_user.id)
			expediente.crear(solicitud.id,current_user.id)
			solicitud.expediente_id = expediente.id
			solicitud.save
			@s = solicitud
			@s.logC
			AplicationMailer.recibo(solicitante.email).deliver	
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
		unless current_user.rol.nombre.eql? "admin"
			@asignacion = Asignacion.where(:enlace_id => current_user.id )
		end

		if current_user.rol.nombre.eql? "oip"
			@asignaciones = Oip.find_by_usuario_id(current_user.id).asignaciones
		end	
	end

	def justificar
		@justificacion = Justificacion.new(params[:justificacion])
		@justificacion.leyAcuerdos << LeyAcuerdo.find(params[:ley])
		e =Mensaje.find(params[:mensaje_id]).expediente_id
		@justificacion.expediente_id = e	
		@justificacion.fecha_cambio = DateTime.now
		@justificacion.basics(current_user.id)
		@justificacion.save	
		Expediente.find(e).cambiadaClasificacion(params[:clasificacion])
		Solicitud.find_by_expediente_id(e).update_attributes(:clasificacion_id=>params[:clasificacion]	)
		@justificacion.clasificacion = Clasificacion.find(Solicitud.find_by_expediente_id(e).clasificacion_id).nombre
		@justificacion.estado = Estado.find(Expediente.find(e).estado_id).nombre
		@justificacion.save
		@justificacion.logC
		redirect_to ver_expediente_path(Solicitud.find_by_expediente_id(@justificacion.expediente_id),Expediente.find( @justificacion.expediente_id) )
	end


	def justificarCambio
		@justificacion = Justificacion.new(:descripcion=>params[:descripcion])
		@justificacion.leyAcuerdos << LeyAcuerdo.find(params[:ley])
		@justificacion.fecha_cambio = DateTime.now
		@justificacion.expediente_id = params[:expediente_id]
		@justificacion.basics(current_user.id)
		@justificacion.estado = Estado.find(params[:Estado]).nombre
		if @justificacion.estado.starts_with? "Entregado"
			Solicitud.find_by_expediente_id(@justificacion.expediente_id).update_attributes(:finalizada=>true)
		end
		@justificacion.clasificacion = 	Clasificacion.find(Solicitud.find_by_expediente_id(params[:expediente_id]).clasificacion_id).nombre
		@expediente = Expediente.find(params[:expediente_id]).update_attributes(:estado_id=>params[:Estado])
		@justificacion.save
		@justificacion.logC
		AplicationMailer.cambioEstado(	Solicitante.find(Solicitud.find_by_expediente_id(@justificacion.expediente_id).solicitante_id).email,@justificacion.estado,@justificacion.descripcion).deliver
		redirect_to ver_expediente_path(Solicitud.find_by_expediente_id(@justificacion.expediente_id),Expediente.find( @justificacion.expediente_id) )
	end

	def	show
		@solicitud = Solicitud.find(params[:solicitud_id])
		@expediente = Expediente.find(params[:expediente_id])
		@mensajes = Mensaje.where(:expediente_id=>params[:expediente_id])
		@asignacion = Asignacion.where(:expediente_id=>params[:expediente_id])	
	    @cambios = Justificacion.where(:expediente_id=>params[:expediente_id])
	end	

	def estado
		@estados = Estado.where(:anterior_id=> Expediente.find(params[:expediente_id]).estado_id)
		@leyes= LeyAcuerdo.all
		@justificacion = Justificacion.new
		@solicitud = params[:solicitud_id]
		@expediente = params[:expediente_id]
		
	end

	def asignar
		temp = Enlace.where(:institucion_id=> Oip.find_by_usuario_id(current_user.id).institucion_id)
		@enlaces = []
		temp.each do |t|
			@enlaces << [t.nombre,t.usuario_id]
		end
		temp2 = Solicitud.where( :responsable=> current_user.id)
		@solicitudes = []
		temp2.each do |t|
			unless t.finalizada
				@solicitudes << [t.numero,t.expediente_id]
			end
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
		@asignacion.completada = false
		AplicationMailer.asignacion(User.find(@asignacion.enlace_id).email).deliver
		@asignacion.save
		@asignacion.logC
		redirect_to root_path

	end

	def reclasificar
		@justificacion = Justificacion.new(:descripcion=>"Se ha llegado a un consenso sobre la clasificacion de la informacion")
		@justificacion.leyAcuerdos << LeyAcuerdo.first
		@justificacion.expediente_id = params[:expediente_id]	
		e = params[:expediente_id]
		@justificacion.fecha_cambio = DateTime.now
		@justificacion.basics(current_user.id)
		@justificacion.save	
		id = Clasificacion.find_by_nombre(params[:clasificacion])
		Expediente.find(e).cambiadaClasificacion(id)
		Solicitud.find_by_expediente_id(e).update_attributes(:clasificacion_id=>id)
		@justificacion.clasificacion = Clasificacion.find(Solicitud.find_by_expediente_id(e).clasificacion_id).nombre
		@justificacion.estado = Estado.find(Expediente.find(e).estado_id).nombre
		@justificacion.save
		x = Solicitud.find(params[:solicitud_id])
		if params[:clasificacion].eql? "publica"
			x.fecha = DateTime.now
			x.save
		end
		redirect_to ver_expediente_path(Solicitud.find_by_expediente_id(@justificacion.expediente_id),Expediente.find( @justificacion.expediente_id) )


 	end
	
	def reasignar
		s = Solicitud.find(params[:solicitud_id])
		s.update_attributes(:responsable=>params[:nuevo])
		@solicitudes = Solicitud.all
		if current_user.rol.nombre.eql? "enlace"
			@asignacion = Asignacion.where(:enlace_id => current_user.id )
		end
		render :action=>"pendiente"
	end

	def completar
		Asignacion.find(params[:asignacion_id]).update_attributes(:completada=>true)
		@solicitudes = Solicitud.all
		if current_user.rol.nombre.eql? "enlace"
			@asignacion = Asignacion.where(:enlace_id => current_user.id )
		end
		render :action=>"pendiente"		
	end

end

