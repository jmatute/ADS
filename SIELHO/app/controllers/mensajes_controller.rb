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

	def new
		@mensaje = Mensaje.new()
		@usuarios = User.all()
		@destinos = User.destinos(current_user.id)
<<<<<<< HEAD
	#	send_file('/home/javier/Dropbox/Analisis/SIELHO/public/images/1.jpg')
=======
		temp = Solicitud.solicitudes(current_user.id)
		@solicitudes = []
		temp.each do |t|
			@solicitudes << [t.numero,t.expediente_id]
		end
>>>>>>> af835e36b7b57157574616f1a3211086a565c1c9
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
		redirect_to root_path
	end

	def historial
		@mensajes = Mensaje.where(:emisor_id=>params[:id])
	end

end
