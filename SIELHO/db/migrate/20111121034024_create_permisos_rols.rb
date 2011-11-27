class CreatePermisosRols < ActiveRecord::Migration
  def self.up
  	create_table :permisos_rols,:id => false do |t|
		t.integer :rol_id
		t.integer :permiso_id
	end
  end

  def self.down
	drop_table :permisos_rols
  end
end
