class AddInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    add_column :users, :activo, :boolean
    add_column :users, :rol_id, :int
  end

  def self.down
    remove_column :users, :rol_id
    remove_column :users, :activo
    remove_column :users, :username
  end
end
