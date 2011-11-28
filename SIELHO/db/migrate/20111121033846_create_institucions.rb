class CreateInstitucions < ActiveRecord::Migration
  def self.up
    create_table :institucions do |t|
      t.text :descripcion
      t.string :nombre
      t.string :tipo_institucion
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :institucions
  end
end
