class ParametrizacionController < ApplicationController
	def index
	end

	def newocupacion
		@ocupacion = Ocupacion.new()
	end

	def newdepartamento
		@departamento = Departamento.new()
	end

	def newestado
		@estado = Estado.new()
		@estados = Estado.estados
	end

	def newleyacuerdo
		@leyAcuerdo = LeyAcuerdo.new()
	end

	def newinstitucion
		@institucion = Institucion.new()
	end

	def newtipodocumento
		@tipodocumento = TipoDocumento.new()
	end
	
	
	def create
		if params.has_key? "departamento"
			@departamento = Departamento.new(params[:departamento])
			@departamento.agregar(  Oip.find_by_usuario_id(current_user.id).institucion_id,current_user.id)
			if @departamento.save()
				@departamento.logC()
				flash[:notice] = "Nueva Departamento creado "
			elsif
				render :action => "newdepartamento"
			end	

		end
		if params.has_key? "ocupacion"
			@ocupacion = Ocupacion.new(params[:ocupacion])
			@ocupacion.usuarioMod = current_user.id
			@ocupacion.usuarioRes = current_user.id
			@ocupacion.fechaCrear = DateTime.now
			@ocupacion.fechaMod = DateTime.now
			if @ocupacion.save()
	    			flash[:notice] = "Nueva Ocupacion creada "
			else
					render :action => "newocupacion"
			end
		end
		if params.has_key? "estado"
			@estado = Estado.new(params[:estado])
			@estado.usuarioMod = current_user.id
			@estado.usuarioRes = current_user.id
			@estado.fechaCrear = DateTime.now
			@estado.fechaMod = DateTime.now
			if @estado.save()
				@estado.logC	
				flash[:notice] = "Nuevo Estado creado "
			elsif
					render :action => "newestado"
			end	

		end
		if params.has_key? "tipo_documento"
			@tipodocumento = TipoDocumento.new(params[:tipo_documento])
			@tipodocumento.usuarioMod = current_user.id
			
			@tipodocumento.usuarioRes = current_user.id
			@tipodocumento.fechaCrear = DateTime.now
			@tipodocumento.fechaMod = DateTime.now
			if @tipodocumento.save()
				@tipodocumento.logC
				flash[:notice] = "Nuevo Tipo Documento creado "
			elsif
	   			render :action => "newtipodocumento"	
			end
		end
		if params.has_key? "ley_acuerdo"
			@leyAcuerdo = LeyAcuerdo.new(params[:ley_acuerdo])
			@leyAcuerdo.usuarioMod = current_user.id
			@leyAcuerdo.usuarioRes = current_user.id
			@leyAcuerdo.fechaCrear = DateTime.now
			@leyAcuerdo.fechaMod = DateTime.now
			if @leyAcuerdo.save()
				@leyAcuerdo.logC
				flash[:notice] = "Nueva Ley/Acuerdo creado "
			elsif
	   			render :action => "newleyacuerdo"	
			end	

		end
		if params.has_key? "institucion"
			@institucion = Institucion.new(params[:institucion])
			@institucion.agregar(current_user.id)
			if @institucion.save()
				@institucion.logC
				flash[:notice] = "Nueva Institucion creada "
			elsif
				render :action => "newinstitucion"
			end	
		end
	end
end
