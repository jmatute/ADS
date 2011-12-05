class AddNumeroToSolicitud < ActiveRecord::Migration
  def self.up
    add_column :solicituds, :numero ,:string
	add_column :solicituds, :finalizada, :boolean
  end

  def self.down
    remove_column :solicituds, :numero 
	remove_column :solicituds, :finalizada
  end
end
