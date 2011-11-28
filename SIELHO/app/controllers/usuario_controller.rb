class UsuarioController < ApplicationController
	def new
		@oip = Oip.new
		@enlace = Enlace.new
		@instituciones = Institucion.instituciones()
		@departamentos = Departamento.departamentos(current_user.id)
	end

	def create
		if params.has_key? "oip"
			oip = Oip.new(params[:oip])
			if oip.save
				oip.crear(current_user.id)
				redirect_to directorio_path
			else
				redirect_to directorio_path
			end
		end

		if params.has_key? "enlace"
			enlace = Enlace.new(params[:enlace])
			if enlace.save
				enlace.crear(current_user.id)
				redirect_to directorio_path
			else
				redirect_to directorio_path
			end
		end



	end

	def directorio
		@oips = Oip.all
		@enlaces = Enlace.all
	end

	def activar_oip
		user = User.find(Oip.find(params[:id]).usuario_id)
		user.activo = !user.activo
		user.save
		redirect_to directorio_path
	end

	def activar_enlace
		user = User.find(Enlace.find(params[:id]).usuario_id)
		user.activo = !user.activo
		user.save
		redirect_to directorio_path
	end


	def modificar_oip
		@instituciones = Institucion.instituciones()
		@oip = Oip.find(params[:id]) 
	end

	def modificar_enlace
		@enlace = Enlace.find(params[:id])
		@departamentos = Departamento.departamentos(current_user.id)

	end

	def editoip
		@oip = Oip.find( params[:id])
		@oip.fechaMod = DateTime.now
		@oip.usuarioMod = current_user.id
		@oip.update_attributes(params[:oip])
		redirect_to directorio_path		
	end

	def editenlace
		@enlace = Enlace.find( params[:id])
		@enlace.fechaMod = DateTime.now
		@enlace.usuarioMod = current_user.id
		@enlace.update_attributes(params[:oip])
		redirect_to directorio_path		

	end
end
