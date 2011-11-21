class ParametrizacionController < ApplicationController
	def index
		@departamento = Departamento.new()
		@tipodocumento = TipoDocumento.new()
		@estado = Estado.new()
		@institucion = Institucion.new()
		@ocupacion = Ocupacion.new()
		@leyAcuerdo = LeyAcuerdo.new()
		@estados = Estado.all()
		flash[:notice] = ""
	end

	def create
		if params.has_key? "departamento"

		end
		if params.has_key? "ocupacion"
			@ocupacion = Ocupacion.new(params[:ocupacion])
			@ocupacion.usuarioMod = current_user.id
			@ocupacion.usuarioRes = current_user.id
			@ocupacion.fechaCrear = DateTime.now
			@ocupacion.fechaMod = DateTime.now
			if @ocupacion.save()
				flash[:notice] = "Nueva Ocupacion creada "
			elsif
				flash[:notice] = "No se pudo crear la ocupacion"
			end	
		end
		if params.has_key? "estado"

		end
		if params.has_key? "tipo_documento"
			@tipodocumento = TipoDocumento.new(params[:ocupacion])
			@tipodocumento.usuarioMod = current_user.id
			@tipodocumento.usuarioRes = current_user.id
			@tipodocumento.fechaCrear = DateTime.now
			@tipodocumento.fechaMod = DateTime.now
			if @ocupacion.save()
				flash[:notice] = "Nuevo Tipo Documento creado "
			elsif
				flash[:notice] = "No se pudo crear la ocupacion"
			end	
		end
		if params.has_key? "ley_acuerdo"

		end
		if params.has_key? "institucion"

		end


	end
end
