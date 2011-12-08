class MensajesController < ApplicationController

	def index
		@mensajes = Mensaje.where(:destinatario_id=>params[:id],:borrado=>false)
	end
	def leido
		m = Mensaje.find(params[:mensaje_id])
		m.leido = true
		m.fechaMod = DateTime.now
		m.usuarioMod = current_user.id
		m.save
		redirect_to inbox_path 
	end

	def download
		@mensaje = Mensaje.find(params[:mensaje_id])
		unless @mensaje.document_file_name.nil?
			send_file "public/mensajes/documents/#{@mensaje.id}/original_#{@mensaje.document_file_name}",:type=>@mensaje.document_content_type
		end
	end
	def new
		@mensaje = Mensaje.new()
		@usuarios = User.all()
		@destinos = User.destinos(current_user.id)
		temp = Solicitud.solicitudes(current_user.id)
		@solicitudes = []
		temp.each do |t|
			@solicitudes << [t.numero,t.expediente_id]
		end
	end


    def nuevo
		@mensaje = Mensaje.new()
		@solicitud = Solicitud.find(params[:solicitud_id])
		@destinos = [ [ User.find(@solicitud.responsable).username , @solicitud.responsable] ]
		@solicitudes = [ [@solicitud.numero,@solicitud.expediente_id]]
		@asignacion = Asignacion.where(:enlace_id=>current_user.id,:expediente_id=>@solicitud.expediente_id,:completada=>false)[0]
		render :action => "new"
	end

	def borrado
		m = Mensaje.find(params[:mensaje_id])
		m.borrado = true
		m.fechaMod = DateTime.now
		m.usuarioMod = current_user.id
		m.save
		redirect_to inbox_path
	
	end

	def show
		@mensaje = Mensaje.find(params[:mensaje_id])
		@mensaje.leido = true
		@mensaje.fechaMod = DateTime.now
		@mensaje.usuarioMod = current_user.id
		@mensaje.save
		@solicitudes = Solicitud.all
		if @mensaje.esNuevaSolicitud
			@informacion = @mensaje.parsear
		end		
	end

	def create
		x = Mensaje.crear(params)
		Mensaje.last.logC
		redirect_to root_path
	end

	def historial
		@mensajes = Mensaje.where(:emisor_id=>params[:id])
	end

end
