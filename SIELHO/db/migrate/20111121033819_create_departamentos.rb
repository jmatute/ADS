class CreateDepartamentos < ActiveRecord::Migration
  def self.up
    create_table :departamentos do |t|
      t.integer :institucion_id
      t.text :descripcion
      t.string :nombre
      t.integer :enlace_id
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :departamentos
  end
end
