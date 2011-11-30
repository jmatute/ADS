class TipoDocumento < ActiveRecord::Base
	validates_presence_of :regla,:nombre,:tipoPersona
	validates_uniqueness_of :regla,:nombre
    validates :nombre, :format => { :with => /\A[a-zA-Z]+\z/, :message => " - Solo se permiten letras" } 
    validates :regla, :format => { :with => /\A[A#-]+\z/, :message => " - Solo se '#' para numeros 'A' para letras " } 
	
end
