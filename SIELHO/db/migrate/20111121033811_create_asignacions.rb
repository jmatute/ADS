class CreateAsignacions < ActiveRecord::Migration
  def self.up
    create_table :asignacions do |t|
      t.integer :enlace_id
      t.text :descripcion
      t.datetime :fechaInic
      t.integer :expediente_id
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :asignacions
  end
end
