require "rubygems"
require "rufus/scheduler"

## to start scheduler
scheduler = Rufus::Scheduler.start_new

## It will print message every i minute

scheduler.every("1m") do
#AplicationMailer.enviarcorreo("javier_suazo@live.com").deliver
	a = File.open("public/plazo","r")
	plazo = a.read().gsub("\n","").to_i
	a.close()
	todas = Solicitud.where(:finalizada => false)
	todas.each do |t|
		if Estado.find(Expediente.find(t.expediente_id).estado_id).nombre.eql?("En tramite")
			diferencia = (DateTime.now.to_i - t.fecha.to_i)/(60*60*24.0)
			if diferencia > plazo
				justificacion = Justificacion.new(:descripcion=>"Se ha cumplido el plazo maximo, se creara una prorroga para la recopilacion de informacion")
				justificacion.leyAcuerdos << LeyAcuerdo.first
				justificacion.fecha_cambio = DateTime.now
				justificacion.expediente_id = t.expediente_id
     			justificacion.basics(0)
        		justificacion.estado = Estado.find_by_nombre("Prorroga").nombre
        		justificacion.clasificacion =  Clasificacion.find(t.clasificacion_id).nombre
				id = Estado.find_by_nombre("Prorroga").id
				expediente = Expediente.find( t.expediente_id)
				expediente.estado_id = id
        		justificacion.save
				expediente.save
                AplicationMailer.cambioEstado(  Solicitante.find(t.solicitante_id).email,justificacion.estado,justificacion.descripcion).deliver

			end
		elsif Estado.find(Expediente.find(t.expediente_id).estado_id).nombre.eql?("Prorroga")
			diferencia = (DateTime.now.to_i - t.fecha.to_i)/(60*60*24.0)
			if diferencia > (2*plazo) && t.finalizada == false
				justificacion = Justificacion.new(:descripcion=>"Se ha cumplido el plazo maximo, la solicitud ha sido cerrada insatisfactoriamente")
				e = t.expediente_id
				justificacion.leyAcuerdos << LeyAcuerdo.first
				justificacion.fecha_cambio = DateTime.now
				justificacion.expediente_id = e
     			justificacion.basics(0)
        		justificacion.estado = "Entregado incompleto con prorroga"
        		justificacion.clasificacion =  "publica"
				id = Estado.find_by_nombre("Entregado incompleto con prorroga").id
				expediente = Expediente.find( e)
				expediente.estado_id = id
        		justificacion.save
				expediente.save
                AplicationMailer.cambioEstado(  Solicitante.find(t.solicitante_id).email,justificacion.estado,justificacion.descripcion).deliver
				t.finalizada = true
				t.save
			end
		end



	end


end
	
scheduler.every("3m") do
#AplicationMailer.enviarcorreo("javier_suazo@live.com").deliver
	a = File.open("public/plazo","r")
	plazo = a.read().gsub("\n","").to_i
	a.close()
	todas = Solicitud.where(:finalizada => false)
	todas.each do |t|
		if Estado.find(Expediente.find(t.expediente_id).estado_id).nombre.eql?("Prorroga")
			diferencia = (DateTime.now.to_i - t.fecha.to_i)/(60*60*24.0)
			if diferencia > (2*plazo) && t.finalizada == false
				justificacion = Justificacion.new(:descripcion=>"Se ha cumplido el plazo maximo, la solicitud ha sido cerrada insatisfactoriamente")
				e = t.expediente_id
				justificacion.leyAcuerdos << LeyAcuerdo.first
				justificacion.fecha_cambio = DateTime.now
				justificacion.expediente_id = e
     			justificacion.basics(0)
        		justificacion.estado = "Entregado incompleto con prorroga"
        		justificacion.clasificacion =  "publica"
				id = Estado.find_by_nombre("Entregado incompleto con prorroga").id
				expediente = Expediente.find( e)
				expediente.estado_id = id
        		justificacion.save
				expediente.save
                AplicationMailer.cambioEstado(  Solicitante.find(t.solicitante_id).email,justificacion.estado,justificacion.descripcion).deliver
				t.finalizada = true
				t.save
			end
		end



	end


end
	
scheduler.every("5m") do
#AplicationMailer.enviarcorreo("javier_suazo@live.com").deliver
	a = File.open("public/plazo","r")
	plazo = a.read().gsub("\n","").to_i
	a.close()
	asignaciones = Asignacion.where(:completada=>false)
	asignaciones.each do |a|
		diferencia = (DateTime.now.to_i - a.fechaInic.to_i)/(60*60*24.0)
		cantidad = a.plazo
		if diferencia >= cantidad
			correo = User.find(a.enlace_id).email
			AplicationMailer.recordatorio(correo, a).deliver	
		end
	end
end
## Prints the message every day at noon
#scheduler.cron("0,2 * * * *") do
#end

#scheduler.in '20m' do
#    puts User.last.username
#	puts "order butter"
#end
