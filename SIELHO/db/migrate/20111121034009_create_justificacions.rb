class CreateJustificacions < ActiveRecord::Migration
  def self.up
    create_table :justificacions do |t|
      t.text :descripcion
      t.datetime :fecha_cambio
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :justificacions
  end
end
