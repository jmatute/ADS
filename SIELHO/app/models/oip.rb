class Oip < ActiveRecord::Base
	validates_presence_of :pnombre,:snombre,:papellido,:sapellido,:email,:institucion_id
	validates_uniqueness_of :email


	def crear()
			Users.create! do |u|
				 u.username = x.pnombre.slice(0,1) + x.snombre + x.papellido
				 u.rol_id = 2
				 u.activo = false
				 u.email = self.email
				 u.password = 'password'
				 u.password_confirmation = 'password'
			end
	end

end
