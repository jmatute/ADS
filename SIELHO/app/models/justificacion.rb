class Justificacion < ActiveRecord::Base
	has_and_belongs_to_many :leyAcuerdos	
	validates_presence_of :descripcion
end
