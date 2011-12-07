class BuscarController < ApplicationController
  def index
#	p params[:inicio]["(1i)"]
 #       p params[:inicio]["(2i)"]
#	p params[:inicio]["(3i)"]

#	p "asdddddddddddddddddddddddddddddddddddd"

	unless params[:institucion].nil?
	@encontrados = Solicitud.buscar(params[:search],params[:institucion]["institucion"],params[:inicio],params[:final])
  
	end
  end
  def create
  end

end
