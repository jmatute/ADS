class Ocupacion < ActiveRecord::Base
	validates_presence_of :nombre
	before_save :addinfo

	def addinfo
		fechaCrear = DateTime.now
		fechaMod = DateTime.now
		usuarioRes = current_user.id
		usuarioMod = current_user.id 
	end

end
