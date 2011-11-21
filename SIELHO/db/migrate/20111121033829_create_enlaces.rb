class CreateEnlaces < ActiveRecord::Migration
  def self.up
    create_table :enlaces do |t|
      t.integer :usuario_id
      t.integer :departamento_id
      t.integer :institucion_id
      t.string :pnombre
      t.string :snombre
      t.string :papellido
      t.string :sapellido
      t.string :email
      t.string :email2
      t.string :tlf
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :enlaces
  end
end
