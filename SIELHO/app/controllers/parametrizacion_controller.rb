class ParametrizacionController < ApplicationController
	def index
		@departamento = Departamento.new()
		@tipodocumento = TipoDocumento.new()
		@estado = Estado.new()
		@institucion = Institucion.new()
		@ocupacion = Ocupacion.new()
		@leyAcuerdo = LeyAcuerdo.new()
		@estados = Estado.all()
		@parametrizar = params[:parametrizar]
		flash[:notice] = ""
	end

	def create
		if params.has_key? "departamento"
			@departamento = Departamento.new(params[:departamento])
			@departamento.agregar(current_user.id)
			if @departamento.save()
				flash[:notice] = "Nueva Departamento creada "
			elsif
				flash[:notice] = "No se pudo crear la departamento"
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
			elsif
				flash[:notice] = "No se pudo crear la ocupacion"
			end	
		end
		if params.has_key? "estado"
			@estado = Estado.new(params[:estado])
			@estado.usuarioMod = current_user.id
			@estado.usuarioRes = current_user.id
			@estado.fechaCrear = DateTime.now
			@estado.fechaMod = DateTime.now
			if @estado.save()
				flash[:notice] = "Nuevo Estado creado "
			elsif
				flash[:notice] = "No se pudo crear el estado"
			end	

		end
		if params.has_key? "tipo_documento"
			@tipodocumento = TipoDocumento.new(params[:tipo_documento])
			@tipodocumento.usuarioMod = current_user.id
			@tipodocumento.usuarioRes = current_user.id
			@tipodocumento.fechaCrear = DateTime.now
			@tipodocumento.fechaMod = DateTime.now
			if @ocupacion.save()
				flash[:notice] = "Nuevo Tipo Documento creado "
			elsif
				flash[:notice] = "No se pudo crear el tipo de documento"
			end	
		end
		if params.has_key? "ley_acuerdo"
			@leyAcuerdo = LeyAcuerdo.new(params[:ley_acuerdo])
			@leyAcuerdo.usuarioMod = current_user.id
			@leyAcuerdo.usuarioRes = current_user.id
			@leyAcuerdo.fechaCrear = DateTime.now
			@leyAcuerdo.fechaMod = DateTime.now
			if @leyAcuerdo.save()
				flash[:notice] = "Nueva Ley/Acuerdo creado "
			elsif
				flash[:notice] = "No se pudo crear Ley/Acuerdo"
			end	

		end
		if params.has_key? "institucion"
			@institucion = Institucion.new(params[:institucion])
			@institucion.agregar(current_user.id)
			if @institucion.save()
				flash[:notice] = "Nueva Ley/Acuerdo creado "
			elsif
				flash[:notice] = "No se pudo crear Ley/Acuerdo"
			end	
		end
	end
end
