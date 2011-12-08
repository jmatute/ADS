class CreateMensajes < ActiveRecord::Migration
  def self.up
    create_table :mensajes do |t|
      t.integer :emisor_id
      t.integer :destinatario_id
      t.string :titulo
      t.text :texto
      t.datetime :fecha
      t.integer :expediente_id
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :mensajes
  end
end
