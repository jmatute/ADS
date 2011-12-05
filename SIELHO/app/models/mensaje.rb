class Mensaje < ActiveRecord::Base

	has_attached_file :document ,:path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension"

 	attr_accessor :avatar_file_name


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
		AplicationMailer.nueva(User.find(o.usuario_id).email,Institucion.find(institucion).nombre).deliver
									
				crear.save()
			end
		end
		crear = Mensaje.new(:emisor_id=>0,:destinatario_id=>Administrador.last.usuario_id,:titulo=>"Nueva Solicitud de Informacion",:texto=>x,:fecha=>DateTime.now,
									:leido=>false,:borrado=>false,:fechaCrear=>DateTime.now,:fechaMod=>DateTime.now,:usuarioRes=>0,:usuarioMod=>0)
		#AplicationMailer.nueva(User.find(Administrador.last.usuario_id).email,Institucion.find(institucion).nombre)
		crear.save()
	end



	def self.solicitudValida(informacion) 
		info = JSON.parse( informacion.to_json.to_s )
		errores = []
		if info["solicitud"]["lugar"].blank?
			errores << "Lugar no puede estar en blanco"
		elsif info["solicitud"]["lugar"].match(/\A[a-zA-Z ]+\z/).nil?
			errores << "Lugar solo puede contener letras"
		end

		if info["solicitante"]["nombre"].blank?
			errores << "Nombre del solicitante no puede estar en blanco"
		elsif info["solicitante"]["nombre"].match(/\A[a-zA-Z ]+\z/).nil?
			errores << "Nombre solo puede contener letras"
		end
		
		if info["solicitud"]["descripcion"].blank?
			errores << "Debe hacer una descripcion de su solicitud"
		end

		if info["solicitud"]["institucion_id"].blank?
			errores << "Debe de elegir una institucion"
		end

		if info["documento"]["tipoDocumento_id"].blank?
			errores << "Elija un tipo de documento"
		else
			unless TipoDocumento.find(info["documento"]["tipoDocumento_id"]).validar( info["documento"]["numero"] )
				errores << "Documento no cumple con el formato: " + TipoDocumento.find(info["documento"]["tipoDocumento_id"]).regla
			end
		end

		unless !info["solicitante"]["telefono"].blank? || !info["solicitante"]["fax"].blank? || !info["solicitante"]["direccion_postal"].blank? || !info["solicitante"]["email"].blank?
			errores << "Debe de elegir al menos una forma de contacto"
		end

		if info["solicitante"]["email"].blank?
			errores << "El correo es obligatorio"
		elsif /\A[a-zA-Z0-9._]+@[a-zA-Z0-9._]+(.[a-zA-Z0-9._]+)+\z/.match(info["solicitante"]["email"]).nil?
			correcta = false
			errores << "El correo ingresado no es valido"
		end

		unless info["solicitante"]["telefono"].blank?
			if /\A[0-9]{8}\z/.match(info["solicitante"]["telefono"]).nil?
				errores << "El telefono no se encuentra en formato valido, por favor solo numeros"	
			end
		end
		
		unless info["solicitante"]["fax"].blank?
			if /\A[0-9]{8}\z/.match(info["solicitante"]["fax"]).nil?
				errores << "El telefono no se encuentra en formato valido, por favor solo numeros"	
			end
		end


		return errores
	end

	def esNuevaSolicitud()
		return self.titulo.eql? "Nueva Solicitud de Informacion"
	end

	def parsear()
		mensaje = JSON.parse(self.texto)
		return mensaje
	end
	
	def self.crear(parametros)
		temp = Mensaje.new(parametros[:mensaje])
		temp.emisor_id = parametros[:id]
		temp.fecha = DateTime.now
		temp.usuarioMod = parametros[:id]
		temp.usuarioRes = parametros[:id]
		temp.fechaCrear = DateTime.now
		temp.fechaMod = DateTime.now
		temp.leido = false
		temp.borrado = false
		temp.save
	end
end
