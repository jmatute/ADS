class BuscarController < ApplicationController
  def index

	unless params[:institucion].nil?
	@encontrados = Solicitud.buscar(params[:search],params[:institucion]["institucion"],params[:inicio],params[:final]) 
	end
  end
  def create
  end

end
