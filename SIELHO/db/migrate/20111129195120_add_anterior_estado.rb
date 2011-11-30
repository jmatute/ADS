class AddAnteriorEstado < ActiveRecord::Migration
  def self.up
    add_column :estados, :anterior_id, :integer
  	add_column :estados, :siguiente_id, :integer

  end

  def self.down
	remove_column :estados, :anterior_id
  	remove_column :estados, :siguiente_id
  end
end
