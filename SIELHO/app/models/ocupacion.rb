class Ocupacion < ActiveRecord::Base
	validates_presence_of :nombre
	validates_uniqueness_of :nombre
end
