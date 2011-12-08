class CreateTipoDocumentos < ActiveRecord::Migration
  def self.up
    create_table :tipo_documentos do |t|
      t.string :regla
      t.string :nombre
      t.integer :tipoPersona
      t.datetime :fechaCrear
      t.datetime :fechaMod
      t.integer :usuarioRes
      t.integer :usuarioMod

    end
  end

  def self.down
    drop_table :tipo_documentos
  end
end
