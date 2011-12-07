class BuscarController < ApplicationController
  def index
	@encontrados = Solicitud.buscar(params[:search],1,params[:inicio],params[:final])
  end

  def create
  end

end
