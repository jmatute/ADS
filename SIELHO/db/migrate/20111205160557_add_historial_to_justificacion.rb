class AddHistorialToJustificacion < ActiveRecord::Migration
  def self.up
 	add_column :justificacions, :clasificacion ,:string
	add_column :justificacions, :estado , :string
  end

  def self.down
	remove_column :justificacions,:clasificacion
	remove_column :justificacions, :estado
  end
end
