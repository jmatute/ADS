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
		username = @oip.pnombre.slice(0,1) + @oip.snombre + @oip.papellido
		usuario = User.find(@oip.usuario_id)
		usuario.username = username
		usuario.save
		@oip.save
		@oip.update_attributes(params[:oip])
		redirect_to directorio_path		
	end

	def editenlace
		@enlace = Enlace.find( params[:id])
		@enlace.fechaMod = DateTime.now
		@enlace.usuarioMod = current_user.id
		@enlace.update_attributes(params[:oip])
		username = @enlace.pnombre.slice(0,1) + @enlace.snombre + @enlace.papellido
		usuario = User.find(@enlace.usuario_id)
		usuario.username = username
		usuario.save
		@oip.save
		@oip.update_attributes(params[:oip])
		redirect_to directorio_path		
	end


   def newPlazo
		
   end

   def createPlazo
       
		if params[:plazo].blank?
			flash[:alert] = "Debe ingresar un plazo"
			render :action=>"newPlazo"
			return
		end

		if /\A[0-9]+\z/.match(params[:plazo]).nil?
			flash[:alert] = "Debe ingresar un plazo numerico"
			render :action=>"newPlazo"
			return
		end

		plazo = params[:plazo].to_i
 		if plazo.eql? 0
			flash[:alert] = "El plazo debe ser mayor que cero"
			render :action=>"newPlazo"
			return

		end

		File.open('public/plazo', 'w') {|f| f.write(params[:plazo]) }
		redirect_to root_path
   end
end
