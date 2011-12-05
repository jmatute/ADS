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
end
