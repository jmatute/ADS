class EstadisticasController < ApplicationController
  def index
  	s =  Solicitud.export_users
	p s
  end

end
