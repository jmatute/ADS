class Enlace < ActiveRecord::Base
	def nombre()
		return self.pnombre + "  " + self.papellido
	end




	def crear(usuario)
		self.institucion_id = Oip.find_by_usuario_id(usuario).institucion_id
     	 self.usuarioMod = usuario
         self.usuarioRes = usuario
         self.fechaCrear = DateTime.now
         self.fechaMod = DateTime.now
		if self.email2.blank?
			self.email2 = ""
		end

		if self.tlf.blank?
			self.tlf = ""
		end
	
		pass = ActiveSupport::SecureRandom.base64(7)
		
		User.create! do |u|
			 u.username = self.pnombre.slice(0,1) + self.snombre + self.papellido
			 u.rol_id = 3
			 u.activo = false
			 u.email = self.email
			 u.password = pass
			 u.password_confirmation = pass
		end

		AplicationMailer.bienvenido(User.last,pass).deliver	
		self.usuario_id = User.last.id
		self.save
	end




end
