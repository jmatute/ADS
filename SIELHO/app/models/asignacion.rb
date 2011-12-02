class Asignacion < ActiveRecord::Base
	validates_presence_of :expediente_id,:enlace_id,:descripcion

end
