class TipoDocumento < ActiveRecord::Base
	validates_presence_of :regla,:nombre,:tipoPersona
	validates_uniqueness_of :regla,:nombre
end
