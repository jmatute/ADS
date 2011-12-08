class LeyAcuerdo < ActiveRecord::Base
	validates_presence_of :noLey,:noAcuerdo, :fechaGaceta,:descripcion
	validates :noLey, :format => { :with => /\A[0-9a-zA-Z\- ]+\z/, :message => " - Solo se permiten letras y numeros" } 
    validates :noAcuerdo, :format => { :with => /\A[0-9a-zA-Z\- ]+\z/, :message => " - Solo se permiten letras y numeros" } 
	has_and_belongs_to_many :justificacions 
	def logC
		

		file = File.open("public/historial", "a")
		fecha = DateTime.now.to_s
		mod = self.usuarioRes
		rol = User.find(self.usuarioRes).rol.nombre
		descripcion = "creacion de leyacuerdo"
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" + "\t" + "descripcion" + "\t" + "N/A" + "\t" + self.descripcion + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" + "\t" + "noLEY" + "\t" + "N/A" + "\t" + self.noLey + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" +  "\t" + "noAcuerdo" + "\t" + "N/A" + "\t" + self.noAcuerdo + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" +  "\t" + "fechaGaceta" + "\t" + "N/A" + "\t" + self.fechaGaceta.to_s + "\t" + descripcion + "\n")

		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" +  "\t" + "fechaCrear" + "\t" + "N/A" + "\t" + self.fechaCrear.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" +  "\t" + "fechaMod" + "\t" + "N/A" + "\t" + self.fechaMod.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" +  "\t" + "usuarioRes" + "\t" + "N/A" + "\t" + self.usuarioRes.to_s + "\t" + descripcion + "\n")
		file.write(fecha + "\t" +mod.to_s+ "\t" +rol.to_s+ "\t" + "leyacuerdo" + "\t" + "usuarioMod" + "\t" + "N/A" + "\t" + self.usuarioMod.to_s + "\t" + descripcion + "\n")

		file.close()


	end	

end
