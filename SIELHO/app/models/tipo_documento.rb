class TipoDocumento < ActiveRecord::Base
	validates_presence_of :regla,:nombre,:tipoPersona
	validates_uniqueness_of :regla,:nombre
    validates :nombre, :format => { :with => /\A[a-zA-Z]+\z/, :message => " - Solo se permiten letras" } 
    validates :regla, :format => { :with => /\A[A#-]+\z/, :message => " - Solo se '#' para numeros 'A' para letras " } 


	def cambiarARegexRegla()
		cad = self.regla.gsub("#","[0-9]")
		cad = cad.gsub("A","[A-Z]")
		cad = "\\A" + cad + "\\z"
		return Regexp.new(cad)
	end

	def self.documentos(tipo)
		document = TipoDocumento.where( :tipoPersona => tipo)
		res = []
		document.each do |d|
			res << [d.nombre,d.id]
		end
		return res 
	end
	
	def validar(cadena)
		return !self.cambiarARegexRegla().match(cadena).nil?
	end	

	def logC
		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de tipoDocumento"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "tipo_documento" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.nombre + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "regla" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.regla + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "tipo_persona" + "\t" + "nombre" + "\t" + "N/A" + "\t" + self.tipoPersona.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "tipo_documento" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "tipo_documento" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "tipo_documento" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "tipo_documento" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


	end	

end
