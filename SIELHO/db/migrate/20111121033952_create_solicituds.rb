class CreateSolicituds < ActiveRecord::Migration
  def self.up
    create_table :solicituds do |t|
      t.integer :solicitante_id
      t.text :descripcion
      t.string :lugar
	  t.integer :institucion_id
      t.datetime :fecha
      t.integer :clasificacion_id
      t.integer :expediente_id
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod
	  t.integer :responsable
    end
  end

  def self.down
    drop_table :solicituds
  end
end
