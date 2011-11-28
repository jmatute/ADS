class Administrador < ActiveRecord::Base

	def nombre()
		return self.pnombre + "  " + self.papellido
	end
end
