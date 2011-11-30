class AddAnteriorEstado < ActiveRecord::Migration
  def self.up
    add_column :estados, :anterior_id, :integer

  end

  def self.down
	remove_column :estados, :anterior_id
  end
end
