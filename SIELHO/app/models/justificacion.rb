class Justificacion < ActiveRecord::Base
	has_and_belongs_to_many :leyAcuerdos	

end
