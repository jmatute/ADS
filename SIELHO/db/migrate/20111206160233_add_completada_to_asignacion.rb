class AddCompletadaToAsignacion < ActiveRecord::Migration
  def self.up
	add_column :asignacions,:completada,:boolean
  end

  def self.down
	remove_column :asignacions,:completada
  end
end
