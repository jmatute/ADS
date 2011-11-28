class UsuarioController < ApplicationController
	def new
		@oip = Oip.new
		@enlace = Enlace.new
		@instituciones = Institucion.instituciones()
	end

	def create
		if params.has_key? "oip"
			oip = Oip.new(params[:oip])
			if oip.save
				oip.crear(current_user.id)
				redirect_to root_path
			else
				redirect_to root_path
			end
		end
	end

	def directorio
		@oips = Oip.all
		@enlaces = Enlace.all
	end

	def activar


		redirect_to root_path
	end
end
