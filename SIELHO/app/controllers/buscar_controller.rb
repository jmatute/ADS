class BuscarController < ApplicationController
  def index
  	@i = Institucion.all
	@encontados = Solicitud.buscar(params[:search], params[:institucion],params[:inicio],params[:final])
  end

  def create
  end

end
