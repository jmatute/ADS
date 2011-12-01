class LeyAcuerdo < ActiveRecord::Base
	validates_presence_of :noLey,:noAcuerdo, :fechaGaceta,:descripcion
	validates :noLey, :format => { :with => /\A[0-9a-zA-Z\- ]+\z/, :message => " - Solo se permiten letras y numeros" } 
    validates :noAcuerdo, :format => { :with => /\A[0-9a-zA-Z\- ]+\z/, :message => " - Solo se permiten letras y numeros" } 
	has_and_belongs_to_many :justificacions 
end
