class EstadisticasController < ApplicationController
  require 'fastercsv'
  
  def index
	if params[:inicio] && params[:final] && [:institucion]
	if Solicitud.all && Clasificacion.all && Institucion.all
	  solicitudes = Solicitud.all
	  solicitudes2 = []
	    solicitudes.each do |y|
	      temp = y.fecha.strftime("%m-%d-%Y")
		      if temp >= params[:final].to_s && temp <= params[:inicio].to_s && y.institucion_id == params[:institucion]["institucion"].to_i
			  solicitudes2 << y
		      end
	      end
	end
	 publicas = []
	 privadas = []
	 otras = []
	 
	 solicitudes2.each do |z|
	     if Clasificacion.find_by_id(z.clasificacion_id).blank? || Clasificacion.find_by_id(z.clasificacion_id).nil?
	      otras << z
	     else
	    if Clasificacion.find_by_id(z.clasificacion_id).nombre == "publica"
	       publicas << z
	    end
	    if Clasificacion.find_by_id(z.clasificacion_id).nombre == "clasificada"
	      privadas << z
	    end
	     end
	  end
	  hola = Institucion.find_by_id(params[:institucion]["institucion"].to_i).nombre
	  
	  @outfile = "stats_" + Time.now.strftime("%m-%d-%Y") + ".csv"
	  csv_data = FasterCSV.generate do |csv|
	  csv << ["Fecha del Reporte","Institucion Obligada","Solicitudes Realizadas", "Solicitudes Otorgadas", "Solicitudes Denegadas","Solicitudes en Proceso"]
	
		1.times do |user|
		  csv << [
		    DateTime.now.strftime("%d-%m-%Y"),
		    hola,
		    solicitudes2.size,
		    publicas.size,
		    privadas.size,
		    otras.size,
		]
		end
	  end
 
	  send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{@outfile}"
 

	end


	  
	
  end

end
