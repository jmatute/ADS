class CreateAdministradors < ActiveRecord::Migration
  def self.up
    create_table :administradors do |t|
      t.integer :usuario_id
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
    drop_table :administradors
  end
end
