class CreateOips < ActiveRecord::Migration
  def self.up
    create_table :oips do |t|
      t.integer :usuario_id
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

    end
  end

  def self.down
    drop_table :oips
  end
end
