class Institucion < ActiveRecord::Base
	validates_presence_of :nombre, :tipo_institucion
	validates_uniqueness_of :nombre

end
