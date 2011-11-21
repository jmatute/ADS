class ParametrizacionController < ApplicationController
	def index
		@departamento = Departamento.new()
		@tipodocumento = TipoDocumento.new()
		@estado = Estado.new()
		@institucion = Institucion.new()
		@ocupacion = Ocupacion.new()
		@leyAcuerdo = LeyAcuerdo.new()
		@estados = Estado.all()
	end

	def create
		if params.has_key? "departamento"

		end
		if params.has_key? "ocupacion"
			if @ocupacion.save()
				flash[:notice] = "Nueva Ocupacion creada"
				render :action => 'index'
			elsif
				render :action => 'index'
			end	
		end
		if params.has_key? "estado"

		end
		if params.has_key? "tipo_documento"

		end
		if params.has_key? "ley_acuerdo"

		end
		if params.has_key? "institucion"

		end
	end
end
