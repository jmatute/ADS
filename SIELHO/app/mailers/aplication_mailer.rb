class AplicationMailer < ActionMailer::Base
#  default :from => "from@example.com"

  default :from => "iaip.sielho@gmail.com"  
  
  def enviarcorreo(user)  
    mail(:to => user, :subject => "Solicitud de Informacion Realizada con Exito")  
  end  
	
  def bienvenido(user,pass)
	@password=pass
	@user = user
	mail(:to => user.email, :subject => "Su usuario ha sido creado")
  end

  def incompleta(nombre,descripcion,ley,instituto,correo)
		@nombre=nombre
		@instituto = instituto
		@descripcion=descripcion
		@noley = ley.noLey
		@noacuerdo = ley.noAcuerdo
		@descripcion_ley = ley.descripcion
		mail(:to => correo, :subject => "Su solicitud se encuentra incompleta")
  end
  
	def incompetente(nombre,descripcion,ley,instituto,correo)
		@nombre=nombre
		@instituto = instituto
		@descripcion=descripcion
		@noley = ley.noLey
		@noacuerdo = ley.noAcuerdo
		@descripcion_ley = ley.descripcion
		mail(:to => correo, :subject => "Su solicitud no compete a la institucion")
  end

	def clasificada(nombre,descripcion,ley,instituto,correo)
		@nombre=nombre
		@instituto = instituto
		@descripcion=descripcion
		@noley = ley.noLey
		@noacuerdo = ley.noAcuerdo
		@descripcion_ley = ley.descripcion
		mail(:to => correo, :subject => "La informacion de su solicitud se encuentra clasificada")
  end
	
	def reservacion(nombre,descripcion,ley,instituto,correo)
		@nombre=nombre
		@instituto = instituto
		@descripcion=descripcion
		@noley = ley.noLey
		@noacuerdo = ley.noAcuerdo
		@descripcion_ley = ley.descripcion
		mail(:to => correo, :subject => "La informacion de su solicitud se encuentra en tramite de reservacion")
  end




  def nueva(correo,institucion)
		@institucion
		mail(:to=>correo, :subject => "Existe una nueva solicitud de informacion")
  end

  def recibo(correo)
		mail(:to=>correo,:subject => "Acuse de Recibo")
  end

  def cambioEstado(correo,estado,descripcion) 
		@estado = estado
		@descripcion = descripcion
		mail(:to=>correo,:subject => "Su solicitud ha cambiado de estado")
  end

  def asignacion(correo)
		mail(:to=>correo,:subject => "Tiene una nueva asignacion de informacion")
  end

  def recordatorio(correo,asignacion)
		@asignacion = asignacion
		mail(:to=>correo,:subject => "Recordatorio para la asignacion de informacion")
  end

 def correo_solicitante(correo, adjunto,path,numero,texto,titulo)
		unless adjunto.blank?
			attachments[adjunto] = File.read(path)
		end
		@texto = texto
		@titulo = titulo
		@numero = numero
		mail(:to=>correo ,:subject => "Informacion sobre su solicitud de informacion")
 end
end
