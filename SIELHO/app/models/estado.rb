class Estado < ActiveRecord::Base
	validates_presence_of :nombre,:descripcion,:anterior_id
    validates :nombre, :format => { :with => /\A[a-zA-Z ]+\z/, :message => " - Solo se permiten letras" } 
	
	def self.estados()
		x = []
		todos =Estado.all
		todos.each do |i|
			x << [ i.nombre, i.id]
		end
		x << ["ninguno",0]
		return x
	end

	def posible()



	end
end
