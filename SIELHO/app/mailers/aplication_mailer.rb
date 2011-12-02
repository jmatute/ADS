class AplicationMailer < ActionMailer::Base
#  default :from => "from@example.com"

  default :from => "iaip.sielho@gmail.com"  
  
  def enviarcorreo(user)  
    mail(:to => user, :subject => "Solicitud de Informacion Realizada con Exito")  
  end  
end
