Rol.new(:nombre=>"admin",:descripcion=>"administrador completo del sistema",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>0,:usuarioMod=>0).save()
Rol.new(:nombre=>"oip",:descripcion=>"oficial de informacion de una institucion",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1).save()
Rol.new(:nombre=>"enlace",:descripcion=>"enlace de un departamento dentro de una institucion",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1).save()

Clasificacion.new(:nombre=>"publica",:descripcion=>"La informacion solicitada se encuentra en dominio publico",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1).save()
Clasificacion.new(:nombre=>"tramite de reservacion",:descripcion=>"La informacion solicitada se encuentra en tramite de ser clasificada, la solicitud se suspendra hasta tener resultado",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1).save()
Clasificacion.new(:nombre=>"clasificada",:descripcion=>"La informacion solicitada se encuentra clasificada, no puede ser compartida con el publico general",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1).save()
Clasificacion.new(:nombre=>"incompleta",:descripcion=>"La solicitud se encuentra incompleta, no cuenta con la informacion lo suficientemente explicita",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1).save()
Clasificacion.new(:nombre=>"no competente",:descripcion=>"La solicitud fue hecha a una institucion en la cual no le compete la recoleccion de tal informacion",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1).save()

Estado.new(:nombre=>"Sin clasificar",:descripcion=>"La solicitud aun no ha sido vista por algun oip",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>0).save()
Estado.new(:nombre=>"Finalizada por incompletitud",:descripcion=>"La solicitud se encuentra incompleta, no cuenta con la informacion lo suficientemente explicita",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>1).save()
Estado.new(:nombre=>"Finalizada por que no compete a la institucion",:descripcion=>"La solicitud fue hecha a una institucion en la cual no le compete la recoleccion de tal informacion",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>1).save()
Estado.new(:nombre=>"Suspendida",:descripcion=>"La informacion solicitada se encuentra en tramite de ser clasificada, la solicitud se suspendra hasta tener resultado",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>1).save()
Estado.new(:nombre=>"En tramite",:descripcion=>"La informacion se encuentra publica, el tramite de recoleccion ha sido iniciado, plazo 10 dias laborales",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>1).save()
Estado.new(:nombre=>"Finalizado Informacion Clasificada",:descripcion=>"La informacion se encuentra publica, el tramite de recoleccion ha sido iniciado, plazo 10 dias laborales",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>1).save()

Estado.new(:nombre=>"Prorroga",:descripcion=>"Periodo de prorroga para la recopilacion de informacion",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>5).save()
Estado.new(:nombre=>"Entregado incompleto sin prorroga",:descripcion=>"Informacion no pudo ser recopilada",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>5).save()
Estado.new(:nombre=>"Entregado parcial sin prorroga",:descripcion=>"Informacion fue entregada parcialmente",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>5).save()
Estado.new(:nombre=>"Entregado completo sin prorroga",:descripcion=>"Toda la informacion fue entregada ",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>5).save()
Estado.new(:nombre=>"Entregado incompleto con prorroga",:descripcion=>"Informacion no pudo ser recopilada",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>6).save()
Estado.new(:nombre=>"Entregado parcial con prorroga",:descripcion=>"Informacion fue entregada parcialmente",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>6).save()
Estado.new(:nombre=>"Entregado completo con prorroga",:descripcion=>"Toda la informacion fue entregada ",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1,:anterior_id=>6).save()

User.create! do |u|
	 u.username = "JEnriqueSuaazo1"
	 u.rol_id = 1
	 u.activo = true
	 u.email = "jenriquesuazoai@hotmail.com"
	 u.password = 'password'
	 u.password_confirmation = 'password'
	 x = Administrador.new                                                    
     x.email = u.email                                            
     x.save                               
end

Administrador.last.update_attributes(:usuario_id=>User.last.id,:pnombre=>"Javier",:snombre=>"Enrique",:papellido=>"Suazo",:sapellido=>"Medina",:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>1,:usuarioMod=>1)
