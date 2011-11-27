class Estado < ActiveRecord::Base
	validates_presence_of :nombre,:descripcion
	has_many :estados, :as => :next
	belongs_to :estado
end
