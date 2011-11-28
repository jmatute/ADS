class Mensaje < ActiveRecord::Base
	belongs_to :expedientes
	validates_presence_of :destinatario_id,:emisor_id,:titulo,:texto,:fecha
	def self.HasMensajeNoLeido(usuario)
		return Mensaje.where(:leido=>false,:borrado=>false,:destinatario_id=>usuario) != []
	end

	def self.NuevaSolicitud(informacion)
		x = informacion.to_json.to_s
		institucion = informacion[:solicitud][:institucion_id]
		oficiales = Oip.where(:institucion_id => institucion)
		oficiales.each do |o|
			if User.find(o.usuario_id).activo
				crear = Mensaje.new(:emisor_id=>0,:destinatario_id=>o.usuario_id,:titulo=>"Nueva Solicitud de Informacion",:texto=>x,:fecha=>DateTime.now,
									:leido=>false,:borrado=>false,:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>0,:usuarioMod=>0)
				crear.save()
			end
		end
		crear = Mensaje.new(:emisor_id=>0,:destinatario_id=>Administrador.last.usuario_id,:titulo=>"Nueva Solicitud de Informacion",:texto=>x,:fecha=>DateTime.now,
									:leido=>false,:borrado=>false,:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>0,:usuarioMod=>0)
		crear.save()


	end
end
