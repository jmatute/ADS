class LeyAcuerdo < ActiveRecord::Base
	validates_presence_of :noLey,:noAcuerdo, :fechaGaceta,:descripcion
	validates_numericality_of :noLey,:format => { :message => " - Solo se permiten numeros" } 
	validates_numericality_of :noAcuerdo,:format => {:message => " - Solo se permiten numeros" } 



end
