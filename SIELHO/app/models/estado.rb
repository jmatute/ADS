class Estado < ActiveRecord::Base
	validates_presence_of :nombre,:descripcion

end
