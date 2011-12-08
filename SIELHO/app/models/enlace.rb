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
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = usuario
		rol = User.find(usuario).rol.nombre
		descripcion = "creacion de usuario"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "user" + "\t" + "username" + "\t" + "N/A" + "\t" + User.last.username + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "user" +  "\t" + "email" + "\t" + "N/A" + "\t" + self.email + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "user" +  "\t" + "activo" + "\t" + "N/A" + "\t" + "false" + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "user" +  "\t" + "rol_id" + "\t" + "N/A" + "\t" + 3.to_s + "\t" + descripcion + "\n")
		file.close()
		
		AplicationMailer.bienvenido(User.last,pass).deliver	
		self.usuario_id = User.last.id
		self.save


		file = File.open("public/historial", "a")
		descripcion = "creacion de enlace"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "usuario_id" + "\t" + "N/A" + "\t" + self.usuario_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "departamento" + "\t" + "N/A" + "\t" + self.departamento_id.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "institucion" + "\t" + "N/A" + "\t" + self.institucion_id.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "pnombre" + "\t" + "N/A" + "\t" + self.pnombre + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "snombre" + "\t" + "N/A" + "\t" + self.snombre + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "papellido" + "\t" + "N/A" + "\t" + self.papellido + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "sapellido" + "\t" + "N/A" + "\t" + self.sapellido + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "sapellido" + "\t" + "N/A" + "\t" + self.sapellido + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "email" + "\t" + "N/A" + "\t" + self.email + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "email2" + "\t" + "N/A" + "\t" + self.email2 + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "enlace" + "\t" + "tlf" + "\t" + "N/A" + "\t" + self.tlf + "\t" + descripcion + "\n")

		file.close()




	end




end
