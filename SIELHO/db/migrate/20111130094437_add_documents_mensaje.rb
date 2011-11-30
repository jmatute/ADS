class AddDocumentsMensaje < ActiveRecord::Migration

 def self.up
    add_column :mensajes, :document_file_name,    :string
    add_column :mensajes, :document_content_type, :string
    add_column :mensajes, :document_file_size,    :integer
    add_column :mensajes, :document_updated_at,   :datetime
  end

  def self.down
    remove_column :mensajes, :document_file_name
    remove_column :mensajes, :document_content_type
    remove_column :mensajes, :document_file_size
    remove_column :mensajes, :document_updated_at
  end


end
