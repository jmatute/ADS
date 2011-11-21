class CreateLeyAcuerdos < ActiveRecord::Migration
  def self.up
    create_table :ley_acuerdos do |t|
      t.string :noLey
      t.string :noAcuerdo
	  t.date :fechaGaceta
	  t.text :descripcion
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

    end
  end

  def self.down
    drop_table :ley_acuerdos
  end
end
