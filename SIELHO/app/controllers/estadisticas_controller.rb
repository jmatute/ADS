class EstadisticasController < ApplicationController
  def index
   Solicitud.export_users
  end

end
