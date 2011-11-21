class CreateExpedientes < ActiveRecord::Migration
  def self.up
    create_table :expedientes do |t|
      t.integer :estado_id
      t.integer :solicitud_id
      t.integer :creador
      t.datetime :fechaEntrega
      t.datetime :fechaEmision
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

      t.timestamps
    end
  end

  def self.down
    drop_table :expedientes
  end
end
