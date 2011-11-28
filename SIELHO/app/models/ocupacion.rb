class Ocupacion < ActiveRecord::Base
	validates_presence_of :nombre
	validates_uniqueness_of :nombre
	
	def self.ocupaciones()
		x = []
		todos =Ocupacion.all
		todos.each do |i|
			x << [ i.nombre, i.id]
		end
		return x
	end

end
