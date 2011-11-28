class AddLeidoToMensaje < ActiveRecord::Migration
  def self.up
    add_column :mensajes, :leido ,:boolean
    add_column :mensajes, :borrado, :boolean
  end

  def self.down
    remove_column :mensajes, :leido 
    remove_column :mensajes, :borrado
  end
end
