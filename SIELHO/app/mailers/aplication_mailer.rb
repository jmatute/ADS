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
end
