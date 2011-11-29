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
end
