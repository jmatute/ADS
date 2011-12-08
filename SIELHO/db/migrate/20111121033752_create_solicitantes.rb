class CreateSolicitantes < ActiveRecord::Migration
  def self.up
    create_table :solicitantes do |t|
      t.string :nombre
      t.integer :documento_id
      t.integer :tipo_solicitante
      t.integer :ocupacion_id
      t.string :genero
      t.string :nivel_educativo
      t.string :telefono
      t.string :email
      t.text :direccion_postal
      t.string :fax
      t.string :poder
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod
	  t.integer :responsable
    end
  end

  def self.down
    drop_table :solicitantes
  end
end
