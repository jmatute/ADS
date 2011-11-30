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
		@mensaje = Mensaje.new
		@usuarios = User.all
		@destinos = User.destinos(current_user.id)
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
