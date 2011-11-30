class Ocupacion < ActiveRecord::Base
	validates_presence_of :nombre , :format => {:message => " Ocupacion no puede ser en blanco "}
	validates_uniqueness_of :nombre, :format => { :message => "  - Ocupacion con ese nombre ya existe" }
    validates :nombre, :format => { :with => /\A[a-zA-Z]+\z/, :message => " - Solo se permiten letras" } 
	

     def self.ocupaciones()
		x = []
		todos =Ocupacion.all
		todos.each do |i|
			x << [ i.nombre, i.id]
		end
		return x
	end


end
