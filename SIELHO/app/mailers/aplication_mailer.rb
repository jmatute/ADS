class AplicationMailer < ActionMailer::Base
#  default :from => "from@example.com"

  default :from => "iaip.sielho@gmail.com"  
  
  def enviar_correo(user)  
    mail(:to => user, :subject => "Solicitud Realizada con Exito")  
  end  
end
