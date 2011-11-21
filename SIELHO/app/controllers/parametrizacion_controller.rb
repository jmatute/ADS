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
		p @departamento 
		p @tipodocumento 
		p @estado
		p @institucion 
		p @ocupacion 
		p @leyAcuerdo
		p @estados 
	end
end
