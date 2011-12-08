class CreateOcupacions < ActiveRecord::Migration
  def self.up
    create_table :ocupacions do |t|
      t.string :nombre
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

    end
  end

  def self.down
    drop_table :ocupacions
  end
end
