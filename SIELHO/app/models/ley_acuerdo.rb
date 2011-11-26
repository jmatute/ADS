class LeyAcuerdo < ActiveRecord::Base
	validates_presence_of :noLey,:noAcuerdo, :fechaGaceta,:descripcion


end
