class TipoDocumento < ActiveRecord::Base
	validates_presence_of :regla,:nombre,:tipoPersona
	validates_uniqueness_of :regla,:nombre
    validates :nombre, :format => { :with => /\A[a-zA-Z]+\z/, :message => " - Solo se permiten letras" } 
    validates :regla, :format => { :with => /\A[A#-]+\z/, :message => " - Solo se '#' para numeros 'A' para letras " } 


	def cambiarARegexRegla()
		cad = self.regla.gsub("#","[0-9]")
		cad = cad.gsub("A","[A-Z]")
		cad = "\\A" + cad + "\\z"
		return Regexp.new(cad)
	end

	def self.documentos(tipo)
		document = TipoDocumento.where( :tipoPersona => tipo)
		res = []
		document.each do |d|
			res << [d.nombre,d.id]
		end
		return res 
	end
	
	def validar(cadena)
		return !self.cambiarARegexRegla().match(cadena).nil?
	end	
end
