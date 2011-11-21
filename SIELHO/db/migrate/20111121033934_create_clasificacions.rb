class CreateClasificacions < ActiveRecord::Migration
  def self.up
    create_table :clasificacions do |t|
      t.string :nombre
      t.text :descripcion
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :clasificacions
  end
end
