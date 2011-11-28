class AddNumeroToSolicitud < ActiveRecord::Migration
  def self.up
    add_column :solicituds, :numero ,:string
  end

  def self.down
    remove_column :solicituds, :numero ,:string
  end
end
