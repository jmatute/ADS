class Rol < ActiveRecord::Base
	has_and_belongs_to_many :permisos
end
