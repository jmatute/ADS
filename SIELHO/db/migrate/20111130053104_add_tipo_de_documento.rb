class AddTipoDeDocumento < ActiveRecord::Migration
  def self.up  
     add_column :documentos, :tipoDocumento_id, :integer
  end

  def self.down
	remove_column :documentos, :tipoDocumento_id
  end
end
