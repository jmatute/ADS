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

		if user.activo
			antes = "false"
			despues = "true"
		else
			antes = "true"
			despues = "false"
		end
		

		fecha = DateTime.now.to_s
		mod = current_user.id.to_s
		descripcion = "activar/desactivar usuario #{params[:id]}"
		rol = "admin"
		file = File.open("public/historial", "a")	
		file.write(fecha + "\t" + mod + "\t" + rol + "\t" + "user" + "\t" + "activo" + "\t" + antes + "\t" + descripcion + "\n")
		file.close
		uno = 1
		unless user.activo
			responsabilidad = Solicitud.where(:finalizada => false,:responsable=>user.id)
			responsabilidad.each do |r|
				r.update_attributes(:responsable=>current_user.id)
				descripcion = "transpasar responsabilidad de solicitudes"
				file = File.open("public/historial", "a")	
				file.write(fecha + "\t" + mod + "\t" + rol + "\t" + "solicitud" + "\t" + "responsable" + "\t" + user.id.to_s + "\t" + uno.to_s + "\t" +  descripcion + "\n")
				file.close()
			end				
		end
		redirect_to directorio_path
	end

	def activar_enlace
		user = User.find(Enlace.find(params[:id]).usuario_id)
		user.activo = !user.activo
		user.save
		if user.activo
			antes = "false"
			despues = "true"
		else
			antes = "true"
			despues = "false"
		end
		

		fecha = DateTime.now.to_s
		mod = current_user.id.to_s
		descripcion = "activar/desactivar usuario #{params[:id]}"
		rol = "oip"
		file = File.open("public/historial", "a")	
		file.write(fecha + "\t" + mod + "\t" + rol + "\t" + "user" + "\t" + "activo" + "\t" + antes + "\t" + despues + "\t" +  descripcion + "\n")
		file.close()
		unless user.activo
			responsabilidad = Asignacion.where(:completada => false,:enlace_id=>user.id)
			responsabilidad.each do |r|
				x = Solicitud.find_by_expediente_id(r.expediente_id ).responsable
				r.update_attributes(:enlace_id=>x  )
				descripcion = "transpasar responsabilida de asignaciones"
				file = File.open("public/historial", "a")	
				file.write(fecha + "\t" + mod + "\t" + rol + "\t" + "asignacion" + "\t" + "enlaceid" + "\t" + user.id + "\t" + x +"\t" +  descripcion + "\n")
				file.close()
				
			end				
		end
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
