class CreateRols < ActiveRecord::Migration
  def self.up
    create_table :rols do |t|
      t.string :nombre
      t.text :descripcion
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

    end
  end

  def self.down
    drop_table :rols
  end
end
