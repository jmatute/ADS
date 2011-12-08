class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	validates_uniqueness_of :username
	has_many :administradors
	has_many :enlaces
	has_many :oips

	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  attr_accessible :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

 def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
 end

 def self.destinos(usuario)
		x = []
		todos = User.all
		normal = User.find usuario


		if normal.rol.nombre.eql? "oip"
			x << ["solicitante",0]
		end

		todos.each do |i|
			if normal.rol.nombre.eql? "admin"
				if i.rol.nombre.eql? "oip"
					x << [ i.username, i.id]
				end
			end
			
			if normal.rol.nombre.eql? "oip"
				if i.rol.nombre.eql? "admin"
					x << [i.username,i.id]
				end
				if i.rol.nombre.eql?("enlace") && (Enlace.find_by_usuario_id(i.id).institucion_id.eql? Oip.find_by_usuario_id(normal.id).institucion_id)
					x << [i.username,i.id]
				end
			end
			
			if normal.rol.nombre.eql? "enlace"
				if i.rol.nombre.eql?("oip") && (Enlace.find_by_usuario_id(normal.id).institucion_id.eql? Oip.find_by_usuario_id(i.id).institucion_id)
					x << [i.username,i.id]
				end
			end
		end

		return x
	end

	def rol()
		Rol.find(rol_id)
	end

  def agregar_admin(params)
	
	self.rol_id = 1
	self.activo = true
	self.username = params[:user][:username]
    self.save()
	x = Administrador.new
	x.email = params[:user][:email]
	x.usuario_id = id
	x.save()	
  end

end
